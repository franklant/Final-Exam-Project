-- Name: Franklan Taylor
-- Date: 4/25/2025
-- Course: COMP267-001
-- Description: creates a weak table roster class that keeps tracks of which students are assigned to a what class

USE ncat;
-- class roster (weak table)
CREATE TABLE IF NOT EXISTS roster_class (
	rosterID	INT NOT NULL, 
    userID		INT NOT NULL,
    CONSTRAINT FK_ROSTER_ROSTERCLASS FOREIGN KEY (rosterID) REFERENCES roster (ID),
    CONSTRAINT FK_USER_ROSTERCLASS FOREIGN KEY (userID) REFERENCES users (ID)
);