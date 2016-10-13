-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.11 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for the_coffee_table
DROP DATABASE IF EXISTS `the_coffee_table`;
CREATE DATABASE IF NOT EXISTS `the_coffee_table` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `the_coffee_table`;


-- Dumping structure for procedure the_coffee_table.all-tables
DROP PROCEDURE IF EXISTS `all-tables`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `all-tables`()
BEGIN
	SELECT distinct(TableNo) from tbl_orders order by TableNo asc;
END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.get-categories
DROP PROCEDURE IF EXISTS `get-categories`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get-categories`()
BEGIN
SELECT categoryname from tbl_category order by categoryname asc ;

END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.get-items
DROP PROCEDURE IF EXISTS `get-items`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get-items`()
BEGIN
	SELECT * from tbl_product as p
	left join tbl_rate as r
	on
	p.itemno = r.itemno
	order by categoryname asc;
END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.get-survey
DROP PROCEDURE IF EXISTS `get-survey`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get-survey`()
BEGIN
	SELECT * from tbl_survey limit 10;
END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.orders
DROP PROCEDURE IF EXISTS `orders`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders`(IN `tableNumber` INT)
BEGIN
	SELECT * from tbl_orders WHERE TableNo = tableNumber order by name asc;
	
	/** you should not miss this part ..maraming developers d marunong gumamit neto**/
END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.rater
DROP PROCEDURE IF EXISTS `rater`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `rater`(IN `xitem` VARCHAR(50), IN `xrate` FLOAT)
BEGIN
	update tbl_rate set rateCount = rateCount + 1 WHERE itemno = xitem limit 1;
	update tbl_rate set totalRate = totalRate + xrate WHERE itemno = xitem limit 1;
	update tbl_rate set maxRate = (ratecount*5) WHERE itemno = xitem limit 1;
	update tbl_rate set percentage = ((totalRate/maxRate)*100)/20 WHERE itemno = xitem limit 1;
END//
DELIMITER ;


-- Dumping structure for table the_coffee_table.tbl_admin
DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `admin_id` int(8) NOT NULL AUTO_INCREMENT,
  `password` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_admin: 0 rows
/*!40000 ALTER TABLE `tbl_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_admin` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_category
DROP TABLE IF EXISTS `tbl_category`;
CREATE TABLE IF NOT EXISTS `tbl_category` (
  `catNo` int(11) NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(50) NOT NULL,
  PRIMARY KEY (`catNo`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_category: 2 rows
/*!40000 ALTER TABLE `tbl_category` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_category` (`catNo`, `categoryname`) VALUES
	(1, '123'),
	(2, 'asd');
/*!40000 ALTER TABLE `tbl_category` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_menu
DROP TABLE IF EXISTS `tbl_menu`;
CREATE TABLE IF NOT EXISTS `tbl_menu` (
  `menuno` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `categoryname` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `imgURL` varchar(50) NOT NULL,
  PRIMARY KEY (`menuno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table the_coffee_table.tbl_menu: 0 rows
/*!40000 ALTER TABLE `tbl_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_menu` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_orders
DROP TABLE IF EXISTS `tbl_orders`;
CREATE TABLE IF NOT EXISTS `tbl_orders` (
  `orderNo` int(11) NOT NULL AUTO_INCREMENT,
  `TableNo` int(11) DEFAULT NULL COMMENT 'kung saang table',
  `productNo` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`orderNo`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_orders: 5 rows
/*!40000 ALTER TABLE `tbl_orders` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_orders` (`orderNo`, `TableNo`, `productNo`, `name`, `qty`, `price`) VALUES
	(20, 3, '19', 'Shake', 2, 50.00),
	(19, 1, '19', 'Shake', 1, 25.00),
	(18, 5, '17', 'Banana Split', 1, 50.00),
	(17, 2, '18', 'Hot Choco', 2, 30.00),
	(16, 2, '16', 'Pasta', 1, 20.00);
/*!40000 ALTER TABLE `tbl_orders` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_product
DROP TABLE IF EXISTS `tbl_product`;
CREATE TABLE IF NOT EXISTS `tbl_product` (
  `itemno` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `categoryname` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `imgURL` text,
  PRIMARY KEY (`itemno`),
  KEY `itemno` (`itemno`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_product: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_product` (`itemno`, `status`, `name`, `categoryname`, `description`, `price`, `imgURL`) VALUES
	(16, 'NOT AVAILABLE', 'Pasta', '123', 'zxczxczasdsad', 20.00, 'pasta'),
	(17, 'AVAILABLE', 'Banana Split', 'asd', 'jknkjfbsdjbjkbf', 50.00, 'bananasplit'),
	(18, 'AVAILABLE', 'Hot Choco', '123', 'lkjjnjknkjnjn', 15.00, 'hotchoco'),
	(19, 'AVAILABLE', 'Shake', 'asd', 'zxczxczxc', 25.00, 'shakes'),
	(20, 'AVAILABLE', 'Sandwich', '123', 'asannssad', 25.00, 'sandwich');
/*!40000 ALTER TABLE `tbl_product` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_rate
DROP TABLE IF EXISTS `tbl_rate`;
CREATE TABLE IF NOT EXISTS `tbl_rate` (
  `itemno` int(11) NOT NULL,
  `rateCount` int(10) unsigned NOT NULL DEFAULT '0',
  `maxRate` float unsigned DEFAULT '0',
  `totalRate` float unsigned DEFAULT '0',
  `percentage` float unsigned DEFAULT '0',
  KEY `itemno` (`itemno`),
  CONSTRAINT `FK_tbl_rate_tbl_product` FOREIGN KEY (`itemno`) REFERENCES `tbl_product` (`itemno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_rate: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_rate` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_rate` (`itemno`, `rateCount`, `maxRate`, `totalRate`, `percentage`) VALUES
	(16, 9, 45, 15, 1.66667),
	(17, 10, 50, 42, 4.2),
	(18, 5, 25, 11.5, 2.3),
	(19, 4, 20, 17.5, 4.5),
	(20, 5, 25, 9.5, 1.9);
/*!40000 ALTER TABLE `tbl_rate` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_staff_account
DROP TABLE IF EXISTS `tbl_staff_account`;
CREATE TABLE IF NOT EXISTS `tbl_staff_account` (
  `staff_number` int(10) NOT NULL AUTO_INCREMENT,
  `staff_id` varchar(50) DEFAULT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL,
  `password` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`staff_number`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_staff_account: 0 rows
/*!40000 ALTER TABLE `tbl_staff_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_staff_account` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_survey
DROP TABLE IF EXISTS `tbl_survey`;
CREATE TABLE IF NOT EXISTS `tbl_survey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `averageRate` float DEFAULT NULL,
  `rateCount` float DEFAULT NULL,
  `maxRate` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_survey: 10 rows
/*!40000 ALTER TABLE `tbl_survey` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_survey` (`id`, `question`, `averageRate`, `rateCount`, `maxRate`) VALUES
	(1, 'q1', NULL, NULL, NULL),
	(2, 'q2', NULL, NULL, NULL),
	(3, 'q3', NULL, NULL, NULL),
	(4, 'q4', NULL, NULL, NULL),
	(5, 'q5', NULL, NULL, NULL),
	(6, 'q6', NULL, NULL, NULL),
	(7, 'q7', NULL, NULL, NULL),
	(8, 'q8', NULL, NULL, NULL),
	(9, 'q9', NULL, NULL, NULL),
	(10, 'q10', NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_survey` ENABLE KEYS */;


-- Dumping structure for table the_coffee_table.tbl_tableno
DROP TABLE IF EXISTS `tbl_tableno`;
CREATE TABLE IF NOT EXISTS `tbl_tableno` (
  `tblno` int(11) NOT NULL AUTO_INCREMENT,
  `IP` varchar(50) NOT NULL,
  PRIMARY KEY (`tblno`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_tableno: 1 rows
/*!40000 ALTER TABLE `tbl_tableno` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_tableno` (`tblno`, `IP`) VALUES
	(1, '::1');
/*!40000 ALTER TABLE `tbl_tableno` ENABLE KEYS */;


-- Dumping structure for trigger the_coffee_table.create-rate
DROP TRIGGER IF EXISTS `create-rate`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER `create-rate` AFTER INSERT ON `tbl_product` FOR EACH ROW BEGIN
	INSERT into tbl_rate(itemno)VALUES(new.itemno);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
