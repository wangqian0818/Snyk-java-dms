INSERT INTO `menu` VALUES ('207', '2025-12-03 17:21:46', '2025-12-03 17:21:48', 'root,system', 'sysinfo', '207', NULL, NULL);
INSERT INTO `permission` VALUES ('608', '系统管理-系统信息-查询', '/system/sysinfo', 'GET', '207', '1', '2025-12-03 17:25:55', '2025-12-03 17:25:56');
INSERT INTO `permission_group_permission` (permission_group_id, permission_id, readonly, gmt_create, gmt_modified) VALUES ('5', '608', '0', '2025-12-03 17:28:40', '2025-12-03 17:28:41');
ALTER TABLE `mq_message` ADD COLUMN `channel_name` VARCHAR(255) NULL COMMENT '通道名称' AFTER `device_name`;