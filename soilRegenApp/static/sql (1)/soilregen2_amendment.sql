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
-- Table structure for table `amendment`
--

DROP TABLE IF EXISTS `amendment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amendment` (
  `amendment_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `brand_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `organic` tinyint(1) DEFAULT NULL,
  `organic_certified` tinyint(1) DEFAULT NULL,
  `cat_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`amendment_id`),
  KEY `country_id` (`country_id`),
  KEY `cat_id` (`cat_id`),
  KEY `type_id` (`type_id`),
  KEY `amendment_ibfk_4_idx` (`user_id`),
  CONSTRAINT `amendment_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amendment`
--

LOCK TABLES `amendment` WRITE;
/*!40000 ALTER TABLE `amendment` DISABLE KEYS */;
INSERT INTO `amendment` VALUES (1,'Alfalfa Meal','Generic',224,1,1,1,1,'Alfalfa Meal is a natural source of readily available nitrogen for plants. It can be used in compost teas as a microbe catalyst to improve the growth of microbes in your teas. This amendment can be spread on soil.',NULL),(2,'Aragonite','Generic',224,1,1,1,1,'Aragonite is a sea calcium that is exceptionally high in calcium and low in magnesium. It is made from mollusk shells, and can be used on soils that need calcium, but no magnesium. This is a great soil amendment to use.',NULL),(3,'Azomite','Generic',224,1,1,1,1,'AZOMITE is a natural mineral substance which is mined directly from its Utah desert source. OMRI-Listed for organic production, AZOMITE can be used as an agricultural fertilizer and/or soil amendment product.',NULL),(4,'Basalt Rock Dust','Generic',224,1,1,1,1,'Basalt is a naturally mined mineral that contains trace elements. Silica is an important nutrient needed for plant growth, and basalt is a great choice for that.',NULL),(5,'Wood Ash','Generic',224,1,1,1,1,'can help to raise the soils alkalinity and also provide nitrogen',NULL),(6,'Worm Castings','Generic',224,1,1,1,1,'worm casting are nothing more than worm poop. They offer similar benefits as adding compost. They are perfect for adding microbial life to the soil, and may best be used as a tea for cost reasons',NULL),(7,'Yard Waste','Generic',224,1,1,1,1,'Contains some nitrogen and trace amounts of potassium and phosphorus. Fresh grass clippings are nitrogen rich, but dried out grass clippings are carbon rich. Where as dried leaves are carbon rich. ',NULL),(8,'Yarrow','Generic',224,1,1,1,1,'Can be used as compost accelerator, or for the micro-nutrients is contains. It may best be used as a tea or fermented plant extract as supplying large amounts may be cost prohibitive',NULL),(9,'Willow Bark','Generic',224,1,1,1,1,'contains a growth hormone that may be beneficial to plants. Willow water has long been used to root cuttings of plants. Making a nutrient rich tea with it and applying to yards and gardens can be beneficial. ',NULL),(10,'Zeolites','Generic',224,1,1,1,1,'are made from volcanic stones. Zeolite is capable of holding up to 60% of its weight in water. Tests have shown Zeolite can increase water infiltration by 7%-30% on gently sloped land and up to 50% on steeply sloped land.',NULL),(11,'Bat Guano','Generic',224,1,1,1,1,'Bat guano comes in many different NPK values. You can get guano high in nitrogen, or guano high in phosphorous. ',NULL),(12,'Bentonite Clay','Generic',224,1,1,1,1,'Bentonite clay is an all natural way to retain moisture in your soil. It can be used as an alternative to the chemical based gel beads you see in commercial potting soils.',NULL),(13,'Biochar','Generic',224,1,1,1,1,'Biochar is a specialty product that is similar to charcoal. Because of its precise manufacturing procedures it will survive for thousands of years in the soil. It is known to be a habitat for microbes.',NULL),(14,'Biosolids (treated sewage sludge)','Generic',224,1,1,1,1,'This use to be a widely used amendment, but not in many years. For obvious reasons stay away from it.',NULL),(15,'Blood Meal','Generic',224,1,1,1,1,'Blood Meal is a byproduct that is extremely high in readily available nitrogen. A little goes a long way',NULL),(16,'Bone Char','Generic',224,1,1,1,1,'Bone Char is a burned bone product that is like charcoal that provides phosphorus to the soil.',NULL),(17,'Bone Meal','Generic',224,1,1,1,1,'Bone Meal is another byproduct that contains high levels of phosphorous and also provides calcium. It to can burn your plants so caution should be taken when applying large amount to your soil.',NULL),(18,'Calphos - Colloidal Phosphate','Generic',224,1,1,1,1,'Calphos is a natural, untreated soft phosphate with colloidal clay containing valuable minor minerals in addition to phosphorus. It is not acid forming.',NULL),(19,'Comfrey','Generic',224,1,1,1,1,'Comfrey has the three major nutrients Nitrogen, Phosphorous, and potassium plus high levels of calcium, which can be very beneficial if harvested and made into comfrey tea for plants..',NULL),(20,'Compost','Generic',224,1,1,1,1,'Adding compost is the tried and true organic way to increase soil health. It can help retain moisture in soils, can help to loosen clay soils, and also add much needed microbial life to all soils. ',NULL),(21,'Corn Gluten Meal','Generic',224,1,1,1,1,'Can aid in the prevention of weed growth when used as a per-emergent on lawns early in the season.',NULL),(22,'Cottonseed Hulls','Generic',224,1,1,1,1,'This byproduct of the cotton industry can be used to aerate clay soils, and bring organic matter in. Often used as a mulch product.',NULL),(23,'Cottonseed Meal','Generic',224,1,1,1,1,'Good choice for a slow release nitrogen amendment that will also lower soil pH. Good choice for acid loving plants like blueberries.',NULL),(24,'Crushed Oyster Shells','Generic',224,1,1,1,1,'Crushed oyster shells can aid in aeration of soils, and also bring a very long term slow release calcium source.',NULL),(25,'Crustacean Meal','Generic',224,1,1,1,1,'Crustacean Meal is a blend of different meals. It may contain crab, shrimp, or lobster meals. It can act as along term nitrogen source, and help with microbial activity in the soil.',NULL),(26,'Diatomaceous Earth','Generic',224,1,1,1,1,'Diatomaceous earth made form fossilized skeletal remains of diatoms which are minuscule aquatic organisms. It is a great source of silica for your plants.',NULL),(27,'Dolomite Limestone','Generic',224,1,1,1,1,'Raises pH in acidic soils and is a quality source of calcium and magnesium.',NULL),(28,'Dried Molasses','Generic',224,1,1,1,1,'Dried Molasses is usually a molasses type product that is sprayed on to a carrier. It is very reasonably priced, and is great for spreading on lawns and gardens to increase microbial activity.',NULL),(29,'Feather Meal','Generic',224,1,1,1,1,'Feather meal is a byproduct of the poultry industry. It is cooked and sterilized under extreme heat using steam pressure cookers. It is a solid source of nitrogen that will release slowly over time. ',NULL),(30,'Fish Bone Meal','Generic',224,1,1,1,1,'Fish bone meal is a super high phosphorous amendment that is a waste product from the fishing industry. It is a better alternative to standard bone meal.',NULL),(31,'Fish Meal','Generic',224,1,1,1,1,'Fish meal is a good all around fertilizer. It provides a good source of nitrogen for your plants and also, it is a source of long lasting, slow release nitrogen.',NULL),(32,'Granite Dust','Generic',224,1,1,1,1,'Granite dust, if available in your area, can be a good amendment for your garden. It provides minerals and trace elements that are not available in your average potting soil.',NULL),(33,'Green Sand','Generic',224,1,1,1,1,'Green sand is a naturally occurring mineral that is mined from ancient sea floors. It is an excellent source of iron, potassium, silica, and other valuable minerals.',NULL),(34,'Gypsum','Generic',224,1,1,1,1,'Gypsum is a common mineral that works wonders on compacted clay-heavy soils by improving their structure and fertility.',NULL),(35,'Humic Acid','Generic',224,1,1,1,1,'Humic Acid, a product of composting, is used to improve soil fertility by enhancing nutrient uptake, stimulating soil microbial life and improving the structure of the soil.',NULL),(36,'Kelp Meal','Generic',224,1,1,1,1,'Kelp meal, derived from seaweed, is a rich source of trace minerals, growth hormones and vitamins, and aids in increasing plant health and improving resistance to stress.',NULL),(37,'Langbeinite','Generic',224,1,1,1,1,'Langbeinite is a unique source of plant nutrition, as it provides three essential nutrients, potassium, magnesium and sulfur, in one product.',NULL),(38,'Lava Sand','Generic',224,1,1,1,1,'Lava sand improves the physical structure of the soil, while also adding beneficial nutrients and minerals.',NULL),(39,'Limestone','Generic',224,1,1,1,1,'Limestone is used in gardening to balance the pH level of soils, making them more alkaline or sweet.',NULL),(40,'Manure Compost','Generic',224,1,1,1,1,'Composted manure adds nutrients to the soil, improves soil structure, aids in water retention and encourages beneficial insects and microbes.',NULL),(41,'Mushroom Compost','Generic',224,1,1,1,1,'Mushroom compost is a type of slow-release, organic plant fertilizer. It provides nutrients and improves soil structure.',NULL),(42,'Peat Moss','Generic',224,1,1,1,1,'Peat moss is used in gardening to improve soil fertility and to increase the soil\'s capacity to hold water and nutrients.',NULL),(43,'Potash','Generic',224,1,1,1,1,'Potash is an excellent source of potassium, which plants need for proper cell function and growth resulting in more vigorous plants and bigger yields.',NULL),(44,'Rock Dust','Generic',224,1,1,1,1,'Rock dust is used in organic farming to replenish minerals in the soil that have been depleted by cultivation.',NULL),(45,'Rock Phosphate','Generic',224,1,1,1,1,'Rock Phosphate is a natural powder form of the element phosphorous which plants need for photosynthesis.',NULL),(46,'Seabird Guano','Generic',224,1,1,1,1,'Seabird guano is an excellent high-nitrogen fertilizer and can also be a source of phosphorus and potassium, as well as several trace elements.',NULL),(47,'Sphagnum Peat','Generic',224,1,1,1,1,'Sphagnum peat moss is widely used in gardening for its ability to retain water and nutrients and create a favorable soil condition.',NULL),(48,'Sul-Po-Mag','Generic',224,1,1,1,1,'Sul-Po-Mag is a quick acting source of potassium and magnesium and also contains sulfur.',NULL),(49,'Vermiculite','Generic',224,1,1,1,1,'Vermiculite improves soil aeration and moisture retention and contributes calcium and magnesium to the soil.',NULL);
/*!40000 ALTER TABLE `amendment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-23 15:55:38
