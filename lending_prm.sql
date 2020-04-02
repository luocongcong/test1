/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_prm

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:23:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for prm_resource
-- ----------------------------
DROP TABLE IF EXISTS `prm_resource`;
CREATE TABLE `prm_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `code` varchar(45) NOT NULL COMMENT '唯一值',
  `name` varchar(128) NOT NULL COMMENT '资源名称',
  `url` varchar(250) NOT NULL COMMENT '资源路径',
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '资源类型 （0-页面  1-api）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `edit_time` datetime DEFAULT NULL COMMENT '编辑时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '修改者',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8mb4 COMMENT='权限资源表 ';

-- ----------------------------
-- Table structure for prm_role
-- ----------------------------
DROP TABLE IF EXISTS `prm_role`;
CREATE TABLE `prm_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `role_name` varchar(45) NOT NULL COMMENT '角色名称',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '更新者',
  `edit_time` datetime DEFAULT NULL COMMENT '更新时间',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='角色表 ';

-- ----------------------------
-- Table structure for prm_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `prm_role_resource`;
CREATE TABLE `prm_role_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `resource_id` int(11) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_id_resource_id` (`role_id`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2822 DEFAULT CHARSET=utf8mb4 COMMENT='角色资源表 ';

-- ----------------------------
-- Table structure for prm_user
-- ----------------------------
DROP TABLE IF EXISTS `prm_user`;
CREATE TABLE `prm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(45) NOT NULL COMMENT '登录名',
  `full_name` varchar(45) NOT NULL COMMENT '用户名称',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `is_disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '状态 （0-禁用 1-正常）',
  `creator` varchar(45) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `editor` varchar(45) DEFAULT NULL COMMENT '更新者',
  `edit_time` datetime DEFAULT NULL COMMENT '更新时间',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_name` (`user_name`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Table structure for prm_user_role
-- ----------------------------
DROP TABLE IF EXISTS `prm_user_role`;
CREATE TABLE `prm_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_id_role_id` (`user_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='用户角色表 ';
