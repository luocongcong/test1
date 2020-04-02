/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_collect

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:22:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for case_lock_record
-- ----------------------------
DROP TABLE IF EXISTS `case_lock_record`;
CREATE TABLE `case_lock_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '锁单记录Id',
  `collect_case_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收案件Id',
  `repay_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '还款单Id',
  `user_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `mobile` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `overdue_days` int(11) NOT NULL COMMENT '逾期天数',
  `collect_stage_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '催收阶段',
  `lock_case_days` int(11) NOT NULL COMMENT '锁单天数',
  `collector_id` bigint(20) NOT NULL COMMENT '申请人id',
  `collector_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '申请人',
  `lock_reason` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '锁单理由',
  `approval_post` int(11) NOT NULL COMMENT '催收岗位',
  `approval_status` int(11) NOT NULL COMMENT '审批状态',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approver_id` bigint(20) DEFAULT NULL COMMENT '审批人id',
  `approver_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '审批人',
  `remark` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_case_id` (`collect_case_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='锁单记录 ';

-- ----------------------------
-- Table structure for case_lock_rule
-- ----------------------------
DROP TABLE IF EXISTS `case_lock_rule`;
CREATE TABLE `case_lock_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '锁单规则id',
  `collect_plan_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收计划Id',
  `lock_days` int(11) NOT NULL COMMENT '锁单天数',
  `is_approval` bit(1) NOT NULL COMMENT '是否审批',
  `collector_post` int(11) DEFAULT NULL COMMENT '审批主管',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_plan_id` (`collect_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='锁单规则 ';

-- ----------------------------
-- Table structure for case_mitigate_record
-- ----------------------------
DROP TABLE IF EXISTS `case_mitigate_record`;
CREATE TABLE `case_mitigate_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '减免记录Id',
  `collect_case_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收案件Id',
  `repay_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '还款订单Id',
  `user_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `mobile` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `overdue_fee` decimal(18,2) NOT NULL COMMENT '逾期费',
  `apply_mitigate_periods` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '申请减免期数',
  `apply_mitigate_amount` decimal(18,2) NOT NULL COMMENT '申请减免金额',
  `collector_id` bigint(20) NOT NULL COMMENT '申请人id',
  `collector_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '申请人',
  `mitigate_reason` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '减免理由',
  `approval_post` int(11) NOT NULL COMMENT '审批岗位',
  `approval_status` int(11) NOT NULL COMMENT '审批状态',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approver_id` bigint(20) DEFAULT NULL COMMENT '审批人id',
  `approver_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '审批人',
  `remark` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_case_id` (`collect_case_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='减免记录 ';

-- ----------------------------
-- Table structure for case_mitigate_rule
-- ----------------------------
DROP TABLE IF EXISTS `case_mitigate_rule`;
CREATE TABLE `case_mitigate_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '减免规则id',
  `mitigate_ratio` decimal(18,2) NOT NULL COMMENT '减免比例',
  `is_approval` bit(1) NOT NULL COMMENT '是否审批',
  `collector_post` int(11) NOT NULL COMMENT '审批主管',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='减免规则 ';

-- ----------------------------
-- Table structure for collect_case
-- ----------------------------
DROP TABLE IF EXISTS `collect_case`;
CREATE TABLE `collect_case` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收单id',
  `loan_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '借款单id',
  `lending_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '放款单id',
  `repay_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '还款单id',
  `loan_channel_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '进件渠道',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `user_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '用户姓名',
  `mobile` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '手机号码',
  `customer_type` int(11) NOT NULL COMMENT '客户类型',
  `collect_language` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '催收语言',
  `lender_id` bigint(20) NOT NULL COMMENT '资方id',
  `repay_order_status` int(11) NOT NULL COMMENT '还款状态',
  `should_repay_date` datetime NOT NULL COMMENT '应还时间',
  `last_collect_status` int(11) NOT NULL DEFAULT 0 COMMENT '最后催收状态',
  `last_collect_stage_id` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '最后催收阶段Id',
  `last_collector_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '最后催收员Id',
  `last_collector_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '最后催收员姓名',
  `last_group_id` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '最后催收小组',
  `assign_status` int(11) NOT NULL COMMENT '派单状态',
  `last_assign_time` datetime DEFAULT NULL COMMENT '最后派单时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_repay_order_id` (`repay_order_id`),
  KEY `idx_loan_order_id` (`loan_order_id`),
  KEY `idx_lending_order_id` (`lending_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收单 ';

-- ----------------------------
-- Table structure for collect_contact_log
-- ----------------------------
DROP TABLE IF EXISTS `collect_contact_log`;
CREATE TABLE `collect_contact_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收日志id',
  `collect_case_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收案件id',
  `repay_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '还款单id',
  `collect_task_id` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '催收任务Id',
  `collector_id` bigint(20) NOT NULL COMMENT '催收员id',
  `collector_name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '催收员名称',
  `collect_time` datetime NOT NULL COMMENT '催收时间',
  `collect_way` int(11) NOT NULL COMMENT '催收方式',
  `collect_periods` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '催收期数',
  `contact_mobile` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `contact_relation` int(11) NOT NULL COMMENT '联系人关系',
  `contact_status` int(11) NOT NULL COMMENT '联络状态',
  `repay_willingness` int(11) NOT NULL COMMENT '还款意愿',
  `promise_repay_time` datetime DEFAULT NULL COMMENT '承认还款时间',
  `promise_repay_amount` decimal(18,2) DEFAULT NULL COMMENT '承认还款金额',
  `remark` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_case_id` (`collect_case_id`),
  KEY `idx_repay_order_id` (`repay_order_id`),
  KEY `idx_collect_task_id` (`collect_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收联系日志 ';

-- ----------------------------
-- Table structure for collect_group
-- ----------------------------
DROP TABLE IF EXISTS `collect_group`;
CREATE TABLE `collect_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '唯一值',
  `group_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '小组名称',
  `group_type` int(11) NOT NULL COMMENT '小组类型',
  `leader_id` bigint(20) DEFAULT NULL COMMENT '组长id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收组 ';

-- ----------------------------
-- Table structure for collect_plan
-- ----------------------------
DROP TABLE IF EXISTS `collect_plan`;
CREATE TABLE `collect_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收计划id',
  `plan_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '催收计划名称',
  `loan_channel_ids` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '借款渠道id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收计划 ';

-- ----------------------------
-- Table structure for collect_stage
-- ----------------------------
DROP TABLE IF EXISTS `collect_stage`;
CREATE TABLE `collect_stage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收阶段id',
  `collect_plan_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收计划id',
  `collect_stage_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '催收阶段名称',
  `start_overdue_day` int(11) NOT NULL COMMENT '起始逾期天数',
  `end_overdue_day` int(11) NOT NULL COMMENT '结束逾期天数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_plan_id` (`collect_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收阶段 ';

-- ----------------------------
-- Table structure for collect_task
-- ----------------------------
DROP TABLE IF EXISTS `collect_task`;
CREATE TABLE `collect_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收任务id',
  `collect_case_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收案件id',
  `repay_order_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '还款单id',
  `collector_id` bigint(20) NOT NULL COMMENT '催收员id',
  `collector_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '催收员姓名',
  `collect_plan_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收计划id',
  `collect_stage_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收阶段id',
  `collect_stage_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '催收阶段',
  `can_recall_time` datetime NOT NULL COMMENT '可抽单时间',
  `over_time` datetime DEFAULT NULL COMMENT '结束委派时间',
  `overdure_periods` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '逾期期数',
  `collect_status` int(11) NOT NULL COMMENT '催收状态',
  `repaid_amount` decimal(18,2) NOT NULL DEFAULT 0.00 COMMENT '还款金额',
  `repaid_time` datetime DEFAULT NULL COMMENT '还款时间',
  `assign_collector_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '派单人',
  `transfer_reason` int(11) DEFAULT NULL COMMENT '转案原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_case_id` (`collect_case_id`),
  KEY `idx_repay_order_id` (`repay_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收任务 ';

-- ----------------------------
-- Table structure for collection_firm
-- ----------------------------
DROP TABLE IF EXISTS `collection_firm`;
CREATE TABLE `collection_firm` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收公司id',
  `collection_firm_name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '催收公司名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收公司';

-- ----------------------------
-- Table structure for collector
-- ----------------------------
DROP TABLE IF EXISTS `collector`;
CREATE TABLE `collector` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '唯一值',
  `collector_id` bigint(20) NOT NULL COMMENT '催收员id',
  `account_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '催收员帐号',
  `collector_name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '催收员姓名',
  `collector_post` int(11) NOT NULL COMMENT '催收岗位',
  `collect_language` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '催收语言',
  `collect_group_id` char(36) COLLATE utf8_bin DEFAULT NULL COMMENT '催收组id',
  `collection_firm_id` char(36) COLLATE utf8_bin NOT NULL COMMENT '催收公司id',
  `outbound_company_id` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '外呼公司id',
  `outbound_seat_no` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '外呼公司坐席号',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否禁用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  UNIQUE KEY `uk_collector_id` (`collector_id`),
  UNIQUE KEY `uk_account_name` (`account_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收员 ';

-- ----------------------------
-- Table structure for stage_assign_strategy
-- ----------------------------
DROP TABLE IF EXISTS `stage_assign_strategy`;
CREATE TABLE `stage_assign_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `unique_id` varchar(36) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '唯一Id',
  `collect_stage_id` varchar(36) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '催收阶段Id',
  `customer_type` int(11) NOT NULL COMMENT '客户类型',
  `collect_group_ids` varchar(1024) COLLATE utf8_bin DEFAULT NULL COMMENT '催收组Id集合',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '编辑者',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_collect_stage_id` (`collect_stage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收分派策略';
