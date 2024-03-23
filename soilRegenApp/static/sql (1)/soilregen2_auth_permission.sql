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
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add amendment',7,'add_amendment'),(26,'Can change amendment',7,'change_amendment'),(27,'Can delete amendment',7,'delete_amendment'),(28,'Can view amendment',7,'view_amendment'),(29,'Can add amendment category',8,'add_amendmentcategory'),(30,'Can change amendment category',8,'change_amendmentcategory'),(31,'Can delete amendment category',8,'delete_amendmentcategory'),(32,'Can view amendment category',8,'view_amendmentcategory'),(33,'Can add amendment element',9,'add_amendmentelement'),(34,'Can change amendment element',9,'change_amendmentelement'),(35,'Can delete amendment element',9,'delete_amendmentelement'),(36,'Can view amendment element',9,'view_amendmentelement'),(37,'Can add amendment type',10,'add_amendmenttype'),(38,'Can change amendment type',10,'change_amendmenttype'),(39,'Can delete amendment type',10,'delete_amendmenttype'),(40,'Can view amendment type',10,'view_amendmenttype'),(41,'Can add analysis',11,'add_analysis'),(42,'Can change analysis',11,'change_analysis'),(43,'Can delete analysis',11,'delete_analysis'),(44,'Can view analysis',11,'view_analysis'),(45,'Can add analysis item',12,'add_analysisitem'),(46,'Can change analysis item',12,'change_analysisitem'),(47,'Can delete analysis item',12,'delete_analysisitem'),(48,'Can view analysis item',12,'view_analysisitem'),(49,'Can add country',13,'add_country'),(50,'Can change country',13,'change_country'),(51,'Can delete country',13,'delete_country'),(52,'Can view country',13,'view_country'),(53,'Can add element',14,'add_element'),(54,'Can change element',14,'change_element'),(55,'Can delete element',14,'delete_element'),(56,'Can view element',14,'view_element'),(57,'Can add farm',15,'add_farm'),(58,'Can change farm',15,'change_farm'),(59,'Can delete farm',15,'delete_farm'),(60,'Can view farm',15,'view_farm'),(61,'Can add field',16,'add_field'),(62,'Can change field',16,'change_field'),(63,'Can delete field',16,'delete_field'),(64,'Can view field',16,'view_field'),(65,'Can add report item',17,'add_reportitem'),(66,'Can change report item',17,'change_reportitem'),(67,'Can delete report item',17,'delete_reportitem'),(68,'Can view report item',17,'view_reportitem'),(69,'Can add soil report',18,'add_soilreport'),(70,'Can change soil report',18,'change_soilreport'),(71,'Can delete soil report',18,'delete_soilreport'),(72,'Can view soil report',18,'view_soilreport'),(73,'Can add source',19,'add_source'),(74,'Can change source',19,'change_source'),(75,'Can delete source',19,'delete_source'),(76,'Can view source',19,'view_source'),(77,'Can add source amendment',20,'add_sourceamendment'),(78,'Can change source amendment',20,'change_sourceamendment'),(79,'Can delete source amendment',20,'delete_sourceamendment'),(80,'Can view source amendment',20,'view_sourceamendment'),(81,'Can add user profile',21,'add_userprofile'),(82,'Can change user profile',21,'change_userprofile'),(83,'Can delete user profile',21,'delete_userprofile'),(84,'Can view user profile',21,'view_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
