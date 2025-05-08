FINAL EXAM PROJECT
COMP267-001
4/25/2025
Created by Franklan Taylor.


(1) HOW TO RUN: 
	- To run the application, you can run the 'main.py' script or open the 'FinalExamProjectApp' shortcut that will run the exe application.
	- To set up the database for the application, run the 'FinalExamProjectDump' SQL file found in the SQL folder. This will create the scheme, data, procedures, and functions necessary to properly run the application.
	* Be sure that all of the SQL has been run before running the application. Could cause errors as some tables and procedures may not have been properly added. 


(2) DESCRIPTION: 
	- This project uses 'pygame' and 'pygame-menu' to display UI/GUI elements in the application. 
	- This project also utilizes the MySQL Connector/Python API to authenticate the application to the database and authorize users with their roles. The API also handles the back-end functionality with verifying, inserting, updating, and deleting data. 
	- The connection to the database authenticates using database user and password from 'auth.py' and returns a connection string that the program uses to manipulate data.
	- The SQL folder houses all of the database code for the application (Users, Roles, Roster, RosterClass, Major).
	- The Menus folder houses all of the code for the menu elements of the application (StudentMenu, ManagerMenu).
	- The UI folder houses all of the code for the UI/GUI elements of the application (TextBox, ButtonBox).
	- The DB folder houses all of the MySQL Connector/Python API code as well as the authentication info for the application (Connection, Auth).
	- main.py has the boiler-plate, as well as login code used to run the application and authorize the user.


(3) OVERVIEW: 
	- Manager: The manager role can (1) add a student, (2) add a student to a class, (3) drop a student from a class, (4) view a students schedule, and (5) view a class roster. 
	- Student: The student can (1) view their class schedule and (2) drop from a course.
	