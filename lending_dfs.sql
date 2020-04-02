/*
Navicat MySQL Data Transfer

Source Server         : 120.76.72.206
Source Server Version : 50505
Source Host           : 120.76.72.206:3306
Source Database       : lending_dfs

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-03-25 17:22:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dfs_file_info
-- ----------------------------
DROP TABLE IF EXISTS `dfs_file_info`;
CREATE TABLE `dfs_file_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` varchar(45) NOT NULL COMMENT '文件Id',
  `bucket` varchar(45) NOT NULL COMMENT 'bucket',
  `original_filename` varchar(150) NOT NULL COMMENT '原始文件名',
  `store_path` varchar(100) NOT NULL COMMENT '存储路径',
  `suffix` varchar(45) NOT NULL COMMENT '文件后缀',
  `size` varchar(45) NOT NULL COMMENT '文件大小',
  `remark` varchar(45) NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_file_id` (`file_id`),
  KEY `idx_store_path` (`store_path`)
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8mb4 COMMENT='分布式文件信息';
