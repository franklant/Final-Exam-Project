-- Name: Franklan Taylor
-- Date: 4/25/2025
-- Course: COMP267-001
-- Description: Creates a table to store student majors

USE ncat;
CREATE TABLE IF NOT EXISTS major (
	ID				INT AUTO_INCREMENT NOT NULL,
    major			VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID)
);

-- Majors
INSERT INTO major (major) VALUES ("Computer Science"), ("Computer Engineering"), ("Criminal Justice"),
								 ("Social Work"), ("Animal Science"), ("Electrical Engineering");