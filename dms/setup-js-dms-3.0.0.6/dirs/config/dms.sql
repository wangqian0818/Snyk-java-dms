/*
 Navicat Premium Data Transfer

 Source Server         : 开发.101.233
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : 10.10.101.233:3306
 Source Schema         : dms_all_bak

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 04/02/2026 11:40:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alarm_config
-- ----------------------------
DROP TABLE IF EXISTS `alarm_config`;
CREATE TABLE `alarm_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警名称',
  `type` tinyint(4) NOT NULL COMMENT '类型：1-登录告警，2-标记告警，3-网络安全告警，4-应用安全告警，5-设备离线告警，6-设备异常告警，7-日志容量告警',
  `threshold` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '告警阈值：数字或者json',
  `notice_type` tinyint(4) NOT NULL COMMENT '通知方式：1-全部，2-邮件',
  `receivers` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接受人，多个逗号分割',
  `notice_rank` tinyint(4) NOT NULL COMMENT '通知级别：1-信息级，2-低危级，3-中危级，4-高危级，5-严重级',
  `period` int(11) NOT NULL COMMENT '检测周期',
  `state` tinyint(1) NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_alarm_config_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警策略配置-告警策略配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alarm_info
-- ----------------------------
DROP TABLE IF EXISTS `alarm_info`;
CREATE TABLE `alarm_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `system_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '系统IP',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录用户',
  `login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录IP',
  `result` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结果',
  `device_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型',
  `log_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志类型',
  `record_time` datetime(0) DEFAULT NULL COMMENT '告警时间',
  `notice_rank` tinyint(4) DEFAULT NULL COMMENT '告警级别',
  `count` int(11) DEFAULT NULL COMMENT '告警次数',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '告警内容',
  `actual_capacity` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '实际容量',
  `handle_state` tinyint(4) DEFAULT NULL COMMENT '处理状态',
  `handle_msg` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '处理信息',
  `handle_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '处理人',
  `sip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源IP',
  `dip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的IP',
  `sport` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源端口',
  `dport` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的端口',
  `protocol` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '协议类型',
  `client_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '信息交换用户',
  `priority` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '事件级别',
  `class_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '事件类别、事件类型',
  `severity` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '严重程度',
  `ddos_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'DDoS攻击类型',
  `app_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务名称',
  `rule_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '策略名称',
  `filter_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件过滤类型',
  `action` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '动作',
  `describe` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'WAF内容',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alarm_info_opinions
-- ----------------------------
DROP TABLE IF EXISTS `alarm_info_opinions`;
CREATE TABLE `alarm_info_opinions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `alarm_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '告警信息ID',
  `handle_msg` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '处理意见',
  `handle_user` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '处理人',
  `handle_time` datetime(0) DEFAULT NULL COMMENT '处理时间',
  `gmt_create` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警信息处理意见' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alarm_receiver
-- ----------------------------
DROP TABLE IF EXISTS `alarm_receiver`;
CREATE TABLE `alarm_receiver`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人',
  `mail` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `notice_rank` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知级别，多选逗号分割',
  `notice_type` tinyint(4) NOT NULL COMMENT '通知方式：1-全部，2-邮件',
  `templete_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '告警模板ID',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_alarm_receiver_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警策略配置-告警接收人' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alarm_templete
-- ----------------------------
DROP TABLE IF EXISTS `alarm_templete`;
CREATE TABLE `alarm_templete`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板名称',
  `uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板文件uuid',
  `type` tinyint(4) NOT NULL COMMENT '类型：1-邮件',
  `data` longblob NOT NULL COMMENT '模板文件内容',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板描述',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_acl_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '告警策略配置-告警模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for baseline_service
-- ----------------------------
DROP TABLE IF EXISTS `baseline_service`;
CREATE TABLE `baseline_service`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `port` int(11) NOT NULL COMMENT '服务端口',
  `cycle_unit` int(11) NOT NULL DEFAULT 1 COMMENT '核查周期单位 1-天 2-时 3-分 4-秒',
  `cycle_num` int(11) NOT NULL COMMENT '核查周期数值',
  `enable` tinyint(1) DEFAULT NULL COMMENT '功能启用开关 0-关闭 1-开启',
  `white_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '白名单IP。用逗号隔开',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_identity_service_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `baseline_service_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基线核查服务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_device_basic
-- ----------------------------
DROP TABLE IF EXISTS `business_device_basic`;
CREATE TABLE `business_device_basic`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `business_visit_id` bigint(20) UNSIGNED NOT NULL COMMENT '业务访问ID',
  `source_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源IP',
  `destination_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的IP',
  `destination_port` int(11) DEFAULT NULL COMMENT '目的端口',
  `proxy_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '代理IP',
  `proxy_port` int(11) DEFAULT NULL COMMENT '代理端口',
  `proxy_mode` tinyint(4) DEFAULT NULL COMMENT '代理模式：1-反向，2-透明，3-半透明',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '时间配置ID',
  `limit_conn` int(11) DEFAULT NULL COMMENT '最大连接数',
  `waf` tinyint(1) DEFAULT 0 COMMENT 'WAF开启标识',
  `virus` tinyint(1) DEFAULT 0 COMMENT '病毒开启标识',
  `cookie` tinyint(1) DEFAULT 0 COMMENT 'Cookie过滤开启标识',
  `waf_work_state` tinyint(4) DEFAULT -1 COMMENT 'WAF生效状态',
  `virus_work_state` tinyint(4) DEFAULT -1 COMMENT '病毒生效状态',
  `cookie_work_state` tinyint(4) DEFAULT -1 COMMENT 'Cookie过滤生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `fastpath` tinyint(1) DEFAULT NULL COMMENT '快转开关',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `insulate_channel_id` bigint(20) DEFAULT NULL COMMENT '隔离通道ID',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_business_device_basic_border_device_basic_id`(`channel_info_id`) USING BTREE,
  INDEX `fk_business_device_basic_business_visit_id`(`business_visit_id`) USING BTREE,
  CONSTRAINT `business_device_basic_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-业务访问-设备策略-基本属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_group
-- ----------------------------
DROP TABLE IF EXISTS `business_group`;
CREATE TABLE `business_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务组名称',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络域名称',
  `data_type` tinyint(4) DEFAULT NULL COMMENT '数据类型：1-数据业务，2-管理业务',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_business_group_name`(`name`) USING BTREE,
  INDEX `fk_business_group_network_area_id`(`network_area_id`) USING BTREE,
  CONSTRAINT `business_group_ibfk_1` FOREIGN KEY (`network_area_id`) REFERENCES `network_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务主机-业务组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_ha_device_relevance
-- ----------------------------
DROP TABLE IF EXISTS `business_ha_device_relevance`;
CREATE TABLE `business_ha_device_relevance`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备SN',
  `app_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '模块',
  `source_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '模块ID',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '下发消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_host
-- ----------------------------
DROP TABLE IF EXISTS `business_host`;
CREATE TABLE `business_host`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主机名称',
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主机IP，可多个，用逗号分割',
  `business_group_id` bigint(20) UNSIGNED NOT NULL COMMENT '业务组ID',
  `business_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务组名称',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_business_host_name`(`name`) USING BTREE,
  INDEX `fk_business_host_business_group_id`(`business_group_id`) USING BTREE,
  CONSTRAINT `business_host_ibfk_1` FOREIGN KEY (`business_group_id`) REFERENCES `business_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务主机-业务主机' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_id_pool
-- ----------------------------
DROP TABLE IF EXISTS `business_id_pool`;
CREATE TABLE `business_id_pool`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '业务类型：1-业务访问，2-文件传输，3-数据库同步，4-数据同步',
  `gmt_create` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务ID池' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_insulate_channel
-- ----------------------------
DROP TABLE IF EXISTS `business_insulate_channel`;
CREATE TABLE `business_insulate_channel`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通道名称',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `iface_a_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网络接口A名称',
  `iface_a_id` bigint(20) UNSIGNED NOT NULL COMMENT '网络接口A ID',
  `iface_b_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网络接口B名称',
  `iface_b_id` bigint(20) UNSIGNED NOT NULL COMMENT '网络接口B ID',
  `direction` tinyint(4) NOT NULL COMMENT '通道方向',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_business_insulate_channel_border_device_basic_id`(`channel_info_id`) USING BTREE,
  INDEX `fk_business_insulate_channel_iface_a_id`(`iface_a_id`) USING BTREE,
  INDEX `fk_business_insulate_channel_iface_b_id`(`iface_b_id`) USING BTREE,
  CONSTRAINT `business_insulate_channel_ibfk_1` FOREIGN KEY (`iface_b_id`) REFERENCES `channel_iface` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `business_insulate_channel_ibfk_2` FOREIGN KEY (`iface_a_id`) REFERENCES `channel_iface` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `business_insulate_channel_ibfk_3` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-隔离通道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_strategy
-- ----------------------------
DROP TABLE IF EXISTS `business_strategy`;
CREATE TABLE `business_strategy`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_device_basic_id` bigint(20) UNSIGNED NOT NULL COMMENT '基本属性ID',
  `app_type` tinyint(4) DEFAULT NULL COMMENT '业务类型：1-业务访问，2-文件同步，3-数据库同步，4-数据同步',
  `type` tinyint(4) NOT NULL COMMENT '策略类型：1-浏览安全策略，2-文件传输策略，3-邮件策略，4-定制应用策略，5-内容审查策略，6-QoS，7-ACL，8-域间标记，9-隔离通道',
  `channel_info_id` bigint(20) NOT NULL COMMENT '设备ID',
  `strategy_id` bigint(20) UNSIGNED NOT NULL COMMENT '策略ID',
  `iface_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '接口ID',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_business_strategy_business_device_basic_id`(`business_device_basic_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-业务访问-策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_time
-- ----------------------------
DROP TABLE IF EXISTS `business_time`;
CREATE TABLE `business_time`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间配置名称',
  `mode` tinyint(4) DEFAULT NULL COMMENT '时间模式：1-时间周期模式，2-超时模式，3-周期模式',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型：1-每天，2-每周，3-每月',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时长（s）',
  `date_start` datetime(0) DEFAULT NULL COMMENT '开始日期',
  `date_end` datetime(0) DEFAULT NULL COMMENT '结束日期',
  `gmt_start` datetime(0) DEFAULT NULL COMMENT '开始时间',
  `gmt_end` datetime(0) DEFAULT NULL COMMENT '结束时间',
  `weekdays` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '星期几，逗号分割',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_business_time_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-时间配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_transmission
-- ----------------------------
DROP TABLE IF EXISTS `business_transmission`;
CREATE TABLE `business_transmission`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `channel_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备名称',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '时间配置ID',
  `business_time_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '时间配置名称',
  `insulate_channel_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '隔离通道ID',
  `insulate_channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '隔离通道名称',
  `arp_enable` tinyint(1) DEFAULT 0 COMMENT '透传ARP',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_user
-- ----------------------------
DROP TABLE IF EXISTS `business_user`;
CREATE TABLE `business_user`  (
  `user_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for business_visit
-- ----------------------------
DROP TABLE IF EXISTS `business_visit`;
CREATE TABLE `business_visit`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `rank` tinyint(4) DEFAULT NULL COMMENT '安全等级',
  `source_network_area_id` bigint(20) DEFAULT NULL COMMENT '源域ID',
  `source_network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源域名称',
  `destination_network_area_id` bigint(20) DEFAULT NULL COMMENT '目的域ID',
  `destination_network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的域名称',
  `source_business_group_id` bigint(20) DEFAULT NULL COMMENT '源业务组ID',
  `source_business_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源业务组名称',
  `destination_business_group_id` bigint(20) DEFAULT NULL COMMENT '目的业务组ID',
  `destination_business_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的业务组名称',
  `source_port` int(11) DEFAULT NULL COMMENT '源端口',
  `destination_port` int(11) DEFAULT NULL COMMENT '目的端口',
  `l4_proto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传输层协议',
  `l7_proto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用层协议',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_business_visit_name`(`name`) USING BTREE,
  INDEX `fk_business_visit_source_network_area_id`(`source_network_area_id`) USING BTREE,
  INDEX `fk_business_visit_destination_network_area_id`(`destination_network_area_id`) USING BTREE,
  INDEX `fk_business_visit_source_business_group_id`(`source_business_group_id`) USING BTREE,
  INDEX `fk_business_visit_destination_business_group_id`(`destination_business_group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-业务访问' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for card_dispatch_network
-- ----------------------------
DROP TABLE IF EXISTS `card_dispatch_network`;
CREATE TABLE `card_dispatch_network`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `network_area_id` bigint(20) DEFAULT NULL,
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `channel_info_id` bigint(20) DEFAULT NULL,
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `work_state` tinyint(4) DEFAULT -1,
  `deleting` tinyint(4) DEFAULT 0,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for card_strategy_acl
-- ----------------------------
DROP TABLE IF EXISTS `card_strategy_acl`;
CREATE TABLE `card_strategy_acl`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '策略名称',
  `channel_info_id` bigint(20) DEFAULT NULL COMMENT '设备变id',
  `sip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '源ip',
  `sport` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '源端口',
  `dip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '目的ip',
  `dport` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '目的端口',
  `protocol` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '协议类型',
  `ifname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网口名称',
  `listorder` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '命中策略的优先级',
  `ttl` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '策略存活周期(单位秒)',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '命中后对报文的处理动作',
  `mt_label` bigint(20) DEFAULT NULL COMMENT '正向比对标记对象',
  `tg_label` bigint(20) DEFAULT NULL COMMENT '正向出口打标记对象',
  `rv_mt_label` bigint(20) DEFAULT NULL COMMENT '反向比对标记对象',
  `rv_tg_label` bigint(20) DEFAULT NULL COMMENT '反向出口打标记对象',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '安全卡acl策略，设备管理-边界设备-卡ACL策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for card_strategy_tag
-- ----------------------------
DROP TABLE IF EXISTS `card_strategy_tag`;
CREATE TABLE `card_strategy_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '策略名称',
  `channel_info_id` bigint(20) DEFAULT NULL COMMENT '设备变id',
  `ifname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网口名称',
  `mt_label` bigint(20) DEFAULT NULL COMMENT '正向比对标记对象',
  `tg_label` bigint(20) DEFAULT NULL COMMENT '正向出口打标记对象',
  `rv_mt_label` bigint(20) DEFAULT NULL COMMENT '反向比对标记对象',
  `rv_tg_label` bigint(255) DEFAULT NULL COMMENT '反向出口打标记对象',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '安全卡acl策略，设备管理-边界设备-卡ACL策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for card_tag_obj
-- ----------------------------
DROP TABLE IF EXISTS `card_tag_obj`;
CREATE TABLE `card_tag_obj`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标记对象名称',
  `tag_type` tinyint(4) UNSIGNED ZEROFILL DEFAULT NULL COMMENT '类型：1-对比标记，2-打标记',
  `doi` int(11) DEFAULT NULL COMMENT '标记解释域；整形取值范围[1,UINT32_MAX]',
  `type` int(11) DEFAULT NULL COMMENT '标记类型\r\n1：位图类型，Cat为位图\r\n2：枚举类型，Cat为区间\r\n5：区间类型，Cat为数值\r\n7：自定义类型',
  `match` int(11) DEFAULT NULL COMMENT 'Cat比较方式\r\n0：子集\r\n1：交集\r\n2：重合\r\n3：不相交',
  `sensitivity` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '机密性级别',
  `integrity` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '完整性级别',
  `cat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '类别列表比较对象',
  `mode` int(11) DEFAULT NULL COMMENT '打标记附加属性',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '安全标记策略-安全卡标记对象' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_auto_backup
-- ----------------------------
DROP TABLE IF EXISTS `channel_auto_backup`;
CREATE TABLE `channel_auto_backup`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `auto_enable` tinyint(1) DEFAULT NULL COMMENT '自动备份开关',
  `interval_time` int(11) DEFAULT NULL COMMENT '间隔时间',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-备份-自动备份' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_backup
-- ----------------------------
DROP TABLE IF EXISTS `channel_backup`;
CREATE TABLE `channel_backup`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备份人',
  `file_name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件名称',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `dms_version` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '系统版本',
  `device_version` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备版本',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_backup_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_backup_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-备份' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_ddos_config
-- ----------------------------
DROP TABLE IF EXISTS `channel_ddos_config`;
CREATE TABLE `channel_ddos_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `syn_cookie` tinyint(1) NOT NULL COMMENT 'SynCookie状态：0-关闭，1-打开',
  `udp_flood_enable` tinyint(1) NOT NULL COMMENT '启动状态：0-关闭，1-打开',
  `blocking_threshold_of_udp_sip` int(11) DEFAULT NULL COMMENT 'UDP源IP封锁阈值',
  `blocking_time_of_udp_sip` int(11) DEFAULT NULL COMMENT 'UDP封锁时长',
  `drop_threshold_of_udp_dip` int(11) DEFAULT NULL COMMENT 'UDP目的IP丢弃阈值',
  `icmp_flood_enable` tinyint(1) NOT NULL COMMENT '启动状态：0-关闭，1-打开',
  `blocking_threshold_of_icmp_sip` int(11) DEFAULT NULL COMMENT 'ICMP源IP封锁阈值',
  `blocking_time_of_icmp_sip` int(11) DEFAULT NULL COMMENT 'ICMP封锁时长',
  `drop_threshold_of_icmp_dip` int(11) DEFAULT NULL COMMENT 'ICMP目的IP丢弃阈值',
  `syn_flood_enable` tinyint(1) NOT NULL COMMENT 'SYN启动状态：0-关闭，1-打开',
  `blocking_threshold_of_syn_sip` int(11) DEFAULT NULL COMMENT 'SYN源IP封锁阈值',
  `blocking_time_of_syn_sip` int(11) DEFAULT NULL COMMENT 'SYN封锁时长',
  `drop_threshold_of_syn_dip` int(11) DEFAULT NULL COMMENT 'SYN目的IP丢弃阈值',
  `ack_flood_enable` tinyint(1) NOT NULL COMMENT 'ACK启动状态：0-关闭，1-打开',
  `blocking_threshold_of_ack_sip` int(11) DEFAULT NULL COMMENT 'ACK源IP封锁阈值',
  `blocking_time_of_ack_sip` int(11) DEFAULT NULL COMMENT 'ACK封锁时长',
  `drop_threshold_of_ack_dip` int(11) DEFAULT NULL COMMENT 'ACK目的IP丢弃阈值',
  `rst_flood_enable` tinyint(1) NOT NULL COMMENT 'RST启动状态：0-关闭，1-打开',
  `blocking_threshold_of_rst_sip` int(11) DEFAULT NULL COMMENT 'RST源IP封锁阈值',
  `blocking_time_of_rst_sip` int(11) DEFAULT NULL COMMENT 'RST封锁时长',
  `drop_threshold_of_rst_dip` int(11) DEFAULT NULL COMMENT 'RST目的IP丢弃阈值',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_ddos_config_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_ddos_config_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-DDos配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_diagnose_tool
-- ----------------------------
DROP TABLE IF EXISTS `channel_diagnose_tool`;
CREATE TABLE `channel_diagnose_tool`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `channel_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '通道ID',
  `command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '命令，例如：PING',
  `params` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '命令参数',
  `work_area` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `iface_id` bigint(20) DEFAULT NULL COMMENT '接口ID',
  `exec_state` tinyint(4) DEFAULT 0 COMMENT '执行状态：1-正在执行，2-执行完成',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-诊断工具' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_dispatched_strategy
-- ----------------------------
DROP TABLE IF EXISTS `channel_dispatched_strategy`;
CREATE TABLE `channel_dispatched_strategy`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `type` tinyint(4) NOT NULL COMMENT '策略类型：1-浏览安全策略，2-文件传输策略，3-邮件策略，4-定制应用策略，5-内容审查策略，6-QoS，7-ACL，8-域间标记，9-隔离通道',
  `strategy_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '策略ID',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备已下发策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_ha
-- ----------------------------
DROP TABLE IF EXISTS `channel_ha`;
CREATE TABLE `channel_ha`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '运行模式：backup-主备模式，cluster-负载模式',
  `heartbeat_cycle` int(11) DEFAULT NULL COMMENT '心跳报文发送周期',
  `preempt` tinyint(1) NOT NULL COMMENT '抢占开关 0-禁用，1-启用',
  `device_type` tinyint(4) NOT NULL COMMENT '设备类型：1-网关，2-隔离',
  `enable` tinyint(1) NOT NULL COMMENT '启动状态：0-关闭，1-打开',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_border_device_ha_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-HA组管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_ha_device
-- ----------------------------
DROP TABLE IF EXISTS `channel_ha_device`;
CREATE TABLE `channel_ha_device`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_ha_id` bigint(20) UNSIGNED NOT NULL COMMENT 'HA组ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_number` int(11) NOT NULL COMMENT '设备序号',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `device_role` tinyint(4) NOT NULL COMMENT '设备角色：1-主设备，2-备设备，3-负载设备',
  `enable` tinyint(1) NOT NULL COMMENT '启动状态：0-关闭，1-打开',
  `device_ha_ip` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '心跳口IP',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `work_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工作状态',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_ha_device_border_device_ha_id`(`channel_ha_id`) USING BTREE,
  INDEX `fk_border_device_ha_device_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_ha_device_ibfk_1` FOREIGN KEY (`channel_ha_id`) REFERENCES `channel_ha` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `channel_ha_device_ibfk_2` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-HA组管理-设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_ha_vrids
-- ----------------------------
DROP TABLE IF EXISTS `channel_ha_vrids`;
CREATE TABLE `channel_ha_vrids`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_ha_id` bigint(20) UNSIGNED NOT NULL COMMENT 'HA组ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `vrid` int(11) NOT NULL COMMENT 'Vrid',
  `if_id` bigint(20) NOT NULL COMMENT '接口ID',
  `if_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口名称',
  `vip` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口IP',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_ha_vrids_border_device_ha_id`(`channel_ha_id`) USING BTREE,
  INDEX `fk_border_device_ha_vrids_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_ha_vrids_ibfk_1` FOREIGN KEY (`channel_ha_id`) REFERENCES `channel_ha` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `channel_ha_vrids_ibfk_2` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-HA组管理-Vrids' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_iface
-- ----------------------------
DROP TABLE IF EXISTS `channel_iface`;
CREATE TABLE `channel_iface`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接口名称',
  `work_type` tinyint(4) NOT NULL COMMENT '工作类型：0-管理口,1-心跳口，2-业务口，3-前置机业务口，4-后置机业务口，5-内部管理口',
  `iface_type` tinyint(4) NOT NULL COMMENT '接口类型，1-物理接口，2-VLAN，3-BOND',
  `raw_iface` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '真实物理接口名称，例如：eth1',
  `external` tinyint(4) DEFAULT NULL COMMENT '0-对内接口，1-对外接口',
  `init_iface_id` bigint(20) DEFAULT NULL COMMENT '初始化接口ID',
  `ifaces` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下属接口名称，可多个，用逗号分割',
  `iface_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下属接口id，可多个，用逗号分割',
  `p_iface_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父接口id，可多个，用逗号分割',
  `mac` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '物理地址',
  `vlan_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'VLAN ID，可多个，用逗号分割',
  `bond_mode` tinyint(4) DEFAULT NULL COMMENT 'bond模式',
  `ips` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'IP地址，可多个，用逗号分割',
  `gateway` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网关地址',
  `iface_state` tinyint(4) DEFAULT 0 COMMENT '接口状态：1-UP，2-DOWN',
  `enabled` tinyint(4) DEFAULT NULL COMMENT '接口状态：0-禁用，1-启用',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `iface_work_state` tinyint(4) DEFAULT -1 COMMENT '接口生效状态，物理接口没有',
  `ips_work_state` tinyint(4) DEFAULT -1 COMMENT 'IP生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_iface_raw_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_iface_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-网络接口' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_info
-- ----------------------------
DROP TABLE IF EXISTS `channel_info`;
CREATE TABLE `channel_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备的SN号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通道名称',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络域名称',
  `channel_type` tinyint(4) NOT NULL COMMENT '通道类型\r\n1-2节点单导通道，\r\n2-4节点双单向（ABCD）通道，\r\n3-6节点单导（ABCDEF）通道，\r\n4-隔离通道，\r\n5-双向网闸通道，\r\n6-4节点单导通道（FDCE）',
  `device_sub_type` tinyint(4) DEFAULT NULL COMMENT '废弃不用',
  `card_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '安全卡号',
  `cert_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证书编号',
  `device_node_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '节点名称',
  `location` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '节点位置',
  `device_flag` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备特殊功能标记字段，如乐研',
  `slot_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '槽位号',
  `slot_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '槽位IP',
  `running_state` tinyint(4) DEFAULT 1 COMMENT '设备运行状态：1正常，2异常，3离线，4离线且异常',
  `device_log` tinyint(1) NOT NULL COMMENT '设备日志启用标识',
  `device_log_work_state` tinyint(4) DEFAULT -1 COMMENT '设备日志生效状态',
  `device_remote_log` tinyint(1) NOT NULL COMMENT '设备远程日志启用标识',
  `device_remote_log_work_state` tinyint(4) DEFAULT -1 COMMENT '设备远程日志生效状态',
  `ping` tinyint(1) NOT NULL COMMENT 'PING启用标识',
  `ping_work_state` tinyint(4) DEFAULT -1 COMMENT 'PING生效状态',
  `ssh` tinyint(1) NOT NULL COMMENT 'ssh启用标识',
  `ssh_work_state` tinyint(4) DEFAULT -1 COMMENT 'ssh生效状态',
  `ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理口IP',
  `mac` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理口MAC',
  `ip_mac_work_state` tinyint(4) DEFAULT -1 COMMENT '管理者IP/MAC生效状态',
  `ddos` tinyint(1) NOT NULL COMMENT 'DDoS攻击防护开关',
  `ddos_work_state` tinyint(4) DEFAULT -1 COMMENT 'DDOS生效状态',
  `waf` tinyint(1) NOT NULL COMMENT 'WAF防护开关',
  `waf_work_state` tinyint(4) DEFAULT -1 COMMENT 'WAF防护开关生效状态',
  `virus` tinyint(1) NOT NULL COMMENT '病毒扫描开关',
  `virus_work_state` tinyint(4) DEFAULT -1 COMMENT '病毒扫描开关生效状态',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'A-B-',
  `fastpath` tinyint(1) DEFAULT NULL COMMENT '快转开关',
  `fastpath_work_state` tinyint(4) DEFAULT -1 COMMENT '快转开关生效状态',
  `snmp` tinyint(1) NOT NULL COMMENT 'SNMP开关',
  `snmp_work_state` tinyint(4) DEFAULT -1 COMMENT 'SNMP开关生效状态',
  `scan` tinyint(1) NOT NULL COMMENT '端口扫描开关',
  `scan_work_state` tinyint(4) DEFAULT -1 COMMENT '端口扫描开关生效状态',
  `iface_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络接口',
  `access_flow_log` tinyint(1) NOT NULL COMMENT '数据同步日志启用标识',
  `access_flow_log_work_state` tinyint(4) DEFAULT -1 COMMENT '数据同步日志生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `intrusion_detection` tinyint(1) NOT NULL COMMENT '入侵检测开关',
  `intrusion_detection_work_state` tinyint(4) DEFAULT -1 COMMENT '入侵检测开关生效状态',
  `intrusion_priority` tinyint(4) DEFAULT NULL COMMENT '入侵检测级别',
  `white_ips` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '白名单IPs',
  `intrusion_port` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'http协议监控端口',
  `pcap_log_enable` tinyint(1) DEFAULT NULL COMMENT '攻击数据留存开关',
  `pcap_log_size` int(11) DEFAULT NULL COMMENT '攻击数据留存大小',
  `baseline_check` tinyint(1) DEFAULT NULL COMMENT '基线核查开关   1-开启  0-关闭',
  `system_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '双系统配置',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_border_device_basic_name`(`name`) USING BTREE,
  INDEX `fk_border_device_basic_network_area_id`(`network_area_id`) USING BTREE,
  CONSTRAINT `channel_info_ibfk_1` FOREIGN KEY (`network_area_id`) REFERENCES `network_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-基本配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_info_extra
-- ----------------------------
DROP TABLE IF EXISTS `channel_info_extra`;
CREATE TABLE `channel_info_extra`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备的SN号',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备软件版本信息',
  `abnormal_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '异常原因提示信息',
  `auth_module_state` tinyint(4) DEFAULT NULL COMMENT '认证模块状态:1-运行，2-关闭',
  `ha_state` tinyint(4) DEFAULT NULL COMMENT '双机热备状态:1-master,2-backup',
  `work_load` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备工作负载',
  `waf_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'WAF版本号',
  `waf_update` datetime(0) DEFAULT NULL COMMENT 'WAF更新时间',
  `waf_rule_path` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'WAF规则文件路径',
  `virus_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'Virus版本号',
  `virus_update` datetime(0) DEFAULT NULL COMMENT 'Virus更新时间',
  `virus_factory` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'Virus厂家',
  `virus_db_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'Virus版本',
  `ids_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入侵检测版本号',
  `ids_update` datetime(0) DEFAULT NULL COMMENT '入侵检测更新时间',
  `ids_rule_path` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '入侵检测规则文件路径',
  `security_strategies` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '正常运行中的安全策略状态对象',
  `waf_rules` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'WAF选中规则名',
  `waf_action` tinyint(1) DEFAULT NULL COMMENT 'WAF执行动作',
  `waf_block_time` int(10) DEFAULT NULL COMMENT 'WAF封锁时长',
  `waf_block_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'WAF封锁单位',
  `detection_only` tinyint(1) DEFAULT NULL COMMENT '只检测开关',
  `intrusion_rules` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '入侵检测选中规则名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-基本配置-附加信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_ip_mac
-- ----------------------------
DROP TABLE IF EXISTS `channel_ip_mac`;
CREATE TABLE `channel_ip_mac`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '通道ID',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP',
  `mac` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'MAC',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_ip_mac_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_ip_mac_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-IP MAC绑定' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_restore
-- ----------------------------
DROP TABLE IF EXISTS `channel_restore`;
CREATE TABLE `channel_restore`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_info_id` int(11) DEFAULT NULL COMMENT '设备基础表id',
  `message_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'UUID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作用户',
  `gmt_start` datetime(0) DEFAULT NULL COMMENT '操作开始时间',
  `gmt_end` datetime(0) DEFAULT NULL COMMENT '操作结束时间',
  `result` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结果',
  `remark` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '记录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-备份还原记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_router
-- ----------------------------
DROP TABLE IF EXISTS `channel_router`;
CREATE TABLE `channel_router`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '通道ID',
  `destination_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '目的地址',
  `subnet_mask` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '子网掩码',
  `gateway` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网关地址',
  `out_iface_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '出接口ID',
  `router_table_id` int(11) DEFAULT NULL COMMENT '路由表ID',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_router_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_router_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-路由管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_snmp
-- ----------------------------
DROP TABLE IF EXISTS `channel_snmp`;
CREATE TABLE `channel_snmp`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `trust_ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理主机IP',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '负责人电话',
  `cpu_threshold` int(11) NOT NULL COMMENT 'CPU利用率阈值',
  `memory_threshold` int(11) NOT NULL COMMENT '内存利用率阈值',
  `disk_threshold` int(11) NOT NULL COMMENT '磁盘利用率阈值',
  `trap_comm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Trap发送字符串',
  `snmp_version` tinyint(4) NOT NULL COMMENT '版本：2-SNMP v1&v2，3-SNMP v3',
  `ro_comm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '只读团体字符串',
  `rw_comm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '读写团体字符串',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名称',
  `auth_type` tinyint(4) DEFAULT NULL COMMENT '安全选项：1-加密授权认证，2-非加密授权认证，3-非授权认证',
  `auth_algo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '认证协议',
  `auth_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '认证密码',
  `priv_algo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '加密协议',
  `priv_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '加密密码',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_router_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_snmp_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-SNMP管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_time
-- ----------------------------
DROP TABLE IF EXISTS `channel_time`;
CREATE TABLE `channel_time`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型',
  `info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `time` datetime(0) DEFAULT NULL COMMENT '设备时间',
  `server` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '时间同步服务器地址',
  `period` int(11) DEFAULT NULL COMMENT '时间同步周期(s)',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-时间配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_upgrade
-- ----------------------------
DROP TABLE IF EXISTS `channel_upgrade`;
CREATE TABLE `channel_upgrade`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '更新包名称',
  `file_uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件uuid',
  `type` tinyint(4) NOT NULL COMMENT '更新包类型：1-加固包，2-版本包，3-补丁包',
  `md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'device-设备升级   client-客户端升级',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_border_device_upgrade_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备升级' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_upgrade_dispatch
-- ----------------------------
DROP TABLE IF EXISTS `channel_upgrade_dispatch`;
CREATE TABLE `channel_upgrade_dispatch`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `source_id` bigint(20) UNSIGNED NOT NULL COMMENT '源ID',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '升级包下发' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for channel_webssh
-- ----------------------------
DROP TABLE IF EXISTS `channel_webssh`;
CREATE TABLE `channel_webssh`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `manage_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理IP',
  `port` int(11) DEFAULT NULL COMMENT '服务端口',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录用户',
  `webssh_key` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录密钥',
  `passphrase` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证书密码',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态:-1未下发，1已下发，2未生效，3已生效',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_border_device_webssh_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `channel_webssh_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '边界设备-WEBSSH管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for device_info
-- ----------------------------
DROP TABLE IF EXISTS `device_info`;
CREATE TABLE `device_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备的SN号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '网络域名称',
  `device_type` tinyint(4) NOT NULL COMMENT '1-网关，\r\n2-隔离，\r\n3-2节点单导，\r\n4-6节点双单向（ABCDEF），\r\n5-安全卡，\r\n6-2节点双向网闸，\r\n7-4节点单导（EABF），\r\n8-多通道设备',
  `device_flag` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备特殊标记字段，如乐研',
  `product_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '设备型号',
  `device_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '设备版本',
  `manufacturing_date` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '出厂日期',
  `introduction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产品简介',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for entity_access_device
-- ----------------------------
DROP TABLE IF EXISTS `entity_access_device`;
CREATE TABLE `entity_access_device`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'IP',
  `operate_system` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作系统',
  `org_structure_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '归属单位ID',
  `org_structure_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '归属单位',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `confidentiality_level` tinyint(4) DEFAULT NULL COMMENT '保密级别。与文件传输保密级别和审核有关',
  `sys_client_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for entity_org_structure
-- ----------------------------
DROP TABLE IF EXISTS `entity_org_structure`;
CREATE TABLE `entity_org_structure`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '上级ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `org_level` int(10) DEFAULT NULL COMMENT '级别',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dir` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_file_uuid_name`(`uuid`, `name`) USING BTREE,
  INDEX `index_file_module`(`module`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for identity
-- ----------------------------
DROP TABLE IF EXISTS `identity`;
CREATE TABLE `identity`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'id',
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作用户',
  `client_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户端IP',
  `host_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主机域名或者IP',
  `port` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '主机认证服务端口',
  `result` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '认证结果:成功，失败',
  `key_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证书密码',
  `cert_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '证书文件名',
  `add_time` datetime(0) DEFAULT NULL COMMENT '认证时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_clientip_username`(`user_name`, `client_ip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户认证记录信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for identity_dispatch
-- ----------------------------
DROP TABLE IF EXISTS `identity_dispatch`;
CREATE TABLE `identity_dispatch`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '通道ID',
  `type` tinyint(4) NOT NULL COMMENT '1-认证服务，2-根证书管理',
  `source_id` bigint(20) UNSIGNED NOT NULL COMMENT '源ID',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT NULL COMMENT '数据状态：0正常，1正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '认证下发' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for identity_root_cert
-- ----------------------------
DROP TABLE IF EXISTS `identity_root_cert`;
CREATE TABLE `identity_root_cert`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '根证书名称',
  `file_uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '证书文件uuid',
  `attrs` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证书属性',
  `md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '证书md5',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_identify_root_cert_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '根证书管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for identity_service
-- ----------------------------
DROP TABLE IF EXISTS `identity_service`;
CREATE TABLE `identity_service`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '通道ID',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务器IP',
  `port` int(11) NOT NULL COMMENT '服务端口',
  `period` int(11) NOT NULL COMMENT '认证时效(天)',
  `service_type` tinyint(4) NOT NULL COMMENT '认证服务类别：1-软：RSA/SM9,2-硬：密码机',
  `service_state` tinyint(1) NOT NULL COMMENT '服务状态',
  `work_area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '仅隔离设备，生效区域：A-前置机，B-后置机',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `white_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '白名单。用逗号隔开',
  `white_list_user` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '用户白名单。用逗号隔开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_identity_service_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `identity_service_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '认证服务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for init_device
-- ----------------------------
DROP TABLE IF EXISTS `init_device`;
CREATE TABLE `init_device`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备SN',
  `device_type` tinyint(4) DEFAULT NULL COMMENT '设备类型：1-网关，2-隔离，3-单导，4-双单向',
  `device_sub_type` tinyint(4) DEFAULT NULL COMMENT '设备子类型：1-网关，2-隔离，3-单导',
  `channel_type` tinyint(4) DEFAULT NULL COMMENT '通道类型',
  `channel_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `card_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '安全卡号',
  `location` varchar(31) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '节点位置',
  `device_node_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '节点名称',
  `slot_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '槽位号',
  `slot_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '槽位IP',
  `gmt_clock` datetime(0) DEFAULT NULL COMMENT '设备时钟',
  `gmt_clock_record` datetime(0) DEFAULT NULL COMMENT '设备时钟记录时间',
  `memory` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内存大小',
  `hard_disk` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '磁盘大小',
  `iface_num` tinyint(4) NOT NULL COMMENT '接口数量',
  `cpu_num` tinyint(4) DEFAULT NULL COMMENT 'CPU数量',
  `product_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品型号',
  `product_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品编码',
  `product_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '产品版本',
  `working_mode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工作模式',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备软件版本信息',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备初始化信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for init_interface
-- ----------------------------
DROP TABLE IF EXISTS `init_interface`;
CREATE TABLE `init_interface`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口名称',
  `mac` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接口MAC',
  `device_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `external` tinyint(4) DEFAULT NULL COMMENT '0-对内接口，1-对外接口',
  `ips` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'IP地址，可多个，用逗号分割',
  `type` tinyint(4) NOT NULL COMMENT '类型：0-管理口,1-心跳口，2-业务口，3-前置机业务口，4-后置机业务口，5-内部管理口',
  `if_type` tinyint(4) DEFAULT NULL COMMENT '类型：1-千兆电口，2-千兆光口，3-万兆电口，4-万兆光口',
  `status` tinyint(4) DEFAULT NULL COMMENT 'Link状态：1-UP，2-DOWN',
  `row` tinyint(4) DEFAULT NULL COMMENT '接口行序号',
  `column` tinyint(4) DEFAULT NULL COMMENT '接口列序号',
  `info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工作模式',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_init_interface_init_device_id`(`device_id`) USING BTREE,
  CONSTRAINT `init_interface_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `init_device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备物理接口初始化信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jsp_info
-- ----------------------------
DROP TABLE IF EXISTS `jsp_info`;
CREATE TABLE `jsp_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工作目录路径',
  `port` int(10) DEFAULT NULL COMMENT 'JSP接收端端口',
  `gmt_create` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `entity_id` bigint(20) NOT NULL COMMENT 'entity_access_device表id',
  `business_id` bigint(20) NOT NULL COMMENT 'trans_busi_file表ID。',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '传输客户端启动的jsp进程信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `parent_menus` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `menu` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `sequence` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '1一级菜单，2二级菜单，3三级菜单，4其它',
  `index` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '三级菜单页面顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 246 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'screen', 'top', 1, NULL, NULL);
INSERT INTO `menu` VALUES (2, '2025-01-14 16:17:12', '2025-01-14 16:17:12', 'root,control,baseline', 'base-line-set', 2, NULL, '1');
INSERT INTO `menu` VALUES (3, '2025-01-14 16:17:13', '2025-01-14 16:17:13', 'root,control,baseline', 'base-line-list', 3, NULL, '2');
INSERT INTO `menu` VALUES (4, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,control,identity', 'identity-service', 4, NULL, '1');
INSERT INTO `menu` VALUES (5, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,control,identity', 'identity-user', 5, NULL, '2');
INSERT INTO `menu` VALUES (6, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,control,identity', 'identity-root-cert', 6, NULL, '3');
INSERT INTO `menu` VALUES (7, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,control', 'device-ip-mac', 7, NULL, NULL);
INSERT INTO `menu` VALUES (10, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,protection', 'strategy-acl', 10, NULL, NULL);
INSERT INTO `menu` VALUES (11, '2025-02-10 09:39:37', '2025-02-10 09:39:39', 'root,protection,detection', 'intrusion-config', 11, NULL, '1');
INSERT INTO `menu` VALUES (12, '2025-02-10 09:40:05', '2025-02-10 09:40:07', 'root,protection,detection', 'intrusion-upgrade', 12, NULL, '2');
INSERT INTO `menu` VALUES (13, '2021-11-05 12:07:00', '2021-11-05 12:07:00', 'root,protection', 'device-ddos', 13, NULL, NULL);
INSERT INTO `menu` VALUES (14, '2025-02-10 09:40:54', '2025-02-10 09:40:58', 'root,protection', 'virus-upgrade', 14, NULL, NULL);
INSERT INTO `menu` VALUES (15, '2025-02-13 17:24:12', '2025-02-13 17:24:15', 'root,protection,waf', 'waf-config', 15, NULL, '1');
INSERT INTO `menu` VALUES (16, '2025-02-10 09:41:00', '2025-02-10 09:41:02', 'root,protection,waf', 'waf-upgrade', 16, NULL, '2');
INSERT INTO `menu` VALUES (17, '2025-09-10 14:53:15', '2025-09-10 14:53:15', 'root,protection', 'network-resource', 17, NULL, NULL);
INSERT INTO `menu` VALUES (20, '2022-05-23 16:58:19', '2022-05-23 16:58:19', 'root,strategy,application-security', 'strategy-content', 24, NULL, '5');
INSERT INTO `menu` VALUES (21, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy', 'strategy-qos', 20, NULL, NULL);
INSERT INTO `menu` VALUES (22, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,security-mark', 'strategy-area-mark', 21, NULL, '1');
INSERT INTO `menu` VALUES (23, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,security-mark', 'strategy-mark', 22, NULL, '2');
INSERT INTO `menu` VALUES (24, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,application-security', 'strategy-custom-app', 23, NULL, '4');
INSERT INTO `menu` VALUES (25, '2022-11-10 18:57:50', '2022-11-10 18:57:50', 'root,strategy,application-security', 'strategy-spice', 25, NULL, '9');
INSERT INTO `menu` VALUES (26, '2022-05-23 16:58:19', '2022-05-23 16:58:19', 'root,strategy,filter', 'strategy-name-filter', 26, NULL, '1');
INSERT INTO `menu` VALUES (27, '2022-05-23 16:58:19', '2022-05-23 16:58:19', 'root,strategy,filter', 'strategy-suffix-filter', 27, NULL, '2');
INSERT INTO `menu` VALUES (28, '2022-05-23 16:58:19', '2022-05-23 16:58:19', 'root,strategy,filter', 'strategy-type-filter', 28, NULL, '3');
INSERT INTO `menu` VALUES (29, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,object', 'time-config', 39, NULL, NULL);
INSERT INTO `menu` VALUES (30, '2025-01-13 14:57:14', '2025-01-13 14:57:16', 'root,strategy,dse', 'strategy-data-lable', 29, NULL, '1');
INSERT INTO `menu` VALUES (31, '2025-01-13 14:58:49', '2025-01-13 14:58:51', 'root,strategy', 'strategy-data-sign', 30, NULL, '2');
INSERT INTO `menu` VALUES (40, '2022-05-07 16:59:48', '2022-05-07 16:59:48', 'root,isolation,file', 'trans-file', 40, NULL, '1');
INSERT INTO `menu` VALUES (41, '2022-05-07 16:59:47', '2022-05-07 16:59:47', 'root,isolation,file', 'strategy-trfile', 41, NULL, '2');
INSERT INTO `menu` VALUES (42, '2022-05-07 16:59:47', '2022-05-07 16:59:47', 'root,isolation,file', 'single-file', 42, NULL, '3');
INSERT INTO `menu` VALUES (43, '2022-08-16 15:53:45', '2022-08-16 15:53:47', 'root,isolation', 'single-data', 43, NULL, '1');
INSERT INTO `menu` VALUES (44, '2025-02-09 10:38:08', '2025-02-09 10:38:11', 'root,isolation,data', 'double-data', 44, NULL, '1');
INSERT INTO `menu` VALUES (45, '2025-07-15 15:05:50', '2025-07-15 15:05:50', 'root,isolation,data', 'business-group', 45, NULL, '2');
INSERT INTO `menu` VALUES (46, '2022-08-24 15:17:11', '2022-08-24 15:17:13', 'root,isolation,db', 'verify-db', 46, NULL, '1');
INSERT INTO `menu` VALUES (47, '2022-05-07 16:59:48', '2022-05-07 16:59:48', 'root,isolation,db', 'strategy-db', 47, NULL, '2');
INSERT INTO `menu` VALUES (48, '2022-05-07 16:59:48', '2022-05-07 16:59:48', 'root,isolation,db', 'single-db', 48, NULL, '3');
INSERT INTO `menu` VALUES (49, '2025-09-22 10:16:16', '2025-09-22 10:16:16', 'root,audit', 'obtain-evidence', 53, NULL, NULL);
INSERT INTO `menu` VALUES (50, '2022-08-11 15:53:02', '2022-08-11 15:53:04', 'root,audit,synchronous', 'file-statistic', 50, NULL, '1');
INSERT INTO `menu` VALUES (51, '2022-11-21 10:44:35', '2022-11-21 10:44:38', 'root,audit', 'flow-analyse', 52, NULL, NULL);
INSERT INTO `menu` VALUES (52, '2025-02-10 09:42:05', '2025-02-10 09:42:08', 'root,audit,event', 'control-log', 54, NULL, '1');
INSERT INTO `menu` VALUES (53, '2025-02-10 09:42:11', '2025-02-10 09:42:13', 'root,audit,event', 'protection-log', 56, NULL, '3');
INSERT INTO `menu` VALUES (54, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,event', 'review-log', 57, NULL, '4');
INSERT INTO `menu` VALUES (55, '2025-02-10 09:42:17', '2025-02-10 09:42:18', 'root,audit,event', 'isolation-log', 58, NULL, '5');
INSERT INTO `menu` VALUES (56, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,system-log', 'system-login-log', 59, NULL, '1');
INSERT INTO `menu` VALUES (57, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,system-log', 'system-operation-log', 60, NULL, '2');
INSERT INTO `menu` VALUES (58, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,device-log', 'device-login-log', 61, NULL, '1');
INSERT INTO `menu` VALUES (59, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,device-log', 'device-operation-log', 62, NULL, '2');
INSERT INTO `menu` VALUES (60, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit,device-log', 'device-abnormal-log', 63, NULL, '3');
INSERT INTO `menu` VALUES (61, '2022-04-15 16:08:43', '2022-04-15 16:08:43', 'root,audit', 'send-log', 64, NULL, NULL);
INSERT INTO `menu` VALUES (62, '2023-10-09 09:59:35', '2023-10-09 09:59:38', 'root,audit,client-log', 'client-login-log', 65, NULL, '1');
INSERT INTO `menu` VALUES (63, '2023-10-10 11:52:42', '2023-10-10 11:52:44', 'root,audit,client-log', 'client-operation-log', 66, NULL, '2');
INSERT INTO `menu` VALUES (64, '2025-02-21 18:34:46', '2025-02-21 18:34:46', 'root,analysis', 'device-analysis', 70, NULL, NULL);
INSERT INTO `menu` VALUES (65, '2025-02-21 18:34:46', '2025-02-21 18:34:46', 'root,analysis,havior', 'file-analysis', 71, NULL, '1');
INSERT INTO `menu` VALUES (66, '2025-02-21 18:34:46', '2025-02-21 18:34:46', 'root,analysis,havior', 'single-analysis', 72, NULL, '2');
INSERT INTO `menu` VALUES (67, '2025-02-21 18:34:46', '2025-02-21 18:34:46', 'root,analysis,havior', 'double-analysis', 73, NULL, '3');
INSERT INTO `menu` VALUES (68, '2025-08-06 11:44:33', '2025-08-06 11:44:33', 'root,audit,event', 'receive-log', 55, NULL, '2');
INSERT INTO `menu` VALUES (69, '2022-08-24 15:17:45', '2022-08-24 15:17:47', 'root,audit,synchronous', 'db-statistic', 51, NULL, '2');
INSERT INTO `menu` VALUES (70, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,alarm,config', 'alarm-config', 85, NULL, '1');
INSERT INTO `menu` VALUES (71, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,alarm,config', 'alarm-receiver', 86, NULL, '2');
INSERT INTO `menu` VALUES (72, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,alarm', 'alarm-info', 87, NULL, NULL);
INSERT INTO `menu` VALUES (74, '2025-08-25 09:52:17', '2025-08-25 09:52:17', 'root,form,trans-form', 'file-form', 80, NULL, '1');
INSERT INTO `menu` VALUES (75, '2025-08-25 09:52:18', '2025-08-25 09:52:18', 'root,form,trans-form', 'db-form', 81, NULL, '2');
INSERT INTO `menu` VALUES (76, '2025-08-25 09:52:18', '2025-08-25 09:52:18', 'root,form', 'alarm-form', 82, NULL, '1');
INSERT INTO `menu` VALUES (78, '2025-08-06 11:47:54', '2025-08-06 11:47:54', 'root,analysis,havior', 'db-analysis', 74, NULL, '4');
INSERT INTO `menu` VALUES (80, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,entity', 'network-area', 90, NULL, NULL);
INSERT INTO `menu` VALUES (81, '2025-02-08 16:04:42', '2025-02-08 16:04:45', 'root,entity', 'org-structure', 91, NULL, NULL);
INSERT INTO `menu` VALUES (82, '2025-02-08 16:04:58', '2025-02-08 16:05:00', 'root,entity,access-device', 'access-config', 92, NULL, '1');
INSERT INTO `menu` VALUES (83, '2023-10-17 11:28:00', '2023-10-17 11:28:02', 'root,entity', 'client-user', 95, NULL, NULL);
INSERT INTO `menu` VALUES (84, '2025-07-28 14:31:43', '2025-07-28 14:31:43', 'root,entity,access-device', 'access-upgrade', 93, NULL, '2');
INSERT INTO `menu` VALUES (85, '2025-07-28 14:31:44', '2025-07-28 14:31:44', 'root,entity,access-device', 'access-status', 94, NULL, '3');
INSERT INTO `menu` VALUES (90, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'device-basic', 100, NULL, '1');
INSERT INTO `menu` VALUES (91, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'device-net-iface', 101, NULL, '2');
INSERT INTO `menu` VALUES (92, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'device-router', 102, NULL, '3');
INSERT INTO `menu` VALUES (93, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'device-backup', 103, NULL, '4');
INSERT INTO `menu` VALUES (94, '2022-02-14 09:58:20', '2022-02-14 09:58:20', 'root,device', 'device-upgrade', 106, NULL, NULL);
INSERT INTO `menu` VALUES (95, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'border-device-maintenance', 104, NULL, '6');
INSERT INTO `menu` VALUES (96, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'border-device-diagnose-tool', 105, NULL, '8');
INSERT INTO `menu` VALUES (100, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,system', 'user', 110, NULL, NULL);
INSERT INTO `menu` VALUES (101, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,system', 'permission-group', 111, NULL, NULL);
INSERT INTO `menu` VALUES (102, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,system', 'auth-user', 112, NULL, NULL);
INSERT INTO `menu` VALUES (103, '2022-06-14 14:26:35', '2022-06-14 14:26:39', 'root,system,sconfig', 'defaut-config', 113, NULL, '1');
INSERT INTO `menu` VALUES (104, '2022-06-14 14:27:49', '2022-06-14 14:27:52', 'root,auditmng,auditcof', 'email-config', 114, NULL, '1');
INSERT INTO `menu` VALUES (105, '2022-06-14 14:28:27', '2022-06-14 14:28:30', 'root,auditmng,auditcof', 'audit-config', 115, NULL, '2');
INSERT INTO `menu` VALUES (106, '2025-02-10 09:43:01', '2025-02-10 09:43:03', 'root,auditmng,auditcof', 'enable-config', 116, NULL, '3');
INSERT INTO `menu` VALUES (107, '2022-06-14 14:29:16', '2022-06-14 14:29:12', 'root,auditmng,auditcof', 'syslog-config', 117, NULL, '4');
INSERT INTO `menu` VALUES (108, '2022-06-14 14:27:14', '2022-06-14 14:27:17', 'root,system,sconfig', 'password-config', 118, NULL, '6');
INSERT INTO `menu` VALUES (109, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,system', 'sys-info', 119, NULL, NULL);
INSERT INTO `menu` VALUES (110, '2025-09-18 14:59:42', '2025-09-18 14:59:44', 'root,system', 'license-info', 121, NULL, '2');
INSERT INTO `menu` VALUES (201, '2023-10-09 09:59:35', '2023-10-09 09:59:38', 'root,translate', 'jsp-trans-file', 201, NULL, NULL);
INSERT INTO `menu` VALUES (202, '2023-10-10 11:52:42', '2023-10-10 11:52:44', 'root,translate', 'idenify', 202, NULL, NULL);
INSERT INTO `menu` VALUES (203, '2025-01-15 16:42:31', '2025-01-15 16:42:31', 'root,translate', 'xftp-trans-file', 203, NULL, NULL);
INSERT INTO `menu` VALUES (204, '2025-03-06 11:34:54', '2025-03-06 11:34:56', 'root,translate', 'jsp-approval', 204, NULL, NULL);
INSERT INTO `menu` VALUES (205, '2025-03-17 10:09:40', '2025-03-17 10:09:42', 'root,audit', 'event', 205, NULL, NULL);
INSERT INTO `menu` VALUES (206, '2025-07-07 15:11:46', '2025-07-07 15:11:49', 'root,translate,jsp-trans-file', 'details', 206, NULL, NULL);
INSERT INTO `menu` VALUES (207, '2025-12-03 17:21:46', '2025-12-03 17:21:48', 'root,system', 'sysinfo', 207, NULL, NULL);
INSERT INTO `menu` VALUES (211, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,device,border-device', 'border-device-ha', 211, NULL, '4');
INSERT INTO `menu` VALUES (214, '2021-12-23 17:52:35', '2021-12-23 17:52:35', 'root,device', 'border-device-webssh', 214, NULL, NULL);
INSERT INTO `menu` VALUES (215, '2024-05-28 22:48:59', '2024-05-28 22:49:05', 'root,device', 'device-register', 215, NULL, NULL);
INSERT INTO `menu` VALUES (216, '2022-05-07 16:59:48', '2022-05-07 16:59:48', 'root,resource', 'trans-db', 216, NULL, NULL);
INSERT INTO `menu` VALUES (217, '2022-05-07 16:59:47', '2022-05-07 16:59:47', 'root,resource', 'trans-data', 217, NULL, NULL);
INSERT INTO `menu` VALUES (218, '2022-08-24 15:13:52', '2022-08-24 15:13:54', 'root,strategy,application-security', 'strategy-list', 218, NULL, '1');
INSERT INTO `menu` VALUES (219, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,application-security', 'strategy-browse', 219, NULL, '2');
INSERT INTO `menu` VALUES (220, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,application-security', 'strategy-file', 220, NULL, '3');
INSERT INTO `menu` VALUES (221, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,application-security', 'strategy-mail', 221, NULL, '4');
INSERT INTO `menu` VALUES (222, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,strategy,application-security', 'strategy-content-bak', 222, NULL, '6');
INSERT INTO `menu` VALUES (223, '2022-05-27 17:40:49', '2022-05-27 17:40:49', 'root,strategy,application-security', 'strategy-sqlcheck', 223, NULL, '7');
INSERT INTO `menu` VALUES (224, '2022-07-05 10:38:16', '2022-07-05 10:38:16', 'root,strategy,application-security', 'strategy-videocheck', 224, NULL, '8');
INSERT INTO `menu` VALUES (226, '2022-10-10 14:18:20', '2022-10-10 14:18:22', 'root,strategy,security-mark', 'strategy-app-mark', 226, NULL, '3');
INSERT INTO `menu` VALUES (227, '2022-10-10 14:18:53', '2022-10-10 14:18:55', 'root,strategy,security-mark', 'strategy-tag-mark', 227, NULL, '4');
INSERT INTO `menu` VALUES (228, '2025-01-15 16:42:32', '2025-01-15 16:42:32', 'root,strategy,application-security', 'strategy-identify', 228, NULL, '10');
INSERT INTO `menu` VALUES (231, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,business,visit', 'business-visit', 231, NULL, '1');
INSERT INTO `menu` VALUES (232, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,business,visit', 'insulate-channel', 232, NULL, '2');
INSERT INTO `menu` VALUES (233, '2024-06-07 14:54:02', '2024-06-07 14:54:02', 'root,business,visit', 'business-transmission', 233, NULL, '3');
INSERT INTO `menu` VALUES (234, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,business,statistic', 'traffic-situation', 234, NULL, '1');
INSERT INTO `menu` VALUES (235, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,business,statistic', 'device-traffic', 235, NULL, '2');
INSERT INTO `menu` VALUES (236, '2022-08-24 15:15:39', '2022-08-24 15:15:41', 'root,business,statistic', 'session-traffic', 236, NULL, '3');
INSERT INTO `menu` VALUES (238, '2022-08-11 10:32:04', '2022-08-11 10:32:07', 'root,business,verify', 'verify-file', 238, NULL, '1');
INSERT INTO `menu` VALUES (241, '2024-03-15 11:48:35', '2024-03-15 11:48:38', 'root,business', 'analyses-card', 241, NULL, NULL);
INSERT INTO `menu` VALUES (242, '2024-03-15 11:48:35', '2024-03-15 11:48:38', 'root,business', 'analyses-cardtop', 242, NULL, NULL);
INSERT INTO `menu` VALUES (243, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,alarm,config', 'alarm-templete', 243, NULL, '3');
INSERT INTO `menu` VALUES (244, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,audit', 'traffic-log', 244, NULL, NULL);
INSERT INTO `menu` VALUES (245, '2021-09-20 06:51:47', '2021-09-20 06:51:47', 'root,system', 'help', 245, NULL, NULL);
INSERT INTO `menu` VALUES (246, '2025-01-15 16:42:33', '2025-01-15 16:42:33', 'root,system', 'third-user', 246, NULL, NULL);

-- ----------------------------
-- Table structure for mq_message
-- ----------------------------
DROP TABLE IF EXISTS `mq_message`;
CREATE TABLE `mq_message`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `dispatch_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下发批次号',
  `message_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息的UUID',
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '消息内容',
  `module` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块',
  `method` tinyint(4) NOT NULL COMMENT '执行方法:1-GET,2-POST,3-PUT,4-DELETE',
  `source_id` bigint(20) UNSIGNED NOT NULL COMMENT '模块ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息发送者',
  `response_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '消息响应',
  `deal_state` tinyint(4) DEFAULT NULL COMMENT '处理状态：1-成功，0-失败',
  `send_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下发类型',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '状态',
  `ha_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'HA组名称',
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务名称',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备名称',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `strategy_name` varchar(16320) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '策略名称',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '下发消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mq_message_node
-- ----------------------------
DROP TABLE IF EXISTS `mq_message_node`;
CREATE TABLE `mq_message_node`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `busi_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务类型',
  `app_id` bigint(20) UNSIGNED NOT NULL COMMENT '模块ID',
  `from_node` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发送节点',
  `to_node` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接收节点',
  `message_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息的UUID',
  `message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '消息内容',
  `response_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '消息响应',
  `error_msg` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '异常信息',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '状态：已下发，已生效，失败',
  `gmt_create` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'EF节点关联下发配置到相关节点记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for network_area
-- ----------------------------
DROP TABLE IF EXISTS `network_area`;
CREATE TABLE `network_area`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网络域名称',
  `integrity` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '完整性密级',
  `confidentiality` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '机密性密级',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
  `skey` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '安全域密钥',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_network_area_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '网络域' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for network_resource
-- ----------------------------
DROP TABLE IF EXISTS `network_resource`;
CREATE TABLE `network_resource`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `iface_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网口ID',
  `iface_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网口名称',
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `work_mode` tinyint(4) DEFAULT NULL COMMENT '模式：1-独享，2-共享',
  `up_value` int(11) DEFAULT NULL COMMENT '带宽大小',
  `enable` tinyint(1) DEFAULT NULL COMMENT '网络资源空闲时释放',
  `channel_state` tinyint(4) DEFAULT NULL COMMENT '通道状态：1-独享，2-共享',
  `work_state` tinyint(4) DEFAULT NULL COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `deleting` tinyint(4) DEFAULT NULL COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `operation_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `audit_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `gmt_audit` datetime(0) DEFAULT NULL,
  `permission_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `operation_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `module` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `details` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `state` tinyint(1) DEFAULT 1,
  `str_create` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 648 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(212) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `method` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_id` bigint(20) UNSIGNED DEFAULT NULL,
  `readonly` tinyint(1) DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_permission_url_method`(`url`, `method`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 900 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '大屏-详情', '/screen/device-num', 'GET', 1, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (2, '接入控制-基线核查-基线核查设置-修改', '/baseline/base-line-set', 'PUT', 2, NULL, '2025-01-14 16:17:24', '2025-01-14 16:17:24');
INSERT INTO `permission` VALUES (3, '接入控制-基线核查-基线核查设置-详情', '/baseline/base-line-set/*', 'GET', 2, 1, '2025-01-14 16:17:25', '2025-01-14 16:17:25');
INSERT INTO `permission` VALUES (4, '接入控制-基线核查-基线核查设置-查询结果', '/baseline/base-line-sets', 'GET', 2, 1, '2025-01-14 16:17:25', '2025-01-14 16:17:25');
INSERT INTO `permission` VALUES (7, '接入控制-基线核查-基线核查结果-详情', '/baseline/base-line-list/*', 'GET', 3, 1, '2025-01-14 16:17:28', '2025-01-14 16:17:28');
INSERT INTO `permission` VALUES (8, '接入控制-基线核查-基线核查结果-删除', '/baseline/base-line-list/*', 'DELETE', 3, NULL, '2025-01-14 16:17:29', '2025-01-14 16:17:29');
INSERT INTO `permission` VALUES (9, '接入控制-基线核查-基线核查结果-查询结果', '/baseline/base-line-lists', 'GET', 3, 1, '2025-01-14 16:17:29', '2025-01-14 16:17:29');
INSERT INTO `permission` VALUES (10, '接入控制-认证管理-认证服务-新建', '/identity/identity-service', 'POST', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (11, '接入控制-认证管理-认证服务-修改', '/identity/identity-service', 'PUT', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (12, '接入控制-认证管理-认证服务-删除', '/identity/identity-service/*', 'DELETE', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (13, '接入控制-认证管理-认证服务-下发', '/identity/identity-service/dispatch', 'PUT', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (14, '接入控制-认证管理-认证服务-批量导入', '/identity/identity-service/import-data', 'POST', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (15, '接入控制-认证管理-认证服务-批量导出', '/identity/identity-service/export-data', 'GET', 4, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (16, '接入控制-认证管理-认证服务-查询结果', '/identity/identity-services', 'GET', 4, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (19, '接入控制-认证管理-认证用户-查询结果', '/identity/identity-user', 'GET', 5, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (20, '接入控制-认证管理-根证书管理-新建', '/identity/identity-root-cert', 'POST', 6, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (21, '接入控制-认证管理-根证书管理-删除', '/identity/identity-root-cert/*', 'DELETE', 6, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (22, '接入控制-认证管理-根证书管理-下发', '/identity/identity-root-cert/dispatch', 'PUT', 6, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (23, '接入控制-认证管理-根证书管理-移除', '/identity/identity-root-cert/remove/*', 'PUT', 6, NULL, '2021-12-16 11:49:24', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (24, '接入控制-认证管理-根证书管理-查看状态', '/identity/identity-root-cert/state/*', 'GET', 6, 1, '2021-09-20 06:51:47', '2022-04-06 14:43:46');
INSERT INTO `permission` VALUES (25, '接入控制-认证管理-根证书管理-查询结果', '/identity/identity-root-certs', 'GET', 6, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (30, '接入控制-IPMAC绑定-新建', '/device/border-device-ip-mac', 'POST', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (31, '接入控制-IPMAC绑定-修改', '/device/border-device-ip-mac', 'PUT', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (32, '接入控制-IPMAC绑定-详情', '/device/border-device-ip-mac/*', 'GET', 7, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (33, '接入控制-IPMAC绑定-删除', '/device/border-device-ip-mac/*', 'DELETE', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (34, '接入控制-IPMAC绑定-下发', '/device/border-device-ip-mac/send/*', 'PUT', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (35, '接入控制-IPMAC绑定-批量导入', '/device/border-device-ip-mac/import-data', 'POST', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (36, '接入控制-IPMAC绑定-批量导出', '/device/border-device-ip-mac/export-data', 'GET', 7, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (37, '接入控制-IPMAC绑定-查询结果', '/device/border-device-ip-macs', 'GET', 7, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (43, '边界防护-网络访问控制-新建', '/strategy/strategy-acl', 'POST', 10, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (44, '边界防护-网络访问控制-修改', '/strategy/strategy-acl', 'PUT', 10, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (45, '边界防护-网络访问控制-详情', '/strategy/strategy-acl/*', 'GET', 10, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (46, '边界防护-网络访问控制-删除', '/strategy/strategy-acl/*', 'DELETE', 10, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (49, '边界防护-网络访问控制-批量导入', '/strategy/strategy-acl/import-data', 'POST', 10, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (50, '边界防护-网络访问控制-批量导出', '/strategy/strategy-acl/export-data', 'GET', 10, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (51, '边界防护-网络访问控制-查询结果', '/strategy/strategy-acls', 'GET', 10, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (56, '边界防护-入侵检测-入侵检测配置-启用', '/protection/intrusion-config/*', 'PUT', 11, NULL, '2022-08-24 18:25:35', '2022-08-24 18:25:35');
INSERT INTO `permission` VALUES (57, '边界防护-入侵检测-入侵检测配置-配置', '/protection/intrusion-config/config', 'PUT', 11, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (58, '边界防护-入侵检测-入侵检测配置-配置详情', '/protection/intrusion-config/config/*', 'GET', 11, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (59, '边界防护-入侵检测-入侵检测配置-查询结果', '/protection/intrusion-configs', 'GET', 11, NULL, '2025-02-11 14:27:03', '2025-02-11 14:27:03');
INSERT INTO `permission` VALUES (60, '边界防护-入侵检测-入侵检测升级-升级', '/protection/intrusion-upgrade', 'PUT', 12, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (61, '边界防护-入侵检测-入侵检测升级-查询结果', '/protection/intrusion-upgrades', 'GET', 12, 1, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (62, '边界防护-DDoS攻击防护-DDOS启用', '/protection/device-ddos/ddos/*', 'PUT', 13, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (63, '边界防护-DDoS攻击防护-DDOS配置', '/protection/device-ddos/ddos-config', 'PUT', 13, NULL, '2022-08-24 18:25:26', '2022-08-24 18:25:26');
INSERT INTO `permission` VALUES (64, '边界防护-DDoS攻击防护-DDOS配置详情', '/protection/device-ddos/ddos-config/*', 'GUT', 13, 1, '2022-08-24 18:25:32', '2022-08-24 18:25:32');
INSERT INTO `permission` VALUES (65, '边界防护-DDoS攻击防护-查询结果', '/protection/device-ddoses', 'PUT', 13, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (66, '边界防护-病毒防护-升级', '/protection/virus-upgrade', 'PUT', 14, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (67, '边界防护-病毒防护-查询结果', '/protection/virus-upgrades', 'GET', 14, NULL, '2025-02-10 15:18:59', '2025-02-10 15:18:59');
INSERT INTO `permission` VALUES (68, '边界防护-WAF-WAF配置-配置', '/protection/waf-config/config', 'PUT', 15, NULL, '2025-02-13 17:31:35', '2025-02-13 17:31:37');
INSERT INTO `permission` VALUES (69, '边界防护-WAF-WAF配置-查询结果', '/protection/waf-config', 'GET', 15, NULL, '2025-02-13 17:32:20', '2025-02-13 17:32:24');
INSERT INTO `permission` VALUES (70, '边界防护-WAF-WAF升级-升级', '/protection/waf-upgrade', 'PUT', 16, NULL, '2021-11-05 12:07:00', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (71, '边界防护-WAF-WAF升级-查询结果', '/protection/waf-upgrades', 'GET', 16, NULL, '2025-02-10 15:18:59', '2025-02-10 15:18:59');
INSERT INTO `permission` VALUES (73, '数据审核-数据格式检查策略-关键字过滤策略-新建', '/strategy/strategy-trcontent', 'POST', 20, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (74, '数据审核-数据格式检查策略-关键字过滤策略-修改', '/strategy/strategy-trcontent', 'PUT', 20, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (75, '数据审核-数据格式检查策略-关键字过滤策略-详情', '/strategy/strategy-trcontent/*', 'GET', 20, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (76, '数据审核-数据格式检查策略-关键字过滤策略-删除', '/strategy/strategy-trcontent/*', 'DELETE', 20, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (77, '数据审核-数据格式检查策略-关键字过滤策略-批量导入', '/strategy/strategy-trcontent/import-data', 'POST', 20, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (78, '数据审核-数据格式检查策略-关键字过滤策略-批量导出', '/strategy/strategy-trcontent/export-data', 'GET', 20, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (79, '数据审核-数据格式检查策略-关键字过滤策略-查询结果', '/strategy/strategy-trcontents', 'GET', 20, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (80, '数据审核-流量控制策略-新建', '/strategy/strategy-qos', 'POST', 21, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (81, '数据审核-流量控制策略-修改', '/strategy/strategy-qos', 'PUT', 21, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (82, '数据审核-流量控制策略-详情', '/strategy/strategy-qos/*', 'GET', 21, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (83, '数据审核-流量控制策略-删除', '/strategy/strategy-qos/*', 'DELETE', 21, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (84, '数据审核-流量控制策略-批量导入', '/strategy/strategy-qos/import-data', 'POST', 21, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (85, '数据审核-流量控制策略-批量导出', '/strategy/strategy-qos/export-data', 'GET', 21, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (86, '数据审核-流量控制策略-查询结果', '/strategy/strategy-qoses', 'GET', 21, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (90, '数据审核-安全标记策略-域间标记策略-新建', '/strategy/strategy-area-mark', 'POST', 22, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (91, '数据审核-安全标记策略-域间标记策略-修改', '/strategy/strategy-area-mark', 'PUT', 22, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (92, '数据审核-安全标记策略-域间标记策略-详情', '/strategy/strategy-area-mark/*', 'GET', 22, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (93, '数据审核-安全标记策略-域间标记策略-删除', '/strategy/strategy-area-mark/*', 'DELETE', 22, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (94, '数据审核-安全标记策略-域间标记策略-批量导入', '/strategy/strategy-area-mark/import-data', 'POST', 22, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (95, '数据审核-安全标记策略-域间标记策略-批量导出', '/strategy/strategy-area-mark/export-data', 'GET', 22, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (96, '数据审核-安全标记策略-域间标记策略-查询结果', '/strategy/strategy-area-marks', 'GET', 22, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (100, '数据审核-安全标记策略-标记-新建', '/strategy/strategy-mark', 'POST', 23, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (101, '数据审核-安全标记策略-标记-修改', '/strategy/strategy-mark', 'PUT', 23, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (102, '数据审核-安全标记策略-标记-详情', '/strategy/strategy-mark/*', 'GET', 23, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (103, '数据审核-安全标记策略-标记-删除', '/strategy/strategy-mark/*', 'DELETE', 23, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (104, '数据审核-安全标记策略-标记-批量导入', '/strategy/strategy-mark/import-data', 'POST', 23, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (105, '数据审核-安全标记策略-标记-批量导出', '/strategy/strategy-mark/export-data', 'GET', 23, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (106, '数据审核-安全标记策略-标记-查询结果', '/strategy/strategy-marks', 'GET', 23, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (110, '数据审核-数据格式检查策略-自定义协议检查策略-新建', '/strategy/strategy-custom-app', 'POST', 24, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (111, '数据审核-数据格式检查策略-自定义协议检查策略-修改', '/strategy/strategy-custom-app', 'PUT', 24, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (112, '数据审核-数据格式检查策略-自定义协议检查策略-详情', '/strategy/strategy-custom-app/*', 'GET', 24, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (113, '数据审核-数据格式检查策略-自定义协议检查策略-删除', '/strategy/strategy-custom-app/*', 'DELETE', 24, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (114, '数据审核-数据格式检查策略-自定义协议检查策略-删除规则', '/strategy/strategy-custom-app/del-command/*', 'DELETE', 24, NULL, '2021-11-22 19:32:58', '2021-11-24 11:23:08');
INSERT INTO `permission` VALUES (115, '数据审核-数据格式检查策略-自定义协议检查策略-批量导入', '/strategy/strategy-custom-app/import-data', 'POST', 24, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (116, '数据审核-数据格式检查策略-自定义协议检查策略-批量导出', '/strategy/strategy-custom-app/export-data', 'GET', 24, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (117, '数据审核-数据格式检查策略-自定义协议检查策略-查询结果', '/strategy/strategy-custom-apps', 'GET', 24, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (120, '数据审核-应用安全策略-虚拟桌面协议过滤策略-新建', '/strategy/strategy-spice', 'POST', 25, NULL, '2022-11-10 18:57:52', '2022-11-10 18:57:52');
INSERT INTO `permission` VALUES (121, '数据审核-应用安全策略-虚拟桌面协议过滤策略-修改', '/strategy/strategy-spice', 'PUT', 25, NULL, '2022-11-10 18:57:54', '2022-11-10 18:57:54');
INSERT INTO `permission` VALUES (122, '数据审核-应用安全策略-虚拟桌面协议过滤策略-详情', '/strategy/strategy-spice/*', 'GET', 25, 1, '2022-11-10 18:57:56', '2022-11-10 18:57:56');
INSERT INTO `permission` VALUES (123, '数据审核-应用安全策略-虚拟桌面协议过滤策略-删除', '/strategy/strategy-spice/*', 'DELETE', 25, NULL, '2022-11-10 18:57:59', '2022-11-10 18:57:59');
INSERT INTO `permission` VALUES (124, '数据审核-应用安全策略-虚拟桌面协议过滤策略-批量导入', '/strategy/strategy-spice/import-data', 'POST', 25, NULL, '2022-11-10 18:58:01', '2022-11-10 18:58:01');
INSERT INTO `permission` VALUES (125, '数据审核-应用安全策略-虚拟桌面协议过滤策略-批量导出', '/strategy/strategy-spice/export-data', 'GET', 25, NULL, '2022-11-10 18:58:03', '2022-11-10 18:58:03');
INSERT INTO `permission` VALUES (126, '数据审核-应用安全策略-虚拟桌面协议过滤策略-查询结果', '/strategy/strategy-spices', 'GET', 25, 1, '2022-11-10 18:58:05', '2022-11-10 18:58:05');
INSERT INTO `permission` VALUES (130, '数据审核-文件过滤策略-文件名称过滤策略-新建', '/strategy/strategy-name-filter', 'POST', 26, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (131, '数据审核-文件过滤策略-文件名称过滤策略-修改', '/strategy/strategy-name-filter', 'PUT', 26, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (132, '数据审核-文件过滤策略-文件名称过滤策略-详情', '/strategy/strategy-name-filter/*', 'GET', 26, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (133, '数据审核-文件过滤策略-文件名称过滤策略-删除', '/strategy/strategy-name-filter/*', 'DELETE', 26, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (134, '数据审核-文件过滤策略-文件名称过滤策略-批量导入', '/strategy/strategy-name-filter/import-data', 'POST', 26, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (135, '数据审核-文件过滤策略-文件名称过滤策略-批量导出', '/strategy/strategy-name-filter/export-data', 'GET', 26, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (136, '数据审核-文件过滤策略-文件名称过滤策略-查询结果', '/strategy/strategy-name-filters', 'GET', 26, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (140, '数据审核-文件过滤策略-文件后缀名过滤策略-新建', '/strategy/strategy-suffix-filter', 'POST', 27, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (141, '数据审核-文件过滤策略-文件后缀名过滤策略-修改', '/strategy/strategy-suffix-filter', 'PUT', 27, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (142, '数据审核-文件过滤策略-文件后缀名过滤策略-详情', '/strategy/strategy-suffix-filter/*', 'GET', 27, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (143, '数据审核-文件过滤策略-文件后缀名过滤策略-删除', '/strategy/strategy-suffix-filter/*', 'DELETE', 27, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (144, '数据审核-文件过滤策略-文件后缀名过滤策略-批量导入', '/strategy/strategy-suffix-filter/import-data', 'POST', 27, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (145, '数据审核-文件过滤策略-文件后缀名过滤策略-批量导出', '/strategy/strategy-suffix-filter/export-data', 'GET', 27, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (146, '数据审核-文件过滤策略-文件后缀名过滤策略-查询结果', '/strategy/strategy-suffix-filters', 'GET', 27, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (150, '数据审核-文件过滤策略-文件类型过滤策略-新建', '/strategy/strategy-type-filter', 'POST', 28, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (151, '数据审核-文件过滤策略-文件类型过滤策略-修改', '/strategy/strategy-type-filter', 'PUT', 28, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (152, '数据审核-文件过滤策略-文件类型过滤策略-详情', '/strategy/strategy-type-filter/*', 'GET', 28, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (153, '数据审核-文件过滤策略-文件类型过滤策略-删除', '/strategy/strategy-type-filter/*', 'DELETE', 28, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (154, '数据审核-文件过滤策略-文件类型过滤策略-批量导入', '/strategy/strategy-type-filter/import-data', 'POST', 28, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (155, '数据审核-文件过滤策略-文件类型过滤策略-批量导出', '/strategy/strategy-type-filter/export-data', 'GET', 28, NULL, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (156, '数据审核-文件过滤策略-文件类型过滤策略-查询结果', '/strategy/strategy-type-filters', 'GET', 28, 1, '2022-05-23 16:58:19', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (160, '对象管理-时间对象-新建', '/time-config/config', 'POST', 29, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (161, '对象管理-时间对象-修改', '/time-config/config', 'PUT', 29, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (162, '对象管理-时间对象-详情', '/time-config/config/*', 'GET', 29, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (163, '对象管理-时间对象-删除', '/time-config/config/*', 'DELETE', 29, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (164, '对象管理-时间对象-查询结果', '/time-config/configs', 'GET', 29, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (170, '隔离交换-单向文件同步-文件资源配置-新建', '/trans-file/trans-file', 'POST', 40, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (171, '隔离交换-单向文件同步-文件资源配置-修改', '/trans-file/trans-file', 'PUT', 40, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (172, '隔离交换-单向文件同步-文件资源配置-详情', '/trans-file/trans-file/*', 'GET', 40, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (173, '隔离交换-单向文件同步-文件资源配置-删除', '/trans-file/trans-file/*', 'DELETE', 40, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (174, '隔离交换-单向文件同步-文件资源配置-批量导入', '/trans-file/trans-file/import-data', 'POST', 40, NULL, '2022-05-10 14:46:29', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (175, '隔离交换-单向文件同步-文件资源配置-批量导出', '/trans-file/trans-file/export-data', 'GET', 40, NULL, '2022-05-10 14:46:29', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (176, '隔离交换-单向文件同步-文件资源配置-查询结果', '/trans-file/trans-files', 'GET', 40, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (180, '隔离交换-单向文件同步-文件同步策略-新建', '/strategy/strategy-trfile', 'POST', 41, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (181, '隔离交换-单向文件同步-文件同步策略-修改', '/strategy/strategy-trfile', 'PUT', 41, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (182, '隔离交换-单向文件同步-文件同步策略-详情', '/strategy/strategy-trfile/*', 'GET', 41, 1, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (183, '隔离交换-单向文件同步-文件同步策略-删除', '/strategy/strategy-trfile/*', 'DELETE', 41, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (184, '隔离交换-单向文件同步-文件同步策略-批量导入', '/strategy/strategy-trfile/import-data', 'POST', 41, NULL, '2022-05-17 16:17:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (185, '隔离交换-单向文件同步-文件同步策略-批量导出', '/strategy/strategy-trfile/export-data', 'GET', 41, NULL, '2022-05-17 16:17:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (186, '隔离交换-单向文件同步-文件同步策略-查询结果', '/strategy/strategy-trfiles', 'GET', 41, 1, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (190, '隔离交换-单向文件同步-新建', '/single-file/single-file', 'POST', 42, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (191, '隔离交换-单向文件同步-修改', '/single-file/single-file', 'PUT', 42, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (192, '隔离交换-单向文件同步-详情', '/single-file/single-file/*', 'GET', 42, 1, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (193, '隔离交换-单向文件同步-删除', '/single-file/single-file/*', 'DELETE', 42, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (194, '隔离交换-单向文件同步-下发', '/single-file/single-file/send/*', 'PUT', 42, NULL, '2022-08-24 18:30:08', '2022-08-24 18:30:08');
INSERT INTO `permission` VALUES (195, '隔离交换-单向文件同步-移除', '/single-file/single-file/remove/*', 'PUT', 42, NULL, '2022-08-24 18:30:13', '2022-08-24 18:30:13');
INSERT INTO `permission` VALUES (196, '隔离交换-单向文件同步-业务测试', '/single-file/single-file/status/*', 'GUT', 42, NULL, '2022-08-24 18:30:16', '2022-08-24 18:30:16');
INSERT INTO `permission` VALUES (197, '隔离交换-单向文件同步-手动同步', '/single-file/single-file/sync/*', 'PUT', 42, NULL, '2022-08-25 10:48:50', '2022-08-25 10:48:50');
INSERT INTO `permission` VALUES (198, '隔离交换-单向文件同步-查询结果', '/single-file/single-files', 'GET', 42, 1, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (210, '隔离交换-单向数据导入-新建', '/single-data/single-data', 'POST', 43, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (211, '隔离交换-单向数据导入-修改', '/single-data/single-data', 'PUT', 43, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (212, '隔离交换-单向数据导入-详情', '/single-data/single-data/*', 'GET', 43, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (213, '隔离交换-单向数据导入-删除', '/single-data/single-data/*', 'DELETE', 43, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (214, '隔离交换-单向数据导入-下发', '/single-data/single-data/send/*', 'PUT', 43, NULL, '2022-08-25 10:21:08', '2022-08-25 10:21:08');
INSERT INTO `permission` VALUES (215, '隔离交换-单向数据导入-移除', '/single-data/single-data/remove/*', 'PUT', 43, NULL, '2022-08-25 10:21:16', '2022-08-25 10:21:16');
INSERT INTO `permission` VALUES (216, '隔离交换-单向数据导入-查询结果', '/single-data/single-datas', 'GET', 43, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (230, '隔离交换-双单向数据交换-服务配置-新建', '/double-data/double-data', 'POST', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (231, '隔离交换-双单向数据交换-服务配置-修改', '/double-data/double-data', 'PUT', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (232, '隔离交换-双单向数据交换-服务配置-详情', '/double-data/double-data/*', 'GET', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (233, '隔离交换-双单向数据交换-服务配置-删除', '/double-data/double-data/*', 'DELETE', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (234, '隔离交换-双单向数据交换-服务配置-下发', '/double-data/double-data/send/*', 'PUT', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (235, '隔离交换-双单向数据交换-服务配置-移除', '/double-data/double-data/remove/*', 'PUT', 44, NULL, '2025-02-10 15:17:02', '2025-02-10 15:17:02');
INSERT INTO `permission` VALUES (236, '隔离交换-双单向数据交换-服务配置-查询结果', '/double-data/double-datas', 'GET', 44, NULL, '2025-02-09 10:39:27', '2025-02-09 10:39:31');
INSERT INTO `permission` VALUES (240, '隔离交换-双单向数据交换-业务管理-新建', '/business/business-group', 'POST', 45, NULL, '2025-07-15 15:03:29', '2025-07-15 15:03:29');
INSERT INTO `permission` VALUES (241, '隔离交换-双单向数据交换-业务管理-修改', '/business/business-group', 'PUT', 45, NULL, '2025-07-15 15:03:29', '2025-07-15 15:03:29');
INSERT INTO `permission` VALUES (242, '隔离交换-双单向数据交换-业务管理-详情', '/business/business-group/*', 'GET', 45, 1, '2025-07-15 15:03:30', '2025-07-15 15:03:30');
INSERT INTO `permission` VALUES (243, '隔离交换-双单向数据交换-业务管理-删除', '/business/business-group/*', 'DELETE', 45, NULL, '2025-07-15 15:03:30', '2025-07-15 15:03:30');
INSERT INTO `permission` VALUES (244, '隔离交换-双单向数据交换-业务管理-批量导入', '/business/business-group/import-data', 'POST', 45, NULL, '2025-07-15 15:03:31', '2025-07-15 15:03:31');
INSERT INTO `permission` VALUES (245, '隔离交换-双单向数据交换-业务管理-批量导出', '/business/business-group/export-data', 'GET', 45, NULL, '2025-07-15 15:03:31', '2025-07-15 15:03:31');
INSERT INTO `permission` VALUES (246, '隔离交换-双单向数据交换-业务管理-查询结果', '/business/business-groups', 'GET', 45, 1, '2025-07-15 15:03:32', '2025-07-15 15:03:32');
INSERT INTO `permission` VALUES (250, '审计分析-单向同步统计-文件同步统计-详情', '/file-statistic/file-statistic', 'GET', 50, 1, '2022-08-25 10:23:55', '2022-08-25 10:23:55');
INSERT INTO `permission` VALUES (251, '审计分析-单向同步统计-文件同步统计-文件重传', '/file-statistic/file-statistic/retransmit', 'PUT', 50, NULL, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (252, '审计分析-单向同步统计-文件同步统计-导入校验', '/file-statistic/file-statistic/import-verify', 'POST', 50, NULL, '2022-08-25 10:24:01', '2022-08-25 10:24:01');
INSERT INTO `permission` VALUES (253, '审计分析-单向同步统计-文件同步统计-导出校验', '/file-statistic/file-statistic/export-verify', 'GET', 50, NULL, '2022-08-25 10:24:04', '2022-08-25 10:24:04');
INSERT INTO `permission` VALUES (254, '审计分析-单向同步统计-文件同步统计-批量导出', '/file-statistic/file-statistic/export-data', 'GET', 50, 1, '2022-08-11 10:33:41', '2022-08-11 10:33:44');
INSERT INTO `permission` VALUES (255, '审计分析-单向同步统计-文件同步统计-查询结果', '/file-statistic/file-statistics', 'GET', 50, 1, '2022-08-25 10:23:55', '2022-08-25 10:23:55');
INSERT INTO `permission` VALUES (259, '审计分析-流量分析-查询结果', '/flow-analyse/analyses', 'GET', 51, 1, '2022-11-21 10:47:09', '2022-11-21 10:47:13');
INSERT INTO `permission` VALUES (260, '审计分析-事件日志-接入控制-详情', '/control-log/log', 'GET', 52, NULL, '2025-02-10 14:43:19', '2025-02-10 14:43:22');
INSERT INTO `permission` VALUES (261, '审计分析-事件日志-接入控制-批量导出', '/control-log/export-data', 'GET', 52, NULL, '2025-02-10 14:44:07', '2025-02-10 14:44:10');
INSERT INTO `permission` VALUES (262, '审计分析-事件日志-接入控制-查询结果', '/control-log/logs', 'GET', 52, NULL, '2025-02-10 14:44:11', '2025-02-10 14:44:15');
INSERT INTO `permission` VALUES (265, '审计分析-事件日志-边界防护-详情', '/protection-log/log', 'GET', 53, NULL, '2025-02-10 14:49:14', '2025-02-10 14:49:18');
INSERT INTO `permission` VALUES (266, '审计分析-事件日志-边界防护-批量导出', '/protection-log/export-data', 'GET', 53, NULL, '2025-02-10 14:49:20', '2025-02-10 14:49:22');
INSERT INTO `permission` VALUES (267, '审计分析-事件日志-边界防护-查询结果', '/protection-log/logs', 'GET', 53, NULL, '2025-02-10 14:49:23', '2025-02-10 14:49:25');
INSERT INTO `permission` VALUES (270, '审计分析-事件日志-数据审核-详情', '/review-log/log', 'GET', 54, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (271, '审计分析-事件日志-数据审核-批量导出', '/review-log/export-data', 'GET', 54, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (272, '审计分析-事件日志-数据审核-查询结果', '/review-log/logs', 'GET', 54, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (275, '审计分析-事件日志-隔离交换-详情', '/isolation-log/log', 'GET', 55, NULL, '2025-02-10 14:49:27', '2025-02-10 14:49:29');
INSERT INTO `permission` VALUES (276, '审计分析-事件日志-隔离交换-批量导出', '/isolation-log/export-data', 'GET', 55, NULL, '2025-02-10 14:49:30', '2025-02-10 14:49:32');
INSERT INTO `permission` VALUES (277, '审计分析-事件日志-隔离交换-查询结果', '/isolation-log/logs', 'GET', 55, NULL, '2025-02-10 14:49:34', '2025-02-10 14:49:35');
INSERT INTO `permission` VALUES (280, '审计分析-系统日志-登录日志-详情', '/system-login-log/log/*', 'GET', 56, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (281, '审计分析-系统日志-登录日志-批量导出', '/system-login-log/export-data', 'GET', 56, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (282, '审计分析-系统日志-登录日志-查询结果', '/system-login-log/logs', 'GET', 56, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (285, '审计分析-系统日志-操作日志-详情', '/system-operation-log/log/*', 'GET', 57, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (286, '审计分析-系统日志-操作日志-批量导出', '/system-operation-log/export-data', 'GET', 57, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (287, '审计分析-系统日志-操作日志-查询结果', '/system-operation-log/logs', 'GET', 57, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (290, '审计分析-设备日志-登录日志-详情', '/device-login-log/log', 'GET', 58, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (291, '审计分析-设备日志-登录日志-批量导出', '/device-login-log/export-data', 'GET', 58, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (292, '审计分析-设备日志-登录日志-查询结果', '/device-login-log/logs', 'GET', 58, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (295, '审计分析-设备日志-操作日志-详情', '/device-operation-log/log', 'GET', 59, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (296, '审计分析-设备日志-操作日志-批量导出', '/device-operation-log/export-data', 'GET', 59, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (297, '审计分析-设备日志-操作日志-查询结果', '/device-operation-log/logs', 'GET', 59, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (300, '审计分析-设备日志-异常日志-详情', '/device-abnormal-log/log', 'GET', 60, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (301, '审计分析-设备日志-异常日志-批量导出', '/device-abnormal-log/export-data', 'GET', 60, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (302, '审计分析-设备日志-异常日志-查询结果', '/device-abnormal-log/logs', 'GET', 60, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (305, '审计分析-下发日志-详情', '/send-log/log/*', 'GET', 61, 1, '2022-04-15 16:08:43', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (306, '审计分析-下发日志-批量导出', '/send-log/export-data', 'GUT', 61, NULL, '2022-08-25 10:29:00', '2022-08-25 10:29:00');
INSERT INTO `permission` VALUES (307, '审计分析-下发日志-查询结果', '/send-log/logs', 'GET', 61, 1, '2022-04-15 16:08:43', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (310, '审计分析-客户端日志-登录日志-详情', '/client-login-log/log/*', 'GET', 62, 1, '2023-10-09 10:03:34', '2023-10-09 10:03:37');
INSERT INTO `permission` VALUES (311, '审计分析-客户端日志-登录日志-批量导出', '/client-login-log/export-data', 'GET', 62, NULL, '2023-10-10 10:34:18', '2023-10-10 10:34:20');
INSERT INTO `permission` VALUES (312, '审计分析-客户端日志-登录日志-查询结果', '/client-login-log/logs', 'GET', 62, 1, '2023-10-09 10:03:34', '2023-10-09 10:03:37');
INSERT INTO `permission` VALUES (315, '审计分析-客户端日志-操作日志-详情', '/client-operation-log/log/*', 'GET', 63, 1, '2023-10-10 10:34:18', '2023-10-10 10:34:20');
INSERT INTO `permission` VALUES (316, '审计分析-客户端日志-操作日志-批量导出', '/client-operation-log/export-data', 'GET', 63, NULL, '2023-10-09 10:03:34', '2023-10-09 10:03:37');
INSERT INTO `permission` VALUES (317, '审计分析-客户端日志-操作日志-查询结果', '/client-operation-log/logs', 'GET', 63, 1, '2023-10-10 10:34:18', '2023-10-10 10:34:20');
INSERT INTO `permission` VALUES (320, '告警中心-告警策略配置-告警策略配置-新建', '/alarm-config/config', 'POST', 70, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (321, '告警中心-告警策略配置-告警策略配置-修改', '/alarm-config/config/*', 'PUT', 70, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (322, '告警中心-告警策略配置-告警策略配置-详情', '/alarm-config/config/*', 'GET', 70, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (323, '告警中心-告警策略配置-告警策略配置-删除', '/alarm-config/config/*', 'DELETE', 70, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (324, '告警中心-告警策略配置-告警策略配置-批量导入', '/alarm-config/import-data', 'POST', 70, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (325, '告警中心-告警策略配置-告警策略配置-批量导出', '/alarm-config/export-data', 'GET', 70, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (326, '告警中心-告警策略配置-告警策略配置-查询结果', '/alarm-config/configs', 'GET', 70, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (328, '告警中心-告警策略配置-告警接收人-新建', '/alarm-receiver/receiver', 'POST', 71, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (329, '告警中心-告警策略配置-告警接收人-修改', '/alarm-receiver/receiver/*', 'PUT', 71, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (330, '告警中心-告警策略配置-告警接收人-详情', '/alarm-receiver/receiver/*', 'GET', 71, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (331, '告警中心-告警策略配置-告警接收人-删除', '/alarm-receiver/receiver/*', 'DELETE', 71, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (332, '告警中心-告警策略配置-告警接收人-批量导入', '/alarm-receiver/import-data', 'POST', 71, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (333, '告警中心-告警策略配置-告警接收人-批量导出', '/alarm-receiver/export-data', 'GET', 71, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (334, '告警中心-告警策略配置-告警接收人-查询结果', '/alarm-receiver/receivers', 'GET', 71, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (335, '告警中心-告警信息-详情', '/alarm-info/info/*', 'GET', 72, 1, '2021-09-20 06:51:47', '2021-11-09 16:16:57');
INSERT INTO `permission` VALUES (336, '告警中心-告警信息-批量导出', '/alarm-info/export-data', 'GET', 72, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (337, '告警中心-告警信息-查询结果', '/alarm-info/infos', 'GET', 72, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (340, '实体管理-网络域管理-新建', '/network/network-area', 'POST', 80, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (341, '实体管理-网络域管理-修改', '/network/network-area', 'PUT', 80, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (342, '实体管理-网络域管理-详情', '/network/network-area/*', 'GET', 80, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (343, '实体管理-网络域管理-删除', '/network/network-area/*', 'DELETE', 80, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (344, '实体管理-网络域管理-批量导入', '/network/network-area/import-data', 'POST', 80, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (345, '实体管理-网络域管理-批量导出', '/network/network-area/export-data', 'GET', 80, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (346, '实体管理-网络域管理-查询结果', '/network/network-areas', 'GET', 80, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (350, '实体管理-组织架构管理-新建', '/entity/org-structure', 'POST', 81, NULL, '2025-02-10 15:17:09', '2025-02-10 15:17:09');
INSERT INTO `permission` VALUES (351, '实体管理-组织架构管理-修改', '/entity/org-structure', 'PUT', 81, NULL, '2025-02-10 15:17:10', '2025-02-10 15:17:10');
INSERT INTO `permission` VALUES (352, '实体管理-组织架构管理-详情', '/entity/org-structure/*', 'GET', 81, NULL, '2025-02-10 15:17:10', '2025-02-10 15:17:10');
INSERT INTO `permission` VALUES (353, '实体管理-组织架构管理-删除', '/entity/org-structure/*', 'DELETE', 81, NULL, '2025-02-10 15:17:10', '2025-02-10 15:17:10');
INSERT INTO `permission` VALUES (354, '实体管理-组织架构管理-批量导入', '/entity/org-structure/import-data', 'POST', 81, NULL, '2025-02-10 15:17:10', '2025-02-10 15:17:10');
INSERT INTO `permission` VALUES (355, '实体管理-组织架构管理-批量导出', '/entity/org-structure/export-data', 'GET', 81, NULL, '2025-02-10 15:17:10', '2025-02-10 15:17:10');
INSERT INTO `permission` VALUES (356, '实体管理-组织架构管理-查询结果', '/entity/org-structures', 'GET', 81, NULL, '2025-02-08 16:08:36', '2025-02-08 16:08:40');
INSERT INTO `permission` VALUES (360, '实体管理-信息交换设备管理-配置-新建', '/entity/access-device', 'POST', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (361, '实体管理-信息交换设备管理-配置-修改', '/entity/access-device', 'PUT', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (362, '实体管理-信息交换设备管理-配置-详情', '/entity/access-device/*', 'GET', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (363, '实体管理-信息交换设备管理-配置-删除', '/entity/access-device/*', 'DELETE', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (364, '实体管理-信息交换设备管理-配置-下发', '/entity/access-device/import-data', 'POST', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (365, '实体管理-信息交换设备管理-配置-移除', '/entity/access-device/export-data', 'GET', 82, NULL, '2025-02-10 15:17:12', '2025-02-10 15:17:12');
INSERT INTO `permission` VALUES (366, '实体管理-信息交换设备管理-配置-查询结果', '/entity/access-devices', 'GET', 82, NULL, '2025-02-08 16:09:40', '2025-02-08 16:09:45');
INSERT INTO `permission` VALUES (367, '实体管理-信息交换设备管理-升级-查询结果', '/entity/access-upgrade', 'GET', 84, NULL, '2025-07-28 14:32:09', '2025-07-28 14:32:09');
INSERT INTO `permission` VALUES (368, '实体管理-信息交换设备管理-状态-查询结果', '/entity/access-status', 'GET', 85, NULL, '2025-07-28 14:32:10', '2025-07-28 14:32:10');
INSERT INTO `permission` VALUES (370, '实体管理-信息交换用户管理-新建', '/client/system/user', 'POST', 83, NULL, '2025-01-15 16:52:21', '2025-01-15 16:52:21');
INSERT INTO `permission` VALUES (371, '实体管理-信息交换用户管理-详情', '/client/system/user/*', 'GET', 83, 1, '2025-01-15 16:52:22', '2025-01-15 16:52:22');
INSERT INTO `permission` VALUES (372, '实体管理-信息交换用户管理-删除', '/client/system/user/*', 'DELETE', 83, NULL, '2025-01-15 16:52:23', '2025-01-15 16:52:23');
INSERT INTO `permission` VALUES (373, '实体管理-信息交换用户管理-重置密码', '/client/system/user/reset', 'PUT', 83, NULL, '2025-01-15 16:52:24', '2025-01-15 16:52:24');
INSERT INTO `permission` VALUES (374, '实体管理-信息交换用户管理-解锁', '/client/system/user/unlock', 'PUT', 83, NULL, '2025-01-15 16:52:26', '2025-01-15 16:52:26');
INSERT INTO `permission` VALUES (375, '实体管理-信息交换用户管理-下线', '/client/system/user/unlogin', 'PUT', 83, NULL, '2025-01-15 16:52:27', '2025-01-15 16:52:27');
INSERT INTO `permission` VALUES (376, '实体管理-信息交换用户管理-查询结果', '/client/system/users', 'GET', 83, 1, '2025-01-15 16:52:28', '2025-01-15 16:52:28');
INSERT INTO `permission` VALUES (380, '设备管理-边界设备-基本配置-新建', '/device/border-device-basic', 'POST', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (381, '设备管理-边界设备-基本配置-修改', '/device/border-device-basic', 'PUT', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (382, '设备管理-边界设备-基本配置-详情', '/device/border-device-basic/*', 'GET', 90, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (383, '设备管理-边界设备-基本配置-删除', '/device/border-device-basic/*', 'DELETE', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (384, '设备管理-边界设备-基本配置-批量导入', '/device/border-device-basic/import-data', 'POST', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (385, '设备管理-边界设备-基本配置-批量导出', '/device/border-device-basic/export-data', 'GET', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (386, '设备管理-边界设备-基本配置-查询结果', '/device/border-device-basics', 'GET', 90, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (387, '设备管理-边界设备-基本配置-时间配置', '/device/border-device-basic/time-config', 'PUT', 90, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (388, '设备管理-边界设备-基本配置-设备状态', '/device/border-device-basic-state/*', 'GET', 90, 1, '2021-09-26 10:56:39', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (389, '设备管理-边界设备-基本配置-恢复出厂设置', '/device/border-device-basic/recover/*', 'PUT', 90, NULL, '2021-12-07 16:28:29', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (390, '设备管理-边界设备-基本配置-快转开关启用', '/device/border-device-basic/fastpath/*', 'PUT', 90, NULL, '2022-02-16 11:03:26', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (395, '设备管理-边界设备-网络接口-新建', '/device/border-device-net-iface', 'POST', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (396, '设备管理-边界设备-网络接口-修改', '/device/border-device-net-iface', 'PUT', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (397, '设备管理-边界设备-网络接口-删除', '/device/border-device-net-iface/*', 'DELETE', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (398, '设备管理-边界设备-网络接口-启用和禁用', '/device/border-device-net-iface/enable/*', 'PUT', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (399, '设备管理-边界设备-网络接口-下发', '/device/border-device-net-iface/dispatch/*', 'PUT', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (400, '设备管理-边界设备-网络接口-重新下发', '/device/border-device-net-iface/redispatch/*', 'PUT', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (401, '设备管理-边界设备-网络接口-查询结果', '/device/border-device-net-ifaces', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (402, '设备管理-边界设备-网络接口-接口布局', '/device/border-device-net-iface/layout', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (403, '设备管理-边界设备-网络接口-物理接口', '/device/border-device-net-iface/raws', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (404, '设备管理-边界设备-网络接口-VLAN', '/device/border-device-net-iface/vlans', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (405, '设备管理-边界设备-网络接口-BOND', '/device/border-device-net-iface/bonds', 'GET', 91, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (406, '设备管理-边界设备-网络接口-物理接口状态', '/device/border-device-net-iface/state/raw/*', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (407, '设备管理-边界设备-网络接口-VLAN状态', '/device/border-device-net-iface/state/vlan/*', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (408, '设备管理-边界设备-网络接口-BOND状态', '/device/border-device-net-iface/state/bond/*', 'GET', 91, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (409, '设备管理-边界设备-网络接口-速率统计', '/device/border-device-net-iface/speed', 'GET', 91, 1, '2022-01-13 11:49:36', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (410, '设备管理-边界设备-网关配置-新建', '/device/border-device-router', 'POST', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (411, '设备管理-边界设备-网关配置-修改', '/device/border-device-router', 'PUT', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (412, '设备管理-边界设备-网关配置-详情', '/device/border-device-router/*', 'GET', 92, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (413, '设备管理-边界设备-网关配置-删除', '/device/border-device-router/*', 'DELETE', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (414, '设备管理-边界设备-网关配置-下发', '/device/border-device-router/send/*', 'PUT', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (415, '设备管理-边界设备-网关配置-批量下发', '/device/border-device-router/send-more/*', 'PUT', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (416, '设备管理-边界设备-网关配置-批量导入', '/device/border-device-router/import-data', 'POST', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (417, '设备管理-边界设备-网关配置-批量导出', '/device/border-device-router/export-data', 'GET', 92, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (418, '设备管理-边界设备-网关配置-查询结果', '/device/border-device-routers', 'GET', 92, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (420, '设备管理-边界设备-配置备份-新建', '/device/border-device-backup', 'POST', 93, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (421, '设备管理-边界设备-配置备份-删除', '/device/border-device-backup/*', 'DELETE', 93, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (422, '设备管理-边界设备-配置备份-下载', '/device/border-device-backup/download/*', 'GET', 93, NULL, '2021-12-08 11:35:09', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (423, '设备管理-边界设备-配置备份-还原备份', '/device/border-device-backup/restore', 'POST', 93, NULL, '2021-12-08 16:14:18', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (424, '设备管理-边界设备-配置备份-还原记录备份', '/device/border-device-backup/note/restore/*', 'POST', 93, NULL, '2021-12-09 15:34:38', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (425, '设备管理-边界设备-配置备份-备份记录查询结果', '/device/border-device-backup/notes', 'GET', 93, 1, '2021-12-07 09:31:39', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (426, '设备管理-边界设备-配置备份-查询结果', '/device/border-device-backups', 'GET', 93, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (427, '设备管理-边界设备-配置备份-还原进度信息', '/device/border-device-backup/getRestoreInfo/*', 'GET', 93, NULL, '2021-12-10 14:36:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (428, '设备管理-边界设备-配置备份-用户确认', '/device/border-device-backup/userConfirm', 'POST', 93, NULL, '2021-12-12 14:19:03', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (430, '设备管理-设备升级-新建', '/device/border-device-upgrade', 'POST', 94, NULL, '2022-02-14 09:58:20', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (431, '设备管理-设备升级-删除', '/device/border-device-upgrade/*', 'DELETE', 94, NULL, '2022-02-14 09:58:20', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (432, '设备管理-设备升级-下发', '/device/border-device-upgrade/dispatch', 'PUT', 94, NULL, '2022-02-14 09:58:20', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (433, '设备管理-设备升级-查看状态', '/device/border-device-upgrade/state/*', 'GUT', 94, 1, '2022-08-24 18:26:58', '2022-08-24 18:26:58');
INSERT INTO `permission` VALUES (434, '设备管理-设备升级-查询结果', '/device/border-device-upgrades', 'GET', 94, 1, '2022-02-14 09:58:20', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (440, '系统管理-用户管理-新建', '/system/user', 'POST', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (441, '系统管理-用户管理-修改', '/system/user', 'PUT', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (442, '系统管理-用户管理-删除', '/system/user/*', 'DELETE', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (443, '系统管理-用户管理-解锁', '/system/user/unlock', 'PUT', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (444, '系统管理-用户管理-注销', '/system/user/unlogin', 'PUT', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (445, '系统管理-用户管理-重置密码', '/system/user/reset', 'PUT', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (446, '系统管理-用户管理-证书下载', '/system/user/download', 'GET', 100, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (447, '系统管理-用户管理-查询结果', '/system/users', 'GET', 100, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (450, '系统管理-角色管理-新建', '/system/permission-group', 'POST', 101, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (451, '系统管理-角色管理-修改', '/system/permission-group', 'PUT', 101, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (452, '系统管理-角色管理-详情', '/system/permission-group/*', 'GET', 101, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (453, '系统管理-角色管理-删除', '/system/permission-group/*', 'DELETE', 101, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (454, '系统管理-角色管理-查询结果', '/system/permission-groups', 'GET', 101, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (460, '系统管理-授权管理-修改', '/system/auth-user', 'PUT', 102, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (461, '系统管理-授权管理-启用和禁用', '/system/enable/*', 'PUT', 102, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (462, '系统管理-授权管理-查询结果', '/system/auth-users', 'GET', 102, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (465, '系统管理-系统配置-默认配置-修改', '/system/defaut-config', 'PUT', 103, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (466, '系统管理-系统配置-默认配置-详情', '/system/defaut-config', 'GET', 103, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (470, '系统管理-系统配置-邮件服务器配置-修改', '/system/email-config', 'PUT', 104, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (471, '系统管理-系统配置-邮件服务器配置-详情', '/system/email-config', 'GET', 104, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (475, '系统管理-系统配置-日志存储配置-修改', '/system/audit-config', 'PUT', 105, NULL, '2022-06-14 14:35:18', '2022-06-14 14:35:21');
INSERT INTO `permission` VALUES (476, '系统管理-系统配置-日志存储配置-详情', '/system/audit-config', 'GET', 105, 1, '2022-06-14 14:30:32', '2022-06-14 14:30:36');
INSERT INTO `permission` VALUES (480, '系统管理-系统配置-审计日志开关-修改', '/system/enable-config', 'PUT', 106, NULL, '2025-02-10 14:49:37', '2025-02-10 14:49:39');
INSERT INTO `permission` VALUES (481, '系统管理-系统配置-审计日志开关-详情', '/system/enable-config', 'GET', 106, NULL, '2025-02-10 14:49:41', '2025-02-10 14:49:43');
INSERT INTO `permission` VALUES (490, '系统管理-系统配置-日志服务器配置-修改', '/system/syslog-config', 'PUT', 107, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (491, '系统管理-系统配置-日志服务器配置-详情', '/system/syslog-config', 'GET', 107, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (495, '系统管理-系统配置-密码配置-修改', '/system/password-config', 'PUT', 108, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (496, '系统管理-系统配置-密码配置-详情', '/system/password-config', 'GET', 108, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (500, '系统管理-license管理-详情', '/system/license', 'GET', 110, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (501, '系统管理-license管理-更新license', '/system/license-update', 'POST', 110, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (502, '系统管理-系统信息-更新系统名称', '/system/sysname-update', 'POST', 109, NULL, '2022-04-01 12:03:53', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (503, '系统管理-系统信息-系统升级', '/system/dms-update', 'PUT', 109, NULL, '2022-08-25 12:22:32', '2022-08-25 12:22:32');
INSERT INTO `permission` VALUES (504, '系统管理-系统信息-客户端升级', '/system/client-update', 'PUT', 109, NULL, '2024-06-04 09:43:08', '2024-06-04 09:43:08');
INSERT INTO `permission` VALUES (510, '行为分析-设备行为分析-查询结果', '/analysis/device-analysis', 'GET', 64, NULL, '2025-02-21 18:34:52', '2025-02-21 18:34:52');
INSERT INTO `permission` VALUES (511, '行为分析-业务行为分析-单向文件同步行为分析-查询结果', '/analysis/file-analysis', 'GET', 65, NULL, '2025-02-21 18:34:52', '2025-02-21 18:34:52');
INSERT INTO `permission` VALUES (512, '行为分析-业务行为分析-单向数据导入行为分析-查询结果', '/analysis/single-analysis', 'GET', 66, NULL, '2025-02-21 18:34:52', '2025-02-21 18:34:52');
INSERT INTO `permission` VALUES (513, '行为分析-业务行为分析-双单向数据交换行为分析-查询结果', '/analysis/double-analysis', 'GET', 67, NULL, '2025-02-21 18:34:52', '2025-02-21 18:34:52');
INSERT INTO `permission` VALUES (514, '行为分析-业务行为分析-单向数据库同步行为分析-查询结果', '/analysis/db-analysis', 'GET', 78, NULL, '2025-08-06 11:48:08', '2025-08-06 11:48:08');
INSERT INTO `permission` VALUES (516, '审计分析-事件日志-数据引接-详情', '/receive-log/log', 'GET', 68, 1, '2025-08-06 11:45:12', '2025-08-06 11:45:12');
INSERT INTO `permission` VALUES (517, '审计分析-事件日志-数据引接-批量导出', '/receive-log/export-data', 'GET', 68, NULL, '2025-08-06 11:45:13', '2025-08-06 11:45:13');
INSERT INTO `permission` VALUES (518, '审计分析-事件日志-数据引接-查询结果', '/receive-log/logs', 'GET', 68, 1, '2025-08-06 11:45:13', '2025-08-06 11:45:13');
INSERT INTO `permission` VALUES (520, '数据审核-数据完整性检查策略-新建', '/strategy/strategy-data-sign', 'POST', 31, NULL, '2025-01-13 15:22:46', '2025-01-13 15:22:46');
INSERT INTO `permission` VALUES (521, '数据审核-数据完整性检查策略-修改', '/strategy/strategy-data-sign', 'PUT', 31, NULL, '2025-01-13 15:22:48', '2025-01-13 15:22:48');
INSERT INTO `permission` VALUES (522, '数据审核-数据完整性检查策略-详情', '/strategy/strategy-data-sign/*', 'GET', 31, 1, '2025-01-13 15:22:49', '2025-01-13 15:22:49');
INSERT INTO `permission` VALUES (523, '数据审核-数据完整性检查策略-删除', '/strategy/strategy-data-sign/*', 'DELETE', 31, NULL, '2025-01-13 15:22:50', '2025-01-13 15:22:50');
INSERT INTO `permission` VALUES (524, '数据审核-数据完整性检查策略-批量导入', '/strategy/strategy-data-sign/import-data', 'POST', 31, NULL, '2025-01-13 15:22:53', '2025-01-13 15:22:53');
INSERT INTO `permission` VALUES (525, '数据审核-数据完整性检查策略-批量导出', '/strategy/strategy-data-sign/export-data', 'GET', 31, NULL, '2025-01-13 15:22:54', '2025-01-13 15:22:54');
INSERT INTO `permission` VALUES (526, '数据审核-数据完整性检查策略-查询结果', '/strategy/strategy-data-signs', 'GET', 31, 1, '2025-01-13 15:22:55', '2025-01-13 15:22:55');
INSERT INTO `permission` VALUES (530, '隔离交换-单向数据库同步-数据库资源配置-新建', '/trans-db/trans-db', 'POST', 46, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (531, '隔离交换-单向数据库同步-数据库资源配置-修改', '/trans-db/trans-db', 'PUT', 46, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (532, '隔离交换-单向数据库同步-数据库资源配置-详情', '/trans-db/trans-db/*', 'GET', 46, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (533, '隔离交换-单向数据库同步-数据库资源配置-删除', '/trans-db/trans-db/*', 'DELETE', 46, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (534, '隔离交换-单向数据库同步-数据库资源配置-批量导入', '/trans-db/trans-db/import-data', 'POST', 46, NULL, '2022-05-16 15:29:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (535, '隔离交换-单向数据库同步-数据库资源配置-批量导出', '/trans-db/trans-db/export-data', 'GET', 46, NULL, '2022-05-16 15:29:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (536, '隔离交换-单向数据库同步-数据库资源配置-查询结果', '/trans-db/trans-dbs', 'GET', 46, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (540, '隔离交换-单向数据库同步-数据库同步策略-新建', '/strategy/strategy-db', 'POST', 47, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (541, '隔离交换-单向数据库同步-数据库同步策略-修改', '/strategy/strategy-db', 'PUT', 47, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (542, '隔离交换-单向数据库同步-数据库同步策略-详情', '/strategy/strategy-db/*', 'GET', 47, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (543, '隔离交换-单向数据库同步-数据库同步策略-删除', '/strategy/strategy-db/*', 'DELETE', 47, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (544, '隔离交换-单向数据库同步-数据库同步策略-批量导入', '/strategy/strategy-db/import-data', 'POST', 47, NULL, '2022-05-20 14:32:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (545, '隔离交换-单向数据库同步-数据库同步策略-批量导出', '/strategy/strategy-db/export-data', 'GET', 47, NULL, '2022-05-20 14:32:42', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (546, '隔离交换-单向数据库同步-数据库同步策略-查询结果', '/strategy/strategy-dbs', 'GET', 47, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (550, '隔离交换-单向数据库同步-数据库同步服务-新建', '/single-db/single-db', 'POST', 48, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (551, '隔离交换-单向数据库同步-数据库同步服务-修改', '/single-db/single-db', 'PUT', 48, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (552, '隔离交换-单向数据库同步-数据库同步服务-详情', '/single-db/single-db/*', 'GET', 48, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (553, '隔离交换-单向数据库同步-数据库同步服务-删除', '/single-db/single-db/*', 'DELETE', 48, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (554, '隔离交换-单向数据库同步-数据库同步服务-下发', '/single-db/single-db/send/*', 'PUT', 48, NULL, '2022-05-25 10:30:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (555, '隔离交换-单向数据库同步-数据库同步服务-移除', '/single-db/single-db/remove/*', 'PUT', 48, NULL, '2022-05-25 10:30:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (556, '隔离交换-单向数据库同步-数据库同步服务-同步记录', '/single-db/single-db/notes/*', 'GUT', 48, NULL, '2022-08-25 10:17:31', '2022-08-25 10:17:31');
INSERT INTO `permission` VALUES (557, '隔离交换-单向数据库同步-数据库同步服务-业务测试', '/single-db/single-db/status/*', 'GUT', 48, NULL, '2022-08-25 10:17:36', '2022-08-25 10:17:36');
INSERT INTO `permission` VALUES (558, '隔离交换-单向数据库同步-数据库同步服务-传输配置', '/single-db/single-db/config/*', 'PUT', 48, NULL, '2022-08-25 10:17:39', '2022-08-25 10:17:39');
INSERT INTO `permission` VALUES (559, '隔离交换-单向数据库同步-数据库同步服务-手动同步', '/single-db/single-db/sync/*', 'PUT', 48, NULL, '2022-08-25 10:17:43', '2022-08-25 10:17:43');
INSERT INTO `permission` VALUES (560, '隔离交换-单向数据库同步-数据库同步服务-查询结果', '/single-db/single-dbs', 'GET', 48, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (570, '审计分析-单向同步统计-数据库同步统计-详情', '/db-statistic/db-statistic', 'GET', 69, 1, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (571, '审计分析-单向同步统计-数据库同步统计-数据重传', '/db-statistic/db-statistic/retransmit', 'PUT', 69, NULL, '2022-08-25 10:24:01', '2022-08-25 10:24:01');
INSERT INTO `permission` VALUES (572, '审计分析-单向同步统计-数据库同步统计-导入校验', '/db-statistic/db-statistic/import-verify', 'POST', 69, NULL, '2022-08-25 10:24:04', '2022-08-25 10:24:04');
INSERT INTO `permission` VALUES (573, '审计分析-单向同步统计-数据库同步统计-导出校验', '/db-statistic/db-statistic/export-verify', 'GET', 69, 1, '2022-08-29 11:00:40', '2022-08-29 11:00:43');
INSERT INTO `permission` VALUES (574, '审计分析-单向同步统计-数据库同步统计-批量导出', '/db-statistic/db-statistic/export-data', 'GET', 69, 1, '2022-08-25 10:25:40', '2022-08-25 10:25:40');
INSERT INTO `permission` VALUES (575, '审计分析-单向同步统计-数据库同步统计-查询结果', '/db-statistic/db-statistics', 'GET', 69, 1, '2022-08-25 10:25:42', '2022-08-25 10:25:42');
INSERT INTO `permission` VALUES (580, '设备管理-边界设备-设备调试-修改', '/device/border-device-maintenance', 'PUT', 95, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (581, '设备管理-边界设备-设备调试-PING启用', '/device/border-device-maintenance/ping/*', 'PUT', 95, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (582, '设备管理-边界设备-设备调试-SSH启用', '/device/border-device-maintenance/ssh/*', 'PUT', 95, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (583, '设备管理-边界设备-设备调试-下发', '/device/border-device-maintenance/send/*', 'PUT', 95, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (584, '设备管理-边界设备-设备调试-批量下发', '/device/border-device-maintenance/send-more', 'PUT', 95, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (585, '设备管理-边界设备-设备调试-查询结果', '/device/border-device-maintenances', 'GET', 95, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (590, '设备管理-边界设备-诊断工具-执行', '/device/border-device-diagnose-tool/execute', 'POST', 96, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (591, '设备管理-边界设备-诊断工具-取消执行', '/device/border-device-diagnose-tool/cancel/*', 'PUT', 96, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (592, '设备管理-边界设备-诊断工具-重新执行', '/device/border-device-diagnose-tool/redo/*', 'POST', 96, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (593, '设备管理-边界设备-诊断工具-获取执行结果', '/device/border-device-diagnose-tool/execute/*', 'GET', 96, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (594, '设备管理-边界设备-诊断工具-下载执行结果', '/device/border-device-diagnose-tool/download/*', 'GET', 96, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (595, '设备管理-边界设备-诊断工具-查询结果', '/device/border-device-diagnose-tools', 'GET', 96, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (601, '传输管理-JSP文件传输-查询', '/translate/jsp-trans-file', 'GET', 201, 1, '2024-05-28 22:56:05', '2024-05-28 22:56:10');
INSERT INTO `permission` VALUES (602, '传输管理-用户认证-认证', '/translate/idenify', 'GET', 202, 1, '2024-05-28 22:56:08', '2024-05-28 22:56:11');
INSERT INTO `permission` VALUES (603, '传输管理-XFTP文件传输-查询', '/translate/xftp-trans-file', 'GET', 203, 1, '2025-02-10 19:30:41', '2025-02-10 19:30:43');
INSERT INTO `permission` VALUES (604, '传输管理-数据审核', '/translate/jsp-approval', 'GET', 204, 1, '2025-03-06 11:43:28', '2025-03-06 11:43:31');
INSERT INTO `permission` VALUES (605, '审计分析-事件日志-数据接引-查询结果', '/integrator-log/log', 'GET', 205, NULL, '2025-03-17 10:21:46', '2025-03-17 10:21:48');
INSERT INTO `permission` VALUES (606, '审计分析-事件日志-数据接引-详情', '/integrator-log/logs', 'GET', 205, NULL, '2025-03-17 10:22:18', '2025-03-17 10:22:19');
INSERT INTO `permission` VALUES (607, '传输管理-JSP文件传输-查询-详情', '/translate/jsp-trans-file/details/*', 'GET', 206, 1, '2025-07-07 15:14:44', '2025-07-07 15:14:46');
INSERT INTO `permission` VALUES (608, '系统管理-系统信息-查询', '/system/sysinfo', 'GET', 207, 1, '2025-12-03 17:25:55', '2025-12-03 17:25:56');
INSERT INTO `permission` VALUES (640, '边界防护-网络资源控制-新建', '/protection/resource', 'POST', 17, NULL, '2025-09-10 14:53:22', '2025-09-10 14:53:22');
INSERT INTO `permission` VALUES (641, '边界防护-网络资源控制-修改', '/protection/resource', 'PUT', 17, NULL, '2025-09-10 14:53:23', '2025-09-10 14:53:23');
INSERT INTO `permission` VALUES (642, '边界防护-网络资源控制-详情', '/protection/resource/*', 'GET', 17, 1, '2025-09-10 14:53:23', '2025-09-10 14:53:23');
INSERT INTO `permission` VALUES (643, '边界防护-网络资源控制-删除', '/protection/resource/*', 'DELETE', 17, NULL, '2025-09-10 14:53:24', '2025-09-10 14:53:24');
INSERT INTO `permission` VALUES (644, '边界防护-网络资源控制-带宽使用情况', '/protection/resource/band-width', 'GET', 17, 1, '2025-09-10 14:53:24', '2025-09-10 14:53:24');
INSERT INTO `permission` VALUES (645, '边界防护-网络资源控制-配置详情', '/protection/resource/detail', 'GET', 17, 1, '2025-09-10 14:53:24', '2025-09-10 14:53:24');
INSERT INTO `permission` VALUES (646, '边界防护-网络资源控制-配置', '/protection/resource/config', 'PUT', 17, NULL, '2025-09-10 14:53:25', '2025-09-10 14:53:25');
INSERT INTO `permission` VALUES (647, '边界防护-网络资源控制-下发', '/protection/resource/send/*', 'PUT', 17, NULL, '2025-09-10 14:53:25', '2025-09-10 14:53:25');
INSERT INTO `permission` VALUES (648, '边界防护-网络资源控制-移除', '/protection/resource/remove/*', 'PUT', 17, NULL, '2025-09-10 14:53:26', '2025-09-10 14:53:26');
INSERT INTO `permission` VALUES (649, '边界防护-网络资源控制-手动恢复', '/protection/resource/restore/*', 'PUT', 17, NULL, '2025-09-10 14:53:26', '2025-09-10 14:53:26');
INSERT INTO `permission` VALUES (650, '边界防护-网络资源控制-批量下发', '/protection/resource/batch-send', 'PUT', 17, NULL, '2025-09-10 14:53:27', '2025-09-10 14:53:27');
INSERT INTO `permission` VALUES (651, '边界防护-网络资源控制-批量移除', '/protection/resource/batch-remove', 'PUT', 17, NULL, '2025-09-10 14:53:27', '2025-09-10 14:53:27');
INSERT INTO `permission` VALUES (652, '边界防护-网络资源控制-批量删除', '/protection/resource/batch-delete', 'DELETE', 17, NULL, '2025-09-10 14:53:28', '2025-09-10 14:53:28');
INSERT INTO `permission` VALUES (653, '边界防护-网络资源控制-批量导入', '/protection/resource/import-data', 'POST', 17, NULL, '2025-09-10 14:53:28', '2025-09-10 14:53:28');
INSERT INTO `permission` VALUES (654, '边界防护-网络资源控制-批量导出', '/protection/resource/export-data', 'GET', 17, NULL, '2025-09-10 14:53:29', '2025-09-10 14:53:29');
INSERT INTO `permission` VALUES (655, '边界防护-网络资源控制-查询结果', '/protection/resources', 'GET', 17, 1, '2025-09-10 14:53:29', '2025-09-10 14:53:29');
INSERT INTO `permission` VALUES (660, '报表管理-传输报表-文件同步报表-查询结果', '/form/file-forms', 'GET', 74, 1, '2025-08-25 09:56:24', '2025-08-25 09:56:24');
INSERT INTO `permission` VALUES (661, '报表管理-传输报表-数据库同步报表-查询结果', '/form/db-forms', 'GET', 75, 1, '2025-08-25 09:56:25', '2025-08-25 09:56:25');
INSERT INTO `permission` VALUES (662, '报表管理-告警报表-查询结果', '/form/alarm-forms', 'GET', 76, 1, '2025-08-25 09:56:26', '2025-08-25 09:56:26');
INSERT INTO `permission` VALUES (670, '审计分析-攻击报文取证-删除', '/pcap-log/log', 'DELETE', 49, NULL, '2025-09-22 10:16:18', '2025-09-22 10:16:18');
INSERT INTO `permission` VALUES (671, '审计分析-攻击报文取证-导出', '/pcap-log/log/download', 'GET', 49, NULL, '2025-09-22 10:16:19', '2025-09-22 10:16:19');
INSERT INTO `permission` VALUES (672, '审计分析-攻击报文取证-批量删除', '/pcap-log/log/batch-delete', 'DELETE', 49, NULL, '2025-09-22 10:16:19', '2025-09-22 10:16:19');
INSERT INTO `permission` VALUES (673, '审计分析-攻击报文取证-批量导出', '/pcap-log/log/batch-download', 'GET', 49, NULL, '2025-09-22 10:16:19', '2025-09-22 10:16:19');
INSERT INTO `permission` VALUES (674, '审计分析-攻击报文取证-查询结果', '/pcap-log/logs', 'GET', 49, NULL, '2025-09-22 10:16:20', '2025-09-22 10:16:20');
INSERT INTO `permission` VALUES (700, '设备管理-边界设备-HA组管理-新建', '/device/border-device-ha', 'POST', 211, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (701, '设备管理-边界设备-HA组管理-修改', '/device/border-device-ha', 'PUT', 211, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (702, '设备管理-边界设备-HA组管理-详情', '/device/border-device-ha/*', 'GET', 211, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (703, '设备管理-边界设备-HA组管理-删除', '/device/border-device-ha/*', 'DELETE', 211, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (704, '设备管理-边界设备-HA组管理-启用和禁用', '/device/border-device-ha/enable/*', 'PUT', 211, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (705, '设备管理-边界设备-HA组管理-查询结果', '/device/border-device-has', 'GET', 211, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (707, '设备管理-边界设备-运维管理-设备流量日志启用', '/device/border-device-maintenance/device-log/*', 'PUT', 212, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (708, '设备管理-边界设备-运维管理-放行的应用安全策略日志启用', '/device/border-device-maintenance/remote-log/*', 'PUT', 212, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (711, '设备管理-边界设备-运维管理-SNMP启用', '/device/border-device-maintenance/snmp/*', 'PUT', 212, NULL, '2022-06-10 14:18:08', '2022-06-10 14:18:12');
INSERT INTO `permission` VALUES (712, '设备管理-边界设备-运维管理-SNMP配置', '/device/border-device-maintenance/snmp', 'PUT', 212, NULL, '2022-06-10 14:18:56', '2022-06-10 14:19:00');
INSERT INTO `permission` VALUES (713, '设备管理-边界设备-运维管理-SNMP配置详情', '/device/border-device-maintenance/snmp/*', 'GET', 212, 1, '2022-06-10 14:19:23', '2022-06-10 14:19:26');
INSERT INTO `permission` VALUES (723, '设备管理-设备注册', '/device/register', 'POST', 215, NULL, '2023-10-17 11:26:36', '2023-10-17 11:26:43');
INSERT INTO `permission` VALUES (731, '资源配置-数据资源配置-新建', '/trans-data/trans-data', 'POST', 217, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (732, '资源配置-数据资源配置-修改', '/trans-data/trans-data', 'PUT', 217, NULL, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (733, '资源配置-数据资源配置-详情', '/trans-data/trans-data/*', 'GET', 217, 1, '2022-05-07 16:59:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (734, '资源配置-数据资源配置-删除', '/trans-data/trans-data/*', 'DELETE', 217, NULL, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (735, '资源配置-数据资源配置-批量导入', '/trans-data/trans-data/import-data', 'POST', 217, NULL, '2022-05-11 15:26:12', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (736, '资源配置-数据资源配置-批量导出', '/trans-data/trans-data/export-data', 'GET', 217, NULL, '2022-05-11 15:26:12', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (737, '资源配置-数据资源配置-查询结果', '/trans-data/trans-datas', 'GET', 217, 1, '2022-05-07 16:59:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (738, '策略管理-应用安全策略-名单配置-新建', '/strategy/strategy-list', 'POST', 218, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (739, '策略管理-应用安全策略-名单配置-修改', '/strategy/strategy-list', 'PUT', 218, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (740, '策略管理-应用安全策略-名单配置-详情', '/strategy/strategy-list/*', 'GET', 218, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (741, '策略管理-应用安全策略-名单配置-删除', '/strategy/strategy-list/*', 'DELETE', 218, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (742, '策略管理-应用安全策略-名单配置-批量导入', '/strategy/strategy-list/import-data', 'POST', 218, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (743, '策略管理-应用安全策略-名单配置-批量导出', '/strategy/strategy-list/export-data', 'GET', 218, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (744, '策略管理-应用安全策略-名单配置-查询结果', '/strategy/strategy-lists', 'GET', 218, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (745, '策略管理-应用安全策略-安全浏览策略-新建', '/strategy/strategy-browse', 'POST', 219, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (746, '策略管理-应用安全策略-安全浏览策略-修改', '/strategy/strategy-browse', 'PUT', 219, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (747, '策略管理-应用安全策略-安全浏览策略-详情', '/strategy/strategy-browse/*', 'GET', 219, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (748, '策略管理-应用安全策略-安全浏览策略-删除', '/strategy/strategy-browse/*', 'DELETE', 219, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (749, '策略管理-应用安全策略-安全浏览策略-批量导入', '/strategy/strategy-browse/import-data', 'POST', 219, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (750, '策略管理-应用安全策略-安全浏览策略-批量导出', '/strategy/strategy-browse/export-data', 'GET', 219, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (751, '策略管理-应用安全策略-安全浏览策略-查询结果', '/strategy/strategy-browses', 'GET', 219, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (752, '策略管理-应用安全策略-文件传输策略-新建', '/strategy/strategy-file', 'POST', 220, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (753, '策略管理-应用安全策略-文件传输策略-修改', '/strategy/strategy-file', 'PUT', 220, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (754, '策略管理-应用安全策略-文件传输策略-详情', '/strategy/strategy-file/*', 'GET', 220, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (755, '策略管理-应用安全策略-文件传输策略-删除', '/strategy/strategy-file/*', 'DELETE', 220, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (756, '策略管理-应用安全策略-文件传输策略-批量导入', '/strategy/strategy-file/import-data', 'POST', 220, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (757, '策略管理-应用安全策略-文件传输策略-批量导出', '/strategy/strategy-file/export-data', 'GET', 220, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (758, '策略管理-应用安全策略-文件传输策略-查询结果', '/strategy/strategy-files', 'GET', 220, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (759, '策略管理-应用安全策略-邮件策略-新建', '/strategy/strategy-mail', 'POST', 221, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (760, '策略管理-应用安全策略-邮件策略-修改', '/strategy/strategy-mail', 'PUT', 221, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (761, '策略管理-应用安全策略-邮件策略-详情', '/strategy/strategy-mail/*', 'GET', 221, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (762, '策略管理-应用安全策略-邮件策略-删除', '/strategy/strategy-mail/*', 'DELETE', 221, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (763, '策略管理-应用安全策略-邮件策略-批量导入', '/strategy/strategy-mail/import-data', 'POST', 221, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (764, '策略管理-应用安全策略-邮件策略-批量导出', '/strategy/strategy-mail/export-data', 'GET', 221, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (765, '策略管理-应用安全策略-邮件策略-查询结果', '/strategy/strategy-mails', 'GET', 221, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (766, '策略管理-应用安全策略-内容审查策略-新建', '/strategy/strategy-content', 'POST', 222, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (767, '策略管理-应用安全策略-内容审查策略-修改', '/strategy/strategy-content', 'PUT', 222, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (768, '策略管理-应用安全策略-内容审查策略-详情', '/strategy/strategy-content/*', 'GET', 222, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (769, '策略管理-应用安全策略-内容审查策略-删除', '/strategy/strategy-content/*', 'DELETE', 222, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (770, '策略管理-应用安全策略-内容审查策略-批量导入', '/strategy/strategy-content/import-data', 'POST', 222, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (771, '策略管理-应用安全策略-内容审查策略-批量导出', '/strategy/strategy-content/export-data', 'GET', 222, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (772, '策略管理-应用安全策略-内容审查策略-查询结果', '/strategy/strategy-contents', 'GET', 222, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (773, '策略管理-应用安全策略-SQL审查策略-新建', '/strategy/strategy-sqlcheck', 'POST', 223, NULL, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (774, '策略管理-应用安全策略-SQL审查策略-修改', '/strategy/strategy-sqlcheck', 'PUT', 223, NULL, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (775, '策略管理-应用安全策略-SQL审查策略-详情', '/strategy/strategy-sqlcheck/*', 'GET', 223, 1, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (776, '策略管理-应用安全策略-SQL审查策略-删除', '/strategy/strategy-sqlcheck/*', 'DELETE', 223, NULL, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (777, '策略管理-应用安全策略-SQL审查策略-批量导入', '/strategy/strategy-sqlcheck/import-data', 'POST', 223, NULL, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (778, '策略管理-应用安全策略-SQL审查策略-批量导出', '/strategy/strategy-sqlcheck/export-data', 'GET', 223, NULL, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (779, '策略管理-应用安全策略-SQL审查策略-查询结果', '/strategy/strategy-sqlchecks', 'GET', 223, 1, '2022-05-27 17:40:49', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (780, '策略管理-应用安全策略-视频传输策略-新建', '/strategy/strategy-videocheck', 'POST', 224, NULL, '2022-07-05 10:43:37', '2022-07-05 10:43:37');
INSERT INTO `permission` VALUES (781, '策略管理-应用安全策略-视频传输策略-修改', '/strategy/strategy-videocheck', 'PUT', 224, NULL, '2022-07-05 10:43:40', '2022-07-05 10:43:40');
INSERT INTO `permission` VALUES (782, '策略管理-应用安全策略-视频传输策略-详情', '/strategy/strategy-videocheck/*', 'GET', 224, 1, '2022-07-05 10:43:43', '2022-07-05 10:43:43');
INSERT INTO `permission` VALUES (783, '策略管理-应用安全策略-视频传输策略-删除', '/strategy/strategy-videocheck/*', 'DELETE', 224, NULL, '2022-07-05 10:43:47', '2022-07-05 10:43:47');
INSERT INTO `permission` VALUES (784, '策略管理-应用安全策略-视频传输策略-批量导入', '/strategy/strategy-videocheck/import-data', 'POST', 224, NULL, '2022-07-05 10:43:52', '2022-07-05 10:43:52');
INSERT INTO `permission` VALUES (785, '策略管理-应用安全策略-视频传输策略-批量导出', '/strategy/strategy-videocheck/export-data', 'GET', 224, NULL, '2022-07-05 10:43:49', '2022-07-05 10:43:49');
INSERT INTO `permission` VALUES (786, '策略管理-应用安全策略-视频传输策略-查询结果', '/strategy/strategy-videochecks', 'GET', 224, 1, '2022-07-05 10:43:54', '2022-07-05 10:43:54');
INSERT INTO `permission` VALUES (794, '策略管理-安全标记策略-应用安全标记策略-新建', '/strategy/strategy-app-mark', 'POST', 226, NULL, '2022-08-25 10:23:55', '2022-08-25 10:23:55');
INSERT INTO `permission` VALUES (795, '策略管理-安全标记策略-应用安全标记策略-修改', '/strategy/strategy-app-mark', 'PUT', 226, NULL, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (796, '策略管理-安全标记策略-应用安全标记策略-详情', '/strategy/strategy-app-mark/*', 'GET', 226, 1, '2022-08-25 10:23:55', '2022-08-25 10:23:55');
INSERT INTO `permission` VALUES (797, '策略管理-安全标记策略-应用安全标记策略-删除', '/strategy/strategy-app-mark/*', 'DELETE', 226, NULL, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (798, '策略管理-安全标记策略-应用安全标记策略-批量导入', '/strategy/strategy-app-mark/import-data', 'POST', 226, NULL, '2022-08-25 10:24:01', '2022-08-25 10:24:01');
INSERT INTO `permission` VALUES (799, '策略管理-安全标记策略-应用安全标记策略-批量导出', '/strategy/strategy-app-mark/export-data', 'GET', 226, NULL, '2022-08-25 10:24:04', '2022-08-25 10:24:04');
INSERT INTO `permission` VALUES (800, '策略管理-安全标记策略-应用安全标记策略-查询结果', '/strategy/strategy-app-marks', 'GET', 226, 1, '2022-08-11 10:33:41', '2022-08-11 10:33:44');
INSERT INTO `permission` VALUES (801, '策略管理-安全标记策略-标记对象-新建', '/strategy/strategy-tag-mark', 'POST', 227, NULL, '2022-08-25 10:25:40', '2022-08-25 10:25:40');
INSERT INTO `permission` VALUES (802, '策略管理-安全标记策略-标记对象-修改', '/strategy/strategy-tag-mark', 'PUT', 227, NULL, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (803, '策略管理-安全标记策略-标记对象-详情', '/strategy/strategy-tag-mark/*', 'GET', 227, 1, '2022-08-25 10:23:55', '2022-08-25 10:23:55');
INSERT INTO `permission` VALUES (804, '策略管理-安全标记策略-标记对象-删除', '/strategy/strategy-tag-mark/*', 'DELETE', 227, NULL, '2022-08-25 10:23:58', '2022-08-25 10:23:58');
INSERT INTO `permission` VALUES (805, '策略管理-安全标记策略-标记对象-批量导入', '/strategy/strategy-tag-mark/import-data', 'POST', 227, NULL, '2022-08-25 10:24:01', '2022-08-25 10:24:01');
INSERT INTO `permission` VALUES (806, '策略管理-安全标记策略-标记对象-批量导出', '/strategy/strategy-tag-mark/export-data', 'GET', 227, NULL, '2022-08-25 10:25:42', '2022-08-25 10:25:42');
INSERT INTO `permission` VALUES (807, '策略管理-安全标记策略-标记对象-查询结果', '/strategy/strategy-tag-marks', 'GET', 227, 1, '2022-08-11 15:54:22', '2022-08-11 15:54:25');
INSERT INTO `permission` VALUES (808, '策略管理-应用安全策略-应用识别策略-新建', '/strategy/strategy-identify', 'POST', 228, NULL, '2024-07-12 16:51:04', '2024-07-12 16:51:04');
INSERT INTO `permission` VALUES (809, '策略管理-应用安全策略-应用识别策略-修改', '/strategy/strategy-identify', 'PUT', 228, NULL, '2024-07-12 16:51:05', '2024-07-12 16:51:05');
INSERT INTO `permission` VALUES (810, '策略管理-应用安全策略-应用识别策略-详情', '/strategy/strategy-identify/*', 'GET', 228, 1, '2024-07-12 16:51:06', '2024-07-12 16:51:06');
INSERT INTO `permission` VALUES (811, '策略管理-应用安全策略-应用识别策略-删除', '/strategy/strategy-identify/*', 'DELETE', 228, NULL, '2024-07-12 16:51:06', '2024-07-12 16:51:06');
INSERT INTO `permission` VALUES (812, '策略管理-应用安全策略-应用识别策略-批量导入', '/strategy/strategy-identify/import-data', 'POST', 228, NULL, '2024-07-12 16:51:07', '2024-07-12 16:51:07');
INSERT INTO `permission` VALUES (813, '策略管理-应用安全策略-应用识别策略-批量导出', '/strategy/strategy-identify/export-data', 'GET', 228, NULL, '2024-07-12 16:51:08', '2024-07-12 16:51:08');
INSERT INTO `permission` VALUES (814, '策略管理-应用安全策略-应用识别策略-查询结果', '/strategy/strategy-identifys', 'GET', 228, 1, '2024-07-12 16:51:09', '2024-07-12 16:51:09');
INSERT INTO `permission` VALUES (815, '策略管理-DSE策略-数据标识策略-新建', '/strategy/strategy-data-lable', 'POST', 30, NULL, '2025-01-13 15:22:01', '2025-01-13 15:22:01');
INSERT INTO `permission` VALUES (816, '策略管理-DSE策略-数据标识策略-修改', '/strategy/strategy-data-lable', 'PUT', 30, NULL, '2025-01-13 15:22:01', '2025-01-13 15:22:01');
INSERT INTO `permission` VALUES (817, '策略管理-DSE策略-数据标识策略-详情', '/strategy/strategy-data-lable/*', 'GET', 30, 1, '2025-01-13 15:22:02', '2025-01-13 15:22:02');
INSERT INTO `permission` VALUES (818, '策略管理-DSE策略-数据标识策略-删除', '/strategy/strategy-data-lable/*', 'DELETE', 30, NULL, '2025-01-13 15:22:02', '2025-01-13 15:22:02');
INSERT INTO `permission` VALUES (819, '策略管理-DSE策略-数据标识策略-批量导入', '/strategy/strategy-data-lable/import-data', 'POST', 30, NULL, '2025-01-13 15:22:03', '2025-01-13 15:22:03');
INSERT INTO `permission` VALUES (820, '策略管理-DSE策略-数据标识策略-批量导出', '/strategy/strategy-data-lable/export-data', 'GET', 30, NULL, '2025-01-13 15:22:03', '2025-01-13 15:22:03');
INSERT INTO `permission` VALUES (821, '策略管理-DSE策略-数据标识策略-查询结果', '/strategy/strategy-data-lables', 'GET', 30, 1, '2025-01-13 15:22:04', '2025-01-13 15:22:04');
INSERT INTO `permission` VALUES (829, '业务管理-业务访问配置-业务访问-新建', '/business-visit/visit', 'POST', 231, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (830, '业务管理-业务访问配置-业务访问-修改', '/business-visit/visit', 'PUT', 231, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (831, '业务管理-业务访问配置-业务访问-详情', '/business-visit/visit/*', 'GET', 231, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (832, '业务管理-业务访问配置-业务访问-删除', '/business-visit/visit/*', 'DELETE', 231, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (833, '业务管理-业务访问配置-业务访问-下发', '/business-visit/visit/send/*', 'PUT', 231, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (834, '业务管理-业务访问配置-业务访问-移除', '/business-visit/visit/remove/*', 'PUT', 231, NULL, '2021-01-04 15:17:18', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (835, '业务管理-业务访问配置-业务访问-查询结果', '/business-visit/visits', 'GET', 231, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (836, '业务管理-业务访问配置-业务访问-状态详情', '/business-visit/visit-work-states/*', 'GET', 231, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (837, '业务管理-业务访问配置-业务访问-业务状态详情', '/business-visit/app-work-states/*', 'GET', 231, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (838, '业务管理-业务访问配置-业务访问-重新下发应用配置', '/business-visit/visit-redispatch', 'PUT', 231, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (839, '业务管理-业务访问配置-业务访问-重新下发策略', '/business-visit/app-redispatch', 'PUT', 231, NULL, '2021-09-26 08:21:45', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (840, '业务管理-业务访问配置-业务访问-删除业务', '/business-visit/visit/basic-delete/*', 'DELETE', 231, NULL, '2021-12-24 14:03:39', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (841, '业务管理-业务访问配置-业务访问-删除策略', '/business-visit/visit/app-delete/*', 'DELETE', 231, NULL, '2021-12-24 14:03:39', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (842, '业务管理-业务访问配置-业务访问-业务列表', '/business-visit/study-visit-work-states/*', 'GET', 231, 1, '2022-02-15 15:04:26', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (843, '业务管理-业务访问配置-业务访问-自学习列表', '/business-visit/visit/study/*', 'GET', 231, 1, '2022-02-15 11:43:33', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (844, '业务管理-业务访问配置-业务访问-自学习策略列表', '/business-visit/visit/study-browse/*', 'GET', 231, 1, '2022-02-15 11:43:33', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (845, '业务管理-业务访问配置-业务访问-自学习', '/business-visit/visit/study-send', 'PUT', 231, NULL, '2022-02-15 11:43:33', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (846, '业务管理-业务访问配置-业务访问-删除自学习', '/business-visit/visit/study-delete/*', 'DELETE', 231, NULL, '2022-02-15 11:43:33', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (847, '业务管理-业务访问配置-业务访问-自学习清空', '/business-visit/visit/study-clear', 'PUT', 231, NULL, '2022-02-17 11:00:48', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (848, '业务管理-业务访问配置-隔离通道-新建', '/insulate-channel/channel', 'POST', 232, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (849, '业务管理-业务访问配置-隔离通道-修改', '/insulate-channel/channel', 'PUT', 232, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (850, '业务管理-业务访问配置-隔离通道-详情', '/insulate-channel/channel/*', 'GET', 232, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (851, '业务管理-业务访问配置-隔离通道-删除', '/insulate-channel/channel/*', 'DELETE', 232, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (852, '业务管理-业务访问配置-隔离通道-查询结果', '/insulate-channel/channels', 'GET', 232, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (853, '业务管理-业务访问配置-网络传输业务-新建', '/business-transmission/trans', 'POST', 233, NULL, '2024-06-07 14:54:07', '2024-06-07 14:54:07');
INSERT INTO `permission` VALUES (854, '业务管理-业务访问配置-网络传输业务-修改', '/business-transmission/trans', 'PUT', 233, NULL, '2024-06-07 14:54:07', '2024-06-07 14:54:07');
INSERT INTO `permission` VALUES (855, '业务管理-业务访问配置-网络传输业务-详情', '/business-transmission/trans/*', 'GET', 233, 1, '2024-06-07 14:54:07', '2024-06-07 14:54:07');
INSERT INTO `permission` VALUES (856, '业务管理-业务访问配置-网络传输业务-删除', '/business-transmission/trans/*', 'DELETE', 233, NULL, '2024-06-07 14:54:07', '2024-06-07 14:54:07');
INSERT INTO `permission` VALUES (857, '业务管理-业务访问配置-网络传输业务-下发', '/business-transmission/trans/send/*', 'PUT', 233, NULL, '2024-06-07 14:54:08', '2024-06-07 14:54:08');
INSERT INTO `permission` VALUES (858, '业务管理-业务访问配置-网络传输业务-移除', '/business-transmission/trans/remove/*', 'PUT', 233, NULL, '2024-06-07 14:54:08', '2024-06-07 14:54:08');
INSERT INTO `permission` VALUES (859, '业务管理-业务访问配置-网络传输业务-查询结果', '/business-transmission/transes', 'GET', 233, 1, '2024-06-07 14:54:08', '2024-06-07 14:54:08');
INSERT INTO `permission` VALUES (860, '业务管理-业务访问配置-网络传输业务-状态', '/business-transmission/trans-work-states/*', 'GET', 233, 1, '2024-06-07 14:54:09', '2024-06-07 14:54:09');
INSERT INTO `permission` VALUES (861, '业务管理-业务流量统计-流量概况-查询结果', '/traffic-situation/device-top', 'GET', 234, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (862, '业务管理-业务流量统计-设备流量-统计', '/device-traffic/traffic/device-ifname-statistic', 'GET', 235, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (863, '业务管理-业务流量统计-设备流量-批量导出', '/device-traffic/export-data', 'GET', 235, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (864, '业务管理-业务流量统计-设备流量-查询结果', '/device-traffic/traffics', 'GET', 235, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (865, '业务管理-业务流量统计-会话流量-详情', '/session-traffic/traffic/*', 'GET', 236, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (866, '业务管理-业务流量统计-会话流量-批量导出', '/session-traffic/export-data', 'GET', 236, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (867, '业务管理-业务流量统计-会话流量-查询结果', '/session-traffic/traffics', 'GET', 236, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (885, '业务管理-卡流量分析-查询', '/analyses-card/analyses-card', 'GET', 241, 1, '2024-03-15 11:22:50', '2024-03-15 11:22:53');
INSERT INTO `permission` VALUES (886, '业务管理-卡流量分析Top-查询', '/analyses-card/analyses-cardtop', 'GET', 242, 1, '2024-03-15 11:22:50', '2024-03-15 11:22:53');
INSERT INTO `permission` VALUES (887, '告警中心-告警策略配置-告警模板-新建', '/alarm-templete/templete', 'POST', 243, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (888, '告警中心-告警策略配置-告警模板-修改', '/alarm-templete/templete/*', 'PUT', 243, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (889, '告警中心-告警策略配置-告警模板-详情', '/alarm-templete/templete/*', 'GET', 243, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (890, '告警中心-告警策略配置-告警模板-删除', '/alarm-templete/templete/*', 'DELETE', 243, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (891, '告警中心-告警策略配置-告警模板-查询结果', '/alarm-templete/templetes', 'GET', 243, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (892, '审计中心-流量日志-详情', '/traffic-log/log', 'GET', 244, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (893, '审计中心-流量日志-批量导出', '/traffic-log/export-data', 'GET', 244, NULL, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (894, '审计中心-流量日志-查询结果', '/traffic-log/logs', 'GET', 244, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (895, '系统管理-帮助-详情', '/system/view', 'GET', 245, 1, '2021-09-20 06:51:47', '2022-06-01 14:50:04');
INSERT INTO `permission` VALUES (896, '系统管理-三方应用-新建', '/system/third-user', 'POST', 246, NULL, '2024-10-17 16:05:46', '2024-10-17 16:05:46');
INSERT INTO `permission` VALUES (897, '系统管理-三方应用-修改', '/system/third-user', 'PUT', 246, NULL, '2024-10-21 10:29:11', '2024-10-21 10:29:11');
INSERT INTO `permission` VALUES (898, '系统管理-三方应用-删除', '/system/third-user/*', 'DELETE', 246, NULL, '2024-10-17 16:05:47', '2024-10-17 16:05:47');
INSERT INTO `permission` VALUES (899, '系统管理-三方应用-重置密码', '/system/third-user/reset', 'PUT', 246, NULL, '2024-10-17 16:05:47', '2024-10-17 16:05:47');
INSERT INTO `permission` VALUES (900, '系统管理-三方应用-查询结果', '/system/third-users', 'GET', 246, NULL, '2024-10-17 16:05:47', '2024-10-17 16:05:47');

-- ----------------------------
-- Table structure for permission_group
-- ----------------------------
DROP TABLE IF EXISTS `permission_group`;
CREATE TABLE `permission_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `type` tinyint(4) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_permission_group_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_group
-- ----------------------------
INSERT INTO `permission_group` VALUES (2, '系统管理员', 1, 2, 1, '2022-06-14 16:05:53', '2022-06-14 16:05:53');
INSERT INTO `permission_group` VALUES (3, '安全管理员', 1, 3, 1, '2022-06-14 16:09:16', '2022-06-25 15:33:24');
INSERT INTO `permission_group` VALUES (4, '审计管理员', 1, 4, 1, '2022-06-14 16:13:04', '2022-06-14 16:13:04');
INSERT INTO `permission_group` VALUES (5, '传输客户端用户', 0, 5, 1, '2023-10-17 09:38:24', '2023-10-17 09:38:24');
INSERT INTO `permission_group` VALUES (6, '业务安全管理员', 0, 6, 1, '2022-08-29 09:32:47', '2022-12-01 11:49:02');

-- ----------------------------
-- Table structure for permission_group_permission
-- ----------------------------
DROP TABLE IF EXISTS `permission_group_permission`;
CREATE TABLE `permission_group_permission`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `permission_group_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `readonly` tinyint(1) DEFAULT 0,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_permission_group_permission_permission_id_permission_group_id`(`permission_group_id`, `permission_id`) USING BTREE,
  INDEX `fk_permission_group_permission_permission_id`(`permission_id`) USING BTREE,
  CONSTRAINT `permission_group_permission_ibfk_1` FOREIGN KEY (`permission_group_id`) REFERENCES `permission_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10572 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for redis
-- ----------------------------
DROP TABLE IF EXISTS `redis`;
CREATE TABLE `redis`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'redis-key',
  `gmt_start` datetime(0) DEFAULT NULL COMMENT '添加时间',
  `gmt_end` datetime(0) DEFAULT NULL COMMENT '结束时间',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型：1-list，2-single',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for scheduler_job_config
-- ----------------------------
DROP TABLE IF EXISTS `scheduler_job_config`;
CREATE TABLE `scheduler_job_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一性编号',
  `interval_unit` int(11) NOT NULL COMMENT '时间执行单位，1-秒，2-分钟，3-小时，4-重复次数，5-cron表达式',
  `interval_value` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间值或corn表达式值',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_scheduler_job_config_name`(`name`) USING BTREE,
  UNIQUE INDEX `uk_scheduler_job_config_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scheduler_job_config
-- ----------------------------
INSERT INTO `scheduler_job_config` VALUES (1, '设备基本信息初始化队列任务', 'DeviceInfoQueue', 1, '60', '2021-08-13 09:36:30', '2021-08-13 09:36:30');
INSERT INTO `scheduler_job_config` VALUES (2, '业务周期模式任务', 'StrategyCycle', 5, '* * * * * ?', '2021-08-13 09:36:30', '2021-08-13 09:36:30');
INSERT INTO `scheduler_job_config` VALUES (3, '日志存储容量检查任务', 'AuditLimitCheck', 5, '0 0 * * * ?', '2022-01-06 09:41:13', '2022-01-06 09:41:13');
INSERT INTO `scheduler_job_config` VALUES (4, '设备自动备份任务', 'AutoBackupCheck', 5, '0 0 1 * * ?', '2022-12-08 18:36:43', '2022-12-08 18:36:43');
INSERT INTO `scheduler_job_config` VALUES (5, '安全域密钥自动下发', 'SetSafeDomainSkey', 5, '0 0 1 * * ?', '2024-03-04 18:16:58', '2024-03-04 18:17:01');

-- ----------------------------
-- Table structure for strategy_acl
-- ----------------------------
DROP TABLE IF EXISTS `strategy_acl`;
CREATE TABLE `strategy_acl`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `source_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源IP',
  `source_port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源端口',
  `destination_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的IP',
  `destination_port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的端口',
  `proto_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '协议类型',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '调度周期id',
  `business_time_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '调度周期名称',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级：同上',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_acl_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '网络安全策略-ACL' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_app_mark
-- ----------------------------
DROP TABLE IF EXISTS `strategy_app_mark`;
CREATE TABLE `strategy_app_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `un_tag_deny_enable` tinyint(1) DEFAULT NULL COMMENT '无标记动作，1-阻断，0-允许',
  `allow_marks` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '放行标记对象',
  `deny_marks` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '阻断标记对象',
  `un_tag_enable` tinyint(1) DEFAULT NULL COMMENT '去标记开关，1-开，0-关',
  `tag_enable` tinyint(4) DEFAULT NULL COMMENT '标记动作，1-打标，0-透传',
  `mark_level` bigint(20) DEFAULT NULL COMMENT '标记级别',
  `mark_type` bigint(20) DEFAULT NULL COMMENT '标记类型',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用层信息',
  `udp_threshold` int(11) DEFAULT NULL COMMENT 'UDP阈值',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级：同上',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_app_mark_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安全标记策略-应用安全标记策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_area_mark
-- ----------------------------
DROP TABLE IF EXISTS `strategy_area_mark`;
CREATE TABLE `strategy_area_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `device_type` tinyint(4) DEFAULT NULL COMMENT '设备类型',
  `location` tinyint(4) DEFAULT NULL COMMENT '位置：1-发送端，2-接收端',
  `source_network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '源域ID',
  `source_network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源域名称',
  `destination_network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '目的域ID',
  `destination_network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的域名称',
  `source_business_group_id` bigint(20) DEFAULT NULL COMMENT '源业务组ID',
  `source_business_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源业务组名称',
  `destination_business_group_id` bigint(20) DEFAULT NULL COMMENT '目的业务ID',
  `destination_business_group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的业务名称',
  `strategy_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '标记ID',
  `strategy_mark_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标记名称',
  `category_compare_type` tinyint(4) DEFAULT NULL COMMENT '类别对比方式类型',
  `mark_action` tinyint(4) DEFAULT NULL COMMENT '标记动作',
  `reverse_mark_action` tinyint(4) DEFAULT NULL COMMENT '反向标记动作',
  `transfer_strategy_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '转换后标记ID',
  `transfer_strategy_mark_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '转换后标记名称',
  `session_reverse_strategy_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '会话反向标记ID',
  `session_reverse_strategy_mark_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '会话反向标记名称',
  `session_reverse_category_compare_type` tinyint(4) DEFAULT NULL COMMENT '会话反向类别比对方式类型：同上',
  `session_reverse_transfer_strategy_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '会话反向转换后标记',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级：同上',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_area_mark_name`(`name`) USING BTREE,
  INDEX `fk_strategy_area_mark_source_network_area_id`(`source_network_area_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_destination_network_area_id`(`destination_network_area_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_source_business_group_id`(`source_business_group_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_destination_business_group_id`(`destination_business_group_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_strategy_mark_id`(`strategy_mark_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_transfer_strategy_mark_id`(`transfer_strategy_mark_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_session_reverse_strategy_mark_id`(`session_reverse_strategy_mark_id`) USING BTREE,
  INDEX `fk_strategy_area_mark_sr_transfer_strategy_mark_id`(`session_reverse_transfer_strategy_mark_id`) USING BTREE,
  CONSTRAINT `strategy_area_mark_ibfk_1` FOREIGN KEY (`strategy_mark_id`) REFERENCES `strategy_mark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `strategy_area_mark_ibfk_2` FOREIGN KEY (`session_reverse_strategy_mark_id`) REFERENCES `strategy_mark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `strategy_area_mark_ibfk_3` FOREIGN KEY (`transfer_strategy_mark_id`) REFERENCES `strategy_mark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `strategy_area_mark_ibfk_4` FOREIGN KEY (`session_reverse_transfer_strategy_mark_id`) REFERENCES `strategy_mark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `strategy_area_mark_ibfk_5` FOREIGN KEY (`source_network_area_id`) REFERENCES `network_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `strategy_area_mark_ibfk_6` FOREIGN KEY (`destination_network_area_id`) REFERENCES `network_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安全标记策略-域间标记策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_browse
-- ----------------------------
DROP TABLE IF EXISTS `strategy_browse`;
CREATE TABLE `strategy_browse`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '命令',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `mime_type` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'MIME类型',
  `uri_list_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'URI名单ID',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_browse_name`(`name`) USING BTREE,
  INDEX `fk_strategy_browse_uri_list_id`(`uri_list_id`) USING BTREE,
  CONSTRAINT `strategy_browse_ibfk_1` FOREIGN KEY (`uri_list_id`) REFERENCES `strategy_list` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-安全浏览策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_content
-- ----------------------------
DROP TABLE IF EXISTS `strategy_content`;
CREATE TABLE `strategy_content`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `exec_action` tinyint(4) DEFAULT NULL COMMENT '执行动作：1-允许，2-阻断',
  `match_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '匹配方式：1-忽略大小写，2-.包含换行符，3-多行锚定，4-仅匹配模式，5-逻辑组合；多个分号分割',
  `keywords_list_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '关键字，名单配置ID',
  `keywords_list_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键字，名单配置名称',
  `code_format` tinyint(4) DEFAULT NULL COMMENT '编码格式：1-Base64，2-Utf-8，3-Unicode',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_content_name`(`name`) USING BTREE,
  INDEX `fk_strategy_content_keywords_list_id`(`keywords_list_id`) USING BTREE,
  CONSTRAINT `strategy_content_ibfk_1` FOREIGN KEY (`keywords_list_id`) REFERENCES `strategy_list` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-内容审查策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_custom_app
-- ----------------------------
DROP TABLE IF EXISTS `strategy_custom_app`;
CREATE TABLE `strategy_custom_app`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `app_end` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用结束符',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时长（s）',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_custom_app_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-定制应用策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_custom_app_command
-- ----------------------------
DROP TABLE IF EXISTS `strategy_custom_app_command`;
CREATE TABLE `strategy_custom_app_command`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `strategy_custom_app_id` bigint(20) UNSIGNED NOT NULL COMMENT '定制应用策略ID',
  `match_direction` tinyint(4) NOT NULL COMMENT '匹配方向',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_strategy_custom_app_command_strategy_custom_app_id`(`strategy_custom_app_id`) USING BTREE,
  CONSTRAINT `strategy_custom_app_command_ibfk_1` FOREIGN KEY (`strategy_custom_app_id`) REFERENCES `strategy_custom_app` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-定制应用策略-定制命令' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_custom_app_type_command
-- ----------------------------
DROP TABLE IF EXISTS `strategy_custom_app_type_command`;
CREATE TABLE `strategy_custom_app_type_command`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `strategy_custom_app_command_id` bigint(20) UNSIGNED NOT NULL COMMENT '定制应用策略-定制应用命令ID',
  `command` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '命令字',
  `offset` int(11) DEFAULT NULL COMMENT '偏移量',
  `splitter` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分隔符',
  `param` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数',
  `end` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结束符',
  `response_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '响应码',
  `response_offset` int(11) DEFAULT NULL COMMENT '响应偏移量',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_strategy_custom_app_type_command_sc_app_command_id`(`strategy_custom_app_command_id`) USING BTREE,
  CONSTRAINT `strategy_custom_app_type_command_ibfk_1` FOREIGN KEY (`strategy_custom_app_command_id`) REFERENCES `strategy_custom_app_command` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-定制应用策略-定制命令' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_custom_app_type_value
-- ----------------------------
DROP TABLE IF EXISTS `strategy_custom_app_type_value`;
CREATE TABLE `strategy_custom_app_type_value`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `strategy_custom_app_command_id` bigint(20) UNSIGNED NOT NULL COMMENT '定制应用策略-定制命令ID',
  `offset` int(11) DEFAULT NULL COMMENT '偏移量',
  `byte_num` int(11) DEFAULT NULL COMMENT '字节数',
  `end` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '结束符',
  `comparator` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '比较操作符',
  `compare_value` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '比较值',
  `response_offset` int(11) DEFAULT NULL COMMENT '响应偏移量',
  `response_byte_num` int(11) DEFAULT NULL COMMENT '响应字节数',
  `response_end` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '响应结束符',
  `response_comparator` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '响应比较操作',
  `response_compare_value` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '响应比较值',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_strategy_custom_app_type_value_strategy_custom_app_command_id`(`strategy_custom_app_command_id`) USING BTREE,
  CONSTRAINT `strategy_custom_app_type_value_ibfk_1` FOREIGN KEY (`strategy_custom_app_command_id`) REFERENCES `strategy_custom_app_command` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-定制应用策略-定制命令-数值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_data_lable
-- ----------------------------
DROP TABLE IF EXISTS `strategy_data_lable`;
CREATE TABLE `strategy_data_lable`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `in_flow` tinyint(4) DEFAULT NULL COMMENT '进流量检查',
  `out_flow` tinyint(4) DEFAULT NULL COMMENT '出流量封装',
  `level` int(11) DEFAULT NULL COMMENT '标记级别',
  `type` bigint(20) DEFAULT NULL COMMENT '标记类型',
  `info` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '说明',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_data_sign
-- ----------------------------
DROP TABLE IF EXISTS `strategy_data_sign`;
CREATE TABLE `strategy_data_sign`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `hmac_mode` tinyint(4) DEFAULT NULL COMMENT '签名模式',
  `in_flow` tinyint(4) DEFAULT NULL COMMENT '进流量检查',
  `out_flow` tinyint(4) DEFAULT NULL COMMENT '出流量封装',
  `seed` int(11) DEFAULT NULL COMMENT 'HMACkey种子',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_file
-- ----------------------------
DROP TABLE IF EXISTS `strategy_file`;
CREATE TABLE `strategy_file`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `command` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '命令',
  `user_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '用户名名单，分号分割',
  `upload_file_type_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '上传文件类型名单，分号分割',
  `download_file_type_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '下载文件类型名单，分号分割',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_file_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-文件传输策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_identify
-- ----------------------------
DROP TABLE IF EXISTS `strategy_identify`;
CREATE TABLE `strategy_identify`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '策略名称',
  `exec_action` tinyint(4) DEFAULT NULL COMMENT '执行动作：1-允许，2-阻断',
  `protocol` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用类型：HTTP、FTP、SMTP',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_list
-- ----------------------------
DROP TABLE IF EXISTS `strategy_list`;
CREATE TABLE `strategy_list`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名单名称',
  `type` tinyint(4) NOT NULL COMMENT '类型：1-URI，2-邮件地址，3-关键字',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_list_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-名单配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_mail
-- ----------------------------
DROP TABLE IF EXISTS `strategy_mail`;
CREATE TABLE `strategy_mail`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `transfer_proto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传输协议类型',
  `attachment_format_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '邮件附件格式名单，分号分割',
  `title_keyword_id` bigint(20) DEFAULT NULL COMMENT '邮件主题关键字名单，关键字ID',
  `mail_id` bigint(20) DEFAULT NULL COMMENT '邮件地址名单ID',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_mail_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-邮件策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_mark
-- ----------------------------
DROP TABLE IF EXISTS `strategy_mark`;
CREATE TABLE `strategy_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标记名称',
  `mark_type` tinyint(4) NOT NULL COMMENT '标记类型：1-type1 7-type7',
  `visit_mode` tinyint(4) DEFAULT NULL COMMENT '强访模式：1-机密性，2-完整性',
  `integrity` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '完整性密级',
  `confidentiality` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '机密性密级',
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类别列表',
  `doi` bigint(20) DEFAULT 12 COMMENT 'DOI',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_mark_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安全标记策略-标记' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_qos
-- ----------------------------
DROP TABLE IF EXISTS `strategy_qos`;
CREATE TABLE `strategy_qos`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `device_type` tinyint(4) DEFAULT NULL COMMENT '设备类型',
  `location` tinyint(4) DEFAULT NULL COMMENT '位置：1-发送端，2-接收端',
  `limit_speed_mode` tinyint(4) NOT NULL COMMENT '限速模式：1-限速， 2-限容',
  `work_mode` tinyint(4) NOT NULL COMMENT '工作模式：1-共享模式，2-独享模式',
  `message_type` tinyint(4) DEFAULT NULL COMMENT '报文类型',
  `up_value` int(11) DEFAULT NULL COMMENT '上行阈值',
  `up_unit` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上行阈值单位',
  `down_value` int(11) DEFAULT NULL COMMENT '下行阈值',
  `down_unit` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下行阈值单位',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级：1-信息级，2-低危级，3-中危级，4-高危级，5-严重级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_qos_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流量控制策略-QoS' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_spice
-- ----------------------------
DROP TABLE IF EXISTS `strategy_spice`;
CREATE TABLE `strategy_spice`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `exec_action` tinyint(4) DEFAULT NULL COMMENT '执行动作：1-允许，2-阻断',
  `channel_type` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道类型',
  `customize_channel` int(11) DEFAULT NULL COMMENT '自定义通道',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_spice_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-spice协议过滤策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_sql_check
-- ----------------------------
DROP TABLE IF EXISTS `strategy_sql_check`;
CREATE TABLE `strategy_sql_check`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `type` tinyint(4) NOT NULL COMMENT '类型：1-SQL审查，2-RTSP过滤，3-SIP过滤',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `sql_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'SQL语句类型',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_custom_app_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用安全策略-SQL审查策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for strategy_tag_mark
-- ----------------------------
DROP TABLE IF EXISTS `strategy_tag_mark`;
CREATE TABLE `strategy_tag_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标记名称',
  `mark_level` bigint(20) DEFAULT NULL COMMENT '标记级别',
  `mark_type` bigint(20) DEFAULT NULL COMMENT '标记类型',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_strategy_tag_mark_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安全标记策略-标记对象' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for study_browse
-- ----------------------------
DROP TABLE IF EXISTS `study_browse`;
CREATE TABLE `study_browse`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `study_visit_id` bigint(20) UNSIGNED NOT NULL COMMENT '业务ID',
  `rule_id` bigint(20) UNSIGNED NOT NULL COMMENT '策略ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '命令',
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `mime_type` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'MIME类型',
  `uri_list` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'URI名单',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-业务访问-自学习-安全浏览策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for study_visit
-- ----------------------------
DROP TABLE IF EXISTS `study_visit`;
CREATE TABLE `study_visit`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_visit_id` bigint(20) UNSIGNED NOT NULL COMMENT '业务ID',
  `business_visit_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `business_device_basic_id` bigint(20) UNSIGNED NOT NULL COMMENT 'AppID',
  `channel_info_id` bigint(20) UNSIGNED NOT NULL COMMENT '设备ID',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `gmt_start` datetime(0) DEFAULT NULL COMMENT '开始时间',
  `gmt_end` datetime(0) DEFAULT NULL COMMENT '结束时间',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_study_visit_border_device_basic_id`(`channel_info_id`) USING BTREE,
  CONSTRAINT `study_visit_ibfk_1` FOREIGN KEY (`channel_info_id`) REFERENCES `channel_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务访问配置-业务访问-自学习' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_client_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_client_info`;
CREATE TABLE `sys_client_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `port` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端服务端口',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据安全交换系统版本号',
  `sn` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端唯一编号',
  `dms_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管控管理口IP。保存客户端上报时保存的IP',
  `update_time` datetime(0) DEFAULT NULL COMMENT '客户端升级时间。升级成功了才修改',
  `update_state` tinyint(4) DEFAULT 0,
  `recover_state` tinyint(4) DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `restore_state` tinyint(4) DEFAULT NULL COMMENT '还原备份状态',
  `restore_uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `gmt_recover` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `gmt_restore` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `os_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端操作系统名称',
  `os_version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端操作系统版本',
  `manage_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '客户端通信IP。客户端上报管控时通过哪个网口，保存该网口IP',
  `business_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '业务口IP，可能有多个，逗号隔开',
  `channel_id` bigint(20) DEFAULT NULL COMMENT '通道ID channel_info表主键。保存客户端上报的通道ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '传输客户端信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idx` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `val` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zh_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sys_config_method`(`name`, `idx`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 0, 'zx.init.web.tokenTtl', '600', 'TOKEN有效期，(单位：秒)', '2025-02-11 10:27:14', '2025-02-11 10:27:14');
INSERT INTO `sys_config` VALUES (2, 0, 'zx.init.web.retryTimes', '3', '连续登录重试次数', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (3, 0, 'zx.init.web.retryInterval', '240', '登录失败，锁定时长，(单位：秒)', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (4, 0, 'zx.init.web.enableCrt', 'false', '启用用户证书', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (5, 0, 'zx.init.web.trustIps', '', '可信主机IP', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (6, 0, 'zx.init.system.ip', '', '集中管控IP', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (7, 0, 'password.rules', '{\"upper\":true,\"lower\":true,\"number\":true,\"special\":true,\"pwdLength\":[10,49]}', '密码复杂度', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (8, 0, 'password.forceChange', 'true', '强制更换密码开关', '2025-02-11 10:27:15', '2025-02-11 10:27:15');
INSERT INTO `sys_config` VALUES (9, 0, 'password.updateCircle', '30', '密码更换周期，(单位：天)', '2025-02-11 10:27:20', '2025-02-11 10:27:20');
INSERT INTO `sys_config` VALUES (10, 0, 'email.host', '', '邮件服务器地址', '2025-02-11 10:27:20', '2025-02-22 17:12:51');
INSERT INTO `sys_config` VALUES (11, 0, 'email.protocol', '', '协议', '2025-02-11 10:27:20', '2025-02-22 17:12:51');
INSERT INTO `sys_config` VALUES (12, 0, 'email.port', '25', '端口', '2025-02-11 10:27:21', '2025-02-22 17:12:51');
INSERT INTO `sys_config` VALUES (13, 0, 'email.username', '', '邮箱', '2025-02-11 10:27:21', '2025-02-22 17:12:51');
INSERT INTO `sys_config` VALUES (14, 0, 'email.password', '', '密码', '2025-02-11 10:27:21', '2025-02-22 17:12:51');
INSERT INTO `sys_config` VALUES (15, 0, 'syslog.host', '', '地址', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (16, 0, 'syslog.protocol', '', '协议', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (17, 0, 'syslog.port', '', '端口', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (18, 0, 'syslog.mode', '', '模式', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (19, 0, 'syslog.enable', 'false', '状态', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (20, 0, 'audit.log.enable', 'true', '全局审计日志', '2025-02-11 10:27:24', '2025-02-14 10:35:22');
INSERT INTO `sys_config` VALUES (21, 0, 'audit.log.access', 'true', '数据同步日志', '2025-02-11 10:27:24', '2025-02-14 10:35:22');
INSERT INTO `sys_config` VALUES (22, 0, 'audit.log.remote', 'false', '放行的应用安全策略日志', '2025-02-11 10:27:24', '2025-02-14 10:35:22');
INSERT INTO `sys_config` VALUES (23, 0, 'audit.limit.time', '180', '日志存储时长(天)', '2025-02-11 10:27:24', '2025-02-11 10:27:24');
INSERT INTO `sys_config` VALUES (24, 0, 'audit.limit.capacity', '10', '日志存储容量(GB)', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (25, 0, 'audit.limit.ftp.enable', 'false', 'FTP转存', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (26, 0, 'audit.limit.hostname', '', 'FTP服务器IP', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (27, 0, 'audit.limit.port', '', 'FTP服务器端口', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (28, 0, 'audit.limit.username', '', '用户名', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (29, 0, 'audit.limit.password', '', '密码', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (30, 0, 'audit.limit.ftpPath', '/', '路径', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (31, 0, 'audit.limit.logCanDeleted', 'false', '日志是否可删除', '2025-02-11 10:27:29', '2025-02-11 10:27:29');
INSERT INTO `sys_config` VALUES (32, 0, 'system.maintenance.username', 'jusonOPS', '运维用户', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (33, 0, 'system.maintenance.password', 'af036f9548992ef7b55f638ffc2bc4eff786f09289f002d15be7176b097eb214', '运维用户密码', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (34, 0, 'backup.ftp.enable', 'false', '自动备份开关', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (35, 0, 'backup.ftp.interval', '', '间隔时间(天)', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (36, 0, 'backup.ftp.hostname', '', '备份服务器地址', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (37, 0, 'backup.ftp.port', '', '备份服务器端口', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (38, 0, 'backup.ftp.username', '', '备份服务器账号', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (39, 0, 'backup.ftp.password', '', '备份服务器密码', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (40, 0, 'backup.ftp.path', '/', '备份上传路径', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (41, 0, 'backup.ftp.devices', '', '备份设备', '2025-02-11 10:27:33', '2025-02-11 10:27:33');
INSERT INTO `sys_config` VALUES (42, 0, 'baseline.enable', 'false', '基线核查开关', '2025-02-12 10:45:41', '2025-02-27 11:23:55');
INSERT INTO `sys_config` VALUES (43, 0, 'baseline.cycle', '7', '基线核查时效(天)', '2025-02-12 10:45:42', '2025-02-27 11:23:55');
INSERT INTO `sys_config` VALUES (44, 0, 'baseline.port', '6000', '基线核查上报端口', '2025-03-05 18:42:58', '2025-03-05 18:42:58');
INSERT INTO `sys_config` VALUES (45, 0, 'sys.name', 'all', '统一设备管理系统', '2025-02-11 10:27:36', '2025-02-11 10:27:36');
INSERT INTO `sys_config` VALUES (46, 0, 'client.ngx', 'true', '客户端与管控通信走业务口ngx代理', '2025-07-21 14:53:46', '2025-07-21 14:53:46');
INSERT INTO `sys_config` VALUES (47, 0, 'network.resource.rate', '10', '带宽利用率', '2025-08-25 14:46:56', '2025-08-25 14:46:56');
INSERT INTO `sys_config` VALUES (48, 0, 'network.resource.duration', '10', '持续时间', '2025-08-25 14:46:56', '2025-08-25 14:46:56');
INSERT INTO `sys_config` VALUES (49, 0, 'network.resource.ge', '600', '千兆口总带宽', '2025-08-25 14:46:56', '2025-08-25 14:46:56');
INSERT INTO `sys_config` VALUES (50, 0, 'network.resource.tg', '6', '万兆口总带宽', '2025-08-25 14:46:56', '2025-08-25 14:46:56');
INSERT INTO `sys_config` VALUES (51, 0, 'baseline.whiteList', '', '基线核查白名单', '2025-09-18 09:57:22', '2025-09-18 09:57:24');
INSERT INTO `sys_config` VALUES (52, 1, 'logType', 'SBRZ', '认证日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (53, 2, 'logType', 'SBYW', '业务访问日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (54, 3, 'logType', 'SBACLHIT', '网络访问控制日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (55, 4, 'logType', 'SBKGJ', 'DDoS攻击防护日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (56, 5, 'logType', 'SBGJCGL', '关键字过滤日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (57, 6, 'logType', 'SBWAF', 'WAF日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (58, 7, 'logType', 'SBDZYY', '自定义协议检查策略日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (59, 8, 'logType', 'SBAQLL', '安全浏览策略日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (60, 9, 'logType', 'SBWJCS', '文件传输策略日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (61, 10, 'logType', 'SBYJ', '邮件策略日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (62, 11, 'logType', 'SBYYBJ', '应用安全标记日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (63, 12, 'logType', 'SBBJGL', '域间标记日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (64, 13, 'logType', 'SBQOSGL', '流量控制日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (65, 14, 'logType', 'SBHAYC', 'HA切换日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (66, 15, 'logType', 'SBIPS', '入侵检测日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (67, 16, 'logType', 'SBSQL', 'SQL审查日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (68, 17, 'logType', 'SBRTSP', 'RTSP过滤日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (69, 18, 'logType', 'SBSIP', 'SIP过滤日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (70, 19, 'logType', 'SBFTPSJ', '单向文件同步日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (71, 20, 'logType', 'SBFTPTJ', '文件同步统计', NULL, NULL);
INSERT INTO `sys_config` VALUES (72, 21, 'logType', 'SBFTPYD', '文件同步源端处理日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (73, 22, 'logType', 'SBDBTSMXX', '单向数据库同步日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (74, 23, 'logType', 'SBACCESS', '单向数据导入日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (75, 24, 'logType', 'SBSPICE', '虚拟桌面协议过滤日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (76, 25, 'logType', 'SBDTCP', '双单向数据交换日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (77, 26, 'logType', 'SBBLSEC', '基线核查日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (78, 27, 'logType', 'SBIPMAC', 'IPMAC绑定日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (79, 28, 'logType', 'SBVIRUS', '病毒防护日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (80, 29, 'logType', 'SBSJWZXJC', '数据完整性检查日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (81, 30, 'logType', 'SBJJM', '数据加解密日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (82, 31, 'logType', 'SBFLCTL', '网络资源控制日志', '2025-12-03 10:37:01', '2025-12-03 10:37:01');
INSERT INTO `sys_config` VALUES (83, 32, 'logType', 'SBFK', '飞控协议过滤日志', '2025-12-03 10:33:32', '2025-12-03 10:33:32');
INSERT INTO `sys_config` VALUES (84, 33, 'logType', 'SBSPT', '视频通日志', '2025-12-03 10:33:33', '2025-12-03 10:33:33');
INSERT INTO `sys_config` VALUES (85, 34, 'logType', 'SBDL', '设备登录日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (86, 35, 'logType', 'SBYC', '设备异常日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (87, 36, 'logType', 'SBCZ', '设备操作日志', NULL, NULL);
INSERT INTO `sys_config` VALUES (88, 37, 'logType', 'SBSXWJGL', '文件过滤日志', '2026-01-07 17:25:31', '2026-01-07 17:25:35');
INSERT INTO `sys_config` VALUES (89, 0, 'zx.init.web.jsp.port', '50000-51000', 'JSP端口范围', '2025-12-27 10:07:50', '2025-12-27 10:07:50');
INSERT INTO `sys_config` VALUES (90, 0, 'zx.init.ntp.type', '时间', '类型', '2026-01-21 16:01:53', '2026-01-21 16:01:53');
INSERT INTO `sys_config` VALUES (91, 0, 'zx.init.ntp.time', '', '时间', '2026-01-21 16:01:53', '2026-01-21 16:01:53');
INSERT INTO `sys_config` VALUES (92, 0, 'zx.init.ntp.server', '', '服务器', '2026-01-21 16:01:54', '2026-01-21 16:01:54');
INSERT INTO `sys_config` VALUES (93, 0, 'zx.init.ntp.cycle', '', '同步周期（分钟）', '2026-01-21 16:01:54', '2026-01-21 16:01:54');

-- ----------------------------
-- Table structure for sys_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_info`;
CREATE TABLE `sys_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `val` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zh_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sys_info_method`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_info
-- ----------------------------
INSERT INTO `sys_info` VALUES (1, 'sys.name', '一体化双单向数据安全交换系统', '系统名称', '2021-09-03 10:16:05', '2025-12-01 10:13:48');
INSERT INTO `sys_info` VALUES (4, 'license.begin', '2025-05-27', '证书有效期开始时间', '2022-03-28 14:39:54', '2025-07-03 18:55:46');
INSERT INTO `sys_info` VALUES (5, 'license.end', '2026-05-27', '证书有效期结束时间', '2022-03-28 14:39:54', '2025-07-03 18:55:46');

-- ----------------------------
-- Table structure for tb_cmp_flow_analyse_min
-- ----------------------------
DROP TABLE IF EXISTS `tb_cmp_flow_analyse_min`;
CREATE TABLE `tb_cmp_flow_analyse_min`  (
  `total_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '统计时间',
  `device` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备sn号',
  `ifname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口名称',
  `upflow` bigint(20) NOT NULL COMMENT '上行流量',
  `downflow` bigint(20) NOT NULL COMMENT '下行流量',
  `uppackage` bigint(20) NOT NULL COMMENT '上行报文数',
  `downpackage` bigint(20) NOT NULL COMMENT '下行报文数',
  `hitcount` bigint(20) NOT NULL COMMENT '连接数',
  INDEX `index_tb_cmp_flow_analyse_min_device`(`device`) USING BTREE,
  INDEX `index_tb_cmp_flow_analyse_min_time`(`total_time`) USING BTREE,
  INDEX `index_tb_cmp_flow_analyse_min_ifname`(`ifname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_approval_opinion
-- ----------------------------
DROP TABLE IF EXISTS `trans_approval_opinion`;
CREATE TABLE `trans_approval_opinion`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '申请类型：1-下发，5-移除，文件传输审核',
  `opinion` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审批意见',
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审批结果',
  `approval_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审批用户',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审核信息表，包含业务下发，业务移除，文件传输审核' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_data
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_data`;
CREATE TABLE `trans_busi_data`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：发送端sender，接收端receiver，接收端中转recSender',
  `location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '位置',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `dispatch_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下发批次号',
  `group_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务组ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `rank` tinyint(4) DEFAULT NULL COMMENT '安全等级',
  `transmit_model` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'FTP' COMMENT '同步方式：UDP,TCP',
  `l7_proto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用层协议',
  `busi_mode` tinyint(4) DEFAULT NULL COMMENT '业务模式：0-反向代理，1-透明代理',
  `transmit_data_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '数据资源ID',
  `transmit_data_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据资源名称',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络域名称',
  `sip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源IP地址',
  `ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `channel_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '通道ID',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `device_sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备的SN号',
  `local_proxy_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '本机代理IP',
  `local_proxy_port` int(11) DEFAULT NULL COMMENT '本机代理端口',
  `local_feedback_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '本机反馈ip',
  `local_feedback_port` int(11) DEFAULT NULL COMMENT '本机反馈端口',
  `local_feedback_sip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发送端反馈源IP',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '调度周期id',
  `delay_sync` int(11) DEFAULT NULL COMMENT '延迟同步时间',
  `strategy_qos_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '流量控制策略',
  `strategy_custom_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '定制应用策略',
  `strategy_content_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '内容审查策略',
  `strategy_area_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '域间标记策略',
  `strategy_app_mark_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '应用安全标记策略',
  `strategy_spice_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'SPICE协议过滤策略',
  `strategy_acl_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络安全策略',
  `strategy_identify_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用识别策略',
  `strategy_data_lable_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'dse应用安全标记策略',
  `strategy_data_sign_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '数据签名策略',
  `filter_file_name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件名称过滤，策略id，英文逗号分隔',
  `filter_file_type` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件类型过滤，策略id，英文逗号分隔',
  `filter_file_suffix` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件后缀名过滤，策略id，英文逗号分隔',
  `waf` tinyint(1) DEFAULT NULL COMMENT 'WAF防护开关',
  `waf_work_state` tinyint(4) DEFAULT -1 COMMENT 'WAF防护开关生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `virus` tinyint(1) DEFAULT NULL COMMENT '病毒扫描开关',
  `virus_work_state` tinyint(4) DEFAULT -1 COMMENT '病毒扫描开关生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `data_cfus` tinyint(1) DEFAULT NULL COMMENT '数据混淆策略',
  `data_cfus_work_state` tinyint(4) DEFAULT -1 COMMENT '数据混淆策略生效状态',
  `video_enable` tinyint(1) DEFAULT NULL COMMENT '视频开关',
  `audio_enable` tinyint(1) DEFAULT NULL COMMENT '音频开关',
  `proto_enable` tinyint(1) DEFAULT NULL COMMENT '飞控协议过滤开关',
  `flight_action` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '过滤动作',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户名',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `approval_state` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `strategy_qos_id`(`strategy_qos_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-数据传输业务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_data_strategy_content
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_data_strategy_content`;
CREATE TABLE `trans_busi_data_strategy_content`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `strategy_content_id` bigint(20) UNSIGNED NOT NULL COMMENT '内容审查策略id',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `business_id`(`business_id`) USING BTREE,
  INDEX `strategy_custom_app_id`(`strategy_content_id`) USING BTREE,
  CONSTRAINT `trans_busi_data_strategy_content_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `trans_busi_data` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `trans_busi_data_strategy_content_ibfk_2` FOREIGN KEY (`strategy_content_id`) REFERENCES `strategy_content` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-数据传输业务-内容审查策略关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_data_strategy_custom
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_data_strategy_custom`;
CREATE TABLE `trans_busi_data_strategy_custom`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `strategy_custom_app_id` bigint(20) UNSIGNED NOT NULL COMMENT '定制应用策略id',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `business_id`(`business_id`) USING BTREE,
  INDEX `strategy_custom_app_id`(`strategy_custom_app_id`) USING BTREE,
  CONSTRAINT `trans_busi_data_strategy_custom_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `trans_busi_data` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `trans_busi_data_strategy_custom_ibfk_2` FOREIGN KEY (`strategy_custom_app_id`) REFERENCES `strategy_custom_app` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-数据传输业务-定制应用关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_db
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_db`;
CREATE TABLE `trans_busi_db`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：发送端sender，接收端receiver，接收端中转recSender',
  `location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '位置',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `dispatch_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下发批次号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `socket_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '代理IP',
  `socket_port` int(11) DEFAULT NULL COMMENT '代理端口',
  `rank` tinyint(4) DEFAULT NULL COMMENT '安全等级',
  `db_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库类型',
  `transmit_db_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '数据库资源ID',
  `transmit_db_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库资源名称',
  `channel_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '通道ID',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `device_sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备SN',
  `device_type` tinyint(4) NOT NULL COMMENT '设备类型：1-网关，2-隔离，3-单导',
  `strategy_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '策略ID',
  `strategy_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '策略名称',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '调度周期ID',
  `business_time_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '调度周期名称',
  `delay_sync` int(11) DEFAULT NULL COMMENT '延迟同步时间',
  `max_flow` int(11) DEFAULT NULL COMMENT '流量控制',
  `max_flow_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流量控制单位',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `approval_state` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  `link_state` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '连接状态：正常，失败，无权限',
  `transmit_state` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传输状态：正在传输，传输停止',
  `virus` tinyint(1) DEFAULT 0 COMMENT '病毒开启标识',
  `virus_work_state` tinyint(4) DEFAULT -1 COMMENT '病毒生效状态',
  `keywords` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '关键字',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户名',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-数据库同步业务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_db_table
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_db_table`;
CREATE TABLE `trans_busi_db_table`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `source_table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '源表名',
  `source_primary_field` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源表主键字段',
  `source_increas_field` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源表自增字段',
  `dest_table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的表名称',
  `dest_primary_field` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的表主键字段',
  `dest_increas_field` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '目的表自增字段',
  `field_list` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段配置',
  `filter_field` longtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'where过滤配置',
  `gmt_create` datetime(0) NOT NULL,
  `gmt_modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-数据库同步业务-表数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_busi_file
-- ----------------------------
DROP TABLE IF EXISTS `trans_busi_file`;
CREATE TABLE `trans_busi_file`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：发送端sender，接收端receiver，接收端中转recSender',
  `location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '位置',
  `business_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '业务ID',
  `dispatch_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '下发批次号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务名称',
  `rank` tinyint(4) DEFAULT NULL COMMENT '安全等级',
  `socket_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '代理IP',
  `socket_port` int(11) DEFAULT NULL COMMENT '代理端口',
  `transmit_model` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'FTP' COMMENT '文件同步模式',
  `channel_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '通道id',
  `channel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通道名称',
  `device_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '设备ID',
  `device_sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '设备的SN号',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '接收子目录，默认采用文件资源的，可以覆盖',
  `business_time_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '调度周期id',
  `delay_sync` int(11) DEFAULT NULL COMMENT '延迟同步时间',
  `max_file_size` bigint(20) DEFAULT NULL COMMENT '文件大小限制，最大10GB',
  `file_size_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件大小限制单位',
  `max_flow` int(11) DEFAULT NULL COMMENT '流量控制，单位是KB/S',
  `max_flow_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流量控制单位',
  `filter_file_name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件名称过滤，策略id，英文逗号分隔',
  `filter_file_type` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件类型过滤，策略id，英文逗号分隔',
  `filter_file_suffix` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件后缀名过滤，策略id，英文逗号分隔',
  `filter_file_content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件内容关键字过滤，策略id，英文逗号分隔',
  `xftp_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'XFTP信息',
  `work_state` tinyint(4) DEFAULT -1 COMMENT '生效状态：-1-未下发，1-已下发，2-未生效，3-已生效',
  `approval_state` tinyint(4) DEFAULT NULL COMMENT '审批状态',
  `link_state` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '连接状态：正常，失败，无权限',
  `transmit_state` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传输状态：正在传输，传输停止',
  `virus` tinyint(1) DEFAULT 0 COMMENT '病毒开启标识',
  `virus_work_state` tinyint(4) DEFAULT -1 COMMENT '病毒生效状态',
  `continued` tinyint(1) DEFAULT 0 COMMENT '病毒开启标识',
  `label_enable` tinyint(1) DEFAULT 0 COMMENT '数据标识开关：0-关闭 1-打开',
  `complete_enable` tinyint(1) DEFAULT 0 COMMENT '数据完整性开关： 0-关闭  1-打开',
  `confidentiality_level` tinyint(4) DEFAULT NULL COMMENT '保密级别。与文件传输保密级别和审核有关',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建用户名',
  `deleting` tinyint(4) DEFAULT 0 COMMENT '正在删除',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `transmit_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '之前trans_strategy_file表字段：文件同步方式:全量同步，增量同步',
  `conflict_strategy` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '之前trans_strategy_file表字段：上传冲突策略:覆盖,丢弃,重命名',
  `resend_num` int(11) DEFAULT 0 COMMENT '之前trans_strategy_file表字段：接收端重发次数上限，默认0，最大10',
  `content_check` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：内容完整性检查：0-不检查，1-检查',
  `source_deal` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '之前trans_strategy_file表字段：源端处理：源端复制，源端删除，源端移动',
  `backup_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '之前trans_strategy_file表字段：源端文件备份目录',
  `sync_delete` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：同步删除：0-不删除，1-删除',
  `level` int(11) DEFAULT 1 COMMENT '之前trans_strategy_file表字段：优先级：1到5，默认1',
  `empty_path_deal_type` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：空文件夹处理方式：0-传输，1-跳过',
  `empty_file_deal_type` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：空文件处理方式',
  `small_file_first` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：小文件优先传输：0-否，1-是',
  `security_rank` tinyint(4) DEFAULT NULL COMMENT '之前trans_strategy_file表字段：威胁安全等级',
  `small_file_limit` bigint(20) DEFAULT NULL COMMENT '之前trans_strategy_file表max_file_size字段：小文件大小限制',
  `confidentiality_enable` tinyint(1) DEFAULT 1 COMMENT '降密脱敏开关。 0-关闭  1-打开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输业务-文件传输业务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_data
-- ----------------------------
DROP TABLE IF EXISTS `trans_data`;
CREATE TABLE `trans_data`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据资源类型：发送端sender，接收端receiver',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源名称',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络域名称',
  `transmit_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '传输方式：UDP,TCP,DTCP',
  `ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导数据资源配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_db
-- ----------------------------
DROP TABLE IF EXISTS `trans_db`;
CREATE TABLE `trans_db`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据库资源类型：发送端sender，接收端receiver',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源名称',
  `network_area_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '网络域ID',
  `network_area_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网络域名称',
  `db_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库类型：oracle,mysql,sqlserver,db2,sybase',
  `db_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库服务IP',
  `db_port` int(11) DEFAULT NULL COMMENT '数据库服务端口',
  `db_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据库名',
  `user_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `user_pwd` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导数据库资源配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_strategy_db
-- ----------------------------
DROP TABLE IF EXISTS `trans_strategy_db`;
CREATE TABLE `trans_strategy_db`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据资源类型：发送端sender，接收端receiver',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `content_check` tinyint(4) DEFAULT 1 COMMENT '内容完整性检查：0-不检查，1-检查',
  `conflict_strategy` tinyint(4) DEFAULT NULL COMMENT '冲突数据处理方式：0-不覆盖，1-覆盖',
  `content_check_size` int(11) DEFAULT 1 COMMENT '接收端完整性检查力度',
  `transmit_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '同步方式：全表复制Copy，增量更新Increment，全表更新Total',
  `transmit_operation` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '同步操作',
  `operation_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作名称',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级：1-信息级，2-低危级，3-中危级，4-高危级，5-严重级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据库传输发送端策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_strategy_file
-- ----------------------------
DROP TABLE IF EXISTS `trans_strategy_file`;
CREATE TABLE `trans_strategy_file`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据资源类型：发送端sender，接收端receiver',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `transmit_model` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'FTP' COMMENT '文件同步模式：FTP',
  `transmit_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '文件同步方式：全量同步，增量同步',
  `conflict_strategy` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '上传冲突策略:覆盖,丢弃,重命名',
  `resend_num` int(11) DEFAULT 0 COMMENT '接收端重发次数上限，默认0，最大10',
  `content_check` tinyint(4) DEFAULT NULL COMMENT '内容完整性检查：0-不检查，1-检查',
  `source_deal` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源端处理：源端复制，源端删除，源端移动',
  `backup_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '源端文件备份目录',
  `sync_delete` tinyint(4) DEFAULT NULL COMMENT '同步删除：0-不删除，1-删除',
  `level` int(11) DEFAULT 1 COMMENT '优先级：1到5，默认1',
  `empty_path_deal_type` tinyint(4) DEFAULT NULL COMMENT '空文件夹处理方式：0-传输，1-跳过',
  `empty_file_deal_type` tinyint(4) DEFAULT NULL COMMENT '空文件处理方式',
  `small_file_first` tinyint(4) DEFAULT NULL COMMENT '小文件优先传输：0-否，1-是',
  `max_file_size` bigint(20) DEFAULT NULL COMMENT '文件大小上限，单位是KB',
  `security_rank` tinyint(4) NOT NULL COMMENT '威胁安全等级',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件传输发送端策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trans_strategy_filter
-- ----------------------------
DROP TABLE IF EXISTS `trans_strategy_filter`;
CREATE TABLE `trans_strategy_filter`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `type` tinyint(4) NOT NULL COMMENT '类型：1-文件名过滤，2-文件后缀过滤，3-文件类型过滤',
  `exec_action` tinyint(4) NOT NULL COMMENT '执行动作：1-允许，2-阻断',
  `keywords` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键字',
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '单导传输策略-过滤策略' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `org_structure_id` bigint(20) UNSIGNED DEFAULT NULL,
  `org_structure_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `responsibility` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `rank` tinyint(4) DEFAULT NULL,
  `login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ip_check` tinyint(1) DEFAULT NULL,
  `gmt_login` datetime(0) DEFAULT NULL,
  `cert_md5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cert_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cert_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_user` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `gmt_change_pwd` datetime(0) DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `jsp_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'JSP密码 只有客户端用户有',
  `system_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户所属系统 dms管控用户/client客户端用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'sysadmin', '系统管理员', NULL, NULL, NULL, '', '13456789012', '5623ab3867ee8f01543097f6a5c87e37f79a9a8a1a932c2dd7dc6bbb86f40b90', 1, 1, 4, '10.10.88.224', NULL, '2025-12-02 18:07:23', 'bb487d32c1458444e4acfdb7b707b4ce', 'user', 'sysadmin.crt', NULL, NULL, '2022-08-25 14:16:24', '2025-11-24 11:31:46', NULL, NULL);
INSERT INTO `user` VALUES (3, 'secadmin', '安全管理员', NULL, NULL, NULL, '', '13456789012', '54e70ac3f721ca5fb39e5387338f313e6cd41f4e67013134ef787948075c8b5f', 1, 1, 2, '10.10.88.224', NULL, '2025-12-02 14:16:34', 'af0e9d208a1497c32a31f0e16af3b20b', 'user', 'secadmin.crt', NULL, NULL, '2022-08-25 14:17:19', '2025-11-24 11:31:02', NULL, NULL);
INSERT INTO `user` VALUES (4, 'logadmin', '审计管理员', NULL, NULL, NULL, '', '13456780123', '1d5da1bf0acb97d60c1ca3288e5c7fe7f3334cc6a3d674c657b79456da8151eb', 1, 1, 4, '10.10.88.223', NULL, '2025-11-26 15:07:19', '0a397de8f68a561791ba2373e03dff33', 'user', 'logadmin.crt', NULL, NULL, '2022-08-25 14:18:24', '2025-11-25 16:05:07', NULL, NULL);
INSERT INTO `user` VALUES (5, 'approver', '业务审核人员', NULL, NULL, NULL, NULL, NULL, 'f5ea0db93d63048b963ed3e6796b6a3a10b17283eeb2bbe9be6b7d60e9d73f9f', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-15 18:15:53', '2025-07-15 18:15:56', NULL, NULL);
INSERT INTO `user` VALUES (6, 'appadmin', '业务管理员', NULL, NULL, NULL, NULL, NULL, 'c34f355d85796bba3f39e4b09ba5c8ddc675d9f37b2d1272fc09ec68bd40c992', NULL, 1, 1, NULL, NULL, NULL, NULL, 'user', 'appadmin.crt', NULL, NULL, '2025-12-17 15:48:49', '2025-12-17 15:48:53', NULL, NULL);

-- ----------------------------
-- Table structure for user_entity_access_device
-- ----------------------------
DROP TABLE IF EXISTS `user_entity_access_device`;
CREATE TABLE `user_entity_access_device`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `entity_access_device_id` int(11) NOT NULL COMMENT 'entity_access_device表的id，代表一个文件传输客户端实体',
  `user_id` int(11) NOT NULL COMMENT 'user表id，代表一个文件传输用户',
  `gmt_create` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `active_status` tinyint(1) DEFAULT NULL COMMENT '生效状态：关联后客户端创建用户等操作是否成功：-1失败;0待处理;1成功',
  `login_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登陆IP',
  `gmt_login` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `approve_user_id` int(11) DEFAULT NULL COMMENT '审批人员ID  用户在绑定客户端时需要指定一个审批用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uq_sysclientinfo_user`(`entity_access_device_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '映射表：建立user(用户表)和sys_client_info(文件传输客户端)两张表的映射关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_login_record
-- ----------------------------
DROP TABLE IF EXISTS `user_login_record`;
CREATE TABLE `user_login_record`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  `gmt_logout` datetime(0) DEFAULT NULL,
  `str_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_permission_group
-- ----------------------------
DROP TABLE IF EXISTS `user_permission_group`;
CREATE TABLE `user_permission_group`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `permission_group_id` bigint(20) UNSIGNED NOT NULL,
  `gmt_create` datetime(0) DEFAULT NULL,
  `gmt_modified` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_permission_user_id`(`user_id`) USING BTREE,
  INDEX `fk_user_permission_group_permission_group_id`(`permission_group_id`) USING BTREE,
  CONSTRAINT `user_permission_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_permission_group_ibfk_2` FOREIGN KEY (`permission_group_id`) REFERENCES `permission_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_permission_group
-- ----------------------------
INSERT INTO `user_permission_group` VALUES (1, 2, 2, '2022-08-25 14:19:41', '2022-08-25 14:19:43');
INSERT INTO `user_permission_group` VALUES (2, 3, 3, '2022-08-25 14:19:48', '2022-08-25 14:19:50');
INSERT INTO `user_permission_group` VALUES (3, 4, 4, '2022-08-25 14:19:54', '2022-08-25 14:19:57');
INSERT INTO `user_permission_group` VALUES (4, 5, 5, '2025-09-22 16:27:57', '2025-09-22 16:27:59');
INSERT INTO `user_permission_group` VALUES (5, 6, 6, '2025-12-18 17:46:08', '2025-12-18 17:46:10');

-- ----------------------------
-- Table structure for xftp_server_info
-- ----------------------------
DROP TABLE IF EXISTS `xftp_server_info`;
CREATE TABLE `xftp_server_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `port` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `gmt_create` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `gmt_modified` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Procedure structure for clearData
-- ----------------------------
DROP PROCEDURE IF EXISTS `clearData`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `clearData`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE table_name VARCHAR(255);
    DECLARE cur CURSOR FOR 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = DATABASE() 
          AND table_name NOT IN ('menu', 'permission', 'user', 'permission_group', 'user_permission_group',
                                  'sys_config', 'sys_info', 'scheduler_job_config');
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO table_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- 使用动态 SQL 执行 TRUNCATE TABLE
        SET @sql = CONCAT('TRUNCATE TABLE ', table_name);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE cur;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for InsertUsers
-- ----------------------------
DROP PROCEDURE IF EXISTS `InsertUsers`;
delimiter ;;
CREATE DEFINER=`root`@`%` PROCEDURE `InsertUsers`()
BEGIN
    DECLARE userId INT DEFAULT 50;
	DECLARE entityId INT DEFAULT 7;

    DECLARE i INT DEFAULT 1;
    DECLARE port INT DEFAULT 4000;
	-- 开启事务
    START TRANSACTION;
	
    WHILE i <= 2000 DO
				# 创建用户数据
        INSERT INTO user (id,name,nick_name,password,enabled, gmt_create) VALUES 
				(userId,CONCAT('wq', i),CONCAT('wq', i),'1ae9b5bce62b6f8fdd8eec5de83f3ab72c9d06263e1780b0f1f9c3ca52335165',1, now());

				INSERT INTO user_permission_group (user_id, permission_group_id, gmt_create) VALUES (userId,5, now());
				
				# jsp_server_info表插入一条
        INSERT INTO jsp_server_info(path,send_port,password,user_id, active_status, gmt_create) values(
            '/root/test/xn', port, 'fbc65462279ca593608ed5407c63687b',userId, 0, now());
				
        INSERT into user_entity_access_device(entity_access_device_id, user_id, active_status, gmt_create) values(entityId, userId, 0, now());
        
        SET i = i + 1;
        SET port = port + 1;
        SET userId = userId + 1;
    END WHILE;
	
	-- 提交事务
    COMMIT;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
