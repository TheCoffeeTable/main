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
CREATE DATABASE IF NOT EXISTS `the_coffee_table` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `the_coffee_table`;


-- Dumping structure for procedure the_coffee_table.get-categories
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `get-categories`()
BEGIN
SELECT categoryname from tbl_category order by categoryname asc ;

END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.get-items
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


-- Dumping structure for procedure the_coffee_table.orders
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders`(IN `tableNumber` INT)
BEGIN
	SELECT * from tbl_orders WHERE TableNo = tableNumber order by name asc;
	
	/** you should not miss this part ..maraming developers d marunong gumamit neto**/
END//
DELIMITER ;


-- Dumping structure for procedure the_coffee_table.rater
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
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `admin_id` int(8) NOT NULL AUTO_INCREMENT,
  `password` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_category
CREATE TABLE IF NOT EXISTS `tbl_category` (
  `catNo` int(11) NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(50) NOT NULL,
  PRIMARY KEY (`catNo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_orders
CREATE TABLE IF NOT EXISTS `tbl_orders` (
  `orderNo` int(11) NOT NULL AUTO_INCREMENT,
  `TableNo` int(11) DEFAULT NULL COMMENT 'kung saang table',
  `productNo` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`orderNo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_product
CREATE TABLE IF NOT EXISTS `tbl_product` (
  `itemno` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `categoryname` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `imgURL` text,
  PRIMARY KEY (`itemno`),
  KEY `itemno` (`itemno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_rate
CREATE TABLE IF NOT EXISTS `tbl_rate` (
  `itemno` int(11) NOT NULL,
  `rateCount` int(10) unsigned NOT NULL DEFAULT '0',
  `maxRate` float unsigned DEFAULT '0',
  `totalRate` float unsigned DEFAULT '0',
  `percentage` float unsigned DEFAULT '0',
  KEY `itemno` (`itemno`),
  CONSTRAINT `FK_tbl_rate_tbl_product` FOREIGN KEY (`itemno`) REFERENCES `tbl_product` (`itemno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_staff_account
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

-- Data exporting was unselected.


-- Dumping structure for trigger the_coffee_table.create-rate
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
