INSERT INTO `menu` VALUES ('8', now(), now(), 'root,control,identity', 'identity-ip', '8', null, '4');
INSERT INTO `permission` VALUES ('18', '接入控制-认证管理-认证IP-查询结果', '/identity/identity-ip', 'GET', '8', '1', now(), now());
INSERT INTO `permission_group_permission`(permission_group_id, permission_id, gmt_create, gmt_modified)  VALUES (3, 18, now(), now());