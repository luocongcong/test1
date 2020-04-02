/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_information

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:22:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accuauth_face_anti_hack
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_face_anti_hack`;
CREATE TABLE `accuauth_face_anti_hack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `image_store_path` varchar(100) NOT NULL,
  `method` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `score` double DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_image_store_path` (`image_store_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='accuauth_face_anti_hack';

-- ----------------------------
-- Table structure for accuauth_face_verify
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_face_verify`;
CREATE TABLE `accuauth_face_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `first_image_store_path` varchar(100) NOT NULL,
  `first_image_remark` varchar(100) NOT NULL,
  `second_image_store_path` varchar(100) NOT NULL,
  `second_image_remark` varchar(100) NOT NULL,
  `request_id` varchar(64) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `identical` bit(1) DEFAULT NULL,
  `score` double DEFAULT NULL,
  `image_id_1` varchar(64) DEFAULT NULL,
  `image_id_2` varchar(64) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_first_image_store_path` (`first_image_store_path`),
  KEY `idx_second_image_store_path` (`second_image_store_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='人脸比对';

-- ----------------------------
-- Table structure for accuauth_ocr
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_ocr`;
CREATE TABLE `accuauth_ocr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `image_store_path` varchar(100) NOT NULL,
  `method` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `image_id` varchar(64) DEFAULT NULL,
  `results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`results`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_image_store_path` (`image_store_path`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COMMENT='accuauth ocr 接口';

-- ----------------------------
-- Table structure for accuauth_verification_aadhaar
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_verification_aadhaar`;
CREATE TABLE `accuauth_verification_aadhaar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `aadhaar_no` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `valid` bit(1) DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='aadhaar卡验真';

-- ----------------------------
-- Table structure for accuauth_verification_driving_license
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_verification_driving_license`;
CREATE TABLE `accuauth_verification_driving_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `dl_no` varchar(45) NOT NULL,
  `dob` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `result_code` int(11) DEFAULT NULL,
  `result_message` varchar(50) DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='驾照验真';

-- ----------------------------
-- Table structure for accuauth_verification_pan
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_verification_pan`;
CREATE TABLE `accuauth_verification_pan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `pan` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `result_code` int(11) DEFAULT NULL,
  `result_message` varchar(50) DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_pan` (`pan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='pan卡验真';

-- ----------------------------
-- Table structure for accuauth_verification_passport
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_verification_passport`;
CREATE TABLE `accuauth_verification_passport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `dob` varchar(45) NOT NULL,
  `doe` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `passport_no` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `result_code` int(11) DEFAULT NULL,
  `result_message` varchar(50) DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='护照验真';

-- ----------------------------
-- Table structure for accuauth_verification_voter
-- ----------------------------
DROP TABLE IF EXISTS `accuauth_verification_voter`;
CREATE TABLE `accuauth_verification_voter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `epic_no` varchar(45) NOT NULL,
  `request_id` varchar(64) NOT NULL,
  `status` varchar(45) NOT NULL,
  `result_code` int(11) DEFAULT NULL,
  `result_message` varchar(50) DEFAULT NULL,
  `result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`result`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选民卡验真';

-- ----------------------------
-- Table structure for advance_face_comparison
-- ----------------------------
DROP TABLE IF EXISTS `advance_face_comparison`;
CREATE TABLE `advance_face_comparison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `first_image_store_path` varchar(100) NOT NULL,
  `first_image_remark` varchar(45) NOT NULL,
  `second_image_store_path` varchar(100) NOT NULL,
  `second_image_remark` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  `transaction_id` varchar(64) NOT NULL,
  `pricing_strategy` varchar(45) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `similarity` double DEFAULT NULL,
  `first_face` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`first_face`)),
  `second_face` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`second_face`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_first_image_store_path` (`first_image_store_path`),
  KEY `idx_second_image_store_path` (`second_image_store_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='人脸比对';

-- ----------------------------
-- Table structure for advance_face_search
-- ----------------------------
DROP TABLE IF EXISTS `advance_face_search`;
CREATE TABLE `advance_face_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `id_number` varchar(45) NOT NULL,
  `face_image_store_path` varchar(100) NOT NULL,
  `code` varchar(45) NOT NULL,
  `transaction_id` varchar(64) NOT NULL,
  `pricing_strategy` varchar(45) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='人脸搜索';

-- ----------------------------
-- Table structure for advance_identity_check
-- ----------------------------
DROP TABLE IF EXISTS `advance_identity_check`;
CREATE TABLE `advance_identity_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `aadhaar_number` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  `transaction_id` varchar(64) NOT NULL,
  `pricing_strategy` varchar(45) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='身份证件验真';

-- ----------------------------
-- Table structure for advance_ocr_check
-- ----------------------------
DROP TABLE IF EXISTS `advance_ocr_check`;
CREATE TABLE `advance_ocr_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `card_type` varchar(45) DEFAULT NULL,
  `front_image_store_path` varchar(100) NOT NULL,
  `back_image_store_path` varchar(100) NOT NULL,
  `code` varchar(45) NOT NULL,
  `transaction_id` varchar(64) NOT NULL,
  `pricing_strategy` varchar(45) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_front_image_store_path` (`front_image_store_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ocr识别';

-- ----------------------------
-- Table structure for advance_pan_status_check
-- ----------------------------
DROP TABLE IF EXISTS `advance_pan_status_check`;
CREATE TABLE `advance_pan_status_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `pan_number` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `birthday` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  `transaction_id` varchar(64) NOT NULL,
  `pricing_strategy` varchar(45) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `is_match` bit(1) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_pan_number` (`pan_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='pan卡验真';
