-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.26 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 traceability 的数据库结构
DROP DATABASE IF EXISTS `traceability`;
CREATE DATABASE IF NOT EXISTS `traceability` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `traceability`;

-- 导出  表 traceability.tl_class_join_tbl 结构
DROP TABLE IF EXISTS `tl_class_join_tbl`;
CREATE TABLE IF NOT EXISTS `tl_class_join_tbl` (
  `Tl_IRI` varchar(255) NOT NULL,
  `Tl_Class_IRI` varchar(255) NOT NULL,
  `Annotation` text,
  PRIMARY KEY (`Tl_IRI`,`Tl_Class_IRI`),
  KEY `Tl_IRI` (`Tl_IRI`),
  KEY `Tl_Class_IRI` (`Tl_Class_IRI`),
  CONSTRAINT `FK_Tl_Class_Join_Tl_Class_IRI` FOREIGN KEY (`Tl_Class_IRI`) REFERENCES `tl_class` (`Tl_Class_IRI`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Class_Join_Tl_IRI` FOREIGN KEY (`Tl_IRI`) REFERENCES `tracelink` (`Tl_IRI`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The join table describing the instanceOf relationship between tracelinks and tl_classes';

-- 数据导出被取消选择。

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
