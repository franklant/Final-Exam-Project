-- Name: Franklan Taylor
-- Date: 4/25/2025
-- Course: COMP267-001
-- Description: Creates user table and procedures used for the application.

CREATE DATABASE IF NOT EXISTS ncat;

USE ncat;
-- create user and key to authenticate application to database
CREATE USER 'AggieAdmin'@'127.0.0.1' IDENTIFIED BY 'AggiePride';
GRANT ALL PRIVILEGES ON ncat.* TO 'AggieAdmin'@'127.0.0.1' WITH GRANT OPTION;
FLUSH PRIVILEGES; 

CREATE TABLE IF NOT EXISTS Users (
	ID				INT AUTO_INCREMENT NOT NULL,
    username		VARCHAR(50),
    userpassword	VARCHAR(50), 	
    roleID			CHAR(3) NOT NULL, -- char(3)
    fname			VARCHAR(50),
    lname			VARCHAR(50),	
    majorID			INT, -- optional for non-students
    PRIMARY KEY (ID),
    CONSTRAINT FK_ROLES_USERS FOREIGN KEY (roleID) REFERENCES roles (ID),
    CONSTRAINT FK_MAJOR_USERS FOREIGN KEY (majorID) REFERENCES major (ID)
);

-- Managers
INSERT INTO Users (username, userpassword, roleID, fname, lname) 
VALUE ('Manager1', 'AggiePride1', 'mgr', 'Mana', 'Gero');

-- -- Students CREATE MAJORS
INSERT INTO Users (username, userpassword, roleID, fname, lname, majorID) 
VALUE ('Student1', 'AggiePride2', 'stu', "Stew", "Dent", 1);

-- create a view for all credentials
CREATE VIEW user_credentials AS
SELECT U.username, U.userpassword, R.Role, U.ID
FROM Users U INNER JOIN Roles R
ON U.roleID = R.ID;

-- return list of student credentials including the major
CREATE VIEW student_list AS 
SELECT U.ID, U.fname, U.lname, M.major
FROM Users U, Major M
WHERE U.roleID = 'stu' AND U.majorID = M.ID AND U.majorID IN (SELECT M.ID FROM major MM WHERE MM.ID = U.majorID);

-- -- veryify login credentials and return a role if they match. Else, return invalid. 
DELIMITER $$
CREATE PROCEDURE FIND_USER(IN user_name VARCHAR(50), IN pass_word VARCHAR(50), OUT results VARCHAR(50), OUT user_id INT)
BEGIN 
	DECLARE rolename VARCHAR(50);
    DECLARE userid INT;
    DECLARE username VARCHAR(50);
    DECLARE pass VARCHAR(50);
	DECLARE finishedReading BOOL DEFAULT FALSE;
    DECLARE success BOOL DEFAULT FALSE;
	DECLARE invalid VARCHAR(7) DEFAULT 'invalid';
	DECLARE findCursor CURSOR FOR 
		SELECT * FROM user_credentials;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET  finishedReading = TRUE;
    
    OPEN findCursor;
    FETCH FROM findCursor INTO username, pass, rolename, userid;
    
    WHILE NOT finishedReading DO
		IF user_name = username AND pass = pass_word THEN 
			SELECT rolename INTO results;
            SELECT userid INTO user_id;
			SET finishedReading = TRUE;
            SET success = TRUE;
        ELSE  
			FETCH FROM findCursor INTO username, pass, rolename, userid;
		END IF;
    END WHILE;
    IF NOT success THEN 
		SELECT invalid INTO results;
	END IF;
    CLOSE findCursor;
END;

-- student procedures
-- drop a class (remove column from rosterclass)
CREATE PROCEDURE DROP_CLASS(IN student_id INT, roster_id INT)
BEGIN
	DELETE FROM roster_class WHERE rosterID = roster_id AND userID = student_id;
END;

-- manager procedures
-- view a students class schedule using dynamic SQL to create a view name
CREATE PROCEDURE VIEW_STUDENT_SCHEDULE(IN user_id INT, IN view_name VARCHAR(50))
BEGIN
	SET @create_view = CONCAT('CREATE OR REPLACE VIEW ', view_name, 
                              ' AS SELECT class, code FROM roster WHERE ID IN (SELECT rosterID FROM roster_class WHERE userID = ', 
							    user_id, ')');
    PREPARE create_stmt FROM @create_view;
    EXECUTE create_stmt;
    
    SET @select_view = CONCAT('SELECT * FROM ', view_name);
    PREPARE select_stmt FROM @select_view;
    EXECUTE select_stmt;
END;

-- view a class roster (given specific rosterID, inner join with rosterclass)
CREATE PROCEDURE VIEW_CLASS_ROSTER(IN roster_id INT) 
BEGIN
	SELECT ID, fname, lname, major
	FROM student_list
	WHERE ID IN (SELECT userID FROM roster_class WHERE rosterID = roster_id);
END;

-- add student to roster (insert into rosterclass the given userID, and rosterID)
CREATE PROCEDURE ADD_STUDENT_TO_ROSTER(IN first_name VARCHAR(50), IN last_name VARCHAR(50), roster_id INT, OUT results CHAR(7))
BEGIN
	DECLARE return_id INT;
    DECLARE return_role_id CHAR(3);
    DECLARE return_roster_class INT;
    DECLARE invalid CHAR(7) DEFAULT 'invalid';
    
	SELECT U.ID, U.roleID INTO return_id, return_role_id FROM Users U
    WHERE U.fname = first_name AND U.lname = last_name;
	
    SELECT RC.rosterID INTO return_roster_class FROM roster_class RC
    WHERE RC.userID = return_id AND RC.rosterID = roster_id;
    
    -- student is not already registered to the class
    IF return_roster_class IS NULL THEN
		IF return_id IS NOT NULL AND return_role_id = 'stu' THEN
			-- insert into rosterclass userID and rosterID
			INSERT INTO roster_class (rosterID, userID)
			VALUE (roster_id, return_id);
		ELSE 
			SELECT invalid INTO results;
		END IF;
	ELSE
		SET invalid = 'exists!';
		SELECT invalid INTO results;
    END IF;
END;

-- allow user to drop student from a roster (remove column with the specified userID and rosterID)
CREATE PROCEDURE DROP_STUDENT_FROM_ROSTER(IN first_name VARCHAR(50), IN last_name VARCHAR(50), roster_id INT, OUT results CHAR(7))
BEGIN
	DECLARE return_id INT;
    DECLARE invalid CHAR(7) DEFAULT 'invalid';
    
	SELECT U.ID INTO return_id FROM Users U
    WHERE U.fname = first_name AND U.lname = last_name;
	
    IF return_id IS NOT NULL THEN
		DELETE FROM roster_class WHERE rosterID = roster_id AND userID = return_id;
	ELSE
		SELECT invalid INTO results;
	END IF;
END;

-- allow user to add a student (insert into users table with the givern username, password, firstname, lastname, and majorid)
CREATE PROCEDURE ADD_STUDENT(IN user_name VARCHAR(50), IN pass_word VARCHAR(50), IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN major INT)
	INSERT INTO Users (username, userpassword, roleID, fname, lname, majorID)
    VALUES (user_name, pass_word, 'stu', first_name, last_name, major);

-- list of all class_names and IDs to add students to a roster
CREATE PROCEDURE CLASS_NAMES()
BEGIN
	SELECT class, ID
    FROM roster;
END;

CREATE PROCEDURE MAJOR_NAMES()
BEGIN
	SELECT major, ID
    FROM major;
END;

CREATE PROCEDURE STUDENT_NAMES()
BEGIN
	SELECT CONCAT(fname, ' ', lname), ID FROM student_list;
END;

CREATE PROCEDURE GET_VIEW_NAME(IN student_id INT, OUT view_name VARCHAR(256))
BEGIN
	SELECT CONCAT(LOWER(fname), '_', LOWER(lname), '_view') INTO view_name
    FROM student_list
    WHERE ID = student_id;
END;