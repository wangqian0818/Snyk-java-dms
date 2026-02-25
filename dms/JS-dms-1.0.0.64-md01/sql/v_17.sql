ALTER TABLE `trans_busi_db` ADD COLUMN `channel_name` VARCHAR(255) NULL COMMENT '通道名称' AFTER `channel_info_id`;
ALTER TABLE `trans_busi_db` ADD COLUMN `device_sn` VARCHAR(255) NULL COMMENT '设备SN' AFTER `device_id`;
ALTER TABLE `trans_busi_db` CHANGE `create_user` `create_user` VARCHAR(32) NULL COMMENT '创建用户名' AFTER `keywords`;