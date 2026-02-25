ALTER TABLE `device_info` ADD COLUMN `network_area_id` BIGINT(20) UNSIGNED NULL COMMENT '网络域ID' AFTER `name`;
ALTER TABLE `device_info` ADD COLUMN `network_area_name` VARCHAR(255) NULL COMMENT '网络域名称' AFTER `network_area_id`;
ALTER TABLE `device_info` ADD COLUMN `product_model` VARCHAR(50) NULL COMMENT '设备型号' AFTER `device_flag`;
ALTER TABLE `device_info` ADD COLUMN `device_version` VARCHAR(50) NULL COMMENT '设备版本' AFTER `product_model`;
ALTER TABLE `device_info` ADD COLUMN `manufacturing_date` VARCHAR(30) NULL COMMENT '出厂日期' AFTER `device_version`;
ALTER TABLE `device_info` ADD COLUMN `introduction` VARCHAR(100) NULL COMMENT '产品简介' AFTER `manufacturing_date`;
ALTER TABLE `channel_time` DROP INDEX `fk_border_device_border_device_basic_id`;
ALTER TABLE `channel_time` DROP FOREIGN KEY `channel_time_ibfk_1`;