/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : tp5

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2016-10-11 16:09:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tp5_action
-- ----------------------------
DROP TABLE IF EXISTS `tp5_action`;
CREATE TABLE `tp5_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='系统行为表';

-- ----------------------------
-- Records of tp5_action
-- ----------------------------
INSERT INTO `tp5_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次，嘿嘿', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1469853599');
INSERT INTO `tp5_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '1', '1380173180');
INSERT INTO `tp5_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `tp5_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '1', '1386139726');
INSERT INTO `tp5_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '1', '1383285551');
INSERT INTO `tp5_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `tp5_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `tp5_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `tp5_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `tp5_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `tp5_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for tp5_action_log
-- ----------------------------
DROP TABLE IF EXISTS `tp5_action_log`;
CREATE TABLE `tp5_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`) USING BTREE,
  KEY `action_id_ix` (`action_id`) USING BTREE,
  KEY `user_id_ix` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行为日志表';

-- ----------------------------
-- Records of tp5_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_addons
-- ----------------------------
DROP TABLE IF EXISTS `tp5_addons`;
CREATE TABLE `tp5_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of tp5_addons
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_attachment
-- ----------------------------
DROP TABLE IF EXISTS `tp5_attachment`;
CREATE TABLE `tp5_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of tp5_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `tp5_auth_extend`;
CREATE TABLE `tp5_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`) USING BTREE,
  KEY `uid` (`group_id`) USING BTREE,
  KEY `group_id` (`extend_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of tp5_auth_extend
-- ----------------------------
INSERT INTO `tp5_auth_extend` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for tp5_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `tp5_auth_group`;
CREATE TABLE `tp5_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_auth_group
-- ----------------------------
INSERT INTO `tp5_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,22,26,27,88');
INSERT INTO `tp5_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,22,26,27,61,66,88,100,102,103,108,109,172,207,231,233,238,239,240,241,242,243,244,249,250,251,252,253,254,255,256,257,258');

-- ----------------------------
-- Table structure for tp5_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `tp5_auth_group_access`;
CREATE TABLE `tp5_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_auth_group_access
-- ----------------------------
INSERT INTO `tp5_auth_group_access` VALUES ('1', '8');

-- ----------------------------
-- Table structure for tp5_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `tp5_auth_rule`;
CREATE TABLE `tp5_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_auth_rule
-- ----------------------------
INSERT INTO `tp5_auth_rule` VALUES ('1', 'admin', '2', 'admin/Index/index', '首页', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('3', 'admin', '2', 'admin/User/index', '用户', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('22', 'admin', '1', 'admin/User/setStatus', '单个更新（启用、禁用、删除）', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('26', 'admin', '1', 'admin/User/index', '用户信息', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('61', 'admin', '1', 'admin/Deploy/edit', '新增或编辑', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('65', 'admin', '1', 'admin/Deploy/group', '网站配置', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('66', 'admin', '1', 'admin/Deploy/index', '配置管理', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('70', 'admin', '1', 'admin/Channel/index', '导航菜单', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('74', 'admin', '1', 'admin/Category/index', '分类管理', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('100', 'admin', '1', 'admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('102', 'admin', '1', 'admin/Menu/add', '新增', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('103', 'admin', '1', 'admin/Menu/edit', '编辑', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('107', 'admin', '1', 'admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('108', 'admin', '1', 'admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('109', 'admin', '1', 'admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('172', 'admin', '2', 'admin/Deploy/group', '系统', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('207', 'admin', '1', 'admin/Menu/import', '导入', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('231', 'admin', '1', 'admin/User/edit', '新增用户', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('233', 'admin', '1', 'admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('238', 'admin', '1', 'admin/AuthManager/editgroup', '新增和编辑', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('239', 'admin', '1', 'admin/AuthManager/writegroup', '保存和编辑用户组', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('240', 'admin', '1', 'admin/AuthManager/group', '授权', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('241', 'admin', '1', 'admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('242', 'admin', '1', 'admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('243', 'admin', '1', 'admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('244', 'admin', '1', 'admin/AuthManager/addtogroup', '保存成员授权', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('249', 'admin', '1', 'admin/User/batchupdate', '批量更新(启用、禁用、删除)', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('250', 'admin', '1', 'admin/AuthManager/batchupdate', '批量用户组状态变更', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('251', 'admin', '1', 'admin/AuthManager/setstatus', '单个用户组状态变更', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('252', 'admin', '1', 'admin/AuthManager/rulesarrayupdate', '访问授权保存', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('253', 'admin', '1', 'admin/Menu/toogle', '仅开发者模式显示和隐藏', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('254', 'admin', '1', 'admin/Menu/setStatus', '单个菜单状态更改', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('255', 'admin', '1', 'admin/Menu/batchupdate', '批量菜单删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('256', 'admin', '1', 'admin/Deploy/setStatus', '单个删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('257', 'admin', '1', 'admin/Deploy/batchupdate', '批量删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('259', 'admin', '1', 'admin/Action/index', '用户行为', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('267', 'admin', '1', 'admin/Action/detailed', '日志详情', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('268', 'admin', '1', 'admin/DataBase/index', '备份数据库', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('269', 'admin', '1', 'admin/DataBase/export', '数据备份', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('270', 'admin', '1', 'admin/DataBase/optimize', '优化表', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('271', 'admin', '1', 'admin/DataBase/repair', '修复表', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('272', 'admin', '1', 'admin/DataBase/import', '还原数据库', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('273', 'admin', '1', 'admin/DataBase/revert', '数据还原', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('274', 'admin', '1', 'admin/DataBase/del', '备份数据删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('275', 'admin', '1', 'admin/Article/batchupdate', '批量更新(禁用、删除、启用、审核、还原)', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('276', 'admin', '1', 'admin/Article/physicaldelete', '物理删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('277', 'admin', '1', 'admin/Article/ajaxmydocument', '搜索', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('278', 'admin', '1', 'admin/Article/add', '新增', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('279', 'admin', '1', 'admin/Article/move', '移动', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('280', 'admin', '1', 'admin/Article/copy', '复制', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('281', 'admin', '1', 'admin/Article/paste', '粘贴', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('283', 'admin', '2', 'admin/Article/mydocument', '内容', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('286', 'admin', '1', 'admin/Article/recycle', '回收站', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('287', 'admin', '1', 'admin/Article/index', '文章列表', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('288', 'admin', '1', 'admin/Action/edit', '新增或者编辑', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('289', 'admin', '1', 'admin/Action/setStatus', '单个变更行为状态', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('290', 'admin', '1', 'admin/Action/batchupdate', '批量变更用户行为', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('291', 'admin', '1', 'admin/Action/renew', '保存或者更新', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('292', 'admin', '1', 'admin/Action/clear', '清空', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('293', 'admin', '1', 'admin/Action/remove', '删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('294', 'admin', '1', 'admin/User/portrait', '头像', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('295', 'admin', '1', 'admin/User/photogallery', '相册', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('296', 'admin', '1', 'admin/Deploy/setUp', '配置更新', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('297', 'admin', '1', 'admin/Channel/add', '新增', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('298', 'admin', '1', 'admin/Channel/batchupdate', '批量更新（启用、删除、禁用）', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('299', 'admin', '1', 'admin/Channel/setStatus', '单个更新（禁用、删除）', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('300', 'admin', '1', 'admin/Channel/renew', '保存', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('301', 'admin', '1', 'admin/Deploy/renew', '保存', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('302', 'admin', '1', 'admin/Category/add', '新增', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('303', 'admin', '1', 'admin/Category/setStatus', '单个更新（禁用、启用）', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('304', 'admin', '1', 'admin/Category/remove', '删除', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('305', 'admin', '1', 'admin/Category/move', '移动', '1', '');
INSERT INTO `tp5_auth_rule` VALUES ('306', 'admin', '1', 'admin/Category/renew', '保存', '1', '');

-- ----------------------------
-- Table structure for tp5_category
-- ----------------------------
DROP TABLE IF EXISTS `tp5_category`;
CREATE TABLE `tp5_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `level` tinyint(8) unsigned NOT NULL DEFAULT '0' COMMENT '级别',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` char(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` char(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` char(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of tp5_category
-- ----------------------------
INSERT INTO `tp5_category` VALUES ('1', 'default', '默认分类', '0', '0', '0', '0', '', '', '', '', '', '', '', '', '', '1,2', '0', '0', '1', '0', '0', '', null, '1473405650', '1475395763', '1', '0', '斯蒂芬森就');

-- ----------------------------
-- Table structure for tp5_channel
-- ----------------------------
DROP TABLE IF EXISTS `tp5_channel`;
CREATE TABLE `tp5_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_channel
-- ----------------------------
INSERT INTO `tp5_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `tp5_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `tp5_channel` VALUES ('3', '0', '官网', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for tp5_deploy
-- ----------------------------
DROP TABLE IF EXISTS `tp5_deploy`;
CREATE TABLE `tp5_deploy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `group` (`group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_deploy
-- ----------------------------
INSERT INTO `tp5_deploy` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'static7个人博客', '0');
INSERT INTO `tp5_deploy` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'static7个人博客', '1');
INSERT INTO `tp5_deploy` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP,OneThink', '8');
INSERT INTO `tp5_deploy` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '2');
INSERT INTO `tp5_deploy` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1469355722', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举\r\n5:多维枚举', '2');
INSERT INTO `tp5_deploy` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '渝ICP备14009050号-1', '9');
INSERT INTO `tp5_deploy` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表推荐\r\n2:频道推荐\r\n4:首页推荐', '3');
INSERT INTO `tp5_deploy` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `tp5_deploy` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1469346241', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:登录', '4');
INSERT INTO `tp5_deploy` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `tp5_deploy` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '30', '2');
INSERT INTO `tp5_deploy` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '7', '10');
INSERT INTO `tp5_deploy` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `tp5_deploy` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', '../data/', '5');
INSERT INTO `tp5_deploy` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `tp5_deploy` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `tp5_deploy` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `tp5_deploy` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '0', '11');
INSERT INTO `tp5_deploy` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1476177234', '1', '0:Article/draftbox\r\n1:Article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:Article/editorPicture\r\n5:User/headPortrait\r\n6:User/updatePassword\r\n7:User/updateNickname\r\n8:User/submitPassword\r\n9:User/submitNickname\r\n10:User/uploader\r\n11:Article/examine\r\n12:Login/logout', '0');
INSERT INTO `tp5_deploy` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `tp5_deploy` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `tp5_deploy` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `tp5_deploy` VALUES ('37', 'APP_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1469354735', '1', '1', '1');
INSERT INTO `tp5_deploy` VALUES ('41', 'TRACE', '3', 'Trace显示方式', '4', '', '支持Html,Console,Socket 设为false则不显示', '1469354929', '1469453893', '1', 'type:html', '0');

-- ----------------------------
-- Table structure for tp5_document
-- ----------------------------
DROP TABLE IF EXISTS `tp5_document`;
CREATE TABLE `tp5_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(200) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `original` varchar(100) NOT NULL COMMENT '原文链接',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE COMMENT '文章ID',
  KEY `idx_category_status` (`category_id`,`status`) USING BTREE,
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of tp5_document
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_document_article
-- ----------------------------
DROP TABLE IF EXISTS `tp5_document_article`;
CREATE TABLE `tp5_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `keywords` char(100) NOT NULL COMMENT '关键词',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE COMMENT '文章ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of tp5_document_article
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_file
-- ----------------------------
DROP TABLE IF EXISTS `tp5_file`;
CREATE TABLE `tp5_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of tp5_file
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_hooks
-- ----------------------------
DROP TABLE IF EXISTS `tp5_hooks`;
CREATE TABLE `tp5_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_hooks
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_member
-- ----------------------------
DROP TABLE IF EXISTS `tp5_member`;
CREATE TABLE `tp5_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `portrait` tinyint(10) unsigned DEFAULT '0' COMMENT '用户头像',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Table structure for tp5_menu
-- ----------------------------
DROP TABLE IF EXISTS `tp5_menu`;
CREATE TABLE `tp5_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tp5_menu
-- ----------------------------
INSERT INTO `tp5_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('16', '用户', '0', '3', 'User/index', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0', '1');
INSERT INTO `tp5_menu` VALUES ('18', '新增用户', '17', '0', 'User/edit', '0', '添加新用户', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('19', '用户行为', '16', '0', 'Action/index', '0', '', '行为管理', '0', '1');
INSERT INTO `tp5_menu` VALUES ('20', '新增或者编辑', '19', '0', 'Action/edit', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('23', '单个变更行为状态', '19', '0', 'Action/setStatus', '0', ' 用户->用户行为 中的启用,禁用和删除权限', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0', '1');
INSERT INTO `tp5_menu` VALUES ('32', '新增和编辑', '27', '0', 'AuthManager/editgroup', '0', '新增、编辑用户组名称和描述', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('33', '保存和编辑用户组', '27', '0', 'AuthManager/writegroup', '0', '新增和编辑用户组的 保存 按钮', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', ' 后台 \\ 用户 \\ 用户信息 列表页的 授权 操作按钮,用于设置用户所属用户组', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', ' 后台 \\ 用户 \\ 权限管理 列表页的 访问授权 操作按钮', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', ' 后台 \\ 用户 \\ 权限管理 列表页的 成员授权 操作按钮', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', ' 成员授权 列表页内的解除授权操作按钮', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addtogroup', '0', ' 用户信息 列表页 授权 时的 保存 按钮和 成员授权 里右上角的 添加 按钮)', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('39', '单个用户组状态变更', '27', '0', 'AuthManager/setstatus', '0', ' 后台 \\ 用户 \\ 权限管理 用户组状态 启用 禁用 删除', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('75', '菜单管理', '187', '5', 'Menu/index', '0', '', '系统设置', '0', '1');
INSERT INTO `tp5_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('120', '仅开发者模式显示和隐藏', '75', '0', 'Menu/toogle', '1', '仅开发者模式显示和显示隐藏切换', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('184', '批量变更用户行为', '19', '0', 'Action/batchupdate', '0', ' 用户->用户行为 中的批量启用、禁用和删除权限', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('185', '批量用户组状态变更', '27', '0', 'AuthManager/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('186', '访问授权保存', '27', '0', 'AuthManager/rulesarrayupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('187', '系统', '0', '4', 'Deploy/group', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('188', '内容', '0', '2', 'Article/mydocument', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('189', '单个菜单状态更改', '75', '0', 'Menu/setStatus', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('190', '批量菜单删除', '75', '0', 'Menu/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('191', '网站配置', '187', '0', 'Deploy/group', '0', '', '系统设置', '0', '1');
INSERT INTO `tp5_menu` VALUES ('196', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0', '1');
INSERT INTO `tp5_menu` VALUES ('197', '备份数据库', '187', '0', 'DataBase/index', '0', '', '数据备份', '0', '1');
INSERT INTO `tp5_menu` VALUES ('198', '数据备份', '197', '0', 'DataBase/export', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('199', '优化表', '197', '0', 'DataBase/optimize', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('200', '修复表', '197', '0', 'DataBase/repair', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('201', '还原数据库', '187', '0', 'DataBase/import', '0', '', '数据备份', '0', '1');
INSERT INTO `tp5_menu` VALUES ('202', '数据还原', '201', '0', 'DataBase/revert', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('203', '备份数据删除', '201', '0', 'DataBase/del', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('204', '导航菜单', '187', '0', 'Channel/index', '0', '', '系统设置', '0', '1');
INSERT INTO `tp5_menu` VALUES ('205', '配置管理', '187', '0', 'Deploy/index', '0', '', '系统设置', '0', '1');
INSERT INTO `tp5_menu` VALUES ('206', '日志详情', '196', '0', 'Action/detailed', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('207', '分类管理', '187', '0', 'Category/index', '0', '', '系统设置', '0', '1');
INSERT INTO `tp5_menu` VALUES ('208', '回收站', '188', '4', 'Article/recycle', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('212', '批量更新(禁用、删除、启用、审核、还原)', '188', '0', 'Article/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('213', '物理删除', '208', '0', 'Article/physicaldelete', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('214', '搜索', '219', '0', 'Article/ajaxmydocument', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('215', '新增', '219', '0', 'Article/add', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('216', '移动', '219', '0', 'Article/move', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('217', '复制', '219', '0', 'Article/copy', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('218', '粘贴', '219', '0', 'Article/paste', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('219', '文章列表', '188', '0', 'Article/index', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('220', '批量更新(启用、禁用、删除)', '17', '0', 'User/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('221', '授权', '17', '0', 'AuthManager/group', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('222', '单个更新（启用、禁用、删除）', '17', '0', 'User/setStatus', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('224', '保存或者更新', '19', '0', 'Action/renew', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('225', '清空', '196', '0', 'Action/clear', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('226', '删除', '196', '0', 'Action/remove', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('227', '头像', '16', '0', 'User/portrait', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('228', '相册', '16', '0', 'User/photogallery', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('229', '配置更新', '191', '0', 'Deploy/setUp', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('230', '新增', '204', '0', 'Channel/add', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('231', '批量更新（启用、删除、禁用）', '204', '0', 'Channel/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('232', '单个更新（禁用、删除）', '204', '0', 'Channel/setStatus', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('233', '保存', '204', '0', 'Channel/renew', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('234', '新增或编辑', '205', '0', 'Deploy/edit', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('235', '单个删除', '205', '0', 'Deploy/setStatus', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('236', '批量删除', '205', '0', 'Deploy/batchupdate', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('237', '保存', '205', '0', 'Deploy/renew', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('238', '新增', '207', '0', 'Category/add', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('239', '单个更新（禁用、启用）', '207', '0', 'Category/setStatus', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('240', '删除', '207', '0', 'Category/remove', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('241', '移动', '207', '0', 'Category/move', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('242', '保存', '207', '0', 'Category/renew', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('244', '上传图片', '219', '0', 'Article/articlePicture', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('245', '上传文件', '219', '0', 'Article/articleFile', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('246', '存草稿', '219', '0', 'Article/autoSave', '0', '', '', '0', '1');
INSERT INTO `tp5_menu` VALUES ('247', '保存', '219', '0', 'Article/renew', '0', '', '', '0', '1');

-- ----------------------------
-- Table structure for tp5_photo_gallery
-- ----------------------------
DROP TABLE IF EXISTS `tp5_photo_gallery`;
CREATE TABLE `tp5_photo_gallery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `group` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '相册组',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='相册表';

-- ----------------------------
-- Records of tp5_photo_gallery
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_picture
-- ----------------------------
DROP TABLE IF EXISTS `tp5_picture`;
CREATE TABLE `tp5_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图片表';

-- ----------------------------
-- Records of tp5_picture
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `tp5_ucenter_admin`;
CREATE TABLE `tp5_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of tp5_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_ucenter_app
-- ----------------------------
DROP TABLE IF EXISTS `tp5_ucenter_app`;
CREATE TABLE `tp5_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of tp5_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `tp5_ucenter_member`;
CREATE TABLE `tp5_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tp5_ucenter_member
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `tp5_ucenter_setting`;
CREATE TABLE `tp5_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of tp5_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_url
-- ----------------------------
DROP TABLE IF EXISTS `tp5_url`;
CREATE TABLE `tp5_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of tp5_url
-- ----------------------------

-- ----------------------------
-- Table structure for tp5_userdata
-- ----------------------------
DROP TABLE IF EXISTS `tp5_userdata`;
CREATE TABLE `tp5_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
