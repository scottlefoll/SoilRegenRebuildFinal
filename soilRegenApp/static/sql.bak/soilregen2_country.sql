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
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Aruba'),(2,'Afghanistan'),(3,'Angola'),(4,'Anguilla'),(5,'Albania'),(6,'Andorra'),(7,'Netherlands Antilles'),(8,'United Arab Emirates'),(9,'Argentina'),(10,'Armenia'),(11,'American Samoa'),(12,'Antarctica'),(13,'French Southern territories'),(14,'Antigua and Barbuda'),(15,'Australia'),(16,'Austria'),(17,'Azerbaijan'),(18,'Burundi'),(19,'Belgium'),(20,'Benin'),(21,'Burkina Faso'),(22,'Bangladesh'),(23,'Bulgaria'),(24,'Bahrain'),(25,'Bahamas'),(26,'Bosnia and Herzegovina'),(27,'Belarus'),(28,'Belize'),(29,'Bermuda'),(30,'Bolivia'),(31,'Brazil'),(32,'Barbados'),(33,'Brunei'),(34,'Bhutan'),(35,'Bouvet Island'),(36,'Botswana'),(37,'Central African Republic'),(38,'Canada'),(39,'Cocos (Keeling) Islands'),(40,'Switzerland'),(41,'Chile'),(42,'China'),(43,'Côte dIvoire'),(44,'Cameroon'),(45,'Congo, The Democratic Republic of the'),(46,'Congo'),(47,'Cook Islands'),(48,'Colombia'),(49,'Comoros'),(50,'Cape Verde'),(51,'Costa Rica'),(52,'Cuba'),(53,'Christmas Island'),(54,'Cayman Islands'),(55,'Cyprus'),(56,'Czech Republic'),(57,'Germany'),(58,'Djibouti'),(59,'Dominica'),(60,'Denmark'),(61,'Dominican Republic'),(62,'Algeria'),(63,'Ecuador'),(64,'Egypt'),(65,'Eritrea'),(66,'Western Sahara'),(67,'Spain'),(68,'Estonia'),(69,'Ethiopia'),(70,'Finland'),(71,'Fiji Islands'),(72,'Falkland Islands'),(73,'France'),(74,'Faroe Islands'),(75,'Micronesia, Federated States of'),(76,'Gabon'),(77,'United Kingdom'),(78,'Georgia'),(79,'Ghana'),(80,'Gibraltar'),(81,'Guinea'),(82,'Guadeloupe'),(83,'Gambia'),(84,'Guinea-Bissau'),(85,'Equatorial Guinea'),(86,'Greece'),(87,'Grenada'),(88,'Greenland'),(89,'Guatemala'),(90,'French Guiana'),(91,'Guam'),(92,'Guyana'),(93,'Hong Kong'),(94,'Heard Island and McDonald Islands'),(95,'Honduras'),(96,'Croatia'),(97,'Haiti'),(98,'Hungary'),(99,'Indonesia'),(100,'India'),(101,'British Indian Ocean Territory'),(102,'Ireland'),(103,'Iran'),(104,'Iraq'),(105,'Iceland'),(106,'Israel'),(107,'Italy'),(108,'Jamaica'),(109,'Jordan'),(110,'Japan'),(111,'Kazakstan'),(112,'Kenya'),(113,'Kyrgyzstan'),(114,'Cambodia'),(115,'Kiribati'),(116,'Saint Kitts and Nevis'),(117,'South Korea'),(118,'Kuwait'),(119,'Laos'),(120,'Lebanon'),(121,'Liberia'),(122,'Libyan Arab Jamahiriya'),(123,'Saint Lucia'),(124,'Liechtenstein'),(125,'Sri Lanka'),(126,'Lesotho'),(127,'Lithuania'),(128,'Luxembourg'),(129,'Latvia'),(130,'Macao'),(131,'Morocco'),(132,'Monaco'),(133,'Moldova'),(134,'Madagascar'),(135,'Maldives'),(136,'Mexico'),(137,'Marshall Islands'),(138,'Macedonia'),(139,'Mali'),(140,'Malta'),(141,'Myanmar'),(142,'Mongolia'),(143,'Northern Mariana Islands'),(144,'Mozambique'),(145,'Mauritania'),(146,'Montserrat'),(147,'Martinique'),(148,'Mauritius'),(149,'Malawi'),(150,'Malaysia'),(151,'Mayotte'),(152,'Namibia'),(153,'New Caledonia'),(154,'Niger'),(155,'Norfolk Island'),(156,'Nigeria'),(157,'Nicaragua'),(158,'Niue'),(159,'Netherlands'),(160,'Norway'),(161,'Nepal'),(162,'Nauru'),(163,'New Zealand'),(164,'Oman'),(165,'Pakistan'),(166,'Panama'),(167,'Pitcairn'),(168,'Peru'),(169,'Philippines'),(170,'Palau'),(171,'Papua New Guinea'),(172,'Poland'),(173,'Puerto Rico'),(174,'North Korea'),(175,'Portugal'),(176,'Paraguay'),(177,'Palestine'),(178,'French Polynesia'),(179,'Qatar'),(180,'Réunion'),(181,'Romania'),(182,'Russian Federation'),(183,'Rwanda'),(184,'Saudi Arabia'),(185,'Sudan'),(186,'Senegal'),(187,'Singapore'),(188,'South Georgia and the South Sandwich Islands'),(189,'Saint Helena'),(190,'Svalbard and Jan Mayen'),(191,'Solomon Islands'),(192,'Sierra Leone'),(193,'El Salvador'),(194,'San Marino'),(195,'Somalia'),(196,'Saint Pierre and Miquelon'),(197,'Sao Tome and Principe'),(198,'Suriname'),(199,'Slovakia'),(200,'Slovenia'),(201,'Sweden'),(202,'Swaziland'),(203,'Seychelles'),(204,'Syria'),(205,'Turks and Caicos Islands'),(206,'Chad'),(207,'Togo'),(208,'Thailand'),(209,'Tajikistan'),(210,'Tokelau'),(211,'Turkmenistan'),(212,'East Timor'),(213,'Tonga'),(214,'Trinidad and Tobago'),(215,'Tunisia'),(216,'Turkey'),(217,'Tuvalu'),(218,'Taiwan'),(219,'Tanzania'),(220,'Uganda'),(221,'Ukraine'),(222,'United States Minor Outlying Islands'),(223,'Uruguay'),(224,'United States'),(225,'Uzbekistan'),(226,'Holy See (Vatican City State)'),(227,'Saint Vincent and the Grenadines'),(228,'Venezuela'),(229,'Virgin Islands, British'),(230,'Virgin Islands, U.S.'),(231,'Vietnam'),(232,'Vanuatu'),(233,'Wallis and Futuna'),(234,'Samoa'),(235,'Yemen'),(236,'Yugoslavia'),(237,'South Africa'),(238,'Zambia'),(239,'Zimbabwe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-23 15:55:36