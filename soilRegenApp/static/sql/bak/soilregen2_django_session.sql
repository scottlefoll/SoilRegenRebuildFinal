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
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3ewscpvl4z6vqonel496dym9ulty2yy1','.eJxVjEEOwiAQAP_C2ZB2gcJ69N43EGBZqRqalPZk_Lsh6UGvM5N5Cx-Ovfij5c0vJK5Ci8sviyE9c-2CHqHeV5nWum9LlD2Rp21yXim_bmf7Nyihlb5Fpzgzj4YjICKAQgjajaDYYiRK7NhRSMYQuYQWYXBT1oNVZqJI4vMF5pU4BA:1rmw5O:UDQpgXf2g-iCbj2Cw2P8tB4cFgQKtFL6b-s2K9QdFPE','2024-04-03 13:34:30.411449'),('69wwc79ayejdfgu16ctokl48xnmelvxj','.eJxVjDsOwjAQBe_iGlmOHf8o6TmDtd5dcADZUpxUiLuTSCmgfTPz3iLBupS0dp7TROIsjDj9bhnwyXUH9IB6bxJbXeYpy12RB-3y2ohfl8P9OyjQy1YrBOfIBHTaW0VkaHAj5mggm0jMXmOkiBb0SBx9sKgGDbfAnrYyevH5AvJtOHM:1qMbLI:la0SxNRwfz7ZbOMyhXMD--4z7v80KbbtnCLEKb7O4FY','2023-08-03 21:37:48.227831'),('7qzqojpamyt6qpxssqriioji8rrd577o','.eJxVjDkOwjAUBe_iGll2vjco6TmD9RcHB1AixUmFuDuJlALaNzPvrTKuS81rK3MeRF2UVaffjZCfZdyBPHC8T5qncZkH0ruiD9r0bZLyuh7u30HFVre6iDD158LAqestEgQvgW2H5KK4RCYYYB-SAZegbCRGAG8MSnDUgfp8AQdMN70:1rmw5m:MzXuBUli1IoF0n3d_iZEY37F7wns540aFltQ967JycE','2024-04-03 13:34:54.923688'),('qkvij6kn54rtvhz7keg664dm6mh3la15','.eJxVjDsOwjAQBe_iGlmOHf8o6TmDtd5dcADZUpxUiLuTSCmgfTPz3iLBupS0dp7TROIsjDj9bhnwyXUH9IB6bxJbXeYpy12RB-3y2ohfl8P9OyjQy1YrBOfIBHTaW0VkaHAj5mggm0jMXmOkiBb0SBx9sKgGDbfAnrYyevH5AvJtOHM:1qMt5s:cvBfi3C__Q1IK_8SiGlRt7Oys-WLFADa7HoIq-0ZuZU','2023-08-04 16:35:04.482238');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
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
