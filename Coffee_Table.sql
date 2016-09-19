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


-- Dumping structure for procedure the_coffee_table.orders
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `orders`(IN `tableNumber` INT)
BEGIN
	SELECT * from tbl_orders WHERE TableNo = tableNumber order by name asc;
	
	/** you should not miss this part ..maraming developers d marunong gumamit neto**/
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


-- Dumping structure for table the_coffee_table.tbl_items
CREATE TABLE IF NOT EXISTS `tbl_items` (
  `itemno` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `categoryname` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `imgURL` varchar(50) NOT NULL,
  PRIMARY KEY (`itemno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_menu
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

-- Data exporting was unselected.


-- Dumping structure for table the_coffee_table.tbl_orders
CREATE TABLE IF NOT EXISTS `tbl_orders` (
  `orderNo` int(11) NOT NULL AUTO_INCREMENT,
  `TableNo` int(11) NOT NULL COMMENT 'kung saang table',
  `itemno` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orderNo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
