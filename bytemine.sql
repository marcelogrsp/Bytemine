-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: BYTEMINE
-- ------------------------------------------------------
-- Server version	8.0.25-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action`
--

DROP TABLE IF EXISTS `action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action`
--

LOCK TABLES `action` WRITE;
/*!40000 ALTER TABLE `action` DISABLE KEYS */;
INSERT INTO `action` VALUES (1,'Buy'),(2,'Sell');
/*!40000 ALTER TABLE `action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_inputs`
--

DROP TABLE IF EXISTS `action_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_inputs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `action_inputs_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `action` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_inputs`
--

LOCK TABLES `action_inputs` WRITE;
/*!40000 ALTER TABLE `action_inputs` DISABLE KEYS */;
INSERT INTO `action_inputs` VALUES (3,1,'Buy'),(4,2,'Sell');
/*!40000 ALTER TABLE `action_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_params`
--

DROP TABLE IF EXISTS `action_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `box_type` varchar(255) DEFAULT NULL,
  `min_value` float DEFAULT NULL,
  `max_value` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `action_params_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `action` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_params`
--

LOCK TABLES `action_params` WRITE;
/*!40000 ALTER TABLE `action_params` DISABLE KEYS */;
INSERT INTO `action_params` VALUES (8,1,'Take Profit','Float','Text Box',0,1000000),(9,1,'Take Profit %','Float','Text Box',0,100),(10,1,'Stop Loss','Float','Text Box',0,1000000),(11,1,'Stop Loss %','Float','Text Box',0,100),(12,1,'Trailling SL','Float','Text Box',0,1000000),(13,1,'Trailling SL %','Float','Text Box',0,100),(14,2,'Take Profit','Float','Text Box',0,1000000),(15,2,'Take Profit %','Float','Text Box',0,100),(16,2,'Stop Loss','Float','Text Box',0,1000000),(17,2,'Stop Loss %','Float','Text Box',0,100),(18,2,'Trailling SL','Float','Text Box',0,1000000),(19,2,'Trailling SL %','Float','Text Box',0,100);
/*!40000 ALTER TABLE `action_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES (1,'Volume'),(2,'Number'),(3,'Current Price'),(4,'LTP');
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_outputs`
--

DROP TABLE IF EXISTS `data_outputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_outputs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `data_outputs_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `data` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_outputs`
--

LOCK TABLES `data_outputs` WRITE;
/*!40000 ALTER TABLE `data_outputs` DISABLE KEYS */;
INSERT INTO `data_outputs` VALUES (1,1,'Output'),(2,2,'Output'),(3,3,'Price'),(4,4,'Output');
/*!40000 ALTER TABLE `data_outputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_params`
--

DROP TABLE IF EXISTS `data_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `box_type` varchar(255) DEFAULT NULL,
  `min_value` float DEFAULT NULL,
  `max_value` float DEFAULT NULL,
  `values` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  CONSTRAINT `data_params_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `data` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_params`
--

LOCK TABLES `data_params` WRITE;
/*!40000 ALTER TABLE `data_params` DISABLE KEYS */;
INSERT INTO `data_params` VALUES (1,1,'CandleStick Size','String','Dropdown',NULL,NULL,'Avg Volume,None'),(2,2,'Number','Float','Text Box',0,1000000,NULL),(3,3,'Symbol','String','Dropdown',NULL,NULL,NULL),(4,3,'Type','String','Dropdown',NULL,NULL,'Open,High,Low,Close');
/*!40000 ALTER TABLE `data_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicator`
--

DROP TABLE IF EXISTS `indicator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicator` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unique_key` varchar(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  `valid` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicator`
--

LOCK TABLES `indicator` WRITE;
/*!40000 ALTER TABLE `indicator` DISABLE KEYS */;
INSERT INTO `indicator` VALUES (2,'b29dedc489097d4cc4cbd6faac64b005','Bollinger Bands','bbands',1,'2021-05-15 14:19:48','2021-05-15 14:19:48'),(5,'06a12dd64fbc5fe1c1d43c4e597502fa','Vector Absolute Value','abs',1,'2021-05-15 19:44:59','2021-05-15 19:44:59'),(6,'9b86f9561dad12659ffd487723cc9067','Vector Arccosine','acos',1,'2020-09-24 19:56:45','2020-09-24 19:56:45'),(9,'d520514b7df2924542f23cbff326d663','Accumulation/Distribution Line','ad',1,'2020-09-24 20:12:42','2020-09-24 20:12:42'),(10,'7e4c862c696694a70ab0ae10d8f7795f','Vector Addition','add',1,'2020-09-24 20:12:42','2020-09-24 20:12:42'),(11,'122531b56f32cbaf99d506208b9aec3f','Accumulation/Distribution Oscillator','adosc',1,'2020-09-24 20:12:45','2020-09-24 20:12:45'),(12,'0c655bdebf93555ee8eaf9a09ccca2aa','Average Directional Movement Index','adx',1,'2020-09-24 20:12:46','2020-09-24 20:12:46'),(13,'92134b2dc0fe9f7acf7666730e759d32','Average Directional Movement Rating','adxr',1,'2020-09-24 20:12:46','2020-09-24 20:12:46'),(14,'61750c83809b03ea38266f80a485d9e1','Awesome Oscillator','ao',1,'2020-09-24 20:12:46','2020-09-24 20:12:46'),(15,'fac53c2d5d825e57e6afe17d408ed0f2','Absolute Price Oscillator','apo',1,'2020-09-24 20:12:46','2020-09-24 20:12:46'),(16,'f647606457bc8e5a3a8b97c1ec45a709','Aroon','aroon',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(17,'be505ac2851e08e5cd6b0f1909e1be32','Aroon Oscillator','aroonosc',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(18,'aceb24b5fe019dfe0fa75dd423c54f69','Vector Arcsine','asin',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(19,'5c8f37d36a9ab869d70c918dc06d57a0','Vector Arctangent','atan',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(20,'c884d7270021d8bd4db27e4539e49861','Average True Range','atr',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(21,'68aa9850a6d211b85d2e33a65affbb13','Average Price','avgprice',1,'2020-09-24 20:12:47','2020-09-24 20:12:47'),(23,'5964cf74ec6ac01be62087c0fcf9502f','Balance of Power','bop',1,'2020-09-24 20:12:48','2020-09-24 20:12:48'),(24,'023768b544854d786f9d95afa6f82793','Commodity Channel Index','cci',1,'2020-09-24 20:12:48','2020-09-24 20:12:48'),(25,'bbb4958c7b575c8e0c0e742aaa74fcd9','Vector Ceiling','ceil',1,'2020-09-24 20:12:48','2020-09-24 20:12:48'),(26,'3dcdc2f0b8ddccc8beecef69e87290e6','Chande Momentum Oscillator','cmo',1,'2020-09-24 20:12:48','2020-09-24 20:12:48'),(27,'af584dd6950899b71f595c5c5a17a3a0','Vector Cosine','cos',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(28,'fca026f017cbc05d472f78e3b5f146cb','Vector Hyperbolic Cosine','cosh',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(29,'e0d39064b9fd76b14122993bb46003ea','Crossany','crossany',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(30,'2e607ef3a19cf3de029e2c5882896d33','Crossover','crossover',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(31,'00cc125c7683af6dae5c43cf2a05d1f4','Chaikins Volatility','cvi',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(32,'25b8537ba3ec8776b9c70a791c14ce82','Linear Decay','decay',1,'2020-09-24 20:12:49','2020-09-24 20:12:49'),(33,'64db8d61d61fce71526e529975efc02e','Double Exponential Moving Average','dema',1,'2020-09-24 20:12:50','2020-09-24 20:12:50'),(34,'52d69c66a9ee34f3c1347f30e9ef72c7','Directional Indicator','di',1,'2020-09-24 20:12:50','2020-09-24 20:12:50'),(35,'2c41228db75c27ac4ae813c97e75cef4','Vector Division','div',1,'2020-09-24 20:12:50','2020-09-24 20:12:50'),(36,'68f551790a305e319827cfedca3ecaa5','Directional Movement','dm',1,'2020-09-24 20:12:50','2020-09-24 20:12:50'),(37,'97fce4d7dcd7a5131e85f8f16256c0c6','Detrended Price Oscillator','dpo',1,'2020-09-24 20:12:50','2020-09-24 20:12:50'),(38,'17414e7e8d26ddc8afeaf5ab4b9cc3e8','Directional Movement Index','dx',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(39,'b48f9197598227d33d7b1fcbd5eea3c3','Exponential Decay','edecay',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(40,'f014b2f80d6cee4d42ed6c19b0fdaadb','Exponential Moving Average','ema',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(41,'decb98b7e2d6e3f2647e543ea52af6a4','Ease of Movement','emv',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(42,'88653e878514ec6640ce54f5a77fd738','Vector Exponential','exp',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(43,'051280af717c8915fe7f278dfff52944','Fisher Transform','fisher',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(44,'675b29090572b4ecb703bee33e908c65','Vector Floor','floor',1,'2020-09-24 20:12:51','2020-09-24 20:12:51'),(45,'68fd5e305f6a0b17345261a7bbea231b','Forecast Oscillator','fosc',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(46,'337dd915bd43b158bfd898e13ac248c9','Hull Moving Average','hma',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(47,'44153a0de27cbf230b403a63884072ef','Kaufman Adaptive Moving Average','kama',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(48,'175ae121e54fe1174067f46a07c2e12d','Klinger Volume Oscillator','kvo',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(49,'9ec7a0f053f4a3a487ac153c1a820e2e','Lag','lag',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(50,'fe35c593db62101e8c013b7acc35c3fe','Linear Regression','linreg',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(51,'7faa0417e91afc50a6edcf9210df68fc','Linear Regression Intercept','linregintercept',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(52,'9374966d09f79f00baa201f83e5d2f91','Linear Regression Slope','linregslope',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(53,'d0a9cf1bc46d06b720df21128e53daa3','Vector Natural Log','ln',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(54,'43618aae68fce7c150d39615d5f7baaf','Vector Base-10 Log','log10',1,'2020-09-24 20:12:52','2020-09-24 20:12:52'),(55,'0996f55d5d19b64d5aa91d5f3dd683ba','Moving Average Convergence/Divergence','macd',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(56,'60178155987d0c0b5400a396e3c8f18f','Market Facilitation Index','marketfi',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(57,'5d5cec9e278c8410da00b9161b7a181a','Mass Index','mass',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(58,'af86dad7a74fe1160d466c8269ac8205','Maximum In Period','max',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(59,'798545866ee2f8dda8dab73e64677810','Mean Deviation Over Period','md',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(60,'a1d203f0d7b276834a00f13b55f8d13d','Median Price','medprice',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(61,'46967a7c8cd7139a0b12312a5879c4c8','Money Flow Index','mfi',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(62,'4fa4e46ecabb3142a7b6c5bfb4d28131','Minimum In Period','min',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(63,'37323780191d51a33d295ac10fb98f06','Momentum','mom',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(64,'4924358014192b0d68b832a0cac91486','Mesa Sine Wave','msw',1,'2020-09-24 20:12:53','2020-09-24 20:12:53'),(65,'19cb608d168c1554be79f3086075e76c','Vector Multiplication','mul',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(66,'f4a5ceb614df0ab776c88d5581e20472','Normalized Average True Range','natr',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(67,'9882dd2661aefe4a83324668709ada16','Negative Volume Index','nvi',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(68,'113ff77b7020096c420e6746897787a7','On Balance Volume','obv',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(69,'bf830c2c3b025abe8cb600994e692725','Percentage Price Oscillator','ppo',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(70,'b20e091e474c36c238d2030cbb11fc15','Parabolic SAR','psar',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(71,'917cb292fae7f9f5cebb142e0a20a312','Positive Volume Index','pvi',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(72,'be6415886bee282ee5b5bcaeb81ef886','Qstick','qstick',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(73,'5aba9c4ef515c564e9ff953dfe3785af','Rate of Change','roc',1,'2020-09-24 20:12:54','2020-09-24 20:12:54'),(74,'d368356976668b3a656e1190fed861f2','Rate of Change Ratio','rocr',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(75,'b57409ccdaae4de4eb1497b1ba3df238','Vector Round','round',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(76,'556df6d0edceee8a1336f958dfd1df09','Relative Strength Index','rsi',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(77,'fcb3cb59a72f95904e7d6b3ffeda31f4','Vector Sine','sin',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(78,'165ba2c0bfaf84a33352773eabcd064f','Vector Hyperbolic Sine','sinh',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(79,'881e742e6dd798ab4bfc2ca5109453f8','Simple Moving Average','sma',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(80,'6579bdc966bdd57aacd1495f60bfeda0','Vector Square Root','sqrt',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(81,'1f801df8f98e15fab3f7cfd4cec63b08','Standard Deviation Over Period','stddev',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(82,'5176992aeac4afee736f7f77d7972923','Standard Error Over Period','stderr',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(83,'56e18830222acc80ae499be65533cabb','Stochastic Oscillator','stoch',1,'2020-09-24 20:12:55','2020-09-24 20:12:55'),(84,'ab025c643c8a5c1b08e2bbb3615df407','Stochastic RSI','stochrsi',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(85,'b4b77687276cc3c5255b329009b215ae','Vector Subtraction','sub',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(86,'61c3ccf3ab28aa4a1f321a3065ede708','Sum Over Period','sum',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(87,'86bf0988f132ae5fc36577398a2a7dad','Vector Tangent','tan',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(88,'a5a8a89dbdb9157f3e8497ea61f87781','Vector Hyperbolic Tangent','tanh',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(89,'9de1d49719d2f717e8a57f37c0504da7','Triple Exponential Moving Average','tema',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(90,'0e7d77dc604062a7245aad97e5219900','Vector Degree Conversion','todeg',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(91,'7daf545f6c4d3180c22833b6c6c9b0f8','Vector Radian Conversion','torad',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(92,'391ffb2a0c9ace757bee8dc7b9ac0a89','True Range','tr',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(93,'23f0ef1a2152febab25db9933586baeb','Triangular Moving Average','trima',1,'2020-09-24 20:12:56','2020-09-24 20:12:56'),(94,'d2b7178cb3441aaecfdaa5555a4c3f0a','Trix','trix',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(95,'8f1f4edb69f4293adf9881576945eaa3','Vector Truncate','trunc',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(96,'4e75e3e12256a4b2e3ad0fd27daee3f1','Time Series Forecast','tsf',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(97,'48b517079d4f46b3038e4c479211283a','Typical Price','typprice',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(98,'de458c037e8b990c29218dc144afb4f0','Ultimate Oscillator','ultosc',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(99,'38978b37e1fc59682fc9775385f8fb5f','Variance Over Period','var',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(100,'79d77f3316bb7225775e80c91fb8f15e','Vertical Horizontal Filter','vhf',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(101,'7ccbb2ef2035f16c5ba7877bea66a9c7','Variable Index Dynamic Average','vidya',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(102,'b80dff1b5f5c4bdc50e9a494f1942bd8','Annualized Historical Volatility','volatility',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(103,'33b757d9563cb0ea49558318fa672b26','Volume Oscillator','vosc',1,'2020-09-24 20:12:57','2020-09-24 20:12:57'),(104,'1939ce31bbaf5dc33be7f109badcadfa','Volume Weighted Moving Average','vwma',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(105,'cbf3ac76804cb531e54e4df9ae598a1d','Williams Accumulation/Distribution','wad',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(106,'086980f4802135698289b8956f62ddd5','Weighted Close Price','wcprice',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(107,'c556bb29f7bc0f6b1b8f42d2bb7f30b5','Wilders Smoothing','wilders',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(108,'b025e2441ff8385417e0fca96edd0ee8','Williams %R','willr',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(109,'2bfc3ffb2dae1e6fb69f5b0288fbefa7','Weighted Moving Average','wma',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(110,'869ccce1d14ca484c390b4e69a164d1e','Zero-Lag Exponential Moving Average','zlema',1,'2020-09-24 20:12:58','2020-09-24 20:12:58'),(111,'9b86f9561dad12659ffd487723cc9067','Vector Arccosine','acos',1,'2021-05-19 16:55:37','2021-05-19 16:55:37');
/*!40000 ALTER TABLE `indicator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicator_outputs`
--

DROP TABLE IF EXISTS `indicator_outputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicator_outputs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indicator_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `indicator_outputs_ibfk_1` (`indicator_id`),
  CONSTRAINT `indicator_outputs_ibfk_1` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicator_outputs`
--

LOCK TABLES `indicator_outputs` WRITE;
/*!40000 ALTER TABLE `indicator_outputs` DISABLE KEYS */;
INSERT INTO `indicator_outputs` VALUES (2,2,'bbands_lower'),(3,2,'bbands_middle'),(4,2,'bbands_upper'),(7,5,'abs'),(8,6,'acos'),(11,9,'ad'),(12,10,'add'),(13,11,'adosc'),(14,12,'dx'),(15,13,'dx'),(16,14,'ao'),(17,15,'apo'),(18,16,'aroon_down'),(19,16,'aroon_up'),(20,17,'aroonosc'),(21,18,'asin'),(22,19,'atan'),(23,20,'atr'),(24,21,'avgprice'),(28,23,'bop'),(29,24,'cci'),(30,25,'ceil'),(31,26,'cmo'),(32,27,'cos'),(33,28,'cosh'),(34,29,'crossany'),(35,30,'crossover'),(36,31,'cvi'),(37,32,'decay'),(38,33,'dema'),(39,34,'plus_di'),(40,34,'minus_di'),(41,35,'div'),(42,36,'plus_dm'),(43,36,'minus_dm'),(44,37,'dpo'),(45,38,'dx'),(46,39,'edecay'),(47,40,'ema'),(48,41,'emv'),(49,42,'exp'),(50,43,'fisher'),(51,43,'fisher_signal'),(52,44,'floor'),(53,45,'fosc'),(54,46,'hma'),(55,47,'kama'),(56,48,'kvo'),(57,49,'lag'),(58,50,'linreg'),(59,51,'linregintercept'),(60,52,'linregslope'),(61,53,'ln'),(62,54,'log10'),(63,55,'macd'),(64,55,'macd_signal'),(65,55,'macd_histogram'),(66,56,'marketfi'),(67,57,'mass'),(68,58,'max'),(69,59,'md'),(70,60,'medprice'),(71,61,'mfi'),(72,62,'min'),(73,63,'mom'),(74,64,'msw_sine'),(75,64,'msw_lead'),(76,65,'mul'),(77,66,'natr'),(78,67,'nvi'),(79,68,'obv'),(80,69,'ppo'),(81,70,'psar'),(82,71,'pvi'),(83,72,'qstick'),(84,73,'roc'),(85,74,'rocr'),(86,75,'round'),(87,76,'rsi'),(88,77,'sin'),(89,78,'sinh'),(90,79,'sma'),(91,80,'sqrt'),(92,81,'stddev'),(93,82,'stderr'),(94,83,'stoch_k'),(95,83,'stoch_d'),(96,84,'stochrsi'),(97,85,'sub'),(98,86,'sum'),(99,87,'tan'),(100,88,'tanh'),(101,89,'tema'),(102,90,'degrees'),(103,91,'radians'),(104,92,'tr'),(105,93,'trima'),(106,94,'trix'),(107,95,'trunc'),(108,96,'tsf'),(109,97,'typprice'),(110,98,'ultosc'),(111,99,'var'),(112,100,'vhf'),(113,101,'vidya'),(114,102,'volatility'),(115,103,'vosc'),(116,104,'vwma'),(117,105,'wad'),(118,106,'wcprice'),(119,107,'wilders'),(120,108,'willr'),(121,109,'wma'),(122,110,'zlema'),(123,111,'acos');
/*!40000 ALTER TABLE `indicator_outputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicator_params`
--

DROP TABLE IF EXISTS `indicator_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicator_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indicator_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `box_type` varchar(255) DEFAULT NULL,
  `min_value` float DEFAULT NULL,
  `max_value` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `indicator_params_ibfk_1` (`indicator_id`),
  CONSTRAINT `indicator_params_ibfk_1` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicator_params`
--

LOCK TABLES `indicator_params` WRITE;
/*!40000 ALTER TABLE `indicator_params` DISABLE KEYS */;
INSERT INTO `indicator_params` VALUES (2,2,'period','Float','Text Box',0,1000000),(3,2,'stddev','Float','Text Box',0,1000000),(6,11,'short period','Float','Text Box',0,1000000),(7,11,'long period','Float','Text Box',0,1000000),(8,12,'period','Float','Text Box',0,1000000),(9,13,'period','Float','Text Box',0,1000000),(10,15,'short period','Float','Text Box',0,1000000),(11,15,'long period','Float','Text Box',0,1000000),(12,16,'period','Float','Text Box',0,1000000),(13,17,'period','Float','Text Box',0,1000000),(14,20,'period','Float','Text Box',0,1000000),(17,24,'period','Float','Text Box',0,1000000),(18,26,'period','Float','Text Box',0,1000000),(19,31,'period','Float','Text Box',0,1000000),(20,32,'period','Float','Text Box',0,1000000),(21,33,'period','Float','Text Box',0,1000000),(22,34,'period','Float','Text Box',0,1000000),(23,36,'period','Float','Text Box',0,1000000),(24,37,'period','Float','Text Box',0,1000000),(25,38,'period','Float','Text Box',0,1000000),(26,39,'period','Float','Text Box',0,1000000),(27,40,'period','Float','Text Box',0,1000000),(28,43,'period','Float','Text Box',0,1000000),(29,45,'period','Float','Text Box',0,1000000),(30,46,'period','Float','Text Box',0,1000000),(31,47,'period','Float','Text Box',0,1000000),(32,48,'short period','Float','Text Box',0,1000000),(33,48,'long period','Float','Text Box',0,1000000),(34,49,'period','Float','Text Box',0,1000000),(35,50,'period','Float','Text Box',0,1000000),(36,51,'period','Float','Text Box',0,1000000),(37,52,'period','Float','Text Box',0,1000000),(38,55,'short period','Float','Text Box',0,1000000),(39,55,'long period','Float','Text Box',0,1000000),(40,55,'signal period','Float','Text Box',0,1000000),(41,57,'period','Float','Text Box',0,1000000),(42,58,'period','Float','Text Box',0,1000000),(43,59,'period','Float','Text Box',0,1000000),(44,61,'period','Float','Text Box',0,1000000),(45,62,'period','Float','Text Box',0,1000000),(46,63,'period','Float','Text Box',0,1000000),(47,64,'period','Float','Text Box',0,1000000),(48,66,'period','Float','Text Box',0,1000000),(49,69,'short period','Float','Text Box',0,1000000),(50,69,'long period','Float','Text Box',0,1000000),(51,70,'acceleration factor step','Float','Text Box',0,1000000),(52,70,'acceleration factor maximum','Float','Text Box',0,1000000),(53,72,'period','Float','Text Box',0,1000000),(54,73,'period','Float','Text Box',0,1000000),(55,74,'period','Float','Text Box',0,1000000),(56,76,'period','Float','Text Box',0,1000000),(57,79,'period','Float','Text Box',0,1000000),(58,81,'period','Float','Text Box',0,1000000),(59,82,'period','Float','Text Box',0,1000000),(60,83,'%k period','Float','Text Box',0,1000000),(61,83,'%k slowing period','Float','Text Box',0,1000000),(62,83,'%d period','Float','Text Box',0,1000000),(63,84,'period','Float','Text Box',0,1000000),(64,86,'period','Float','Text Box',0,1000000),(65,89,'period','Float','Text Box',0,1000000),(66,93,'period','Float','Text Box',0,1000000),(67,94,'period','Float','Text Box',0,1000000),(68,96,'period','Float','Text Box',0,1000000),(69,98,'short period','Float','Text Box',0,1000000),(70,98,'medium period','Float','Text Box',0,1000000),(71,98,'long period','Float','Text Box',0,1000000),(72,99,'period','Float','Text Box',0,1000000),(73,100,'period','Float','Text Box',0,1000000),(74,101,'short period','Float','Text Box',0,1000000),(75,101,'long period','Float','Text Box',0,1000000),(76,101,'alpha','Float','Text Box',0,1000000),(77,102,'period','Float','Text Box',0,1000000),(78,103,'short period','Float','Text Box',0,1000000),(79,103,'long period','Float','Text Box',0,1000000),(80,104,'period','Float','Text Box',0,1000000),(81,107,'period','Float','Text Box',0,1000000),(82,108,'period','Float','Text Box',0,1000000),(83,109,'period','Float','Text Box',0,1000000),(84,110,'period','Float','Text Box',0,1000000);
/*!40000 ALTER TABLE `indicator_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicator_sources`
--

DROP TABLE IF EXISTS `indicator_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicator_sources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indicator_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `box_type` varchar(255) DEFAULT NULL,
  `min_value` float DEFAULT NULL,
  `max_value` float DEFAULT NULL,
  `values` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `indicator_sources_ibfk_1` (`indicator_id`),
  CONSTRAINT `indicator_sources_ibfk_1` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicator_sources`
--

LOCK TABLES `indicator_sources` WRITE;
/*!40000 ALTER TABLE `indicator_sources` DISABLE KEYS */;
INSERT INTO `indicator_sources` VALUES (4,2,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(7,5,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(8,6,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(11,9,'high','Float','Text Box',0,1000000,NULL),(12,9,'low','Float','Text Box',0,1000000,NULL),(13,9,'close','Float','Text Box',0,1000000,NULL),(14,9,'volume','Float','Text Box',0,1000000,NULL),(15,10,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(16,10,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(17,11,'high','Float','Text Box',0,1000000,NULL),(18,11,'low','Float','Text Box',0,1000000,NULL),(19,11,'close','Float','Text Box',0,1000000,NULL),(20,11,'volume','Float','Text Box',0,1000000,NULL),(21,12,'high','Float','Text Box',0,1000000,NULL),(22,12,'low','Float','Text Box',0,1000000,NULL),(23,12,'close','Float','Text Box',0,1000000,NULL),(24,13,'high','Float','Text Box',0,1000000,NULL),(25,13,'low','Float','Text Box',0,1000000,NULL),(26,13,'close','Float','Text Box',0,1000000,NULL),(27,14,'high','Float','Text Box',0,1000000,NULL),(28,14,'low','Float','Text Box',0,1000000,NULL),(29,15,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(30,16,'high','Float','Text Box',0,1000000,NULL),(31,16,'low','Float','Text Box',0,1000000,NULL),(32,17,'high','Float','Text Box',0,1000000,NULL),(33,17,'low','Float','Text Box',0,1000000,NULL),(34,18,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(35,19,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(36,20,'high','Float','Text Box',0,1000000,NULL),(37,20,'low','Float','Text Box',0,1000000,NULL),(38,20,'close','Float','Text Box',0,1000000,NULL),(39,21,'open','Float','Text Box',0,1000000,NULL),(40,21,'high','Float','Text Box',0,1000000,NULL),(41,21,'low','Float','Text Box',0,1000000,NULL),(42,21,'close','Float','Text Box',0,1000000,NULL),(44,23,'open','Float','Text Box',0,1000000,NULL),(45,23,'high','Float','Text Box',0,1000000,NULL),(46,23,'low','Float','Text Box',0,1000000,NULL),(47,23,'close','Float','Text Box',0,1000000,NULL),(48,24,'high','Float','Text Box',0,1000000,NULL),(49,24,'low','Float','Text Box',0,1000000,NULL),(50,24,'close','Float','Text Box',0,1000000,NULL),(51,25,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(52,26,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(53,27,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(54,28,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(55,29,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(56,29,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(57,30,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(58,30,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(59,31,'high','Float','Text Box',0,1000000,NULL),(60,31,'low','Float','Text Box',0,1000000,NULL),(61,32,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(62,33,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(63,34,'high','Float','Text Box',0,1000000,NULL),(64,34,'low','Float','Text Box',0,1000000,NULL),(65,34,'close','Float','Text Box',0,1000000,NULL),(66,35,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(67,35,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(68,36,'high','Float','Text Box',0,1000000,NULL),(69,36,'low','Float','Text Box',0,1000000,NULL),(70,37,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(71,38,'high','Float','Text Box',0,1000000,NULL),(72,38,'low','Float','Text Box',0,1000000,NULL),(73,38,'close','Float','Text Box',0,1000000,NULL),(74,39,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(75,40,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(76,41,'high','Float','Text Box',0,1000000,NULL),(77,41,'low','Float','Text Box',0,1000000,NULL),(78,41,'volume','Float','Text Box',0,1000000,NULL),(79,42,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(80,43,'high','Float','Text Box',0,1000000,NULL),(81,43,'low','Float','Text Box',0,1000000,NULL),(82,44,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(83,45,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(84,46,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(85,47,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(86,48,'high','Float','Text Box',0,1000000,NULL),(87,48,'low','Float','Text Box',0,1000000,NULL),(88,48,'close','Float','Text Box',0,1000000,NULL),(89,48,'volume','Float','Text Box',0,1000000,NULL),(90,49,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(91,50,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(92,51,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(93,52,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(94,53,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(95,54,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(96,55,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(97,56,'high','Float','Text Box',0,1000000,NULL),(98,56,'low','Float','Text Box',0,1000000,NULL),(99,56,'volume','Float','Text Box',0,1000000,NULL),(100,57,'high','Float','Text Box',0,1000000,NULL),(101,57,'low','Float','Text Box',0,1000000,NULL),(102,58,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(103,59,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(104,60,'high','Float','Text Box',0,1000000,NULL),(105,60,'low','Float','Text Box',0,1000000,NULL),(106,61,'high','Float','Text Box',0,1000000,NULL),(107,61,'low','Float','Text Box',0,1000000,NULL),(108,61,'close','Float','Text Box',0,1000000,NULL),(109,61,'volume','Float','Text Box',0,1000000,NULL),(110,62,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(111,63,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(112,64,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(113,65,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(114,65,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(115,66,'high','Float','Text Box',0,1000000,NULL),(116,66,'low','Float','Text Box',0,1000000,NULL),(117,66,'close','Float','Text Box',0,1000000,NULL),(118,67,'close','Float','Text Box',0,1000000,NULL),(119,67,'volume','Float','Text Box',0,1000000,NULL),(120,68,'close','Float','Text Box',0,1000000,NULL),(121,68,'volume','Float','Text Box',0,1000000,NULL),(122,69,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(123,70,'high','Float','Text Box',0,1000000,NULL),(124,70,'low','Float','Text Box',0,1000000,NULL),(125,71,'close','Float','Text Box',0,1000000,NULL),(126,71,'volume','Float','Text Box',0,1000000,NULL),(127,72,'open','Float','Text Box',0,1000000,NULL),(128,72,'close','Float','Text Box',0,1000000,NULL),(129,73,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(130,74,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(131,75,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(132,76,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(133,77,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(134,78,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(135,79,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(136,80,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(137,81,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(138,82,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(139,83,'high','Float','Text Box',0,1000000,NULL),(140,83,'low','Float','Text Box',0,1000000,NULL),(141,83,'close','Float','Text Box',0,1000000,NULL),(142,84,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(143,85,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(144,85,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(145,86,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(146,87,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(147,88,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(148,89,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(149,90,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(150,91,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(151,92,'high','Float','Text Box',0,1000000,NULL),(152,92,'low','Float','Text Box',0,1000000,NULL),(153,92,'close','Float','Text Box',0,1000000,NULL),(154,93,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(155,94,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(156,95,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(157,96,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(158,97,'high','Float','Text Box',0,1000000,NULL),(159,97,'low','Float','Text Box',0,1000000,NULL),(160,97,'close','Float','Text Box',0,1000000,NULL),(161,98,'high','Float','Text Box',0,1000000,NULL),(162,98,'low','Float','Text Box',0,1000000,NULL),(163,98,'close','Float','Text Box',0,1000000,NULL),(164,99,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(165,100,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(166,101,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(167,102,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(168,103,'volume','Float','Text Box',0,1000000,NULL),(169,104,'close','Float','Text Box',0,1000000,NULL),(170,104,'volume','Float','Text Box',0,1000000,NULL),(171,105,'high','Float','Text Box',0,1000000,NULL),(172,105,'low','Float','Text Box',0,1000000,NULL),(173,105,'close','Float','Text Box',0,1000000,NULL),(174,106,'high','Float','Text Box',0,1000000,NULL),(175,106,'low','Float','Text Box',0,1000000,NULL),(176,106,'close','Float','Text Box',0,1000000,NULL),(177,107,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(178,108,'high','Float','Text Box',0,1000000,NULL),(179,108,'low','Float','Text Box',0,1000000,NULL),(180,108,'close','Float','Text Box',0,1000000,NULL),(181,109,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(182,110,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close'),(183,111,'real','Float','Dropdown',0,1000000,'Open,High,Low,Close');
/*!40000 ALTER TABLE `indicator_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic`
--

DROP TABLE IF EXISTS `logic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic`
--

LOCK TABLES `logic` WRITE;
/*!40000 ALTER TABLE `logic` DISABLE KEYS */;
INSERT INTO `logic` VALUES (1,'Crosses Above'),(2,'Crosses Below'),(3,'Below'),(4,'Equal To'),(5,'Higher Than'),(6,'Higher Than Equal To'),(7,'Lower Than'),(8,'Lower Than Equal To'),(9,'Up By'),(10,'Down By');
/*!40000 ALTER TABLE `logic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_inputs`
--

DROP TABLE IF EXISTS `logic_inputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_inputs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logic_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logic_id` (`logic_id`),
  CONSTRAINT `logic_inputs_ibfk_1` FOREIGN KEY (`logic_id`) REFERENCES `logic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_inputs`
--

LOCK TABLES `logic_inputs` WRITE;
/*!40000 ALTER TABLE `logic_inputs` DISABLE KEYS */;
INSERT INTO `logic_inputs` VALUES (1,1,'Input 1'),(2,1,'Input 2'),(3,2,'Input 1'),(4,2,'Input 2'),(5,3,'Input 1'),(6,3,'Input 2'),(7,4,'Input 1'),(8,4,'Input 2'),(9,5,'Input 1'),(10,5,'Input 2'),(11,6,'Input 1'),(12,6,'Input 2'),(13,7,'Input 1'),(14,7,'Input 2'),(15,8,'Input 1'),(16,8,'Input 2'),(17,9,'Input 1'),(18,9,'Input 2'),(19,10,'Input 1'),(20,10,'Input 2');
/*!40000 ALTER TABLE `logic_inputs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logic_outputs`
--

DROP TABLE IF EXISTS `logic_outputs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_outputs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logic_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logic_id` (`logic_id`),
  CONSTRAINT `logic_outputs_ibfk_1` FOREIGN KEY (`logic_id`) REFERENCES `logic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logic_outputs`
--

LOCK TABLES `logic_outputs` WRITE;
/*!40000 ALTER TABLE `logic_outputs` DISABLE KEYS */;
INSERT INTO `logic_outputs` VALUES (1,1,'Then'),(2,1,'Else'),(3,2,'Then'),(4,2,'Else'),(5,3,'Then'),(6,3,'Else'),(7,4,'Then'),(8,4,'Else'),(9,5,'Then'),(10,5,'Else'),(11,6,'Then'),(12,6,'Else'),(13,7,'Then'),(14,7,'Else'),(15,8,'Then'),(16,8,'Else'),(17,9,'Then'),(18,9,'Else'),(19,10,'Then'),(20,10,'Else');
/*!40000 ALTER TABLE `logic_outputs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-01 16:15:17
