/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-26 10:45:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gather_task
-- ----------------------------
DROP TABLE IF EXISTS `gather_task`;
CREATE TABLE `gather_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款用户名',
  `mode_config_id` char(36) NOT NULL COMMENT '支付模式配置Id',
  `loan_order_id` char(36) NOT NULL COMMENT '借款单Id',
  `loan_channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `lending_order_id` char(36) NOT NULL COMMENT '放款单Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款单Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方ID',
  `amount` decimal(18,2) NOT NULL COMMENT '代扣金额',
  `principal` decimal(18,2) NOT NULL COMMENT '代扣本金',
  `interest` decimal(18,2) NOT NULL COMMENT '代扣利息',
  `periods` varchar(45) NOT NULL COMMENT '代扣期数,多期逗号隔开',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '代扣逾期费',
  `apply_type` int(11) NOT NULL COMMENT '申请类型',
  `gather_method` int(11) NOT NULL,
  `card_number` varchar(45) DEFAULT NULL COMMENT '银行卡号',
  `request_no` varchar(45) NOT NULL COMMENT '请求流水号',
  `status` int(11) NOT NULL COMMENT '代扣状态',
  `accept_time` datetime DEFAULT NULL COMMENT '申请时间',
  `complete_time` datetime DEFAULT NULL COMMENT '成功代扣时间',
  `trans_no` varchar(45) DEFAULT NULL COMMENT '代扣流水号',
  `error_msg` varchar(45) DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_request_no` (`request_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_loan_order_id` (`loan_order_id`),
  KEY `idx_loan_channel_id` (`loan_channel_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='还款代扣';

-- ----------------------------
-- Table structure for gather_task_item
-- ----------------------------
DROP TABLE IF EXISTS `gather_task_item`;
CREATE TABLE `gather_task_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gather_task_id` char(36) NOT NULL COMMENT '还款代扣Id',
  `plan_id` char(36) NOT NULL COMMENT '还款计划Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款订单Id',
  `period` int(11) NOT NULL COMMENT '期数',
  `amount` decimal(18,2) NOT NULL COMMENT '还款金额',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '逾期费',
  `mitigate_amount` decimal(18,2) NOT NULL COMMENT '减免金额',
  `overdue_day` int(11) NOT NULL COMMENT '逾期天数',
  PRIMARY KEY (`id`),
  KEY `idx_plan_id` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='还款代扣明细';

-- ----------------------------
-- Table structure for lending_order
-- ----------------------------
DROP TABLE IF EXISTS `lending_order`;
CREATE TABLE `lending_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '用户姓名',
  `loan_order_id` char(36) NOT NULL COMMENT '借款订单Id',
  `loan_channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `loan_amount` decimal(18,2) NOT NULL COMMENT '借款金额',
  `service_amount` decimal(18,2) NOT NULL COMMENT '服务费',
  `gst_amount` decimal(18,2) NOT NULL COMMENT 'GST费用',
  `utm_source` varchar(45) NOT NULL COMMENT '借款来源',
  `amount` decimal(18,2) NOT NULL COMMENT '放款金额',
  `card_number` varchar(45) DEFAULT NULL COMMENT '银行卡号',
  `status` int(11) NOT NULL COMMENT '放款状态(10-待放款 20-放款中 30-放款取消 40-放款失败 50-放款成功)',
  `lender_id` bigint(20) DEFAULT NULL COMMENT '资方Id',
  `customer_type` int(11) NOT NULL COMMENT '客户类型(5-新客 10-老客)',
  `allocation_time` datetime DEFAULT NULL COMMENT '派单时间',
  `error_msg` varchar(100) DEFAULT NULL COMMENT '错误描述',
  `accept_time` datetime DEFAULT NULL COMMENT '受理时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `request_no` varchar(45) DEFAULT NULL COMMENT '请求流水号',
  `trans_no` varchar(45) DEFAULT NULL COMMENT '放款交易号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_loan_order_id` (`loan_order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='放款订单';

-- ----------------------------
-- Table structure for letter_reviewer
-- ----------------------------
DROP TABLE IF EXISTS `letter_reviewer`;
CREATE TABLE `letter_reviewer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `account` varchar(45) NOT NULL COMMENT '帐号',
  `name` varchar(45) NOT NULL COMMENT '姓名',
  `post` int(11) NOT NULL COMMENT '岗位（5-信审专员 10-信审组长 15-信审主管 20-信审总监）',
  `language` varchar(200) NOT NULL COMMENT '语言',
  `status` int(11) NOT NULL COMMENT '状态（0-在职 1-离职）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_account` (`account`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信审员';

-- ----------------------------
-- Table structure for loan_channel
-- ----------------------------
DROP TABLE IF EXISTS `loan_channel`;
CREATE TABLE `loan_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `channel_name` varchar(45) NOT NULL COMMENT '渠道名',
  `max_amount` decimal(18,2) NOT NULL COMMENT '最高额度',
  `reject_close_day` int(11) NOT NULL COMMENT '被拒绝后允许再次申请天数',
  `user_info_expire_day` int(11) NOT NULL COMMENT '用户资料有效天数',
  `risk_approved_expire_day` int(11) unsigned NOT NULL COMMENT '机审通过有效天数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='对接渠道';

-- ----------------------------
-- Table structure for loan_channel_product
-- ----------------------------
DROP TABLE IF EXISTS `loan_channel_product`;
CREATE TABLE `loan_channel_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `channel_id` char(36) NOT NULL COMMENT '渠道Id',
  `product_id` char(36) NOT NULL COMMENT '产品Id',
  `total_orders` int(11) NOT NULL COMMENT '总进单量',
  `is_open` bit(1) NOT NULL COMMENT '是否开放',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_channel_id` (`channel_id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='渠道产品';

-- ----------------------------
-- Table structure for loan_order
-- ----------------------------
DROP TABLE IF EXISTS `loan_order`;
CREATE TABLE `loan_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `order_no` varchar(45) NOT NULL COMMENT '订单号',
  `channel_id` char(36) NOT NULL COMMENT '接入渠道Id',
  `channel_name` varchar(45) NOT NULL COMMENT '渠道名称',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `mobile` varchar(45) NOT NULL COMMENT '手机号码',
  `user_name` varchar(45) DEFAULT NULL COMMENT '用户名',
  `customer_type` int(11) NOT NULL COMMENT '新老客类型（5-新客 10-老客）',
  `device_id` varchar(45) DEFAULT NULL COMMENT '设备Id',
  `sdk_info_uploaded` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Epoch SDK的信息是否已经上传',
  `double_times` int(11) DEFAULT NULL COMMENT '复贷次数',
  `pre_lending_time` datetime DEFAULT NULL COMMENT '上一笔贷款时间',
  `product_id` char(36) DEFAULT NULL COMMENT '借款产品Id',
  `amount` decimal(18,2) DEFAULT NULL COMMENT '借款金额',
  `duration` int(11) DEFAULT NULL COMMENT '借款期限（天）',
  `periods` int(11) DEFAULT NULL COMMENT '借款期数',
  `interest_rate` decimal(18,4) DEFAULT NULL COMMENT '借款利率',
  `service_rate` decimal(18,4) DEFAULT NULL COMMENT '放款服务费率',
  `gst_rate` decimal(18,4) DEFAULT NULL COMMENT 'GST费率',
  `overdue_rate` decimal(18,4) DEFAULT NULL COMMENT '逾期管理费率',
  `max_overdue_ratio` decimal(18,2) DEFAULT NULL COMMENT '封顶逾期费比率',
  `repay_ratio_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '每期还款比例配置' CHECK (json_valid(`repay_ratio_config`)),
  `utm_source` varchar(45) NOT NULL COMMENT '申请来源',
  `status` int(11) NOT NULL COMMENT '订单状态（10-待补充资料 20-审批中 30-审批未通过 40-审批通过 45-人工审批 50-放款中 60-已取消 70-还款中 80-已结清）',
  `sort` int(11) NOT NULL COMMENT '排序',
  `risk_act_key` varchar(45) DEFAULT NULL COMMENT '风控事件活动Key',
  `commit_risk_time` datetime DEFAULT NULL COMMENT '提交风控时间',
  `approve_status` int(11) DEFAULT NULL COMMENT '审批状态',
  `approve_reason` varchar(45) DEFAULT NULL COMMENT '审批理由',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approve_amount` decimal(18,2) DEFAULT NULL COMMENT '审批金额',
  `approve_expire_time` datetime DEFAULT NULL COMMENT '审批过期时间',
  `user_confirm_time` datetime DEFAULT NULL COMMENT '用户确认借款时间',
  `lending_time` datetime DEFAULT NULL COMMENT '放款时间',
  `last_repaid_time` datetime DEFAULT NULL COMMENT '最近还款时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_mobile` (`mobile`),
  KEY `idx_user_name` (`user_name`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_channel_id` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='借款订单';

-- ----------------------------
-- Table structure for loan_order_additional
-- ----------------------------
DROP TABLE IF EXISTS `loan_order_additional`;
CREATE TABLE `loan_order_additional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_order_id` char(36) NOT NULL COMMENT '借款单Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `first_name` varchar(45) NOT NULL COMMENT 'first_name',
  `middle_name` varchar(45) DEFAULT NULL COMMENT 'middle_name',
  `last_name` varchar(45) NOT NULL COMMENT 'last_name',
  `gender` int(11) NOT NULL COMMENT '性别（1-男 2-女）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `email` varchar(100) NOT NULL COMMENT '邮箱地址',
  `employment_type` varchar(45) NOT NULL COMMENT '工作性质',
  `company` varchar(45) DEFAULT NULL COMMENT '公司单位',
  `monthly_income` decimal(18,2) NOT NULL COMMENT '月收入',
  `pin_code` varchar(45) NOT NULL COMMENT 'pin_code',
  `state` varchar(45) DEFAULT NULL COMMENT '所在州',
  `district` varchar(45) DEFAULT NULL COMMENT '所在行政区',
  `city` varchar(100) DEFAULT NULL COMMENT '所在城市',
  `education` varchar(45) DEFAULT NULL COMMENT '教育程度',
  `marital_status` varchar(45) DEFAULT NULL COMMENT '婚姻状态',
  `language` varchar(45) DEFAULT NULL COMMENT '使用语言',
  `emergency_contact_relation1` varchar(45) NOT NULL COMMENT '紧急联系人1关系',
  `emergency_contact_name1` varchar(45) NOT NULL COMMENT '紧急联系人1姓名',
  `emergency_contact_mobile1` varchar(45) NOT NULL COMMENT '紧急联系人1手机号',
  `emergency_contact_relation2` varchar(45) NOT NULL COMMENT '紧急联系人2关系',
  `emergency_contact_name2` varchar(45) NOT NULL COMMENT '紧急联系人2姓名',
  `emergency_contact_mobile2` varchar(45) NOT NULL COMMENT '紧急联系人2手机号',
  `identity_card` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '证件资料' CHECK (json_valid(`identity_card`)),
  `face_image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '活体资料' CHECK (json_valid(`face_image`)),
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_loan_order_id` (`loan_order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_emergency_contact_mobile1` (`emergency_contact_mobile1`),
  KEY `idx_emergency_contact_mobile2` (`emergency_contact_mobile2`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='借款单补充信息';

-- ----------------------------
-- Table structure for loan_order_review
-- ----------------------------
DROP TABLE IF EXISTS `loan_order_review`;
CREATE TABLE `loan_order_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `loan_order_id` char(36) NOT NULL COMMENT '借款订单Id',
  `reviewer_account` varchar(45) DEFAULT NULL COMMENT '信审员帐号',
  `reviewer_name` varchar(45) DEFAULT NULL COMMENT '信审员姓名',
  `is_allocation` bit(1) NOT NULL COMMENT '是否派单',
  `allocation_time` datetime DEFAULT NULL COMMENT '派单时间',
  `review_status` int(11) NOT NULL COMMENT '信审状态（10-待审批 20-审批通过 30-审批拒绝）',
  `review_time` datetime DEFAULT NULL COMMENT '信审时间',
  `review_reason` varchar(300) DEFAULT NULL COMMENT '信审理由',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_loan_order_id` (`loan_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='信审订单';

-- ----------------------------
-- Table structure for loan_product
-- ----------------------------
DROP TABLE IF EXISTS `loan_product`;
CREATE TABLE `loan_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `duration` int(11) NOT NULL COMMENT '借款期限（天）',
  `periods` int(11) NOT NULL COMMENT '借款期数',
  `interest_rate` decimal(18,4) NOT NULL COMMENT '借款利率',
  `service_rate` decimal(18,4) NOT NULL COMMENT '放款服务费率',
  `gst_rate` decimal(18,4) NOT NULL COMMENT 'GST费率',
  `overdue_rate` decimal(18,4) NOT NULL COMMENT '逾期管理费率',
  `max_overdue_ratio` decimal(18,2) DEFAULT NULL COMMENT '封顶逾期费比率',
  `max_amount` decimal(18,2) NOT NULL COMMENT '最大审批金额',
  `min_amount` decimal(18,2) NOT NULL COMMENT '最小审批金额',
  `step_amount` decimal(18,2) NOT NULL COMMENT '审批金额步值',
  `is_extension` bit(1) NOT NULL COMMENT '是否可展期',
  `max_extension_times` int(11) NOT NULL COMMENT '最大展期次数',
  `min_double_times` int(11) NOT NULL COMMENT '最小复贷次数',
  `max_double_times` int(11) NOT NULL COMMENT '最大复贷次数',
  `repay_ratio_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '每期还款比例配置' CHECK (json_valid(`repay_ratio_config`)),
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='贷款产品';

-- ----------------------------
-- Table structure for loan_risk_mode
-- ----------------------------
DROP TABLE IF EXISTS `loan_risk_mode`;
CREATE TABLE `loan_risk_mode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `mode_name` varchar(45) NOT NULL COMMENT '模型名称',
  `risk_act_key` varchar(45) NOT NULL COMMENT '风控事件活动Key',
  `channel_id` char(36) NOT NULL COMMENT '渠道Id',
  `is_default` bit(1) NOT NULL COMMENT '是否默认',
  `shunt_coefficient` decimal(18,2) DEFAULT NULL COMMENT '分流系数(0-100)',
  `product_id` char(36) DEFAULT NULL COMMENT '产品Id',
  `customer_type` int(11) DEFAULT NULL COMMENT '客户类型（5-新客 10-老客）',
  `utm_sources` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '来源渠道' CHECK (json_valid(`utm_sources`)),
  `is_enabled` bit(1) NOT NULL COMMENT '是否启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_mode_name` (`mode_name`),
  KEY `idx_channel_id` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='贷款风控模型';

-- ----------------------------
-- Table structure for order_review_free_record
-- ----------------------------
DROP TABLE IF EXISTS `order_review_free_record`;
CREATE TABLE `order_review_free_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loan_order_id` char(36) NOT NULL COMMENT '借款订单Id',
  `reviewer_account` varchar(45) NOT NULL COMMENT '信审员帐号',
  `reviewer_name` varchar(45) NOT NULL COMMENT '信审员姓名',
  `free_reason` int(11) NOT NULL COMMENT '转单原因',
  `original_language` varchar(45) DEFAULT NULL COMMENT '原借款单语言',
  `new_language` varchar(45) DEFAULT NULL COMMENT '变更后的新语言',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `idx_loan_order_id` (`loan_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信审转单记录';

-- ----------------------------
-- Table structure for promotion_channel
-- ----------------------------
DROP TABLE IF EXISTS `promotion_channel`;
CREATE TABLE `promotion_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `name` varchar(45) NOT NULL COMMENT '名称',
  `utm_source` varchar(45) NOT NULL COMMENT '推广来源',
  `settle_type` int(11) NOT NULL COMMENT '结算方式（1-cap，2-cps，3-uv）',
  `settle_price` decimal(18,2) NOT NULL COMMENT '结算价格',
  `url` varchar(100) NOT NULL COMMENT '推广连接',
  `remark` varchar(45) NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_utm_source` (`utm_source`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='推广渠道';

-- ----------------------------
-- Table structure for repay_deduct
-- ----------------------------
DROP TABLE IF EXISTS `repay_deduct`;
CREATE TABLE `repay_deduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款用户名',
  `mode_config_id` char(36) NOT NULL COMMENT '支付模式配置Id',
  `loan_order_id` char(36) NOT NULL COMMENT '借款单Id',
  `loan_channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `lending_order_id` char(36) NOT NULL COMMENT '放款单Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款单Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方ID',
  `amount` decimal(18,2) NOT NULL COMMENT '代扣金额',
  `principal` decimal(18,2) NOT NULL COMMENT '代扣本金',
  `interest` decimal(18,2) NOT NULL COMMENT '代扣利息',
  `periods` decimal(18,2) NOT NULL COMMENT '代扣期数,多期逗号隔开',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '代扣逾期费',
  `apply_type` int(11) NOT NULL COMMENT '申请类型',
  `card_number` varchar(45) NOT NULL COMMENT '银行卡号',
  `request_no` varchar(45) NOT NULL COMMENT '请求流水号',
  `status` int(11) NOT NULL COMMENT '代扣状态',
  `accept_time` datetime DEFAULT NULL COMMENT '申请时间',
  `complete_time` datetime DEFAULT NULL COMMENT '成功代扣时间',
  `trans_no` varchar(45) DEFAULT NULL COMMENT '代扣流水号',
  `error_msg` varchar(45) DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_request_no` (`request_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_loan_order_id` (`loan_order_id`),
  KEY `idx_loan_channel_id` (`loan_channel_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='还款代扣';

-- ----------------------------
-- Table structure for repay_deduct_item
-- ----------------------------
DROP TABLE IF EXISTS `repay_deduct_item`;
CREATE TABLE `repay_deduct_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deduct_id` char(36) NOT NULL COMMENT '还款代扣Id',
  `plan_id` char(36) NOT NULL COMMENT '还款计划Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款订单Id',
  `period` int(11) NOT NULL COMMENT '期数',
  `amount` decimal(18,2) NOT NULL COMMENT '还款金额',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '逾期费',
  `mitigate_amount` decimal(18,2) NOT NULL COMMENT '减免金额',
  `overdue_day` int(11) NOT NULL COMMENT '逾期天数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_deduct_id` (`deduct_id`),
  KEY `idx_plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='还款代扣明细';

-- ----------------------------
-- Table structure for repay_order
-- ----------------------------
DROP TABLE IF EXISTS `repay_order`;
CREATE TABLE `repay_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款用户名',
  `loan_order_id` char(36) NOT NULL COMMENT '借款单Id',
  `loan_channel_id` char(36) NOT NULL COMMENT '借款渠道Id',
  `lending_order_id` char(36) NOT NULL COMMENT '放款单Id',
  `lender_id` bigint(20) NOT NULL COMMENT '资方Id',
  `loan_amount` decimal(18,2) NOT NULL COMMENT '借款金额',
  `duration` int(11) NOT NULL COMMENT '借款期限',
  `periods` int(11) NOT NULL COMMENT '借款期数',
  `interest_rate` decimal(18,4) NOT NULL COMMENT '借款利率',
  `overdue_rate` decimal(18,4) NOT NULL COMMENT '借款逾期费率',
  `service_amount` decimal(18,2) NOT NULL COMMENT '借款服务费',
  `gst_amount` decimal(18,2) DEFAULT NULL COMMENT 'GST费用',
  `amount` decimal(18,2) NOT NULL COMMENT '应还总额',
  `principal` decimal(18,2) NOT NULL COMMENT '应还本金',
  `interest` decimal(18,2) NOT NULL COMMENT '应还利息',
  `status` int(11) NOT NULL COMMENT '还款状态（5-还款中 10-逾期中 15-已结清）',
  `repay_end_date` date NOT NULL COMMENT '最后一期还款到期日',
  `repaid_amount` decimal(18,2) NOT NULL COMMENT '已还金额',
  `repaid_principal` decimal(18,2) NOT NULL COMMENT '已还本金',
  `repaid_interest` decimal(18,2) NOT NULL COMMENT '已还利息',
  `repaid_overdue_fee` decimal(18,2) NOT NULL COMMENT '已还逾期费',
  `mitigate_amount` decimal(18,2) NOT NULL COMMENT '累计减免金额',
  `last_deduct_status` int(11) DEFAULT NULL COMMENT '最近代扣状态',
  `last_deduct_time` datetime DEFAULT NULL COMMENT '最近代扣时间',
  `last_deduct_result` varchar(50) DEFAULT NULL COMMENT '最近代扣结果',
  `last_repaid_time` datetime DEFAULT NULL COMMENT '最近还款成功时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_lending_order_id` (`lending_order_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_loan_order_id` (`loan_order_id`),
  KEY `idx_loan_channel_id` (`loan_channel_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='还款订单';

-- ----------------------------
-- Table structure for repay_plan
-- ----------------------------
DROP TABLE IF EXISTS `repay_plan`;
CREATE TABLE `repay_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) NOT NULL COMMENT '借款用户名',
  `loan_order_id` char(36) NOT NULL COMMENT '借款单Id',
  `lending_order_id` char(36) NOT NULL COMMENT '放款单Id',
  `repay_order_id` char(36) NOT NULL COMMENT '还款单Id',
  `amount` decimal(18,2) NOT NULL COMMENT '应还总额',
  `principal` decimal(18,2) NOT NULL COMMENT '应还本金',
  `interest` decimal(18,2) NOT NULL COMMENT '应还利息',
  `period` int(11) NOT NULL COMMENT '还款期数',
  `repay_date` date NOT NULL COMMENT '应还日期',
  `is_overdue` bit(1) NOT NULL COMMENT '是否逾期',
  `overdue_day` int(11) NOT NULL COMMENT '逾期天数',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '逾期费',
  `max_overdue_fee` decimal(18,2) NOT NULL COMMENT '逾期费封顶值',
  `mitigate_amount` decimal(18,2) NOT NULL COMMENT '减免金额',
  `status` int(11) NOT NULL COMMENT '还款状态（0-未还 1-已还）',
  `repaid_amount` decimal(18,2) NOT NULL COMMENT '已还金额',
  `repaid_time` datetime DEFAULT NULL COMMENT '最后还款时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_loan_order_id` (`loan_order_id`),
  KEY `idx_lending_order_id` (`lending_order_id`),
  KEY `idx_repay_order_id` (`repay_order_id`),
  KEY `idx_repayment_date` (`repay_date`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='还款计划';

-- ----------------------------
-- Table structure for user_and_info
-- ----------------------------
DROP TABLE IF EXISTS `user_and_info`;
CREATE TABLE `user_and_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一Id',
  `android_id` varchar(100) NOT NULL COMMENT '设备id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户账号',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `chn_id` varchar(100) DEFAULT NULL COMMENT '渠道id',
  `tm` bigint(20) DEFAULT NULL COMMENT '第一次安装时间',
  `create_time` datetime DEFAULT current_timestamp(),
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_AND_USER` (`android_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_apps
-- ----------------------------
DROP TABLE IF EXISTS `user_apps`;
CREATE TABLE `user_apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一Id',
  `android_id` varchar(100) NOT NULL COMMENT '设备id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户账号',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `firstInstallTime` bigint(20) DEFAULT NULL COMMENT '第一次安装时间',
  `isSystemApp` tinyint(1) DEFAULT NULL COMMENT '是否系统应用',
  `name` varchar(100) DEFAULT NULL COMMENT '应用名',
  `packageName` varchar(200) DEFAULT NULL COMMENT '包名',
  `version` varchar(70) DEFAULT NULL COMMENT '版本',
  `lastUpdateTime` bigint(20) DEFAULT NULL COMMENT 'APP端最后更新时间',
  `create_time` datetime DEFAULT current_timestamp(),
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_AND_PACK_VER` (`android_id`,`packageName`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_auth
-- ----------------------------
DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `channel_id` char(36) DEFAULT NULL COMMENT '注册渠道Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `user_name` varchar(45) DEFAULT NULL COMMENT '用户名',
  `mobile` varchar(45) NOT NULL COMMENT '手机号码',
  `password` varchar(45) DEFAULT NULL COMMENT '帐号密码',
  `register_ip` varchar(45) NOT NULL COMMENT '注册IP地址',
  `first_login_time` datetime DEFAULT NULL COMMENT '首次登录时间',
  `last_login_ip` varchar(45) DEFAULT NULL COMMENT '最近一次登录IP地址',
  `last_login_time` datetime DEFAULT NULL COMMENT '最近一次登录时间',
  `utm_source` varchar(45) NOT NULL COMMENT '注册来源',
  `active_source` varchar(45) DEFAULT NULL COMMENT '活跃来源',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  UNIQUE KEY `uk_mobile` (`mobile`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='用户帐号';

-- ----------------------------
-- Table structure for user_basic_info
-- ----------------------------
DROP TABLE IF EXISTS `user_basic_info`;
CREATE TABLE `user_basic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `first_name` varchar(45) NOT NULL COMMENT 'first_name',
  `middle_name` varchar(45) DEFAULT NULL COMMENT 'middle_name',
  `last_name` varchar(45) NOT NULL COMMENT 'last_name',
  `gender` int(11) NOT NULL COMMENT '性别（1-男 2-女）',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `email` varchar(100) NOT NULL COMMENT '邮箱地址',
  `employment_type` varchar(45) NOT NULL COMMENT '工作性质',
  `company` varchar(45) DEFAULT NULL COMMENT '公司单位',
  `industry_category` varchar(20) NOT NULL DEFAULT '' COMMENT '所在行业',
  `monthly_income` decimal(18,2) NOT NULL COMMENT '月收入',
  `salary_range` int(10) unsigned NOT NULL DEFAULT 1 COMMENT '月入范围',
  `occupation` varchar(20) NOT NULL DEFAULT '' COMMENT '职业类型',
  `official_email` varchar(45) DEFAULT '' COMMENT '工作邮箱',
  `pin_code` varchar(45) NOT NULL COMMENT 'pin_code',
  `state` varchar(45) DEFAULT NULL COMMENT '所在州',
  `district` varchar(45) DEFAULT NULL COMMENT '所在行政区',
  `city` varchar(100) DEFAULT NULL COMMENT '所在城市',
  `address` varchar(45) DEFAULT NULL COMMENT '详细地址',
  `education` varchar(45) DEFAULT NULL COMMENT '教育程度',
  `marital_status` varchar(45) DEFAULT NULL COMMENT '婚姻状态',
  `language` varchar(45) DEFAULT NULL COMMENT '使用语言',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='用户基本信息';

-- ----------------------------
-- Table structure for user_cantacts
-- ----------------------------
DROP TABLE IF EXISTS `user_cantacts`;
CREATE TABLE `user_cantacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一Id',
  `android_id` varchar(100) DEFAULT NULL COMMENT '设备id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户账号',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `contact_name` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `contact_mobile` varchar(50) DEFAULT NULL COMMENT '联系人手机号',
  `create_time` datetime DEFAULT current_timestamp(),
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_AND_CON` (`android_id`,`contact_mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_device_list
-- ----------------------------
DROP TABLE IF EXISTS `user_device_list`;
CREATE TABLE `user_device_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `mobile` varchar(45) NOT NULL COMMENT '手机号',
  `device_id` varchar(45) NOT NULL COMMENT '设备Id',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户设备列表';

-- ----------------------------
-- Table structure for user_emergency_contact
-- ----------------------------
DROP TABLE IF EXISTS `user_emergency_contact`;
CREATE TABLE `user_emergency_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `emergency_contact_relation1` varchar(45) NOT NULL COMMENT '紧急联系人1关系',
  `emergency_contact_name1` varchar(45) NOT NULL COMMENT '紧急联系人1姓名',
  `emergency_contact_mobile1` varchar(45) NOT NULL COMMENT '紧急联系人1手机号',
  `emergency_contact_relation2` varchar(45) NOT NULL COMMENT '紧急联系人2关系',
  `emergency_contact_name2` varchar(45) NOT NULL COMMENT '紧急联系人2姓名',
  `emergency_contact_mobile2` varchar(45) NOT NULL COMMENT '紧急联系人2手机号',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`),
  KEY `idx_emergency_contact_mobile1` (`emergency_contact_mobile1`),
  KEY `idx_emergency_contact_mobile2` (`emergency_contact_mobile2`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='用户紧急联系人';

-- ----------------------------
-- Table structure for user_face_image
-- ----------------------------
DROP TABLE IF EXISTS `user_face_image`;
CREATE TABLE `user_face_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `static_image_path` varchar(100) NOT NULL COMMENT '静态图像',
  `is_hack_pass` bit(1) NOT NULL COMMENT '是否通过Hack',
  `data_source` varchar(45) DEFAULT NULL COMMENT '数据来源',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='用户人脸图像';

-- ----------------------------
-- Table structure for user_identity_card
-- ----------------------------
DROP TABLE IF EXISTS `user_identity_card`;
CREATE TABLE `user_identity_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `user_id` bigint(20) NOT NULL COMMENT '用户Id',
  `input_card_no` varchar(45) DEFAULT NULL COMMENT '用户输入卡号',
  `mobile` varchar(45) NOT NULL COMMENT '用户手机号',
  `image_store_path` varchar(100) NOT NULL COMMENT '图片存储路径',
  `card_type` varchar(45) NOT NULL COMMENT '证件类型',
  `card_side` varchar(45) NOT NULL COMMENT '证件方向',
  `data_source` varchar(45) DEFAULT NULL COMMENT '数据来源',
  `card_no` varchar(45) NOT NULL COMMENT '证件号',
  `name` varchar(45) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(45) DEFAULT NULL COMMENT '性别',
  `year_of_birth` int(11) DEFAULT NULL COMMENT '出生年份',
  `birthday` varchar(45) DEFAULT NULL COMMENT '出生日期',
  `card_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '证件ocr信息' CHECK (json_valid(`card_info`)),
  `card_original_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '证件原始信息' CHECK (json_valid(`card_original_info`)),
  `change_fail_times` int(11) DEFAULT NULL COMMENT '修改失败次数',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `user_id_card_type_card_side` (`user_id`,`card_type`,`card_side`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='用户证件信息';

-- ----------------------------
-- Table structure for user_sms
-- ----------------------------
DROP TABLE IF EXISTS `user_sms`;
CREATE TABLE `user_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一Id',
  `android_id` varchar(100) DEFAULT NULL COMMENT '设备id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户账号',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `number` varchar(100) DEFAULT NULL COMMENT '对方号码，短信发送者',
  `addr` varchar(100) DEFAULT NULL COMMENT '对方号码，短信接受者',
  `sms_time` bigint(20) DEFAULT NULL COMMENT '时间',
  `type` tinyint(1) DEFAULT NULL COMMENT '1是已接收 2是已发出',
  `person` varchar(100) DEFAULT NULL COMMENT '对方姓名',
  `body` text DEFAULT NULL COMMENT '短信内容',
  `create_time` datetime DEFAULT current_timestamp(),
  `update_time` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_AND_NUM_TIM` (`android_id`,`number`,`addr`,`sms_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_white_list
-- ----------------------------
DROP TABLE IF EXISTS `user_white_list`;
CREATE TABLE `user_white_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` varchar(36) NOT NULL COMMENT '唯一值',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `mobile` varchar(50) NOT NULL COMMENT '手机号码',
  `is_use_machine_trial_setting` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否使用机审结果设置',
  `machine_trial_result` int(11) DEFAULT NULL COMMENT '机审结果',
  `machine_trial_amount` decimal(18,2) NOT NULL DEFAULT 0.00 COMMENT '机审额度',
  `is_use_machine_trial_mock` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否使用机审桩数据',
  `machine_trial_mock_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`machine_trial_mock_data`)),
  `is_use_pay_setting` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否使用支付模拟配置',
  `bank_card_verify_setting` int(11) NOT NULL DEFAULT 0 COMMENT '银行卡验真配置',
  `lending_setting` int(11) NOT NULL DEFAULT 0 COMMENT '放款配置',
  `repay_setting` int(11) NOT NULL DEFAULT 0 COMMENT '还款配置',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_id_UNIQUE` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='用户白名单';
