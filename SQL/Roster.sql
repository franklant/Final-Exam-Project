-- Name: Franklan Taylor
-- Date: 4/25/2025
-- Course: COMP267-001
-- Description: Creates the roster table holding a list of classes for students

USE ncat;
CREATE TABLE IF NOT EXISTS roster (
	ID		INT AUTO_INCREMENT NOT NULL, 
    class 	VARCHAR(256) NOT NULL, 
    code	CHAR(4), -- PHYS, MATH, COMP, etc.
    CONSTRAINT CHK_CODE CHECK (code IN ('COMP', 'PHYS', 'MATH', 'POLI', 'ECEN', 'PSYC', 'AGRI', 'SOCI')),
    PRIMARY KEY (ID)
    
);

-- create some classes psychology, math, comp
INSERT INTO roster (class, code)
VALUES ('Intro to Programming', 'COMP'), ('Database Design', 'COMP'), 
	   ('Data Structures', 'COMP'), ('Game Design', 'COMP'),
	   ('Physics I', 'PHYS'), ('Physics II', 'PHYS'),
       ('Quantum Physics I', 'PHYS'), ('Quantum Physics II', 'PHYS'),
       ('Algebra and Trig', 'MATH'), ('Discrete Mathemetics I', 'MATH'),
       ('Discrete Mathematics II', 'MATH'), ('Abastract Algebra I', 'MATH'),
       ('Intro to Political Sci.', 'POLI'), ('The U.S. Congress', 'POLI'),
       ('The Politics of Free Trade', 'POLI'), ('Independent Study', 'POLI'),
       ('Discrete Systems Modeling', 'ECEN'), ('Linear Systems and Signals', 'ECEN'),
       ('Electrical Circuits and Systems', 'ECEN'), ('Digital Systems Design I', 'ECEN'),
       ('General Psychology', 'PSYC'), ('Adult Development and Aging', 'PSYC'), 
       ('Media Psychology', 'PSYC'), ('Animal Behavior and Cognition', 'PSYC'),
       ('Sustainable Food Systems', 'AGRI'), ('Undegraduate Research', 'AGRI'),
       ('Principles of Sociology', 'SOCI'), ('Origins of Social Thought', 'SOCI'),
       ('Social Statistics I', 'SOCI'), ('Social Statistics II', 'SOCI'),
       ('Social Theories', 'SOCI'), ('Social Problems', 'SOCI');