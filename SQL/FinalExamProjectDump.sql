CREATE DATABASE  IF NOT EXISTS `ncat` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ncat`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ncat
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `major` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (1,'Computer Science'),(2,'Computer Engineering'),(3,'Criminal Justice'),(4,'Social Work'),(5,'Animal Science'),(6,'Electrical Engineering');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `ID` char(3) NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('mgr','Manager'),('stu','Student');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roster`
--

DROP TABLE IF EXISTS `roster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roster` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `class` varchar(256) NOT NULL,
  `code` char(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `CHK_CODE` CHECK ((`code` in (_utf8mb4'COMP',_utf8mb4'PHYS',_utf8mb4'MATH',_utf8mb4'POLI',_utf8mb4'ECEN',_utf8mb4'PSYC',_utf8mb4'AGRI',_utf8mb4'SOCI')))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roster`
--

LOCK TABLES `roster` WRITE;
/*!40000 ALTER TABLE `roster` DISABLE KEYS */;
INSERT INTO `roster` VALUES (1,'Intro to Programming','COMP'),(2,'Database Design','COMP'),(3,'Data Structures','COMP'),(4,'Game Design','COMP'),(5,'Physics I','PHYS'),(6,'Physics II','PHYS'),(7,'Quantum Physics I','PHYS'),(8,'Quantum Physics II','PHYS'),(9,'Algebra and Trig','MATH'),(10,'Discrete Mathemetics I','MATH'),(11,'Discrete Mathematics II','MATH'),(12,'Abastract Algebra I','MATH'),(13,'Intro to Political Sci.','POLI'),(14,'The U.S. Congress','POLI'),(15,'The Politics of Free Trade','POLI'),(16,'Independent Study','POLI'),(17,'Discrete Systems Modeling','ECEN'),(18,'Linear Systems and Signals','ECEN'),(19,'Electrical Circuits and Systems','ECEN'),(20,'Digital Systems Design I','ECEN'),(21,'General Psychology','PSYC'),(22,'Adult Development and Aging','PSYC'),(23,'Media Psychology','PSYC'),(24,'Animal Behavior and Cognition','PSYC'),(25,'Sustainable Food Systems','AGRI'),(26,'Undegraduate Research','AGRI'),(27,'Principles of Sociology','SOCI'),(28,'Origins of Social Thought','SOCI'),(29,'Social Statistics I','SOCI'),(30,'Social Statistics II','SOCI'),(31,'Social Theories','SOCI'),(32,'Social Problems','SOCI');
/*!40000 ALTER TABLE `roster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roster_class`
--

DROP TABLE IF EXISTS `roster_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roster_class` (
  `rosterID` int NOT NULL,
  `userID` int NOT NULL,
  KEY `FK_ROSTER_ROSTERCLASS` (`rosterID`),
  KEY `FK_USER_ROSTERCLASS` (`userID`),
  CONSTRAINT `FK_ROSTER_ROSTERCLASS` FOREIGN KEY (`rosterID`) REFERENCES `roster` (`ID`),
  CONSTRAINT `FK_USER_ROSTERCLASS` FOREIGN KEY (`userID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roster_class`
--

LOCK TABLES `roster_class` WRITE;
/*!40000 ALTER TABLE `roster_class` DISABLE KEYS */;
INSERT INTO `roster_class` VALUES (13,3),(14,3),(15,3),(16,3),(2,4),(4,4),(6,4),(10,4),(1,2),(2,2),(3,2),(4,2),(6,2),(8,2),(10,2),(1,4),(3,4),(1,5),(4,5),(5,5),(3,5),(18,5),(17,5),(19,5),(20,5),(32,6),(31,6),(1,7),(2,7),(32,7);
/*!40000 ALTER TABLE `roster_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `student_list`
--

DROP TABLE IF EXISTS `student_list`;
/*!50001 DROP VIEW IF EXISTS `student_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_list` AS SELECT 
 1 AS `ID`,
 1 AS `fname`,
 1 AS `lname`,
 1 AS `major`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_credentials`
--

DROP TABLE IF EXISTS `user_credentials`;
/*!50001 DROP VIEW IF EXISTS `user_credentials`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_credentials` AS SELECT 
 1 AS `username`,
 1 AS `userpassword`,
 1 AS `Role`,
 1 AS `ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `userpassword` varchar(50) DEFAULT NULL,
  `roleID` char(3) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `majorID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ROLES_USERS` (`roleID`),
  KEY `FK_MAJOR_USERS` (`majorID`),
  CONSTRAINT `FK_MAJOR_USERS` FOREIGN KEY (`majorID`) REFERENCES `major` (`ID`),
  CONSTRAINT `FK_ROLES_USERS` FOREIGN KEY (`roleID`) REFERENCES `roles` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Manager1','AggiePride1','mgr','Mana','Gero',NULL),(2,'Student1','AggiePride2','stu','Stew','Dent',1),(3,'HDent','AggiePride3','stu','Harvey','Dent',3),(4,'FTaylor','knuckl3s','stu','Franklan','Taylor',1),(5,'CLewis','clewis12','stu','Carl','Lewis',2),(6,'JHinton','jhinton','stu','Justin','Hinton',4),(7,'CGeorge','cgeorge1','stu','Chris','George',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ncat'
--
/*!50003 DROP PROCEDURE IF EXISTS `ADD_STUDENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_STUDENT`(IN user_name VARCHAR(50), IN pass_word VARCHAR(50), IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN major INT)
INSERT INTO Users (username, userpassword, roleID, fname, lname, majorID)
    VALUES (user_name, pass_word, 'stu', first_name, last_name, major) ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ADD_STUDENT_TO_ROSTER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_STUDENT_TO_ROSTER`(IN first_name VARCHAR(50), IN last_name VARCHAR(50), roster_id INT, OUT results CHAR(7))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CLASS_NAMES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CLASS_NAMES`()
BEGIN
	SELECT class, ID
    FROM roster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DROP_CLASS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DROP_CLASS`(IN student_id INT, roster_id INT)
BEGIN
	DELETE FROM roster_class WHERE rosterID = roster_id AND userID = student_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DROP_STUDENT_FROM_ROSTER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DROP_STUDENT_FROM_ROSTER`(IN first_name VARCHAR(50), IN last_name VARCHAR(50), roster_id INT, OUT results CHAR(7))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FIND_USER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FIND_USER`(IN user_name VARCHAR(50), IN pass_word VARCHAR(50), OUT results VARCHAR(50), OUT user_id INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_VIEW_NAME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_VIEW_NAME`(IN student_id INT, OUT view_name VARCHAR(256))
BEGIN
	SELECT CONCAT(LOWER(fname), '_', LOWER(lname), '_view') INTO view_name
    FROM student_list
    WHERE ID = student_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MAJOR_NAMES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MAJOR_NAMES`()
BEGIN
	SELECT major, ID
    FROM major;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `STUDENT_NAMES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `STUDENT_NAMES`()
BEGIN
	SELECT CONCAT(fname, ' ', lname), ID FROM student_list;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VIEW_CLASS_ROSTER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VIEW_CLASS_ROSTER`(IN roster_id INT)
BEGIN
	SELECT ID, fname, lname, major
	FROM student_list
	WHERE ID IN (SELECT userID FROM roster_class WHERE rosterID = roster_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VIEW_STUDENT_SCHEDULE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VIEW_STUDENT_SCHEDULE`(IN user_id INT, IN view_name VARCHAR(50))
BEGIN
	SET @create_view = CONCAT('CREATE OR REPLACE VIEW ', view_name, 
                              ' AS SELECT class, code FROM roster WHERE ID IN (SELECT rosterID FROM roster_class WHERE userID = ', 
							    user_id, ')');
    PREPARE create_stmt FROM @create_view;
    EXECUTE create_stmt;
    
    SET @select_view = CONCAT('SELECT * FROM ', view_name);
    PREPARE select_stmt FROM @select_view;
    EXECUTE select_stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `student_list`
--

/*!50001 DROP VIEW IF EXISTS `student_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_list` AS select `u`.`ID` AS `ID`,`u`.`fname` AS `fname`,`u`.`lname` AS `lname`,`m`.`major` AS `major` from (`users` `u` join `major` `m`) where ((`u`.`roleID` = 'stu') and (`u`.`majorID` = `m`.`ID`) and `u`.`majorID` in (select `m`.`ID` from `major` `mm` where (`mm`.`ID` = `u`.`majorID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_credentials`
--

/*!50001 DROP VIEW IF EXISTS `user_credentials`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_credentials` AS select `u`.`username` AS `username`,`u`.`userpassword` AS `userpassword`,`r`.`role` AS `Role`,`u`.`ID` AS `ID` from (`users` `u` join `roles` `r` on((`u`.`roleID` = `r`.`ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-30 12:35:11
