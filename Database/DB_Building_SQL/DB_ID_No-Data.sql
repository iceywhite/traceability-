-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.26 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for traceability
DROP DATABASE IF EXISTS `traceability`;
CREATE DATABASE IF NOT EXISTS `traceability` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `traceability`;

-- Dumping structure for procedure traceability.Add_Artifact_Basic
DROP PROCEDURE IF EXISTS `Add_Artifact_Basic`;
DELIMITER //
CREATE PROCEDURE `Add_Artifact_Basic`(IN `ArName` varchar(50),IN `Owner_ID` int unsigned)
BEGIN
	
	 DECLARE var_mod_id int unsigned;
	 DECLARE var_Ar_id int unsigned;
	 
	 INSERT INTO modification (ModifiedBy) VALUES (Owner_ID);
	 select max(Mod_ID) from modification into var_mod_id;
	 
	 INSERT INTO artifact (Name) VALUES (ArName);
	 select max(Ar_ID) from artifact into var_Ar_id;
	 
	 INSERT INTO ar_version (Ar_ID,`Owner`,Mod_ID) VALUES (var_Ar_id,Owner_ID,var_mod_id);
	 
	 UPDATE artifact SET Current_Version_ID = LAST_INSERT_ID(), Original_Version_ID = LAST_INSERT_ID() WHERE Ar_ID = var_Ar_id LIMIT 1;
	 
	 INSERT INTO ar_info (Ar_ID,`Name`,`Owner`,Mod_ID) VALUES (var_Ar_id,ArNAME,Owner_ID,var_mod_id);
	 
	 UPDATE artifact SET Current_Info_ID = LAST_INSERT_ID(), Original_Info_ID = LAST_INSERT_ID() WHERE Ar_ID = var_Ar_id LIMIT 1;
	 
	 SELECT * FROM artifact WHERE Ar_ID = var_Ar_id LIMIT 1;
END//
DELIMITER ;

-- Dumping structure for table traceability.artifact
DROP TABLE IF EXISTS `artifact`;
CREATE TABLE IF NOT EXISTS `artifact` (
  `Ar_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact',
  `Current_Version_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the artifact',
  `Original_Version_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the artifact',
  `Current_Info_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the artifact information',
  `Original_Info_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the artifact information',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`Ar_ID`) USING BTREE,
  UNIQUE KEY `Version_Latest` (`Current_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Ar_OriginalVersion` (`Original_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Ar_Info_CurrentVersion` (`Current_Info_ID`) USING BTREE,
  UNIQUE KEY `FK_Ar_Info_OriginalVersion` (`Original_Info_ID`) USING BTREE,
  CONSTRAINT `FK_Ar_CurrentVersion` FOREIGN KEY (`Current_Version_ID`) REFERENCES `ar_version` (`Ar_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Info_CurrentVersion` FOREIGN KEY (`Current_Info_ID`) REFERENCES `ar_info` (`Ar_Info_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Info_OriginalVersion` FOREIGN KEY (`Original_Info_ID`) REFERENCES `ar_info` (`Ar_Info_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_OriginalVersion` FOREIGN KEY (`Original_Version_ID`) REFERENCES `ar_version` (`Ar_Version_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='The list of artifacts providing the current version of the artifacts.\r\nHaving the name field as redundancy for searching speed.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_characterization
DROP TABLE IF EXISTS `ar_characterization`;
CREATE TABLE IF NOT EXISTS `ar_characterization` (
  `Ar_Char_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Ar_ID` int unsigned NOT NULL COMMENT 'The artifact this characterization belongs to',
  `Char_Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact Characterization' COMMENT '*Name of this characterization',
  `Current_Version_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the artifact characterization',
  `Original_Version_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the artifact characterization',
  PRIMARY KEY (`Ar_Char_ID`) USING BTREE,
  UNIQUE KEY `Version_Latest` (`Current_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Ar_OriginalVersion` (`Original_Version_ID`) USING BTREE,
  KEY `FK_Ar_Char_Ar_ID` (`Ar_ID`),
  CONSTRAINT `FK_Ar_Char_Ar_ID` FOREIGN KEY (`Ar_ID`) REFERENCES `artifact` (`Ar_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Char_Current_Version_ID` FOREIGN KEY (`Current_Version_ID`) REFERENCES `ar_char_version` (`Ar_Char_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Char_Original_Version_ID` FOREIGN KEY (`Original_Version_ID`) REFERENCES `ar_char_version` (`Ar_Char_Version_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The list of artifact characterizations providing the current version of the artifact characterizations.\r\nHaving the name field as redundancy for searching speed.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_char_version
DROP TABLE IF EXISTS `ar_char_version`;
CREATE TABLE IF NOT EXISTS `ar_char_version` (
  `Ar_Char_Version_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Ar_Char_ID` int unsigned NOT NULL COMMENT 'Pointing to the artifact this version correspond to',
  `Char_Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact Characterization' COMMENT '*Name of this characterization',
  `Type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'The type of the characterization',
  `Domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'The domain of the characterization',
  `Granularity` tinyint NOT NULL DEFAULT '0' COMMENT '?',
  `Mod_ID` int unsigned NOT NULL COMMENT 'ID of the modification',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'Artifact ID of the previous version (null for the first version)',
  PRIMARY KEY (`Ar_Char_Version_ID`) USING BTREE,
  KEY `ModifiedOn` (`ModifiedOn`) USING BTREE,
  KEY `FK_Ar_Version_ModID` (`Mod_ID`) USING BTREE,
  KEY `Artifact_Version` (`Ar_Char_ID`) USING BTREE,
  CONSTRAINT `FK_Ac_Char_Version_Mod_ID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Char_Version_Char_ID` FOREIGN KEY (`Ar_Char_ID`) REFERENCES `ar_characterization` (`Ar_Char_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Char_Version_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `ar_char_version` (`Ar_Char_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The current and past versions of characterization of the artifacts in the artifact table.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_info
DROP TABLE IF EXISTS `ar_info`;
CREATE TABLE IF NOT EXISTS `ar_info` (
  `Ar_Info_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Artifact_ID` int unsigned NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact' COMMENT 'Name of the artifact',
  `Owner` int unsigned NOT NULL COMMENT 'User ID of the owner',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'Reason of modification',
  `Attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '?',
  `Mod_ID` int unsigned NOT NULL COMMENT '(Make this a seperate table)User ID of the modifier',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'ID of the previous version this is based on (null when the version is the first one)',
  PRIMARY KEY (`Ar_Info_ID`) USING BTREE,
  KEY `Ar_info_Version` (`Artifact_ID`),
  KEY `FK_Ar_info_Version_Owner` (`Owner`),
  KEY `FK_Ar_info_version_Modifier` (`Mod_ID`) USING BTREE,
  KEY `FK_Ar_info_Version_ModifiedOn` (`ModifiedOn`),
  CONSTRAINT `Ar_info_Version` FOREIGN KEY (`Artifact_ID`) REFERENCES `artifact` (`Ar_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Ar_info_version_ModID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_info_Version_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `ar_info` (`Ar_Info_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_info_Version_Owner` FOREIGN KEY (`Owner`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='The current and past versions of information of the artifacts in the artifact table.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_info$ar_characterization
DROP TABLE IF EXISTS `ar_info$ar_characterization`;
CREATE TABLE IF NOT EXISTS `ar_info$ar_characterization` (
  `Ar_Info_ID` int unsigned NOT NULL,
  `Ar_Char_ID` int unsigned NOT NULL,
  `Relation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Ar_Info_ID`,`Ar_Char_ID`) USING BTREE,
  KEY `FK_ar_info_version_ar_characterization` (`Ar_Char_ID`),
  KEY `FK_Ar_Info_Version_ID_Ar_Char_ID` (`Ar_Info_ID`) USING BTREE,
  CONSTRAINT `FK_ar_info_version_ar_characterization` FOREIGN KEY (`Ar_Char_ID`) REFERENCES `ar_characterization` (`Ar_Char_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Info_Version_ID_Ar_Char_ID` FOREIGN KEY (`Ar_Info_ID`) REFERENCES `ar_info` (`Ar_Info_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The join table used to explain which characterizations are defined to a version';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_tl_ar
DROP TABLE IF EXISTS `ar_tl_ar`;
CREATE TABLE IF NOT EXISTS `ar_tl_ar` (
  `source_artifact_ID` int unsigned NOT NULL,
  `tracelink_ID` int unsigned NOT NULL,
  `target_artifact_ID` int unsigned NOT NULL,
  PRIMARY KEY (`source_artifact_ID`,`tracelink_ID`,`target_artifact_ID`) USING BTREE,
  KEY `FK_source artifact_ID` (`source_artifact_ID`),
  KEY `FK_target artifact_ID` (`target_artifact_ID`),
  KEY `FK_tracelink artifact_ID` (`tracelink_ID`) USING BTREE,
  CONSTRAINT `FK_source artifact_ID` FOREIGN KEY (`source_artifact_ID`) REFERENCES `artifact` (`Ar_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_target artifact_ID` FOREIGN KEY (`target_artifact_ID`) REFERENCES `artifact` (`Ar_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_tracelink artifact_ID` FOREIGN KEY (`tracelink_ID`) REFERENCES `tracelink` (`Tl_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The join table showing the relationship between artifacts and trace links';

-- Data exporting was unselected.

-- Dumping structure for table traceability.ar_version
DROP TABLE IF EXISTS `ar_version`;
CREATE TABLE IF NOT EXISTS `ar_version` (
  `Ar_Version_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Artifact_ID` int unsigned NOT NULL,
  `Owner` int unsigned NOT NULL COMMENT '?User ID of the owner',
  `Description` text,
  `Attachment` text,
  `Mod_ID` int unsigned NOT NULL COMMENT 'ID of the modification',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'Artifact ID of the previous version (null for the first version)',
  PRIMARY KEY (`Ar_Version_ID`) USING BTREE,
  KEY `ModifiedOn` (`ModifiedOn`),
  KEY `Artifact_Version` (`Artifact_ID`),
  KEY `FK_Ar_Version_ModID` (`Mod_ID`),
  KEY `FK_Ar_Version_Owner` (`Owner`),
  CONSTRAINT `Artifact_Version` FOREIGN KEY (`Artifact_ID`) REFERENCES `artifact` (`Ar_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Version_ModID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Version_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `ar_version` (`Ar_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ar_Version_Owner` FOREIGN KEY (`Owner`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='The versions of artifacts in the artifact table. (Modifacation history, not information editing)';

-- Data exporting was unselected.

-- Dumping structure for table traceability.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `Department_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Short` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'department name in short',
  `Head` int unsigned DEFAULT NULL COMMENT 'User ID of the head of the department',
  PRIMARY KEY (`Department_ID`),
  KEY `FK_Department_Head` (`Head`),
  CONSTRAINT `FK_Department_Head` FOREIGN KEY (`Head`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='The information of the departments used to provide more information about a user.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.modification
DROP TABLE IF EXISTS `modification`;
CREATE TABLE IF NOT EXISTS `modification` (
  `Mod_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `ModifiedBy` int unsigned NOT NULL COMMENT 'User ID of the modifier',
  `ModificationTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Supervisor` int unsigned DEFAULT NULL COMMENT 'User ID of the supervisor',
  `Reason` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'Reason of modification',
  PRIMARY KEY (`Mod_ID`),
  KEY `FK_ModificationBy` (`ModifiedBy`),
  KEY `FK_Modification_Supervisior` (`Supervisor`),
  CONSTRAINT `FK_Modification_Supervisior` FOREIGN KEY (`Supervisor`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_ModificationBy` FOREIGN KEY (`ModifiedBy`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='The list of all modification operation done by user.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tl_characterization
DROP TABLE IF EXISTS `tl_characterization`;
CREATE TABLE IF NOT EXISTS `tl_characterization` (
  `Tl_Char_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Tl_ID` int unsigned NOT NULL COMMENT 'The artifact this characterization belongs to',
  `Char_Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Trace Link Characterization',
  `Current_Version_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the artifact characterization',
  `Original_Version_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the artifact characterization',
  PRIMARY KEY (`Tl_Char_ID`) USING BTREE,
  UNIQUE KEY `Version_Latest` (`Current_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Tl_OriginalVersion` (`Original_Version_ID`) USING BTREE,
  KEY `FK_Tl_Char_Ar_ID` (`Tl_ID`) USING BTREE,
  CONSTRAINT `FK_Tl_Current_Version_ID` FOREIGN KEY (`Current_Version_ID`) REFERENCES `tl_char_version` (`Tl_Char_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_ID` FOREIGN KEY (`Tl_ID`) REFERENCES `tracelink` (`Tl_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Original_Version_ID` FOREIGN KEY (`Original_Version_ID`) REFERENCES `tl_char_version` (`Tl_Char_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The list of artifact characterizations providing the current version of the trace link characterizations.\r\nHaving the name field as redundancy for searching speed.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tl_char_version
DROP TABLE IF EXISTS `tl_char_version`;
CREATE TABLE IF NOT EXISTS `tl_char_version` (
  `Tl_Char_Version_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Tl_Char_ID` int unsigned NOT NULL COMMENT 'Pointing to the tracelink this version correspond to',
  `Char_Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact Characterization' COMMENT '*Name of this characterization',
  `Type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'The type of the characterization',
  `Domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'The domain of the characterization',
  `Granularity` tinyint NOT NULL DEFAULT '0' COMMENT '?',
  `Mod_ID` int unsigned NOT NULL COMMENT 'ID of the modification',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'Artifact ID of the previous version (null for the first version)',
  PRIMARY KEY (`Tl_Char_Version_ID`) USING BTREE,
  KEY `ModifiedOn` (`ModifiedOn`) USING BTREE,
  KEY `FK_Tl_Version_ModID` (`Mod_ID`) USING BTREE,
  KEY `TraceLink_Version` (`Tl_Char_ID`) USING BTREE,
  CONSTRAINT `FK_Tl_Char_Version_Char_ID` FOREIGN KEY (`Tl_Char_ID`) REFERENCES `tl_characterization` (`Tl_Char_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Mod_ID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `tl_char_version` (`Tl_Char_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The current and past versions of characterization of the trace link in the trace link table.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tl_info
DROP TABLE IF EXISTS `tl_info`;
CREATE TABLE IF NOT EXISTS `tl_info` (
  `Tl_Info_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `TraceLink_ID` int unsigned NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact' COMMENT 'Name of the tracelink',
  `Owner` int unsigned NOT NULL COMMENT 'User ID of the owner',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'Reason of modification',
  `Attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '?',
  `Mod_ID` int unsigned NOT NULL COMMENT '(Make this a seperate table)User ID of the modifier',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'ID of the previous version this is based on (null when the version is the first one)',
  PRIMARY KEY (`Tl_Info_ID`) USING BTREE,
  KEY `FK_Tl_info_Version_Owner` (`Owner`) USING BTREE,
  KEY `FK_Tl_info_version_Modifier` (`Mod_ID`) USING BTREE,
  KEY `FK_Tl_Info_Version_ModifiedOn` (`ModifiedOn`) USING BTREE,
  KEY `Tl_info_Version` (`TraceLink_ID`) USING BTREE,
  CONSTRAINT `FK_Tl_Info_Version_Mod_ID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Info_Version_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `tl_info` (`Tl_Info_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Info_Version_Owner` FOREIGN KEY (`Owner`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Info_Version_TraceLink_ID` FOREIGN KEY (`TraceLink_ID`) REFERENCES `tracelink` (`Tl_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The current and past versions of information of the trace link in the trace link table.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tl_info$tr_characterization
DROP TABLE IF EXISTS `tl_info$tr_characterization`;
CREATE TABLE IF NOT EXISTS `tl_info$tr_characterization` (
  `Tl_Info_ID` int unsigned NOT NULL,
  `Tl_Char_ID` int unsigned NOT NULL,
  `Relation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Tl_Info_ID`,`Tl_Char_ID`) USING BTREE,
  KEY `FK_Tl_Char_ID_Tl_Info_Version_ID` (`Tl_Char_ID`) USING BTREE,
  KEY `FK_Tl_Info_Version_ID_Tl_Char_ID` (`Tl_Info_ID`) USING BTREE,
  CONSTRAINT `FK_Tl_Char_ID` FOREIGN KEY (`Tl_Char_ID`) REFERENCES `tl_characterization` (`Tl_Char_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tl_Info_Version_ID` FOREIGN KEY (`Tl_Info_ID`) REFERENCES `tl_info` (`Tl_Info_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The join table used to explain which characterizations are defined to a version';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tl_version
DROP TABLE IF EXISTS `tl_version`;
CREATE TABLE IF NOT EXISTS `tl_version` (
  `Tl_Version_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `TraceLink_ID` int unsigned NOT NULL,
  `Owner` int unsigned NOT NULL COMMENT '?User ID of the owner',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `Attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `Mod_ID` int unsigned NOT NULL COMMENT 'ID of the modification',
  `ModifiedOn` int unsigned DEFAULT NULL COMMENT 'TraceLink ID of the previous version (null for the first version)',
  PRIMARY KEY (`Tl_Version_ID`) USING BTREE,
  KEY `ModifiedOn` (`ModifiedOn`) USING BTREE,
  KEY `Artifact_Version` (`TraceLink_ID`) USING BTREE,
  KEY `FK_Tl_Version_ModID` (`Mod_ID`) USING BTREE,
  KEY `FK_Tl_Version_Owner` (`Owner`) USING BTREE,
  CONSTRAINT `FK_tr_Version_Mod_ID` FOREIGN KEY (`Mod_ID`) REFERENCES `modification` (`Mod_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tr_Version_ModifiedOn` FOREIGN KEY (`ModifiedOn`) REFERENCES `tl_version` (`Tl_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tr_Version_Owner` FOREIGN KEY (`Owner`) REFERENCES `user` (`User_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Tr_Version_TraceLink_ID` FOREIGN KEY (`TraceLink_ID`) REFERENCES `tracelink` (`Tl_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The versions of trace link in the trace link table. (Modifacation history, not information editing)';

-- Data exporting was unselected.

-- Dumping structure for table traceability.tracelink
DROP TABLE IF EXISTS `tracelink`;
CREATE TABLE IF NOT EXISTS `tracelink` (
  `Tl_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Unnamed Artifact',
  `Current_Version_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the tracelink',
  `Original_Version_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the tracelink',
  `Current_Info_ID` int unsigned DEFAULT NULL COMMENT 'The current version of the tracelink information',
  `Original_Info_ID` int unsigned DEFAULT NULL COMMENT 'The original version of the tracelink information',
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`Tl_ID`) USING BTREE,
  UNIQUE KEY `Version_Latest` (`Current_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Tl_OriginalVersion` (`Original_Version_ID`) USING BTREE,
  UNIQUE KEY `FK_Tl_Info_CurrentVersion` (`Current_Info_ID`) USING BTREE,
  UNIQUE KEY `FK_Tl_Info_OriginalVersion` (`Original_Info_ID`) USING BTREE,
  CONSTRAINT `FK_TraceLink_Current_Info_Version` FOREIGN KEY (`Current_Info_ID`) REFERENCES `tl_info` (`Tl_Info_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_TraceLink_Current_Version` FOREIGN KEY (`Current_Version_ID`) REFERENCES `tl_version` (`Tl_Version_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_TraceLink_Original_Info_Version` FOREIGN KEY (`Original_Info_ID`) REFERENCES `tl_info` (`Tl_Info_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_TraceLink_Original_Version` FOREIGN KEY (`Original_Version_ID`) REFERENCES `tl_version` (`Tl_Version_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='The list of trace link providing the current version of the trace link.\r\nHaving the name field as redundancy for searching speed.';

-- Data exporting was unselected.

-- Dumping structure for table traceability.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `User_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Full_Name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Active` bit(1) NOT NULL COMMENT 'If the user is disabled this should be set to 0',
  `Phone` text,
  `EMail` text,
  `Office` text,
  `Description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`User_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='The information of users';

-- Data exporting was unselected.

-- Dumping structure for table traceability.user$department
DROP TABLE IF EXISTS `user$department`;
CREATE TABLE IF NOT EXISTS `user$department` (
  `User_ID` int unsigned NOT NULL,
  `Department_ID` int unsigned NOT NULL,
  `Role` tinytext,
  `Update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_ID`,`Department_ID`),
  KEY `FK_Department_User` (`Department_ID`),
  KEY `User_ID` (`User_ID`),
  CONSTRAINT `FK_Department_User` FOREIGN KEY (`Department_ID`) REFERENCES `department` (`Department_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_User_Department` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The relationships between users and departments';

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
