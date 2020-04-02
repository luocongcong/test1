/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_message

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:23:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for aliyun_message_state
-- ----------------------------
DROP TABLE IF EXISTS `aliyun_message_state`;
CREATE TABLE `aliyun_message_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` varchar(300) NOT NULL,
  `message_id` varchar(45) DEFAULT NULL,
  `response_code` varchar(45) DEFAULT NULL,
  `response_description` varchar(100) DEFAULT NULL,
  `ription` varchar(45) DEFAULT NULL,
  `segments` varchar(45) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_execute_time` (`response_description`),
  KEY `idx_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿里云短信记录';

-- ----------------------------
-- Table structure for aliyun_message_waiting_send
-- ----------------------------
DROP TABLE IF EXISTS `aliyun_message_waiting_send`;
CREATE TABLE `aliyun_message_waiting_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `message` varchar(300) NOT NULL,
  `start_time` datetime NOT NULL,
  `status` bit(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `creator` varchar(45) NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_uniqueId` (`unique_id`),
  KEY `idx_startTime` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿里云短信待发记录';

-- ----------------------------
-- Table structure for chuanglan_message_state
-- ----------------------------
DROP TABLE IF EXISTS `chuanglan_message_state`;
CREATE TABLE `chuanglan_message_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` varchar(300) NOT NULL,
  `message_id` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `error` varchar(100) DEFAULT NULL,
  `send_status` varchar(45) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chuanglan_message_waiting_send
-- ----------------------------
DROP TABLE IF EXISTS `chuanglan_message_waiting_send`;
CREATE TABLE `chuanglan_message_waiting_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `message` varchar(500) NOT NULL,
  `start_time` datetime NOT NULL,
  `status` bit(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `creator` varchar(45) NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_uniqueId` (`unique_id`),
  KEY `idx_startTime` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message_state
-- ----------------------------
DROP TABLE IF EXISTS `message_state`;
CREATE TABLE `message_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `mobile` varchar(45) NOT NULL COMMENT '手机号',
  `template_type` int(11) NOT NULL COMMENT '模板类型',
  `type` varchar(45) NOT NULL COMMENT '短信类型',
  `message` varchar(300) NOT NULL COMMENT '短信内容',
  `channel` varchar(20) NOT NULL COMMENT '短信通道',
  `batch_no` varchar(45) DEFAULT NULL COMMENT '批次号',
  `trans_no` varchar(45) DEFAULT NULL COMMENT '业务号',
  `execute_code` varchar(45) DEFAULT NULL COMMENT '执行状态码',
  `execute_msg` varchar(200) DEFAULT NULL COMMENT '执行状态描述',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信发送记录';

-- ----------------------------
-- Table structure for message_template
-- ----------------------------
DROP TABLE IF EXISTS `message_template`;
CREATE TABLE `message_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(24) NOT NULL COMMENT '唯一Id',
  `name` varchar(50) NOT NULL COMMENT '模板名称',
  `template_type` int(11) NOT NULL COMMENT '模板类型',
  `template_content` varchar(300) NOT NULL COMMENT '模板内容',
  `is_disabled` bit(1) NOT NULL COMMENT '是否禁用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑人',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_name` (`name`),
  KEY `idx_template_type` (`template_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信模板';

-- ----------------------------
-- Table structure for message_template_strategy
-- ----------------------------
DROP TABLE IF EXISTS `message_template_strategy`;
CREATE TABLE `message_template_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(24) NOT NULL COMMENT '唯一Id',
  `template_type` int(11) NOT NULL COMMENT '模板类型',
  `template_usage_type` int(11) NOT NULL COMMENT '模板策略类型',
  `first_option` int(11) NOT NULL COMMENT '首选渠道',
  `second_option` int(11) DEFAULT NULL COMMENT '备选渠道1',
  `third_option` int(11) DEFAULT NULL COMMENT '备选渠道2',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑人',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_template_type` (`template_type`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='短信模板策略';

-- ----------------------------
-- Table structure for message_waiting_send
-- ----------------------------
DROP TABLE IF EXISTS `message_waiting_send`;
CREATE TABLE `message_waiting_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `message` varchar(500) NOT NULL COMMENT '短信内容',
  `start_time` datetime NOT NULL COMMENT '开始发送时间',
  `strategy_id` char(36) DEFAULT NULL COMMENT '策略Id',
  `batch_no` varchar(20) DEFAULT NULL COMMENT '批次号',
  `trans_no` varchar(30) DEFAULT NULL COMMENT '业务号',
  `occupy_time` datetime DEFAULT NULL COMMENT '短信通道',
  `channel` varchar(20) DEFAULT NULL COMMENT '占据时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `createor` varchar(45) NOT NULL COMMENT '创建人',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '编辑人',
  `version` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`),
  KEY `idx_start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信待发记录';

-- ----------------------------
-- Table structure for niuxin_voice_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `niuxin_voice_sms_log`;
CREATE TABLE `niuxin_voice_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `call_id` bigint(20) NOT NULL COMMENT '通话记录ID，保证唯一，可用来对比数据是否重复获取',
  `username` varchar(45) DEFAULT NULL COMMENT '话机用户名',
  `duration` bigint(20) NOT NULL COMMENT '通话时长',
  `phone` varchar(45) NOT NULL COMMENT '原始被叫号码',
  `start_time` datetime NOT NULL COMMENT '通话开始时间',
  `end_time` datetime NOT NULL COMMENT '通话结束时间',
  `order_id` varchar(45) NOT NULL COMMENT '呼叫订单号',
  `show_phone` varchar(45) DEFAULT NULL COMMENT '呼叫显示号码',
  `record_url` varchar(200) DEFAULT NULL COMMENT '录音文件，通话时长等于0的，没有录音文件',
  `answer_time` datetime NOT NULL COMMENT '呼叫接通时间',
  `direction` int(11) NOT NULL COMMENT '呼叫方向，0为呼出，1为呼入',
  `effective_called_number` varchar(45) NOT NULL COMMENT '规整后的被叫号码',
  `hangup_cause` varchar(45) DEFAULT NULL COMMENT '呼叫挂断原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_call_id` (`call_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='牛信语音短信日志';

-- ----------------------------
-- Table structure for tianyihong_message_state
-- ----------------------------
DROP TABLE IF EXISTS `tianyihong_message_state`;
CREATE TABLE `tianyihong_message_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` varchar(300) NOT NULL,
  `message_id` varchar(45) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `send_status` int(11) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tianyihong_message_waiting_send
-- ----------------------------
DROP TABLE IF EXISTS `tianyihong_message_waiting_send`;
CREATE TABLE `tianyihong_message_waiting_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `message` varchar(500) NOT NULL,
  `start_time` datetime NOT NULL,
  `status` bit(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `creator` varchar(45) NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_uniqueId` (`unique_id`),
  KEY `idx_startTime` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unionaction_message_state
-- ----------------------------
DROP TABLE IF EXISTS `unionaction_message_state`;
CREATE TABLE `unionaction_message_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `message` varchar(300) NOT NULL,
  `serial_no` varchar(45) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `send_status` int(11) DEFAULT NULL,
  `response_description` varchar(100) DEFAULT NULL,
  `request_time` datetime NOT NULL,
  `response_time` datetime NOT NULL,
  `times` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unionaction_message_waiting_send
-- ----------------------------
DROP TABLE IF EXISTS `unionaction_message_waiting_send`;
CREATE TABLE `unionaction_message_waiting_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `message` varchar(500) NOT NULL,
  `start_time` datetime NOT NULL,
  `status` bit(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `creator` varchar(45) NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_uniqueId` (`unique_id`),
  KEY `idx_startTime` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for voice_call_state
-- ----------------------------
DROP TABLE IF EXISTS `voice_call_state`;
CREATE TABLE `voice_call_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unique_id` char(36) NOT NULL COMMENT '唯一Id',
  `phone` varchar(45) NOT NULL COMMENT '电话号码',
  `template_type` int(11) NOT NULL COMMENT '模板类型',
  `trans_no` varchar(45) NOT NULL COMMENT '业务号',
  `call_order_id` varchar(45) DEFAULT NULL COMMENT '呼叫订单号',
  `channel` int(11) DEFAULT NULL COMMENT '语音通道（0-牛信）',
  `status` int(11) DEFAULT NULL COMMENT '状态（0-发起呼叫  5-通话结束）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_unique_id` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='语音电话记录';
