UPDATE `menu` SET parent_menus = 'root,auditmng,auditcof',`index`=1 WHERE id = 104;
UPDATE `menu` SET parent_menus = 'root,auditmng,auditcof',`index`=2 WHERE id = 105;
UPDATE `menu` SET parent_menus = 'root,auditmng,auditcof',`index`=3 WHERE id = 106;
UPDATE `menu` SET parent_menus = 'root,auditmng,auditcof',`index`=4 WHERE id = 107;
ALTER TABLE `alarm_info` ADD COLUMN `channel_name` VARCHAR(255) NULL COMMENT '通道名称' AFTER `device_name`;