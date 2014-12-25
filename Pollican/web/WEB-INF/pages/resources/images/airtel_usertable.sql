-- MySQL dump 10.13  Distrib 5.5.11, for Win32 (x86)
--
-- Host: localhost    Database: Vegayanweb
-- ------------------------------------------------------
-- Server version	5.5.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `simplus_web_user`
--

DROP TABLE IF EXISTS `simplus_web_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplus_web_user` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `status` varchar(20) DEFAULT 'inactive',
  `role` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simplus_web_user`
--

LOCK TABLES `simplus_web_user` WRITE;
/*!40000 ALTER TABLE `simplus_web_user` DISABLE KEYS */;
INSERT INTO `simplus_web_user` VALUES ('admin','admin','inactive','admin'),('cen','cen','inactive','cen'),('simplus','simplus','inactive','ipmpls'),('simplus1','simplus1','inactive','ipmpls'),('simplus10','simplus10','inactive','ipmpls'),('simplus12','simplus12','inactive','ipmpls'),('simplus2','simplus2','inactive','ipmpls'),('simplus3','simplus3','inactive','ipmpls'),('simplus4','simplus4','active','ipmpls'),('simplus5','simplus5','inactive','ipmpls'),('simplus6','simplus6','inactive','ipmpls'),('simplus7','simplus7','inactive','ipmpls'),('simplus9','simplus9','inactive','ipmpls'),('srikanth','srikanth','inactive','ipmpls');
/*!40000 ALTER TABLE `simplus_web_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-19 17:43:33
