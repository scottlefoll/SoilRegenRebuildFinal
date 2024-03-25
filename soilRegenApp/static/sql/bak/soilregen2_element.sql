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
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `element` (
  `element_id` int NOT NULL AUTO_INCREMENT,
  `element_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `common_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `element_symbol` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`element_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,'Nitrogen','Nitrogen','N','Essential for plant growth, as it is a major part of chlorophyll. Nitrogen helps plants with rapid growth, increasing seed and fruit production and improving the quality of leaf and forage crops.'),(2,'Phosphorus','Phosphorus','P','It is a part of the process of photosynthesis, aids in plant maturity, and contributes to the plant\'s yield.'),(3,'Potassium','Potassium','K','Potassium improves overall vigor of the plant. It helps the plants to resist diseases, aids in photosynthesis, and in producing proteins.'),(4,'Calcium','Calcium','Ca','Calcium improves general plant vigor and promotes early root formation and growth. It also helps in neutralizing cell acids.'),(5,'Magnesium','Magnesium','Mg','Magnesium is crucial for seed germination and the production of chlorophyll, fruit, and seeds. It also aids in the absorption of phosphorus in the plant.'),(6,'Sulfur','Sulfur','S','Sulfur is essential for the production of proteins and it aids in the formation of certain oils and volatile compounds.'),(7,'Iron','Iron','Fe','Iron is essential for crop growth and food production. It aids in the synthesis of chlorophyll.'),(8,'Manganese','Manganese','Mn','Manganese helps plants to break down carbohydrates and aids in nitrogen metabolism.'),(9,'Zinc','Zinc','Zn','Zinc plays a considerable role in the growth of the plant, protein synthesis and energy production.'),(10,'Copper','Copper','Cu','Copper aids in carbohydrate and nitrogen metabolism. Insufficient copper results in stunting of plants.'),(11,'Boron','Boron','B','Boron is used in cell wall formation and the development of reproductive parts of plants. It affects metabolism and the transport of sugars in plants.'),(12,'Molybdenum','Molybdenum','Mo','Molybdenum is used by plants for the processing of nitrogen.'),(13,'Sodium','Sodium','Na','Sodium can stimulate plant growth and improve plant resistance to diseases.'),(14,'Chlorine','Chlorine','Cl','Chlorine is essential for photosynthesis process in plants.'),(15,'Selenium','Selenium','Se','Selenium has an essential role in maintaining the integrity of plant cell membranes.'),(16,'Nickel','Nickel','Ni','Nickel is essential for the activation of certain plant enzymes and also helps in the process of nitrogen assimilation.'),(17,'Cobalt','Cobalt','Co','Cobalt is an essential component of several enzymes and co-enzymes. It has been shown to affect growth and metabolism of plants.'),(18,'Silicon','Silicon','Si','Silicon helps in giving strength to plants and in resistance to insects and diseases.'),(19,'Vanadium','Vanadium','V','Vanadium is believed to play a role in the regulation of enzyme activities in plants.'),(20,'Strontium','Strontium','Sr','Strontium is thought to help in the formation and growth of plants.');
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-23 15:32:47
