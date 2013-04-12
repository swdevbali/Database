-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.27


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema email2sms
--

CREATE DATABASE IF NOT EXISTS email2sms;
USE email2sms;

--
-- Definition of table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `name` varchar(255) NOT NULL,
  `server` varchar(45) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `use_ssl` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='		';

--
-- Dumping data for table `account`
--

/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` (`name`,`server`,`port`,`username`,`password`,`use_ssl`,`active`) VALUES 
 ('eko.wibowo@fikr-malaysia.com','pop.gmail.com',995,'eko.wibowo@fikr-malaysia.com','HGtKxT7czTHzcRtjh9ybyw==',0,0),
 ('support-pv@datasam.com.au','pop.gmail.com',995,'support-pv@datasam.com.au','PYsp5cv2Khc/HaIupliAqw==',1,1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;


--
-- Definition of table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE `configuration` (
  `idconfiguration` int(11) NOT NULL AUTO_INCREMENT,
  `phone_notify` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idconfiguration`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configuration`
--

/*!40000 ALTER TABLE `configuration` DISABLE KEYS */;
INSERT INTO `configuration` (`idconfiguration`,`phone_notify`) VALUES 
 (1,'0812221975');
/*!40000 ALTER TABLE `configuration` ENABLE KEYS */;


--
-- Definition of table `inbox`
--

DROP TABLE IF EXISTS `inbox`;
CREATE TABLE `inbox` (
  `idinbox` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` text,
  `date` varchar(255) DEFAULT NULL,
  `handled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idinbox`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inbox`
--

/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox` ENABLE KEYS */;


--
-- Definition of table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `idlog` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `occur` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `account_name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`idlog`),
  KEY `FK_log_1` (`account_name`),
  CONSTRAINT `FK_log_1` FOREIGN KEY (`account_name`) REFERENCES `account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log`
--

/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;


--
-- Definition of table `rule`
--

DROP TABLE IF EXISTS `rule`;
CREATE TABLE `rule` (
  `name` varchar(255) NOT NULL,
  `contains` varchar(255) DEFAULT NULL,
  `send_sms` tinyint(1) DEFAULT NULL,
  `voice_call` tinyint(1) DEFAULT NULL,
  `use_body` tinyint(1) DEFAULT '1',
  `use_subject` tinyint(1) DEFAULT '0',
  `use_sender` tinyint(1) DEFAULT '0',
  `subject_contains` varchar(255) DEFAULT NULL,
  `sender_contains` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rule`
--

/*!40000 ALTER TABLE `rule` DISABLE KEYS */;
INSERT INTO `rule` (`name`,`contains`,`send_sms`,`voice_call`,`use_body`,`use_subject`,`use_sender`,`subject_contains`,`sender_contains`) VALUES 
 ('Severity=Critical','Severity=Critical',1,1,1,0,0,' ',' '),
 ('Severity=Warning','Severity=Warning',1,0,1,0,0,' ',' ');
/*!40000 ALTER TABLE `rule` ENABLE KEYS */;


--
-- Definition of table `send_sms`
--

DROP TABLE IF EXISTS `send_sms`;
CREATE TABLE `send_sms` (
  `idsend_sms` int(11) NOT NULL AUTO_INCREMENT,
  `idinbox` int(11) DEFAULT NULL,
  `content` text,
  `status` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idsend_sms`),
  KEY `fk1_idx` (`idinbox`),
  KEY `FK_send_sms_21` (`account_name`),
  CONSTRAINT `fk1` FOREIGN KEY (`idinbox`) REFERENCES `inbox` (`idinbox`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_send_sms_21` FOREIGN KEY (`account_name`) REFERENCES `account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `send_sms`
--

/*!40000 ALTER TABLE `send_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `send_sms` ENABLE KEYS */;


--
-- Definition of table `voice_call`
--

DROP TABLE IF EXISTS `voice_call`;
CREATE TABLE `voice_call` (
  `idvoice_call` int(11) NOT NULL AUTO_INCREMENT,
  `idinbox` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idvoice_call`),
  KEY `pk2_idx` (`idinbox`),
  KEY `FK_voice_call_2` (`account_name`),
  CONSTRAINT `FK_voice_call_2` FOREIGN KEY (`account_name`) REFERENCES `account` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pk2` FOREIGN KEY (`idinbox`) REFERENCES `inbox` (`idinbox`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `voice_call`
--

/*!40000 ALTER TABLE `voice_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `voice_call` ENABLE KEYS */;

--
-- Create schema tree
--

CREATE DATABASE IF NOT EXISTS tree;
USE tree;

--
-- Definition of table `catatan`
--

DROP TABLE IF EXISTS `catatan`;
CREATE TABLE `catatan` (
  `idcatatan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catatan` text NOT NULL,
  PRIMARY KEY (`idcatatan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `catatan`
--

/*!40000 ALTER TABLE `catatan` DISABLE KEYS */;
/*!40000 ALTER TABLE `catatan` ENABLE KEYS */;


--
-- Definition of table `jenjang`
--

DROP TABLE IF EXISTS `jenjang`;
CREATE TABLE `jenjang` (
  `jenjang` varchar(10) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `prioritas` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`jenjang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `jenjang`
--

/*!40000 ALTER TABLE `jenjang` DISABLE KEYS */;
INSERT INTO `jenjang` (`jenjang`,`prioritas`) VALUES 
 ('IT',0);
/*!40000 ALTER TABLE `jenjang` ENABLE KEYS */;


--
-- Definition of table `jurusan`
--

DROP TABLE IF EXISTS `jurusan`;
CREATE TABLE `jurusan` (
  `idjurusan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jurusan` varchar(255) NOT NULL,
  PRIMARY KEY (`idjurusan`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jurusan`
--

/*!40000 ALTER TABLE `jurusan` DISABLE KEYS */;
INSERT INTO `jurusan` (`idjurusan`,`jurusan`) VALUES 
 (1,'IT');
/*!40000 ALTER TABLE `jurusan` ENABLE KEYS */;


--
-- Definition of table `klien`
--

DROP TABLE IF EXISTS `klien`;
CREATE TABLE `klien` (
  `idklien` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `judul` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `urutan_masuk` int(10) unsigned DEFAULT NULL,
  `jenjang` varchar(10) COLLATE latin1_general_ci DEFAULT NULL,
  `universitas` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `finish` tinyint(1) NOT NULL DEFAULT '0',
  `fokus` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `jurusan` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `prodi` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `catatan` text COLLATE latin1_general_ci NOT NULL,
  `total_harga` double NOT NULL,
  `dp` double DEFAULT NULL,
  `tanggal_dp` date DEFAULT NULL,
  PRIMARY KEY (`idklien`),
  KEY `FK_klien_1` (`jenjang`),
  KEY `FK_klien_2` (`universitas`),
  CONSTRAINT `FK_klien_1` FOREIGN KEY (`jenjang`) REFERENCES `jenjang` (`jenjang`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_klien_2` FOREIGN KEY (`universitas`) REFERENCES `universitas` (`universitas`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `klien`
--

/*!40000 ALTER TABLE `klien` DISABLE KEYS */;
INSERT INTO `klien` (`idklien`,`nama`,`judul`,`urutan_masuk`,`jenjang`,`universitas`,`finish`,`fokus`,`status`,`jurusan`,`prodi`,`catatan`,`total_harga`,`dp`,`tanggal_dp`) VALUES 
 (22,'Fikr Malaysia','FikrPOS',NULL,'IT','Fikr Malaysia',0,0,'Go','IT','IT','Reporting',0,0,'2013-03-11');
/*!40000 ALTER TABLE `klien` ENABLE KEYS */;


--
-- Definition of table `klien_fokus`
--

DROP TABLE IF EXISTS `klien_fokus`;
CREATE TABLE `klien_fokus` (
  `idklien_fokus` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idklien` int(10) unsigned DEFAULT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fokus` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `finish` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(45) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`idklien_fokus`),
  KEY `FK_klien_fokus_1` (`idklien`),
  CONSTRAINT `FK_klien_fokus_1` FOREIGN KEY (`idklien`) REFERENCES `klien` (`idklien`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `klien_fokus`
--

/*!40000 ALTER TABLE `klien_fokus` DISABLE KEYS */;
INSERT INTO `klien_fokus` (`idklien_fokus`,`idklien`,`tanggal`,`fokus`,`finish`,`status`) VALUES 
 (15,22,'2013-03-26 01:53:47','Setup installer',0,'Waiting'),
 (16,22,'2013-03-26 01:53:50','Sales reporting',0,'Waiting'),
 (17,22,'2013-03-26 01:53:52','Stock trigger',0,'Waiting');
/*!40000 ALTER TABLE `klien_fokus` ENABLE KEYS */;


--
-- Definition of table `klien_fokus_log`
--

DROP TABLE IF EXISTS `klien_fokus_log`;
CREATE TABLE `klien_fokus_log` (
  `idklien_fokus_log` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idklien_fokus` int(10) unsigned NOT NULL,
  `end` datetime DEFAULT NULL,
  PRIMARY KEY (`idklien_fokus_log`),
  KEY `FK_klien_fokus_log_1` (`idklien_fokus`),
  CONSTRAINT `FK_klien_fokus_log_1` FOREIGN KEY (`idklien_fokus`) REFERENCES `klien_fokus` (`idklien_fokus`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `klien_fokus_log`
--

/*!40000 ALTER TABLE `klien_fokus_log` DISABLE KEYS */;
INSERT INTO `klien_fokus_log` (`idklien_fokus_log`,`idklien_fokus`,`end`) VALUES 
 (1,15,NULL),
 (2,16,NULL),
 (3,17,NULL),
 (4,15,'2013-03-26 01:03:00'),
 (5,15,'2013-03-26 01:03:27'),
 (6,15,'2013-03-26 01:03:31'),
 (7,16,'2013-03-26 01:03:43'),
 (8,15,'2013-03-26 01:03:47'),
 (9,16,'2013-03-26 01:03:50'),
 (10,17,'2013-03-26 01:03:52');
/*!40000 ALTER TABLE `klien_fokus_log` ENABLE KEYS */;


--
-- Definition of table `pemakai`
--

DROP TABLE IF EXISTS `pemakai`;
CREATE TABLE `pemakai` (
  `idpemakai` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `password` varchar(45) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`idpemakai`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `pemakai`
--

/*!40000 ALTER TABLE `pemakai` DISABLE KEYS */;
INSERT INTO `pemakai` (`idpemakai`,`userid`,`password`) VALUES 
 (1,'swdev','muhammad');
/*!40000 ALTER TABLE `pemakai` ENABLE KEYS */;


--
-- Definition of table `prodi`
--

DROP TABLE IF EXISTS `prodi`;
CREATE TABLE `prodi` (
  `idprodi` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prodi` varchar(45) NOT NULL,
  PRIMARY KEY (`idprodi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `prodi`
--

/*!40000 ALTER TABLE `prodi` DISABLE KEYS */;
INSERT INTO `prodi` (`idprodi`,`prodi`) VALUES 
 (1,'IT');
/*!40000 ALTER TABLE `prodi` ENABLE KEYS */;


--
-- Definition of table `universitas`
--

DROP TABLE IF EXISTS `universitas`;
CREATE TABLE `universitas` (
  `universitas` varchar(30) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`universitas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `universitas`
--

/*!40000 ALTER TABLE `universitas` DISABLE KEYS */;
INSERT INTO `universitas` (`universitas`) VALUES 
 ('Fikr Malaysia');
/*!40000 ALTER TABLE `universitas` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
