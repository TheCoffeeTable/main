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
	SELECT * from tbl_product order by categoryname asc;
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
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_orders: 8 rows
/*!40000 ALTER TABLE `tbl_orders` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_orders` (`orderNo`, `TableNo`, `productNo`, `name`, `qty`, `price`) VALUES
	(1, 1, 'qqq', NULL, 1, 19.00),
	(2, 1, 'asd', NULL, 1, 19.00),
	(3, 1, '2', NULL, 1, 19.00),
	(4, 1, '4', NULL, 1, 19.00),
	(5, 1, 'qqq', '2', 1, 19.00),
	(6, 1, 'ghjgh', '4', 1, 19.00),
	(7, 1, 'ghjgh', '5', 1, 19.00),
	(8, 1, 'asd', '1', 1, 19.00);
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
  `imgURL` varchar(50) NOT NULL,
  PRIMARY KEY (`itemno`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table the_coffee_table.tbl_product: 5 rows
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT IGNORE INTO `tbl_product` (`itemno`, `status`, `name`, `categoryname`, `description`, `price`, `imgURL`) VALUES
	(1, 'AVAILABLE', 'asd', 'asd', 'dsd', 19.00, 'pasta'),
	(2, 'AVAILABLE', 'qqq', '123', 'dsd', 19.00, 'special'),
	(3, 'AVAILABLE', 'ghjgh', 'asd', 'dsd', 19.00, 'bananasplit'),
	(4, 'AVAILABLE', 'ghjgh', '123', 'dsd', 19.00, 'shakes'),
	(5, 'AVAILABLE', 'ghjgh', '123', 'dsd', 19.00, 'sandwich');
/*!40000 ALTER TABLE `tbl_product` ENABLE KEYS */;


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
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
