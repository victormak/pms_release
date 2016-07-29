/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.105
 Source Server Type    : MySQL
 Source Server Version : 50619
 Source Host           : 192.168.1.102
 Source Database       : pms

 Target Server Type    : MySQL
 Target Server Version : 50619
 File Encoding         : utf-8

 Date: 05/09/2016 22:40:40 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `apartment`
-- ----------------------------
DROP TABLE IF EXISTS `apartment`;
CREATE TABLE `apartment` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `apartment_id` int(20) DEFAULT NULL,
  `apartment_name` varchar(20) DEFAULT NULL,
  `apartment_electric_fee` varchar(20) DEFAULT NULL,
  `apartment_desc` varchar(500) DEFAULT NULL,
  `apartment_status` varchar(50) DEFAULT NULL,
  `apartment_floor` int(10) DEFAULT NULL,
  `apartment_person_num` int(10) DEFAULT NULL,
  `apartment_owe` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `contract`
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `id` int(10) NOT NULL,
  `contract_id` int(10) DEFAULT NULL,
  `apartment_id` int(10) DEFAULT NULL,
  `tenant_id` int(10) DEFAULT NULL,
  `contract_starttime` varchar(20) DEFAULT NULL,
  `contract_endtime` varchar(20) DEFAULT NULL,
  `contract_month_price` varchar(20) DEFAULT NULL,
  `contract_deposit` varchar(20) DEFAULT NULL,
  `contract_frequency` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `fee_item`
-- ----------------------------
DROP TABLE IF EXISTS `fee_item`;
CREATE TABLE `fee_item` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `feeitem_id` int(20) DEFAULT NULL,
  `feeitem_name` varchar(20) DEFAULT NULL,
  `feeitem_price` varchar(20) DEFAULT NULL,
  `feeitem_desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `feehistory`
-- ----------------------------
DROP TABLE IF EXISTS `feehistory`;
CREATE TABLE `feehistory` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `feehistory_id` int(20) DEFAULT NULL,
  `tenant_name` varchar(20) DEFAULT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `fee_items` varchar(20) DEFAULT NULL,
  `apartment_name` varchar(20) DEFAULT NULL,
  `electric_fee` varchar(20) DEFAULT NULL,
  `water_fee` varchar(20) DEFAULT NULL,
  `net_fee` varchar(20) DEFAULT NULL,
  `trash_fee` varchar(20) DEFAULT NULL,
  `month_fee` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tenant`
-- ----------------------------
DROP TABLE IF EXISTS `tenant`;
CREATE TABLE `tenant` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(20) DEFAULT NULL,
  `tenant_name` varchar(20) DEFAULT NULL,
  `tenant_age` int(20) DEFAULT NULL,
  `tenant_phonenumber` int(20) DEFAULT NULL,
  `tenant_sex` varchar(20) DEFAULT NULL,
  `tenant_desc` varchar(100) DEFAULT NULL,
  `tenant_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `user_pass` varchar(50) DEFAULT NULL,
  `user_permission` varchar(20) DEFAULT NULL,
  `user_id` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
