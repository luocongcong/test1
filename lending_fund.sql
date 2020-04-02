/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_fund

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:22:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `type` int(11) NOT NULL COMMENT '账户类型（1-放款账户 2-成本账户）',
  `balance` decimal(18,2) NOT NULL COMMENT '账户余额',
  `available_balance` decimal(18,2) NOT NULL COMMENT '可用余额',
  `freeze` decimal(18,2) NOT NULL COMMENT '冻结余额',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_lender_id` (`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='出借人账户';

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `lender_name` varchar(45) NOT NULL COMMENT '资方名称',
  `title` varchar(100) NOT NULL COMMENT '交易标题',
  `request_no` varchar(45) NOT NULL COMMENT '请求流水号',
  `trans_no` varchar(45) NOT NULL COMMENT '交易号',
  `income_amount` decimal(18,2) NOT NULL COMMENT '收入金额',
  `outlay_amount` decimal(18,2) NOT NULL COMMENT '支出金额',
  `category` int(11) NOT NULL COMMENT '交易类别',
  `status` int(11) NOT NULL COMMENT '交易状态',
  `error_msg` varchar(45) DEFAULT NULL COMMENT '错误描述',
  `visible` bit(1) NOT NULL COMMENT '是否可见',
  `complete_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_trans_no` (`trans_no`),
  KEY `idx_lender_id` (`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='账单';

-- ----------------------------
-- Table structure for bill_lending
-- ----------------------------
DROP TABLE IF EXISTS `bill_lending`;
CREATE TABLE `bill_lending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` char(36) NOT NULL COMMENT '账单Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `lending_order_id` char(36) NOT NULL COMMENT '放款订单Id',
  `channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `loan_order_id` char(36) NOT NULL COMMENT '借款订单Id',
  `user_id` bigint(20) NOT NULL COMMENT '借款人Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款人姓名',
  `utm_source` varchar(45) NOT NULL COMMENT '订单来源',
  `card_number` varchar(45) DEFAULT NULL COMMENT '收款银行卡号',
  `lending_amount` decimal(18,2) NOT NULL COMMENT '放款金额',
  `mode_config_id` char(50) NOT NULL COMMENT '放款支付模式配置',
  `procedure_fee` decimal(18,2) NOT NULL COMMENT '放款手续费',
  `channel_fee` decimal(18,2) NOT NULL COMMENT '放款通道费',
  `flow_fee` decimal(18,2) NOT NULL COMMENT '放款流量费',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_id` (`bill_id`),
  KEY `idx_lender_id` (`lender_id`),
  KEY `idx_lending_order_id` (`lending_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='放款账单';

-- ----------------------------
-- Table structure for bill_recharge
-- ----------------------------
DROP TABLE IF EXISTS `bill_recharge`;
CREATE TABLE `bill_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` char(36) NOT NULL COMMENT '账单Id',
  `account_id` varchar(36) NOT NULL COMMENT '账户id',
  `lender_id` bigint(20) NOT NULL COMMENT '出借人Id',
  `mode_config_id` varchar(36) NOT NULL COMMENT '充值支付模式配置',
  `recharge_amount` decimal(18,2) NOT NULL COMMENT '充值金额',
  `procedure_fee` decimal(18,2) NOT NULL COMMENT '手续费',
  `bank_serial_no` varchar(45) DEFAULT NULL COMMENT '银行流水号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_id` (`bill_id`),
  KEY `idx_lender_id` (`lender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值账单';

-- ----------------------------
-- Table structure for bill_repay
-- ----------------------------
DROP TABLE IF EXISTS `bill_repay`;
CREATE TABLE `bill_repay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` char(36) NOT NULL COMMENT '账单Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款订单Id',
  `channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `loan_order_id` char(36) NOT NULL COMMENT '借款订单Id',
  `mode_config_id` char(36) NOT NULL COMMENT '支付模式配置Id',
  `user_id` bigint(20) NOT NULL COMMENT '借款人Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款人姓名',
  `card_number` varchar(45) DEFAULT NULL COMMENT '还款银行卡号',
  `principal` decimal(18,2) NOT NULL COMMENT '还款本金',
  `interest` decimal(18,2) NOT NULL COMMENT '还款利息',
  `periods` varchar(50) NOT NULL COMMENT '还款期数,多期逗号隔开',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '还款逾期费',
  `procedure_fee` decimal(18,2) NOT NULL COMMENT '手续费',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_bill_id` (`bill_id`),
  KEY `idx_lender_id` (`lender_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='还款账单';

-- ----------------------------
-- Table structure for default_mode_config
-- ----------------------------
DROP TABLE IF EXISTS `default_mode_config`;
CREATE TABLE `default_mode_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '出借人Id（0表示平台）',
  `lending_config_id` char(36) NOT NULL COMMENT '放款模式配置Id',
  `repayment_config_id` char(36) DEFAULT NULL COMMENT '还款模式配置Id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_lender_id` (`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='默认支付模式配置';

-- ----------------------------
-- Table structure for flow_fee_price
-- ----------------------------
DROP TABLE IF EXISTS `flow_fee_price`;
CREATE TABLE `flow_fee_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `utm_source` varchar(45) NOT NULL COMMENT '推广来源',
  `customer_type` int(11) NOT NULL DEFAULT 0 COMMENT '客户类型（5-新客 10-老客）',
  `lender_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '资方id',
  `unit_price` decimal(18,2) NOT NULL DEFAULT 0.00 COMMENT '单价',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_utm_source_cusromer_type` (`utm_source`,`customer_type`,`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='流量费单价';

-- ----------------------------
-- Table structure for lender
-- ----------------------------
DROP TABLE IF EXISTS `lender`;
CREATE TABLE `lender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '出借人Id',
  `lender_name` varchar(45) NOT NULL COMMENT '出借人名称',
  `contact_mobile` varchar(45) DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(45) DEFAULT NULL COMMENT '联系邮箱',
  `is_application` bit(1) NOT NULL COMMENT '是否进件',
  `is_auto_lending` bit(1) NOT NULL COMMENT '是否自动放款',
  `auto_lending_start_hour` int(2) NOT NULL COMMENT '自动放款开始时间（精确到小时）',
  `auto_lending_end_hour` int(2) NOT NULL COMMENT '自动放款结束时间（精确到小时）',
  `daily_application_total` int(11) NOT NULL COMMENT '每日进件总量',
  `daily_application_count` int(11) NOT NULL COMMENT '当天进件数量',
  `overdue_fee_mode` int(11) NOT NULL COMMENT '逾期费收取模式（0-置后收取 1-置前收取）',
  `new_customer_ratio` decimal(18,2) NOT NULL COMMENT '新客占比（%）',
  `is_report_notice` bit(1) NOT NULL COMMENT '账单通知',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_lender_id` (`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='资方';

-- ----------------------------
-- Table structure for lender_user
-- ----------------------------
DROP TABLE IF EXISTS `lender_user`;
CREATE TABLE `lender_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) NOT NULL COMMENT '唯一值',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '用户名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑者',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑时间',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_lender_user` (`lender_id`,`user_id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='资方用户表';

-- ----------------------------
-- Table structure for procedure_fee_price
-- ----------------------------
DROP TABLE IF EXISTS `procedure_fee_price`;
CREATE TABLE `procedure_fee_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id（0为平台缺省）',
  `mode_config_id` char(36) DEFAULT NULL COMMENT '模式配置Id',
  `category` int(11) NOT NULL COMMENT '手续费类别',
  `value_type` int(11) NOT NULL COMMENT '手续费值类型',
  `value` decimal(18,4) NOT NULL COMMENT '手续费值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_lende_id` (`lender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='手续费价格';

-- ----------------------------
-- Table structure for water
-- ----------------------------
DROP TABLE IF EXISTS `water`;
CREATE TABLE `water` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `lender_name` varchar(45) NOT NULL COMMENT '资方名称',
  `account_id` char(36) NOT NULL COMMENT '资方账户Id',
  `opposite_id` bigint(20) DEFAULT NULL COMMENT '对方Id',
  `opposite_name` varchar(50) DEFAULT NULL COMMENT '对方名称',
  `opposite_account_id` varchar(50) DEFAULT NULL COMMENT '对方账户Id',
  `bill_id` char(36) NOT NULL COMMENT '交易账单Id',
  `trans_no` varchar(45) NOT NULL COMMENT '交易号',
  `income_amount` decimal(18,2) NOT NULL COMMENT '收入金额',
  `outlay_amount` decimal(18,2) NOT NULL COMMENT '支出金额',
  `available_balance` decimal(18,2) NOT NULL COMMENT '交易后可用余额',
  `main_category` int(11) NOT NULL COMMENT '交易大类',
  `sub_category` int(11) NOT NULL COMMENT '交易小类',
  `remark` varchar(50) NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_bill_id` (`bill_id`),
  KEY `idx_main_category_sub_category` (`main_category`,`sub_category`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_lender_id_trans_no` (`lender_id`,`trans_no`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='账户流水';
