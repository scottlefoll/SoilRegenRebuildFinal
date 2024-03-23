CREATE DATABASE  IF NOT EXISTS `soilregen2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `soilregen2`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: soilregen2
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$qsGPZSZT0G5TyWRIScl2jP$P1H0fbztJlUK+XRJhY/ijWdo6jHeO7ORUtMBFkrM/S0=','2024-03-20 13:34:54.899689',1,'scottlefoll','','','',1,1,'2023-07-19 23:30:46.000000'),(2,'pbkdf2_sha256$600000$TRRqmPpQ4n3EoRu8gACn0k$LEpoidS2F4YoVnE/x5hiqEaX2Ib61IGDb1kxZLjuRfc=',NULL,1,'scottrlefoll','','','slefoll7@gmail.com',1,1,'2023-07-20 20:42:47.713856'),(3,'pbkdf2_sha256$600000$FLGuMpFpG90UiSlVD5RI7h$r0vRzZgnxlIbguCOJARTIG7oRMM69BVtmDN+DMhlYfI=','2023-07-21 16:35:04.359565',1,'scott','','','scottlefoll@gmail.com',1,1,'2023-07-20 20:46:18.222527'),(4,'pbkdf2_sha256$720000$LohiUMn0IGWZ9FRHWK2JzB$fHhkA/Qfldf2s+yZU3QQJ7dczvcuxWQhimFJ3yMt+bE=','2024-03-20 13:29:35.259064',1,'admin','','','admin@soilregen2.com',1,1,'2024-03-20 13:29:10.909996'),(5,'pbkdf2_sha256$720000$1XnGxKe9zDd200HLueiFZ4$fYNzkAAu5AJISujVajkP9UzCkQZUpcVnOtGuy3/qnRM=',NULL,1,'slefoll7','','','',1,1,'2024-03-20 13:31:22.000000'),(6,'pbkdf2_sha256$720000$crNCLcadwsAEoc52N6U20G$x3+BYp2pa0lhKHuzIrHYdx+G6PyLV+PAhirMMlOZkVc=',NULL,1,'scottlefoll@gmail.com','','','',1,1,'2024-03-20 13:31:47.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-23 15:32:48
