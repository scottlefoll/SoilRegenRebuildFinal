-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: soilregen4
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
-- Table structure for table `amendment`
--

DROP TABLE IF EXISTS `amendment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendment` (
  `amendment_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) DEFAULT NULL,
  `brand_name` varchar(50) DEFAULT NULL,
  `organic` int DEFAULT NULL,
  `organic_certified` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `cat_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`amendment_id`),
  KEY `amendment_cat_id_16c2a6e0_fk_amendment_category_cat_id` (`cat_id`),
  KEY `amendment_country_id_254bc5cd_fk_country_country_id` (`country_id`),
  KEY `amendment_type_id_86e595ce_fk_amendment_type_type_id` (`type_id`),
  CONSTRAINT `amendment_cat_id_16c2a6e0_fk_amendment_category_cat_id` FOREIGN KEY (`cat_id`) REFERENCES `amendment_category` (`cat_id`),
  CONSTRAINT `amendment_country_id_254bc5cd_fk_country_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  CONSTRAINT `amendment_type_id_86e595ce_fk_amendment_type_type_id` FOREIGN KEY (`type_id`) REFERENCES `amendment_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment`
--

LOCK TABLES `amendment` WRITE;
/*!40000 ALTER TABLE `amendment` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendment_category`
--

DROP TABLE IF EXISTS `amendment_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendment_category` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment_category`
--

LOCK TABLES `amendment_category` WRITE;
/*!40000 ALTER TABLE `amendment_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendment_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendment_element`
--

DROP TABLE IF EXISTS `amendment_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendment_element` (
  `amendment_element_id` int NOT NULL AUTO_INCREMENT,
  `quantity` double DEFAULT NULL,
  `units` varchar(20) DEFAULT NULL,
  `amendment_id` int DEFAULT NULL,
  `element_id` int DEFAULT NULL,
  PRIMARY KEY (`amendment_element_id`),
  UNIQUE KEY `amendment_element_amendment_id_element_id_c48b6b61_uniq` (`amendment_id`,`element_id`),
  KEY `amendment_element_element_id_1f2b882c_fk_element_element_id` (`element_id`),
  CONSTRAINT `amendment_element_amendment_id_1f010cf6_fk_amendment` FOREIGN KEY (`amendment_id`) REFERENCES `amendment` (`amendment_id`),
  CONSTRAINT `amendment_element_element_id_1f2b882c_fk_element_element_id` FOREIGN KEY (`element_id`) REFERENCES `element` (`element_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment_element`
--

LOCK TABLES `amendment_element` WRITE;
/*!40000 ALTER TABLE `amendment_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendment_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amendment_type`
--

DROP TABLE IF EXISTS `amendment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendment_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment_type`
--

LOCK TABLES `amendment_type` WRITE;
/*!40000 ALTER TABLE `amendment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `amendment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis`
--

DROP TABLE IF EXISTS `analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis` (
  `analysis_id` int NOT NULL AUTO_INCREMENT,
  `analysis_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `soil_report_id` int DEFAULT NULL,
  PRIMARY KEY (`analysis_id`),
  KEY `analysis_soil_report_id_c13371b4_fk_soil_report_report_id` (`soil_report_id`),
  CONSTRAINT `analysis_soil_report_id_c13371b4_fk_soil_report_report_id` FOREIGN KEY (`soil_report_id`) REFERENCES `soil_report` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis`
--

LOCK TABLES `analysis` WRITE;
/*!40000 ALTER TABLE `analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_item`
--

DROP TABLE IF EXISTS `analysis_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis_item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `analysis_id` int DEFAULT NULL,
  `report_item_id` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `analysis_item_analysis_id_acc6a87b_fk_analysis_analysis_id` (`analysis_id`),
  KEY `analysis_item_report_item_id_62c50d5c_fk_report_item_item_id` (`report_item_id`),
  CONSTRAINT `analysis_item_analysis_id_acc6a87b_fk_analysis_analysis_id` FOREIGN KEY (`analysis_id`) REFERENCES `analysis` (`analysis_id`),
  CONSTRAINT `analysis_item_report_item_id_62c50d5c_fk_report_item_item_id` FOREIGN KEY (`report_item_id`) REFERENCES `report_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_item`
--

LOCK TABLES `analysis_item` WRITE;
/*!40000 ALTER TABLE `analysis_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `analysis_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `application_name` varchar(20) NOT NULL,
  PRIMARY KEY (`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,'foliar spray'),(2,'soil drench'),(3,'side dressing'),(4,'top dressing'),(5,'broadcast'),(6,'seed'),(7,'till');
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add amendment',1,'add_amendment'),(2,'Can change amendment',1,'change_amendment'),(3,'Can delete amendment',1,'delete_amendment'),(4,'Can view amendment',1,'view_amendment'),(5,'Can add amendment category',2,'add_amendmentcategory'),(6,'Can change amendment category',2,'change_amendmentcategory'),(7,'Can delete amendment category',2,'delete_amendmentcategory'),(8,'Can view amendment category',2,'view_amendmentcategory'),(9,'Can add amendment type',3,'add_amendmenttype'),(10,'Can change amendment type',3,'change_amendmenttype'),(11,'Can delete amendment type',3,'delete_amendmenttype'),(12,'Can view amendment type',3,'view_amendmenttype'),(13,'Can add analysis',4,'add_analysis'),(14,'Can change analysis',4,'change_analysis'),(15,'Can delete analysis',4,'delete_analysis'),(16,'Can view analysis',4,'view_analysis'),(17,'Can add application',5,'add_application'),(18,'Can change application',5,'change_application'),(19,'Can delete application',5,'delete_application'),(20,'Can view application',5,'view_application'),(21,'Can add country',6,'add_country'),(22,'Can change country',6,'change_country'),(23,'Can delete country',6,'delete_country'),(24,'Can view country',6,'view_country'),(25,'Can add element',7,'add_element'),(26,'Can change element',7,'change_element'),(27,'Can delete element',7,'delete_element'),(28,'Can view element',7,'view_element'),(29,'Can add farm',8,'add_farm'),(30,'Can change farm',8,'change_farm'),(31,'Can delete farm',8,'delete_farm'),(32,'Can view farm',8,'view_farm'),(33,'Can add field',9,'add_field'),(34,'Can change field',9,'change_field'),(35,'Can delete field',9,'delete_field'),(36,'Can view field',9,'view_field'),(37,'Can add ingredient category',10,'add_ingredientcategory'),(38,'Can change ingredient category',10,'change_ingredientcategory'),(39,'Can delete ingredient category',10,'delete_ingredientcategory'),(40,'Can view ingredient category',10,'view_ingredientcategory'),(41,'Can add ingredient type',11,'add_ingredienttype'),(42,'Can change ingredient type',11,'change_ingredienttype'),(43,'Can delete ingredient type',11,'delete_ingredienttype'),(44,'Can view ingredient type',11,'view_ingredienttype'),(45,'Can add practice',12,'add_practice'),(46,'Can change practice',12,'change_practice'),(47,'Can delete practice',12,'delete_practice'),(48,'Can view practice',12,'view_practice'),(49,'Can add recipe',13,'add_recipe'),(50,'Can change recipe',13,'change_recipe'),(51,'Can delete recipe',13,'delete_recipe'),(52,'Can view recipe',13,'view_recipe'),(53,'Can add recipe category',14,'add_recipecategory'),(54,'Can change recipe category',14,'change_recipecategory'),(55,'Can delete recipe category',14,'delete_recipecategory'),(56,'Can view recipe category',14,'view_recipecategory'),(57,'Can add recipe type',15,'add_recipetype'),(58,'Can change recipe type',15,'change_recipetype'),(59,'Can delete recipe type',15,'delete_recipetype'),(60,'Can view recipe type',15,'view_recipetype'),(61,'Can add source',16,'add_source'),(62,'Can change source',16,'change_source'),(63,'Can delete source',16,'delete_source'),(64,'Can view source',16,'view_source'),(65,'Can add unit',17,'add_unit'),(66,'Can change unit',17,'change_unit'),(67,'Can delete unit',17,'delete_unit'),(68,'Can view unit',17,'view_unit'),(69,'Can add user profile',18,'add_userprofile'),(70,'Can change user profile',18,'change_userprofile'),(71,'Can delete user profile',18,'delete_userprofile'),(72,'Can view user profile',18,'view_userprofile'),(73,'Can add soil report',19,'add_soilreport'),(74,'Can change soil report',19,'change_soilreport'),(75,'Can delete soil report',19,'delete_soilreport'),(76,'Can view soil report',19,'view_soilreport'),(77,'Can add report item',20,'add_reportitem'),(78,'Can change report item',20,'change_reportitem'),(79,'Can delete report item',20,'delete_reportitem'),(80,'Can view report item',20,'view_reportitem'),(81,'Can add recipe step',21,'add_recipestep'),(82,'Can change recipe step',21,'change_recipestep'),(83,'Can delete recipe step',21,'delete_recipestep'),(84,'Can view recipe step',21,'view_recipestep'),(85,'Can add recipe ingredient',22,'add_recipeingredient'),(86,'Can change recipe ingredient',22,'change_recipeingredient'),(87,'Can delete recipe ingredient',22,'delete_recipeingredient'),(88,'Can view recipe ingredient',22,'view_recipeingredient'),(89,'Can add ingredient',23,'add_ingredient'),(90,'Can change ingredient',23,'change_ingredient'),(91,'Can delete ingredient',23,'delete_ingredient'),(92,'Can view ingredient',23,'view_ingredient'),(93,'Can add comment',24,'add_comment'),(94,'Can change comment',24,'change_comment'),(95,'Can delete comment',24,'delete_comment'),(96,'Can view comment',24,'view_comment'),(97,'Can add analysis item',25,'add_analysisitem'),(98,'Can change analysis item',25,'change_analysisitem'),(99,'Can delete analysis item',25,'delete_analysisitem'),(100,'Can view analysis item',25,'view_analysisitem'),(101,'Can add source amendment',26,'add_sourceamendment'),(102,'Can change source amendment',26,'change_sourceamendment'),(103,'Can delete source amendment',26,'delete_sourceamendment'),(104,'Can view source amendment',26,'view_sourceamendment'),(105,'Can add amendment element',27,'add_amendmentelement'),(106,'Can change amendment element',27,'change_amendmentelement'),(107,'Can delete amendment element',27,'delete_amendmentelement'),(108,'Can view amendment element',27,'view_amendmentelement'),(109,'Can add log entry',28,'add_logentry'),(110,'Can change log entry',28,'change_logentry'),(111,'Can delete log entry',28,'delete_logentry'),(112,'Can view log entry',28,'view_logentry'),(113,'Can add permission',29,'add_permission'),(114,'Can change permission',29,'change_permission'),(115,'Can delete permission',29,'delete_permission'),(116,'Can view permission',29,'view_permission'),(117,'Can add group',30,'add_group'),(118,'Can change group',30,'change_group'),(119,'Can delete group',30,'delete_group'),(120,'Can view group',30,'view_group'),(121,'Can add user',31,'add_user'),(122,'Can change user',31,'change_user'),(123,'Can delete user',31,'delete_user'),(124,'Can view user',31,'view_user'),(125,'Can add content type',32,'add_contenttype'),(126,'Can change content type',32,'change_contenttype'),(127,'Can delete content type',32,'delete_contenttype'),(128,'Can view content type',32,'view_contenttype'),(129,'Can add session',33,'add_session'),(130,'Can change session',33,'change_session'),(131,'Can delete session',33,'delete_session'),(132,'Can view session',33,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$NF9JrlA8oSLx0vx6HKlax0$+dbXZ4uoDhrp4f+v3xys281FkX6Y3cmdRDfvNevWsoA=','2024-03-31 01:48:28.098853',1,'scottlefoll','','','',1,1,'2023-07-19 23:30:46.000000'),(3,'pbkdf2_sha256$600000$FLGuMpFpG90UiSlVD5RI7h$r0vRzZgnxlIbguCOJARTIG7oRMM69BVtmDN+DMhlYfI=','2023-07-21 16:35:04.359565',1,'scott','','','scottlefoll@gmail.com',1,1,'2023-07-20 20:46:18.222527'),(4,'pbkdf2_sha256$720000$LohiUMn0IGWZ9FRHWK2JzB$fHhkA/Qfldf2s+yZU3QQJ7dczvcuxWQhimFJ3yMt+bE=','2024-03-20 13:29:35.259064',1,'admin','','','admin@soilregen2.com',1,1,'2024-03-20 13:29:10.909996');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `comment_text` varchar(255) NOT NULL,
  `amendment_id` int DEFAULT NULL,
  `recipe_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_amendment_id_5f4ff105_fk_amendment_amendment_id` (`amendment_id`),
  KEY `comment_recipe_id_817c14ef_fk_recipe_recipe_id` (`recipe_id`),
  KEY `comment_user_id_2224f9d1_fk_user_profile_user_id` (`user_id`),
  CONSTRAINT `comment_amendment_id_5f4ff105_fk_amendment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `amendment` (`amendment_id`),
  CONSTRAINT `comment_recipe_id_817c14ef_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `comment_user_id_2224f9d1_fk_user_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Aruba'),(2,'Afghanistan'),(3,'Angola'),(4,'Anguilla'),(5,'Albania'),(6,'Andorra'),(7,'Netherlands Antilles'),(8,'United Arab Emirates'),(9,'Argentina'),(10,'Armenia'),(11,'American Samoa'),(12,'Antarctica'),(13,'French Southern territories'),(14,'Antigua and Barbuda'),(15,'Australia'),(16,'Austria'),(17,'Azerbaijan'),(18,'Burundi'),(19,'Belgium'),(20,'Benin'),(21,'Burkina Faso'),(22,'Bangladesh'),(23,'Bulgaria'),(24,'Bahrain'),(25,'Bahamas'),(26,'Bosnia and Herzegovina'),(27,'Belarus'),(28,'Belize'),(29,'Bermuda'),(30,'Bolivia'),(31,'Brazil'),(32,'Barbados'),(33,'Brunei'),(34,'Bhutan'),(35,'Bouvet Island'),(36,'Botswana'),(37,'Central African Republic'),(38,'Canada'),(39,'Cocos (Keeling) Islands'),(40,'Switzerland'),(41,'Chile'),(42,'China'),(43,'Côte dIvoire'),(44,'Cameroon'),(45,'Congo, The Democratic Republic of the'),(46,'Congo'),(47,'Cook Islands'),(48,'Colombia'),(49,'Comoros'),(50,'Cape Verde'),(51,'Costa Rica'),(52,'Cuba'),(53,'Christmas Island'),(54,'Cayman Islands'),(55,'Cyprus'),(56,'Czech Republic'),(57,'Germany'),(58,'Djibouti'),(59,'Dominica'),(60,'Denmark'),(61,'Dominican Republic'),(62,'Algeria'),(63,'Ecuador'),(64,'Egypt'),(65,'Eritrea'),(66,'Western Sahara'),(67,'Spain'),(68,'Estonia'),(69,'Ethiopia'),(70,'Finland'),(71,'Fiji Islands'),(72,'Falkland Islands'),(73,'France'),(74,'Faroe Islands'),(75,'Micronesia, Federated States of'),(76,'Gabon'),(77,'United Kingdom'),(78,'Georgia'),(79,'Ghana'),(80,'Gibraltar'),(81,'Guinea'),(82,'Guadeloupe'),(83,'Gambia'),(84,'Guinea-Bissau'),(85,'Equatorial Guinea'),(86,'Greece'),(87,'Grenada'),(88,'Greenland'),(89,'Guatemala'),(90,'French Guiana'),(91,'Guam'),(92,'Guyana'),(93,'Hong Kong'),(94,'Heard Island and McDonald Islands'),(95,'Honduras'),(96,'Croatia'),(97,'Haiti'),(98,'Hungary'),(99,'Indonesia'),(100,'India'),(101,'British Indian Ocean Territory'),(102,'Ireland'),(103,'Iran'),(104,'Iraq'),(105,'Iceland'),(106,'Israel'),(107,'Italy'),(108,'Jamaica'),(109,'Jordan'),(110,'Japan'),(111,'Kazakstan'),(112,'Kenya'),(113,'Kyrgyzstan'),(114,'Cambodia'),(115,'Kiribati'),(116,'Saint Kitts and Nevis'),(117,'South Korea'),(118,'Kuwait'),(119,'Laos'),(120,'Lebanon'),(121,'Liberia'),(122,'Libyan Arab Jamahiriya'),(123,'Saint Lucia'),(124,'Liechtenstein'),(125,'Sri Lanka'),(126,'Lesotho'),(127,'Lithuania'),(128,'Luxembourg'),(129,'Latvia'),(130,'Macao'),(131,'Morocco'),(132,'Monaco'),(133,'Moldova'),(134,'Madagascar'),(135,'Maldives'),(136,'Mexico'),(137,'Marshall Islands'),(138,'Macedonia'),(139,'Mali'),(140,'Malta'),(141,'Myanmar'),(142,'Mongolia'),(143,'Northern Mariana Islands'),(144,'Mozambique'),(145,'Mauritania'),(146,'Montserrat'),(147,'Martinique'),(148,'Mauritius'),(149,'Malawi'),(150,'Malaysia'),(151,'Mayotte'),(152,'Namibia'),(153,'New Caledonia'),(154,'Niger'),(155,'Norfolk Island'),(156,'Nigeria'),(157,'Nicaragua'),(158,'Niue'),(159,'Netherlands'),(160,'Norway'),(161,'Nepal'),(162,'Nauru'),(163,'New Zealand'),(164,'Oman'),(165,'Pakistan'),(166,'Panama'),(167,'Pitcairn'),(168,'Peru'),(169,'Philippines'),(170,'Palau'),(171,'Papua New Guinea'),(172,'Poland'),(173,'Puerto Rico'),(174,'North Korea'),(175,'Portugal'),(176,'Paraguay'),(177,'Palestine'),(178,'French Polynesia'),(179,'Qatar'),(180,'Réunion'),(181,'Romania'),(182,'Russian Federation'),(183,'Rwanda'),(184,'Saudi Arabia'),(185,'Sudan'),(186,'Senegal'),(187,'Singapore'),(188,'South Georgia and the South Sandwich Islands'),(189,'Saint Helena'),(190,'Svalbard and Jan Mayen'),(191,'Solomon Islands'),(192,'Sierra Leone'),(193,'El Salvador'),(194,'San Marino'),(195,'Somalia'),(196,'Saint Pierre and Miquelon'),(197,'Sao Tome and Principe'),(198,'Suriname'),(199,'Slovakia'),(200,'Slovenia'),(201,'Sweden'),(202,'Swaziland'),(203,'Seychelles'),(204,'Syria'),(205,'Turks and Caicos Islands'),(206,'Chad'),(207,'Togo'),(208,'Thailand'),(209,'Tajikistan'),(210,'Tokelau'),(211,'Turkmenistan'),(212,'East Timor'),(213,'Tonga'),(214,'Trinidad and Tobago'),(215,'Tunisia'),(216,'Turkey'),(217,'Tuvalu'),(218,'Taiwan'),(219,'Tanzania'),(220,'Uganda'),(221,'Ukraine'),(222,'United States Minor Outlying Islands'),(223,'Uruguay'),(224,'United States'),(225,'Uzbekistan'),(226,'Holy See (Vatican City State)'),(227,'Saint Vincent and the Grenadines'),(228,'Venezuela'),(229,'Virgin Islands, British'),(230,'Virgin Islands, U.S.'),(231,'Vietnam'),(232,'Vanuatu'),(233,'Wallis and Futuna'),(234,'Samoa'),(235,'Yemen'),(236,'Yugoslavia'),(237,'South Africa'),(238,'Zambia'),(239,'Zimbabwe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (28,'admin','logentry'),(30,'auth','group'),(29,'auth','permission'),(31,'auth','user'),(32,'contenttypes','contenttype'),(33,'sessions','session'),(1,'soilRegenApp','amendment'),(2,'soilRegenApp','amendmentcategory'),(27,'soilRegenApp','amendmentelement'),(3,'soilRegenApp','amendmenttype'),(4,'soilRegenApp','analysis'),(25,'soilRegenApp','analysisitem'),(5,'soilRegenApp','application'),(24,'soilRegenApp','comment'),(6,'soilRegenApp','country'),(7,'soilRegenApp','element'),(8,'soilRegenApp','farm'),(9,'soilRegenApp','field'),(23,'soilRegenApp','ingredient'),(10,'soilRegenApp','ingredientcategory'),(11,'soilRegenApp','ingredienttype'),(12,'soilRegenApp','practice'),(13,'soilRegenApp','recipe'),(14,'soilRegenApp','recipecategory'),(22,'soilRegenApp','recipeingredient'),(21,'soilRegenApp','recipestep'),(15,'soilRegenApp','recipetype'),(20,'soilRegenApp','reportitem'),(19,'soilRegenApp','soilreport'),(16,'soilRegenApp','source'),(26,'soilRegenApp','sourceamendment'),(17,'soilRegenApp','unit'),(18,'soilRegenApp','userprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-31 01:36:52.051733'),(2,'auth','0001_initial','2024-03-31 01:36:54.039905'),(3,'admin','0001_initial','2024-03-31 01:36:54.255630'),(4,'admin','0002_logentry_remove_auto_add','2024-03-31 01:36:54.271255'),(5,'admin','0003_logentry_add_action_flag_choices','2024-03-31 01:36:54.303258'),(6,'contenttypes','0002_remove_content_type_name','2024-03-31 01:36:54.424925'),(7,'auth','0002_alter_permission_name_max_length','2024-03-31 01:36:54.563965'),(8,'auth','0003_alter_user_email_max_length','2024-03-31 01:36:54.601158'),(9,'auth','0004_alter_user_username_opts','2024-03-31 01:36:54.615947'),(10,'auth','0005_alter_user_last_login_null','2024-03-31 01:36:54.765501'),(11,'auth','0006_require_contenttypes_0002','2024-03-31 01:36:54.796746'),(12,'auth','0007_alter_validators_add_error_messages','2024-03-31 01:36:54.818173'),(13,'auth','0008_alter_user_username_max_length','2024-03-31 01:36:54.920162'),(14,'auth','0009_alter_user_last_name_max_length','2024-03-31 01:36:54.999248'),(15,'auth','0010_alter_group_name_max_length','2024-03-31 01:36:55.027269'),(16,'auth','0011_update_proxy_permissions','2024-03-31 01:36:55.033433'),(17,'auth','0012_alter_user_first_name_max_length','2024-03-31 01:36:55.133247'),(18,'sessions','0001_initial','2024-03-31 01:36:55.201117'),(19,'soilRegenApp','0001_initial','2024-03-31 01:37:00.639156'),(20,'soilRegenApp','0002_recipeingredient_ingredient','2024-04-01 19:05:51.782174'),(21,'soilRegenApp','0003_alter_ingredient_practice','2024-04-01 20:33:03.035256'),(22,'soilRegenApp','0004_alter_unit_table','2024-04-02 12:42:43.902100');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `element` (
  `element_id` int NOT NULL AUTO_INCREMENT,
  `element_name` varchar(50) DEFAULT NULL,
  `common_name` varchar(50) DEFAULT NULL,
  `element_symbol` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`element_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farm`
--

DROP TABLE IF EXISTS `farm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farm` (
  `farm_id` int NOT NULL AUTO_INCREMENT,
  `farm_name` varchar(50) DEFAULT NULL,
  `street_address` varchar(50) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `zip` varchar(5) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`farm_id`),
  KEY `farm_user_id_80970093_fk_auth_user_id` (`user_id`),
  CONSTRAINT `farm_user_id_80970093_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farm`
--

LOCK TABLES `farm` WRITE;
/*!40000 ALTER TABLE `farm` DISABLE KEYS */;
/*!40000 ALTER TABLE `farm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field` (
  `field_id` int NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) DEFAULT NULL,
  `field_acres` double DEFAULT NULL,
  `soil_type` varchar(50) DEFAULT NULL,
  `growing_zone` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `farm_id` int DEFAULT NULL,
  PRIMARY KEY (`field_id`),
  KEY `field_farm_id_ff9c78c4_fk_farm_farm_id` (`farm_id`),
  CONSTRAINT `field_farm_id_ff9c78c4_fk_farm_farm_id` FOREIGN KEY (`farm_id`) REFERENCES `farm` (`farm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ingredient_id` int NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(45) NOT NULL,
  `ingredient_description` varchar(100) NOT NULL,
  `ingredient_category_id` int NOT NULL,
  `ingredient_type_id` int NOT NULL,
  `practice_id` int NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_ingredient_category__86738f30_fk_ingredien` (`ingredient_category_id`),
  KEY `ingredient_ingredient_type_id_e03630cd_fk_ingredien` (`ingredient_type_id`),
  KEY `ingredient_practice_id_fe8ed3e7` (`practice_id`),
  CONSTRAINT `ingredient_ingredient_category__86738f30_fk_ingredien` FOREIGN KEY (`ingredient_category_id`) REFERENCES `ingredient_category` (`cat_id`),
  CONSTRAINT `ingredient_ingredient_type_id_e03630cd_fk_ingredien` FOREIGN KEY (`ingredient_type_id`) REFERENCES `ingredient_type` (`ingredient_type_id`),
  CONSTRAINT `ingredient_practice_id_fe8ed3e7_fk_practice_practice_id` FOREIGN KEY (`practice_id`) REFERENCES `practice` (`practice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (3,'magnesium sulfate','magnesium supplement',7,3,8),(4,'wood ash','carbon supplement',9,4,9),(5,'compost','carbon supplement',9,4,11),(6,'potassium sulfate','potassium supplement',7,3,13),(7,'azomite','mineral supplement',9,4,14),(8,'real salt','mineral supplement',9,4,15),(9,'microrhizal fungi','innoculent',9,5,16);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_category`
--

DROP TABLE IF EXISTS `ingredient_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_category` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_category`
--

LOCK TABLES `ingredient_category` WRITE;
/*!40000 ALTER TABLE `ingredient_category` DISABLE KEYS */;
INSERT INTO `ingredient_category` VALUES (1,'compost'),(2,'fertilizer'),(3,'pesticide'),(4,'heribicide'),(5,'stimulant'),(6,'innoculant'),(7,'mineral'),(8,'carbon'),(9,'pH balancer');
/*!40000 ALTER TABLE `ingredient_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_type`
--

DROP TABLE IF EXISTS `ingredient_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient_type` (
  `ingredient_type_id` int NOT NULL AUTO_INCREMENT,
  `ingredient_type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`ingredient_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_type`
--

LOCK TABLES `ingredient_type` WRITE;
/*!40000 ALTER TABLE `ingredient_type` DISABLE KEYS */;
INSERT INTO `ingredient_type` VALUES (1,'liquid'),(2,'granular'),(3,'powder'),(4,'dust'),(5,'pelletized');
/*!40000 ALTER TABLE `ingredient_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice`
--

DROP TABLE IF EXISTS `practice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice` (
  `practice_id` int NOT NULL AUTO_INCREMENT,
  `practice_name` varchar(20) NOT NULL,
  `practice_description` varchar(100) NOT NULL,
  PRIMARY KEY (`practice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice`
--

LOCK TABLES `practice` WRITE;
/*!40000 ALTER TABLE `practice` DISABLE KEYS */;
INSERT INTO `practice` VALUES (8,'organic','Oragnic methods, uncertified.'),(9,'certified organic','Organic methods verfied by organic cerfying agency'),(10,'conventional','Mainstream methods and ingredients'),(11,'biodynamic','Method developed by Rudolph Steiner'),(12,'natural','natural ingredients'),(13,'KNF','Korean Natural Farming - traditional methods'),(14,'aquaculture','Growing in a closed water system of plants and fish'),(15,'permaculture','Philosophy of working with, rather than against nature'),(16,'nutrient dense','Techniques to raise brix and nutrient density');
/*!40000 ALTER TABLE `practice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipe_id` int NOT NULL AUTO_INCREMENT,
  `recipe_name` varchar(45) NOT NULL,
  `recipe_description` varchar(100) NOT NULL,
  `recipe_rate` double NOT NULL,
  `recipe_notes` text NOT NULL,
  `application_id` int NOT NULL,
  `practice_id` int NOT NULL,
  `recipe_category_id` int NOT NULL,
  `recipe_type_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_recipe_category_id_06ef155c_fk_recipe_ca` (`recipe_category_id`),
  KEY `recipe_recipe_type_id_e95b6142_fk_recipe_type_recipe_type_id` (`recipe_type_id`),
  KEY `recipe_unit_id_6313ce04_fk_unit_type_unit_id` (`unit_id`),
  KEY `recipe_user_id_aad0b06c_fk_user_profile_user_id` (`user_id`),
  KEY `recipe_application_id_a321c834_fk_application_application_id` (`application_id`),
  KEY `recipe_practice_id_05099696_fk_practice_practice_id` (`practice_id`),
  CONSTRAINT `recipe_application_id_a321c834_fk_application_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`application_id`),
  CONSTRAINT `recipe_practice_id_05099696_fk_practice_practice_id` FOREIGN KEY (`practice_id`) REFERENCES `practice` (`practice_id`),
  CONSTRAINT `recipe_recipe_category_id_06ef155c_fk_recipe_ca` FOREIGN KEY (`recipe_category_id`) REFERENCES `recipe_category` (`recipe_category_id`),
  CONSTRAINT `recipe_recipe_type_id_e95b6142_fk_recipe_type_recipe_type_id` FOREIGN KEY (`recipe_type_id`) REFERENCES `recipe_type` (`recipe_type_id`),
  CONSTRAINT `recipe_unit_id_6313ce04_fk_unit_type_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`),
  CONSTRAINT `recipe_user_id_aad0b06c_fk_user_profile_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'Brix Booster','Raise the nutrient density and mineral content',1,'A combination of rock minerals to feed soil lives323',1,16,1,1,2,1),(12,'Phosphorus Fix','Add that special something to your crops',50,'Enhances phosphorus for root and flower development.',5,8,7,4,1,3),(13,'Potassium Kick','When you want to increase the fruiting potential',2,'Boosts potassium for overall plant health.',3,8,3,3,1,4),(15,'Acidity Adjuster','When you want to increase the fruiting potential',1,'Lowers soil pH to increase acidity.',5,8,11,2,10,3),(16,'Alkalinity Alleviator','When you want to increase the fruiting potential',5,'Raises soil pH to reduce acidity.',4,11,10,2,1,4),(18,'Drainage Dynamo','When you want to increase the fruiting potential',6,'Enhances drainage in compact soils.',1,12,13,1,2,3),(19,'Organic Matter Maximizer','When you want to increase the fruiting potentialWhen you wan',1,'Maximizes organic content for soil fertility.',5,10,13,5,10,4),(21,'Nitrogen Nourisher','Enhances leaf growth and greenness',4,'Increases nitrogen availability.',5,8,14,2,1,3),(22,'Calcium Connector','Strengthens plant cell walls',2,'Improves calcium uptake.',4,11,7,3,1,4),(23,'Sulfur Supplement','For better protein synthesis',5,'Enhances sulfur content for healthier plants.',1,12,7,1,2,1),(24,'Microbe Multiplier','Boost your soil\'s living organisms',3,'Promotes beneficial microbe populations.',3,12,5,2,4,1);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_category`
--

DROP TABLE IF EXISTS `recipe_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_category` (
  `recipe_category_id` int NOT NULL AUTO_INCREMENT,
  `recipe_category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`recipe_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_category`
--

LOCK TABLES `recipe_category` WRITE;
/*!40000 ALTER TABLE `recipe_category` DISABLE KEYS */;
INSERT INTO `recipe_category` VALUES (1,'compost'),(2,'fertilizer'),(3,'herbicide'),(4,'pesticide'),(5,'stimulant'),(6,'innoculant'),(7,'mineral'),(8,'carbon'),(9,'pH balancer'),(10,'fruiting'),(11,'growth'),(12,'germination'),(13,'nutritional'),(14,'fertilizer');
/*!40000 ALTER TABLE `recipe_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_ingredient`
--

DROP TABLE IF EXISTS `recipe_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ingredient` (
  `recipe_ingredient_id` int NOT NULL AUTO_INCREMENT,
  `recipe_ingredient_quantity` double NOT NULL,
  `recipe_ingredient_notes` varchar(255) DEFAULT NULL,
  `recipe_id` int NOT NULL,
  `source_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`recipe_ingredient_id`),
  KEY `recipe_ingredient_recipe_id_f514f422_fk_recipe_recipe_id` (`recipe_id`),
  KEY `recipe_ingredient_source_id_7290a5a1_fk_source_source_id` (`source_id`),
  KEY `recipe_ingredient_unit_id_e965328f_fk_unit_type_unit_id` (`unit_id`),
  KEY `recipe_ingredient_ingredient_id_03c3e665_fk_ingredien` (`ingredient_id`),
  CONSTRAINT `recipe_ingredient_ingredient_id_03c3e665_fk_ingredien` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `recipe_ingredient_recipe_id_f514f422_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `recipe_ingredient_source_id_7290a5a1_fk_source_source_id` FOREIGN KEY (`source_id`) REFERENCES `source` (`source_id`),
  CONSTRAINT `recipe_ingredient_unit_id_e965328f_fk_unit_type_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_ingredient`
--

LOCK TABLES `recipe_ingredient` WRITE;
/*!40000 ALTER TABLE `recipe_ingredient` DISABLE KEYS */;
INSERT INTO `recipe_ingredient` VALUES (1,5,'Add magnesium sulfate carefully, maintaiing the balance with the potassium.',1,5,1,3),(4,3,'mix in the potassium sulfate thoroughly so the plants don\'t burn',1,5,2,6),(5,6,'Azomite contains over 72 different minerals in ideal ratios',1,3,3,7),(6,2,'Make sure you use a well balanced compost',1,6,4,5);
/*!40000 ALTER TABLE `recipe_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_step`
--

DROP TABLE IF EXISTS `recipe_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_step` (
  `recipe_step_id` int NOT NULL AUTO_INCREMENT,
  `recipe_step_number` int NOT NULL,
  `recipe_step_name` varchar(50) NOT NULL,
  `recipe_step_description` varchar(100) NOT NULL,
  `recipe_step_notes` text,
  `recipe_id` int NOT NULL,
  PRIMARY KEY (`recipe_step_id`),
  KEY `recipe_step_recipe_id_bb16b3a0_fk_recipe_recipe_id` (`recipe_id`),
  CONSTRAINT `recipe_step_recipe_id_bb16b3a0_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_step`
--

LOCK TABLES `recipe_step` WRITE;
/*!40000 ALTER TABLE `recipe_step` DISABLE KEYS */;
INSERT INTO `recipe_step` VALUES (1,1,'Combine ingredients','Mix ingredients thoroughly','make sure that the proportions are right',1),(2,2,'Spread into compost111','Distribute the mix into the compost pile','Add a couple of inches of compost mix, and then a thin layer of recipe mix',1),(3,3,'Ripen compost333','Let heat for 60 days ','Allow the pile to heat for at least 60 days, turning every 3 weeks.',1),(4,4,'Harvest77','The compost is ready when it is fine','When all organic clumps and solids are gone, harvest the compost with the recipe',1),(5,5,'Spread','Spread as a top-dressing or around seed','Drop or hand-spread about 1/2\" layer of finished compost onto bed.',1);
/*!40000 ALTER TABLE `recipe_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_type`
--

DROP TABLE IF EXISTS `recipe_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_type` (
  `recipe_type_id` int NOT NULL AUTO_INCREMENT,
  `recipe_type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`recipe_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_type`
--

LOCK TABLES `recipe_type` WRITE;
/*!40000 ALTER TABLE `recipe_type` DISABLE KEYS */;
INSERT INTO `recipe_type` VALUES (1,'liquid'),(2,'granular'),(3,'powder'),(4,'dust'),(5,'pelletized');
/*!40000 ALTER TABLE `recipe_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_item`
--

DROP TABLE IF EXISTS `report_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `tested_element` varchar(100) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `results` double DEFAULT NULL,
  `target_ratio` double DEFAULT NULL,
  `target_level` double DEFAULT NULL,
  `report_id` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `report_item_report_id_17cc9fc4_fk_soil_report_report_id` (`report_id`),
  CONSTRAINT `report_item_report_id_17cc9fc4_fk_soil_report_report_id` FOREIGN KEY (`report_id`) REFERENCES `soil_report` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_item`
--

LOCK TABLES `report_item` WRITE;
/*!40000 ALTER TABLE `report_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soil_report`
--

DROP TABLE IF EXISTS `soil_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soil_report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `report_date` date DEFAULT NULL,
  `lab_name` varchar(50) DEFAULT NULL,
  `field_id` int NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `soil_report_field_id_a1c42506_fk_field_field_id` (`field_id`),
  CONSTRAINT `soil_report_field_id_a1c42506_fk_field_field_id` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soil_report`
--

LOCK TABLES `soil_report` WRITE;
/*!40000 ALTER TABLE `soil_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `soil_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source` (
  `source_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (1,'local','this can be sourced at any local farm supply'),(2,'Midwest Ag','Excellent midwestern ag supplier'),(3,'BioAg International','specialize in Brix supplements'),(4,'Johnny\'s Selected Seeds','all organic seeds and amendments'),(5,'Northeast Ag','conventional Ag supplier'),(6,'North Country Organics','custom organic blends');
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source_amendment`
--

DROP TABLE IF EXISTS `source_amendment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source_amendment` (
  `source_amendment_id` int NOT NULL AUTO_INCREMENT,
  `amendment_id` int DEFAULT NULL,
  `source_id` int DEFAULT NULL,
  PRIMARY KEY (`source_amendment_id`),
  UNIQUE KEY `source_amendment_source_id_amendment_id_e12a33b1_uniq` (`source_id`,`amendment_id`),
  KEY `source_amendment_amendment_id_b234480e_fk_amendment_amendment_id` (`amendment_id`),
  CONSTRAINT `source_amendment_amendment_id_b234480e_fk_amendment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `amendment` (`amendment_id`),
  CONSTRAINT `source_amendment_source_id_718bb179_fk_source_source_id` FOREIGN KEY (`source_id`) REFERENCES `source` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source_amendment`
--

LOCK TABLES `source_amendment` WRITE;
/*!40000 ALTER TABLE `source_amendment` DISABLE KEYS */;
/*!40000 ALTER TABLE `source_amendment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(45) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (1,'lb(s)'),(2,'qt(s)'),(3,'pt(s)'),(4,'gal(s)'),(5,'kg(s)'),(6,'mg(s)'),(7,'liter(s)'),(8,'cup(s)'),(9,'oz'),(10,'ton(s)');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `user_id` int NOT NULL,
  `street_address` varchar(50) NOT NULL,
  `town` varchar(50) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip` varchar(5) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profile_user_id_8fdce8e2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (1,'123 Elm St','Herkimer','NY','10001','1234567890','Example Note 1'),(3,'395 Vt. Route 102','Maidstone','VT','05905','8022742548','12 year organic farmer, recent CSA'),(4,'321 Maple St','Barstow','CA','90002','2223334444','Example Note 4');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'soilregen4'
--

--
-- Dumping routines for database 'soilregen4'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-09 11:10:59
