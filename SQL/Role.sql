-- Name: Franklan Taylor
-- Date: 4/25/2025
-- Course: COMP267-001
-- Description: Create table to store user roles. The roles are used to authorize users and grant certain permissions to the program. 

USE ncat;
CREATE TABLE IF NOT EXISTS roles (
	ID				CHAR(3) NOT NULL,
    role			VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID)
);

INSERT INTO roles VALUES ('mgr', 'Manager'), ('stu', 'Student');