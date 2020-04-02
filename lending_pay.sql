/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_pay

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:23:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bank_branch
-- ----------------------------
DROP TABLE IF EXISTS `bank_branch`;
CREATE TABLE `bank_branch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(255) NOT NULL COMMENT '唯一标识',
  `name` varchar(255) NOT NULL COMMENT '银行名称、邦名称、城市名称、支行名称',
  `bank_name` varchar(255) NOT NULL COMMENT '所属银行名称',
  `parent_id` bigint(20) NOT NULL COMMENT '目录树上级id',
  `ifsc` varchar(255) DEFAULT NULL COMMENT 'IFSC',
  `micr_code` varchar(255) DEFAULT NULL COMMENT 'micr code',
  `address` varchar(255) DEFAULT NULL COMMENT '地址只有最后一级有',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系方式  最后子节点会有值',
  `district` varchar(255) DEFAULT NULL COMMENT '地区',
  `grade` int(255) NOT NULL COMMENT '层级 0银行名称1邦2城市3支行名称',
  PRIMARY KEY (`id`),
  KEY `index_code` (`code`(191)) USING BTREE,
  KEY `index_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=235796 DEFAULT CHARSET=utf8mb4 COMMENT='银行支行信息';

-- ----------------------------
-- Table structure for lending_task
-- ----------------------------
DROP TABLE IF EXISTS `lending_task`;
CREATE TABLE `lending_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) NOT NULL COMMENT '唯一值',
  `lending_trade_id` char(36) NOT NULL COMMENT '交易订单Id',
  `trade_no` varchar(45) NOT NULL COMMENT '交易流水号',
  `amount` decimal(18,2) NOT NULL COMMENT '交易金额',
  `task_no` varchar(45) NOT NULL COMMENT '任务流水号',
  `task_status` int(11) NOT NULL COMMENT '任务状态',
  `task_step` int(11) NOT NULL COMMENT '当前步骤',
  `task_step_desc` varchar(45) NOT NULL COMMENT '当前步骤描述',
  `response_no` varchar(45) DEFAULT NULL COMMENT '响应流水号',
  `response_msg` varchar(512) DEFAULT NULL COMMENT '响应描述',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_lending_trade_id` (`lending_trade_id`),
  KEY `idx_trade_no` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='放款任务 ';

-- ----------------------------
-- Table structure for lending_trade
-- ----------------------------
DROP TABLE IF EXISTS `lending_trade`;
CREATE TABLE `lending_trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) NOT NULL COMMENT '唯一值',
  `request_no` varchar(32) NOT NULL COMMENT '请求流水号',
  `trade_no` varchar(36) NOT NULL DEFAULT '' COMMENT '交易流水号',
  `merchant_id` char(36) NOT NULL COMMENT '商户配置Id',
  `merchant_title` varchar(50) NOT NULL COMMENT '商户配置标题',
  `pay_channel` int(11) NOT NULL COMMENT '支付渠道',
  `pay_tunnel` int(11) NOT NULL COMMENT '支付通道',
  `mode_config_id` char(36) NOT NULL COMMENT '配置模式Id',
  `lending_amount` decimal(18,2) NOT NULL COMMENT '放款金额',
  `status` int(11) NOT NULL COMMENT '交易状态',
  `current_step` int(11) NOT NULL COMMENT '当前交易步骤',
  `current_step_desc` varchar(45) DEFAULT NULL COMMENT '当前交易步骤描述',
  `contact_id` char(36) DEFAULT NULL COMMENT '联系人Id',
  `bank_card_id` char(36) DEFAULT '' COMMENT '银行卡Id',
  `card_number` char(36) DEFAULT NULL,
  `lending_fail_msg` char(100) DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_request_no` (`request_no`),
  KEY `idx_trade_no` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='放款交易 ';

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `title` varchar(100) NOT NULL COMMENT '组合标题',
  `partner_code` varchar(45) NOT NULL COMMENT '商户号',
  `name` varchar(45) NOT NULL COMMENT '商户名称',
  `short_name` varchar(45) NOT NULL COMMENT '商户简称',
  `tunnel_id` char(36) NOT NULL COMMENT '支付通道配置Id',
  `api_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '接口配置信息（JSON）' CHECK (json_valid(`api_config`)),
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='商户配置';

-- ----------------------------
-- Table structure for mode_config
-- ----------------------------
DROP TABLE IF EXISTS `mode_config`;
CREATE TABLE `mode_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `mode_code` int(11) NOT NULL COMMENT '模式编码',
  `subject_merchant_id` char(36) NOT NULL COMMENT '主体商户Id',
  `lending_merchant_id` char(36) NOT NULL COMMENT '放款商户Id',
  `repayment_merchant_id` char(36) NOT NULL COMMENT '还款商户Id',
  `is_disabled` bit(1) NOT NULL COMMENT '是否禁用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_mode_code` (`mode_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='模式配置';

-- ----------------------------
-- Table structure for razorpay_bank_card
-- ----------------------------
DROP TABLE IF EXISTS `razorpay_bank_card`;
CREATE TABLE `razorpay_bank_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `unique_id` char(36) NOT NULL COMMENT '唯一值',
  `mode_config_id` char(36) NOT NULL DEFAULT '' COMMENT '商户id',
  `account_number` varchar(45) NOT NULL COMMENT '银行卡号',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `user_name` varchar(45) NOT NULL COMMENT '用户姓名',
  `ifsc` varchar(45) NOT NULL COMMENT 'IFSC',
  `sign_no` varchar(45) DEFAULT NULL COMMENT '签约号',
  `validation_id` varchar(45) DEFAULT NULL COMMENT '验真id',
  `contact_id` char(36) NOT NULL DEFAULT '' COMMENT '唯一值',
  `bank_name` varchar(45) DEFAULT NULL COMMENT '银行名称',
  `card_name` varchar(45) DEFAULT NULL COMMENT '持卡人姓名',
  `active` bit(1) DEFAULT NULL COMMENT '是否激活',
  `valid_status` int(11) NOT NULL COMMENT '验真状态',
  `registered_name` varchar(45) DEFAULT NULL COMMENT '账户名称',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '版本号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `valid_time` datetime DEFAULT NULL COMMENT '验真时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_account_number` (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='razorpay银行卡 ';

-- ----------------------------
-- Table structure for razorpay_contact
-- ----------------------------
DROP TABLE IF EXISTS `razorpay_contact`;
CREATE TABLE `razorpay_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` varchar(36) DEFAULT NULL COMMENT '唯一Id',
  `merchant_id` varchar(36) NOT NULL COMMENT '商户Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '姓名',
  `mobile` varchar(45) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(45) DEFAULT NULL COMMENT '邮箱',
  `sign_no` varchar(45) DEFAULT NULL COMMENT '签约号',
  `create_time` datetime NOT NULL COMMENT '调用API返回创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_merchant_id_user_id` (`merchant_id`,`user_id`) USING BTREE,
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='razorpay联系人 ';

-- ----------------------------
-- Table structure for repayment_task
-- ----------------------------
DROP TABLE IF EXISTS `repayment_task`;
CREATE TABLE `repayment_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` varchar(36) NOT NULL DEFAULT '' COMMENT '唯一值',
  `repayment_trade_id` char(36) NOT NULL COMMENT '交易订单Id',
  `trade_no` varchar(45) NOT NULL COMMENT '交易流水号',
  `amount` decimal(18,2) NOT NULL COMMENT '交易金额',
  `task_no` varchar(45) NOT NULL COMMENT '任务流水号',
  `task_status` int(11) NOT NULL COMMENT '任务状态',
  `task_step` int(11) NOT NULL COMMENT '当前步骤',
  `task_step_desc` varchar(45) DEFAULT NULL COMMENT '当前步骤描述',
  `response_no` varchar(50) DEFAULT NULL COMMENT '响应流水号',
  `response_payment_id` varchar(32) DEFAULT NULL COMMENT '回调流水号',
  `response_signature` varchar(64) DEFAULT NULL COMMENT '回调签名',
  `response_msg` varchar(512) DEFAULT NULL COMMENT '响应描述',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_repayment_trade_id` (`repayment_trade_id`),
  KEY `idx_trade_no` (`trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='还款任务 ';

-- ----------------------------
-- Table structure for repayment_trade
-- ----------------------------
DROP TABLE IF EXISTS `repayment_trade`;
CREATE TABLE `repayment_trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) NOT NULL COMMENT '唯一值',
  `request_no` varchar(36) NOT NULL COMMENT '请求流水号',
  `trade_no` varchar(36) NOT NULL COMMENT '交易流水号',
  `merchant_id` char(36) NOT NULL COMMENT '商户配置Id',
  `merchant_title` varchar(32) NOT NULL COMMENT '商户配置标题',
  `pay_channel` int(11) NOT NULL COMMENT '支付渠道',
  `pay_tunnel` int(11) NOT NULL COMMENT '支付通道',
  `mode_config_id` char(36) NOT NULL COMMENT '配置模式Id',
  `repayment_amount` decimal(18,2) NOT NULL DEFAULT 0.00 COMMENT '还款金额',
  `status` int(11) NOT NULL COMMENT '交易状态',
  `card_number` varchar(45) DEFAULT NULL COMMENT '银行卡',
  `card_name` varchar(45) DEFAULT NULL COMMENT '持卡人',
  `card_network` varchar(32) DEFAULT NULL COMMENT '银行卡网络',
  `card_issuer` varchar(32) DEFAULT NULL COMMENT '发卡银行',
  `current_step` int(11) NOT NULL COMMENT '当前任务步骤',
  `current_step_desc` varchar(32) DEFAULT NULL COMMENT '当前任务步骤描述',
  `complete_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_request_no` (`request_no`),
  KEY `idx_trade_no` (`trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='还款交易 ';

-- ----------------------------
-- Table structure for tunnel
-- ----------------------------
DROP TABLE IF EXISTS `tunnel`;
CREATE TABLE `tunnel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `title` varchar(100) NOT NULL COMMENT '组合标题',
  `pay_channel` int(11) NOT NULL COMMENT '支付渠道',
  `pay_tunnel` int(11) NOT NULL COMMENT '支付通道类型（10：代收付 20：资金托管）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='支付通道配置';

-- ----------------------------
-- Table structure for user_bank_card
-- ----------------------------
DROP TABLE IF EXISTS `user_bank_card`;
CREATE TABLE `user_bank_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` varchar(36) NOT NULL COMMENT '唯一值',
  `mode_config_id` varchar(36) NOT NULL COMMENT '模式配置Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `card_name` varchar(45) NOT NULL COMMENT '持卡人姓名',
  `ifsc` varchar(45) NOT NULL COMMENT 'IFSC',
  `card_number` varchar(45) NOT NULL COMMENT '银行卡',
  `bank_name` varchar(45) DEFAULT NULL COMMENT '银行名称',
  `sign_no` varchar(45) DEFAULT NULL COMMENT '签约号',
  `is_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否默认账户',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_card_number` (`card_number`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='用户银行卡 ';
