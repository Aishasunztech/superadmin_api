/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : lm_superadmin

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 25/06/2019 16:19:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acl_module_actions
-- ----------------------------
DROP TABLE IF EXISTS `acl_module_actions`;
CREATE TABLE `acl_module_actions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `component_id`(`component_id`) USING BTREE,
  CONSTRAINT `acl_module_actions_ibfk_1` FOREIGN KEY (`component_id`) REFERENCES `acl_modules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for acl_module_actions_to_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `acl_module_actions_to_user_roles`;
CREATE TABLE `acl_module_actions_to_user_roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_id` int(11) NOT NULL,
  `module_action_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_type_id`(`user_type_id`) USING BTREE,
  INDEX `module_action_id`(`module_action_id`) USING BTREE,
  CONSTRAINT `acl_module_actions_to_user_roles_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `acl_module_actions_to_user_roles_ibfk_2` FOREIGN KEY (`module_action_id`) REFERENCES `acl_module_actions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for acl_module_to_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `acl_module_to_user_roles`;
CREATE TABLE `acl_module_to_user_roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_role_id`(`user_role_id`) USING BTREE,
  INDEX `component_id`(`component_id`) USING BTREE,
  CONSTRAINT `acl_module_to_user_roles_ibfk_1` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `acl_module_to_user_roles_ibfk_2` FOREIGN KEY (`component_id`) REFERENCES `acl_modules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_module_to_user_roles
-- ----------------------------
INSERT INTO `acl_module_to_user_roles` VALUES (1, 1, 44);
INSERT INTO `acl_module_to_user_roles` VALUES (2, 1, 37);
INSERT INTO `acl_module_to_user_roles` VALUES (4, 1, 45);
INSERT INTO `acl_module_to_user_roles` VALUES (6, 1, 46);
INSERT INTO `acl_module_to_user_roles` VALUES (7, 1, 43);
INSERT INTO `acl_module_to_user_roles` VALUES (9, 1, 47);
INSERT INTO `acl_module_to_user_roles` VALUES (10, 1, 48);
INSERT INTO `acl_module_to_user_roles` VALUES (11, 1, 1);
INSERT INTO `acl_module_to_user_roles` VALUES (12, 1, 49);

-- ----------------------------
-- Table structure for acl_modules
-- ----------------------------
DROP TABLE IF EXISTS `acl_modules`;
CREATE TABLE `acl_modules`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `component` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login_required` tinyint(1) NOT NULL DEFAULT 1,
  `sort` int(5) NOT NULL DEFAULT 0,
  `dir` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `uri` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uri_UNIQUE`(`uri`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_modules
-- ----------------------------
INSERT INTO `acl_modules` VALUES (1, 'Devices', 'DevicesComponent', 1, 0, '/devices', '/devices');
INSERT INTO `acl_modules` VALUES (2, 'Login', 'LoginComponent', 0, 0, '/login', '/login');
INSERT INTO `acl_modules` VALUES (36, 'Profile List', 'ProfileListComponent', 1, 0, 'components/profile-list', 'profile-list');
INSERT INTO `acl_modules` VALUES (37, 'Account', 'AccountComponent', 1, 0, 'components/account', '/account');
INSERT INTO `acl_modules` VALUES (38, 'Invalid Page', 'InvalidPage', 0, 0, 'components/account', '/invalid_page');
INSERT INTO `acl_modules` VALUES (43, 'AutoUpdate', 'AutoUpdate', 1, 0, NULL, '/apk-list/autoupdate');
INSERT INTO `acl_modules` VALUES (44, 'Labels', 'Labels', 1, 0, '/labels', '/labels');
INSERT INTO `acl_modules` VALUES (45, 'LockMesh', 'LockMesh', 1, 0, '/lockmesh', '/lockmesh');
INSERT INTO `acl_modules` VALUES (46, 'TitanLocker', 'TitanLocker', 1, 0, '/titanlocker', '/titanlocker');
INSERT INTO `acl_modules` VALUES (47, 'ManageData', 'ManageData', 1, 0, '/account/managedata', '/account/managedata');
INSERT INTO `acl_modules` VALUES (48, 'LockMeshDev', 'lockmeshDev', 1, 0, '/lockmesh_dev', '/lockmesh_dev');
INSERT INTO `acl_modules` VALUES (49, 'Tools', 'Tools', 1, 0, NULL, '/tools');

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  `verification_code` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_two_factor_auth` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `type` int(4) NOT NULL,
  `unlink_status` tinyint(4) NOT NULL DEFAULT 0,
  `account_status` enum('suspended','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_email`(`email`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`type`) REFERENCES `user_roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (154, 'Super', 'Admin', 'super!admin@gmail.com', '1052e6d7d642917ca9ecc0f67e6cec22', 0, NULL, 0, 1, 0, NULL, '2019-02-08 09:50:04', '2019-06-13 16:44:39');

-- ----------------------------
-- Table structure for apk_details
-- ----------------------------
DROP TABLE IF EXISTS `apk_details`;
CREATE TABLE `apk_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `logo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_file` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_type` enum('permanent','basic','other') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'basic',
  `label` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `package_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `unique_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `version_code` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `version_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `details` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_bytes` int(100) NULL DEFAULT NULL,
  `apk_size` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `logo_bytes` int(100) NULL DEFAULT NULL,
  `logo_size` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dealers` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `status` enum('Off','On') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Off',
  `delete_status` tinyint(4) NOT NULL DEFAULT 0,
  `created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apk_details
-- ----------------------------
INSERT INTO `apk_details` VALUES (115, 'test', '', 'NL.apk', 'basic', 'Secure Launcher', 'com.secure.launcher', 'com.secure.launcherSecure Launcher', '2', '1.2', NULL, NULL, NULL, NULL, NULL, NULL, 'Off', 0, '2019-06-13 16:00:25', '2019-06-14 11:41:44');
INSERT INTO `apk_details` VALUES (116, 'test12', NULL, 'SCS.apk', 'basic', 'sysctrls', 'com.secure.systemcontrol', 'com.secure.systemcontrol', '117', '1.17', NULL, NULL, NULL, NULL, NULL, NULL, 'Off', 0, '2019-06-13 16:02:20', '2019-06-14 11:41:50');
INSERT INTO `apk_details` VALUES (117, 'sadsad', 'logo-1560511298050.jpg', 'apk-1560511313911.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:22:29', '2019-06-14 17:14:10');
INSERT INTO `apk_details` VALUES (118, 'test123', 'logo-1560511379635.jpg', 'apk-1560511383799.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:23:09', '2019-06-14 17:14:07');
INSERT INTO `apk_details` VALUES (119, 'test123w', 'logo-1560511482325.jpg', 'apk-1560511488001.apk', 'permanent', NULL, 'com.google.android.youtube', NULL, '1417532340', '14.17.53', '', 36302925, '34.62 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:25:01', '2019-06-14 16:52:26');
INSERT INTO `apk_details` VALUES (120, 'applock', 'logo-1560511528216.jpg', 'apk-1560511533869.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:25:38', '2019-06-14 16:52:18');
INSERT INTO `apk_details` VALUES (121, 'youTube', 'logo-1560512033112.jpg', 'apk-1560512037312.apk', 'permanent', NULL, 'com.google.android.youtube', NULL, '1417532340', '14.17.53', '', 36302925, '34.62 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:34:14', '2019-06-14 17:14:04');
INSERT INTO `apk_details` VALUES (122, 'test hamza ', 'logo-1560512354492.jpg', 'apk-1560512358109.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:39:22', '2019-06-14 17:14:01');
INSERT INTO `apk_details` VALUES (123, 'autoUpdate test', 'logo-1560512635885.jpg', 'apk-1560512644487.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 1, '2019-06-14 16:44:25', '2019-06-14 16:52:11');
INSERT INTO `apk_details` VALUES (124, 'NL', 'logo-1560514932481.jpg', 'apk-1560514937429.apk', 'permanent', 'Secure Launcher', 'com.secure.launcher', NULL, '3', '1.3', '', 3181857, '3.03 MB', NULL, NULL, NULL, 'Off', 0, '2019-06-14 17:22:21', '2019-06-14 17:23:55');
INSERT INTO `apk_details` VALUES (125, 'SCS', 'logo-1560517430530.jpg', 'apk-1560519772852.apk', 'permanent', 'sysctrls', 'com.secure.systemcontrol', NULL, '118', '1.18', '', 2293712, '2.19 MB', NULL, NULL, NULL, 'Off', 0, '2019-06-14 17:25:40', '2019-06-14 18:42:58');
INSERT INTO `apk_details` VALUES (126, 'Applock', 'logo-1560771206365.jpg', 'apk-1560771042944.apk', 'permanent', NULL, 'com.domobile.applock', NULL, '2019030701', '2.8.10', '', 8494808, '8.1 MB', NULL, NULL, NULL, 'Off', 0, '2019-06-17 16:30:47', '2019-06-17 16:33:28');

-- ----------------------------
-- Table structure for chat_ids
-- ----------------------------
DROP TABLE IF EXISTS `chat_ids`;
CREATE TABLE `chat_ids`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `chat_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `chat_id_unique`(`chat_id`) USING BTREE,
  INDEX `whitelabel_id`(`whitelabel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_ids
-- ----------------------------
INSERT INTO `chat_ids` VALUES (1, 2, '1', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (2, 2, '2', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (3, 2, '3', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (4, 2, '4', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (5, 2, '5', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (6, 2, '6', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (7, 2, '7', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (8, 2, '8', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (9, 2, '9', 0, '2019-06-17 17:26:32', NULL);
INSERT INTO `chat_ids` VALUES (10, 2, '10', 0, '2019-06-17 17:26:32', NULL);

-- ----------------------------
-- Table structure for db_backups
-- ----------------------------
DROP TABLE IF EXISTS `db_backups`;
CREATE TABLE `db_backups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `backup_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_file` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of db_backups
-- ----------------------------
INSERT INTO `db_backups` VALUES (1, 1, 'dump_lockmesh_db_1560515760019', 'dump_lockmesh_db_1560515760019.zip', '2019-06-14 17:36:43', '2019-06-14 17:36:43');

-- ----------------------------
-- Table structure for device_login
-- ----------------------------
DROP TABLE IF EXISTS `device_login`;
CREATE TABLE `device_login`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mac_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for device_whitelabel
-- ----------------------------
DROP TABLE IF EXISTS `device_whitelabel`;
CREATE TABLE `device_whitelabel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `whitelabel_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_device_whitelabel`(`device_id`, `whitelabel_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for devices
-- ----------------------------
DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fl_dvc_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wl_dvc_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `session_id` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mac_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `account_status` enum('suspended','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `status` enum('active','expired','deleted') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'active',
  `start_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiry_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remaining_days` int(11) NOT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_device_id`(`wl_dvc_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of devices
-- ----------------------------
INSERT INTO `devices` VALUES (19, 'OF977918', '', 1, NULL, '00:27:15:3D:FF:C8', 'VSP1001901S00172', '192.168.0.111', '', '', '', '', '', 'expired', '2019-06-20 14:37:59', '2019-07-20 14:37:59', 30, '2019-06-20 14:37:59', '2019-06-20 17:04:43');
INSERT INTO `devices` VALUES (20, 'OF173904', NULL, 1, NULL, '00:48:CE:A2:5E:36', '0123456789ABCDEF', '192.168.0.100', '', '', '', '', '', 'active', '2019-06-25 07:13:35', '2019-07-25 07:13:35', 30, '2019-06-25 07:13:35', '2019-06-25 07:13:35');

-- ----------------------------
-- Table structure for dropdown_list
-- ----------------------------
DROP TABLE IF EXISTS `dropdown_list`;
CREATE TABLE `dropdown_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `selected_items` mediumtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `type` enum('devices','dealer','sdealer','apk','policies','users') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'devices',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_dlr_id_drpdwn_type`(`dealer_id`, `type`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `dealer_id`(`dealer_id`) USING BTREE,
  CONSTRAINT `dropdown_list_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for login_history
-- ----------------------------
DROP TABLE IF EXISTS `login_history`;
CREATE TABLE `login_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `socket_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `token` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `expiresin` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mac_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `logged_in_client` enum('dealer','admin','device','sdealer') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` enum('socket','token') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'token',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 244 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login_history
-- ----------------------------
INSERT INTO `login_history` VALUES (226, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6ImU2ZTA2MTgzODg1NmJmNDdlMWRlNzMwNzE5ZmIyNjA5IiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTExIDExOjI1OjI3IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjAzMjM4ODcsImV4cCI6MTU2MDQxMDI4N30.iqCygXg3rwkib09l0N7qWtTyhjVglXmSH2d-Hu2hyQw', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-12 12:18:07', NULL);
INSERT INTO `login_history` VALUES (225, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6ImU2ZTA2MTgzODg1NmJmNDdlMWRlNzMwNzE5ZmIyNjA5IiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTExIDExOjI1OjI3IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjAyMzY5MDYsImV4cCI6MTU2MDMyMzMwNn0.0FWOkVhjnenSwg-UNf86TgqeRjhDz_ywJofwlWs2k64', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-11 12:08:26', NULL);
INSERT INTO `login_history` VALUES (224, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTYwMTc0NjAxLCJleHAiOjE1NjAyNjEwMDF9.Myvt1I8ekvxB1FXnNAmHw_Ufv6NtCYH6aB1vNJMLK1k', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-10 18:50:01', NULL);
INSERT INTO `login_history` VALUES (223, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTYwMTc0NTk1LCJleHAiOjE1NjAyNjA5OTV9.nTAawJR2OR4OSNQxD3kfN1n5mwnSbMFj7JoCBu7tFNI', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-10 18:49:55', NULL);
INSERT INTO `login_history` VALUES (222, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTYwMTc0NTQzLCJleHAiOjE1NjAyNjA5NDN9.Ukbi59grQiols0A7GgqkQqPcu8KHBKJl-AJZStw-0NY', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-10 18:49:03', NULL);
INSERT INTO `login_history` VALUES (220, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5NTQzNjY4LCJleHAiOjE1NTk2MzAwNjh9.fddiSsPGIlphtIRwpGHQK22nhEBv3Saw1B29SwWgHWQ', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-03 11:34:28', NULL);
INSERT INTO `login_history` VALUES (221, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTYwMTUyOTYwLCJleHAiOjE1NjAyMzkzNjB9.gUxRrnYgmJGBO2CWsTcKOtin2ds-82-YB1kRTFlZ_30', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-10 12:49:20', NULL);
INSERT INTO `login_history` VALUES (219, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5NTQzNjE1LCJleHAiOjE1NTk2MzAwMTV9.IZvzQmtOSdKAhI2R-JpY8EodPdmPvxqvmerjea8SPhE', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-03 11:33:35', NULL);
INSERT INTO `login_history` VALUES (218, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5NTQyNDM4LCJleHAiOjE1NTk2Mjg4Mzh9.znYzgh_y7EJDJnpUM04jZJbylSGWl-_sJ8JSh8qycOo', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-03 11:13:58', NULL);
INSERT INTO `login_history` VALUES (217, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5Mjk0MTYwLCJleHAiOjE1NTkzODA1NjB9.rxl5NYAPzWWwgqOeE-kRny-GoXbNPsh1sYdlqzwYdAs', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-31 14:16:00', NULL);
INSERT INTO `login_history` VALUES (216, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5MTE4MTc3LCJleHAiOjE1NTkyMDQ1Nzd9.UHU9mLS3fEwqV8lgTbnnquft9xsAM0ASFXNg_5BnfEE', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-29 13:22:57', NULL);
INSERT INTO `login_history` VALUES (214, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5MDMwNTI2LCJleHAiOjE1NTkxMTY5MjZ9.z8tUdQ5D1qDC3MnS7VcU8gBzvEZMO6mn_KbiolRAlH4', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-28 13:02:06', NULL);
INSERT INTO `login_history` VALUES (215, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU5MTE4MTc3LCJleHAiOjE1NTkyMDQ1Nzd9.UHU9mLS3fEwqV8lgTbnnquft9xsAM0ASFXNg_5BnfEE', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-29 13:22:57', NULL);
INSERT INTO `login_history` VALUES (213, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NjAzODE5LCJleHAiOjE1NTg2OTAyMTl9.79Sa_NuvZboszsyk1vG5ywUCrcNWs9RjcfVQXHjNMgU', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 14:30:19', NULL);
INSERT INTO `login_history` VALUES (212, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3OTgxLCJleHAiOjE1NTg2ODQzODF9.W6aMMHm7CBLhklSdJZY1cvUsM0qtMYx46wzJMdsvBz0', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:53:01', NULL);
INSERT INTO `login_history` VALUES (211, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3NzE0LCJleHAiOjE1NTg2ODQxMTR9.WBQmKO4rPBR6BdpteWM7MYsvRLJ6ZdS2TmyZcvtNyH4', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:48:34', NULL);
INSERT INTO `login_history` VALUES (210, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3NTU3LCJleHAiOjE1NTg2ODM5NTd9.p-c3I9HfsG3FwzbvuNPQNAtxBNhu4wPJOFrL8z45IU8', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:45:57', NULL);
INSERT INTO `login_history` VALUES (209, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3NTI1LCJleHAiOjE1NTg2ODM5MjV9.jRlXaQxMnzTc0wHthFAd-FBFPlwqRZuSuAmeH32vA7M', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:45:25', NULL);
INSERT INTO `login_history` VALUES (208, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3Mzg5LCJleHAiOjE1NTg2ODM3ODl9.VjKxkGVUAXZ-rz4e-qbC_Ft6G7aD65emut3qwX-GomU', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:43:09', NULL);
INSERT INTO `login_history` VALUES (207, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3MzQwLCJleHAiOjE1NTg2ODM3NDB9.gECQctQpNdjnZoUc3-hwG2CyLUZCig2AzJenX2FKkpg', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:42:20', NULL);
INSERT INTO `login_history` VALUES (206, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3MjY5LCJleHAiOjE1NTg2ODM2Njl9.iQh7TqC4vKeJ2DraExGIDMJaI7aQjq3Q9ai_nagULdc', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:41:09', NULL);
INSERT INTO `login_history` VALUES (204, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk2NTAyLCJleHAiOjE1NTg2ODI5MDJ9.4y8OccXsY217bK-Z21cBlnDudLzwWgsoEgJDOiG7wAY', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:28:22', NULL);
INSERT INTO `login_history` VALUES (205, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk3MTk4LCJleHAiOjE1NTg2ODM1OTh9.dBILXtJemLxqWaYC_J96PlhnEy0jyKQF0yO1HinNIP4', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:39:58', NULL);
INSERT INTO `login_history` VALUES (203, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJOZWhhIiwibGFzdF9uYW1lIjoiS2FzaHlhcCIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicGFzc3dvcmQiOiJlNmUwNjE4Mzg4NTZiZjQ3ZTFkZTczMDcxOWZiMjYwOSIsInZlcmlmaWVkIjowLCJ2ZXJpZmljYXRpb25fY29kZSI6bnVsbCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwiY3JlYXRlZF9hdCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ1cGRhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsImlwX2FkZHJlc3MiOiI6OjEifSwiaWF0IjoxNTU4NTk1ODU4LCJleHAiOjE1NTg2ODIyNTh9.KfzBJwNAI4p21uY3n57d6EefHC1rr3v-HAhxLmOAcjE', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-05-23 12:17:38', NULL);
INSERT INTO `login_history` VALUES (227, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjE4MTJhYTMwYTMxMTU4OTFmNTk2ZDIwOGVkMzc0M2YzIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEyIDA4OjA3OjExIiwiaXBfYWRkcmVzcyI6Ijo6ZmZmZjo2OC4xODMuNzYuNTQifSwiaWF0IjoxNTYwMzI2ODQ4LCJleHAiOjE1NjA0MTMyNDh9.mVcO0napwjr_jzL4j7_F4pfeBkWV9ytWKOHG1X_CQYU', '86400s', '::ffff:68.183.76.54', NULL, 'admin', 'token', 1, '2019-06-12 08:07:28', NULL);
INSERT INTO `login_history` VALUES (228, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjE4MTJhYTMwYTMxMTU4OTFmNTk2ZDIwOGVkMzc0M2YzIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEyIDA4OjA3OjExIiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjAzMzIxMzksImV4cCI6MTU2MDQxODUzOX0.i_s4nv0c2Ssa0PzDbW4ZArCSfmc1e9J1nvy45s3QVMk', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-12 14:35:39', NULL);
INSERT INTO `login_history` VALUES (229, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjE4MTJhYTMwYTMxMTU4OTFmNTk2ZDIwOGVkMzc0M2YzIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEyIDA4OjA3OjExIiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA0MTk1MTksImV4cCI6MTU2MDUwNTkxOX0.2JVRxUw-kq9gCQFADHJ_DYGRwSSwp3_-MkrwKVXiZlc', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-13 14:51:59', NULL);
INSERT INTO `login_history` VALUES (230, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA0MjY2NDAsImV4cCI6MTU2MDUxMzA0MH0.GG3eWzP-rVjLcTnFFKt1evoJ4_lU1q_pmANS1obiDKw', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-13 16:50:40', NULL);
INSERT INTO `login_history` VALUES (231, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA0OTI2MTAsImV4cCI6MTU2MDU3OTAxMH0.96HoUv47dlkpWEl4Ur90qrJMqxGYlWQlm5lxCsXAxpo', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-14 11:10:10', NULL);
INSERT INTO `login_history` VALUES (232, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA1NzY4MTAsImV4cCI6MTU2MDY2MzIxMH0.Z5KR0IDSR3nhaMNRzkoH7Awj3taUtzv10ZI1omv6zlE', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-15 10:33:30', NULL);
INSERT INTO `login_history` VALUES (233, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA3NTkyOTMsImV4cCI6MTU2MDg0NTY5M30.pOywoGOEPAOOcNNwdx4lAln_fhWyuojem6CChsZcZ6E', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-17 13:14:53', NULL);
INSERT INTO `login_history` VALUES (234, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA3Njc2OTksImV4cCI6MTU2MDg1NDA5OX0.RYhpL1bFAeOuOVRwFcPuLTkKlSls_k4KeJ4NQpJfiFQ', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-17 15:34:59', NULL);
INSERT INTO `login_history` VALUES (235, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA4MzQyODcsImV4cCI6MTU2MDkyMDY4N30.AJJcuZ0zFsglW8-NqW0gSFOxKwF40_XF2I_WrXWVmMA', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-18 10:04:47', NULL);
INSERT INTO `login_history` VALUES (236, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA4NDkxMTAsImV4cCI6MTU2MDkzNTUxMH0.GA2OR3lWN57BtBdPFSXI-HDIp75RZEQP6ucyraHCv2o', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-18 14:11:50', NULL);
INSERT INTO `login_history` VALUES (237, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjEwNTJlNmQ3ZDY0MjkxN2NhOWVjYzBmNjdlNmNlYzIyIiwidmVyaWZpZWQiOjAsInZlcmlmaWNhdGlvbl9jb2RlIjpudWxsLCJpc190d29fZmFjdG9yX2F1dGgiOjAsInR5cGUiOjEsInVubGlua19zdGF0dXMiOjAsImFjY291bnRfc3RhdHVzIjpudWxsLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjA5MzY3MTAsImV4cCI6MTU2MTAyMzExMH0.VR7yY4qHQEiFofAdMOKRlW-n7BAXbODmhtDT3L4q0jI', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-19 14:31:50', NULL);
INSERT INTO `login_history` VALUES (238, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjEwMjM0NDEsImV4cCI6MTU2MTEwOTg0MX0.eRf3eBHSLcfg1tJcDGY0HyYZTstdKboSNr33bHG0XnQ', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-20 14:37:21', NULL);
INSERT INTO `login_history` VALUES (239, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjEzNzg3NTcsImV4cCI6MTU2MTQ2NTE1N30.5_dMCjH4L94RmNP3DwVoXSyu8zpJT_wTO0NbHskVKOo', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-24 17:19:17', NULL);
INSERT INTO `login_history` VALUES (240, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjE0NTY3MjQsImV4cCI6MTU2MTU0MzEyNH0.-yqP-KfiIzryyZSZl59aEI56iLZrQt6-sGfIvz4c-b0', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-25 14:58:44', NULL);
INSERT INTO `login_history` VALUES (241, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjE0NTY3NDMsImV4cCI6MTU2MTU0MzE0M30.p3aGPDFyyLsEEEqsLmZoBWQKtjnkpvOda77ObESIAPA', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-25 14:59:03', NULL);
INSERT INTO `login_history` VALUES (242, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjE0NTY3ODYsImV4cCI6MTU2MTU0MzE4Nn0.VQ535oJQ3HOMjxO97P7RiJxUV8PXeHrwViIHhzoEULk', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-25 14:59:46', NULL);
INSERT INTO `login_history` VALUES (243, NULL, '154', NULL, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImZpcnN0X25hbWUiOiJTdXBlciIsImxhc3RfbmFtZSI6IkFkbWluIiwiZW1haWwiOiJzdXBlciFhZG1pbkBnbWFpbC5jb20iLCJ2ZXJpZmllZCI6MCwiaXNfdHdvX2ZhY3Rvcl9hdXRoIjowLCJ0eXBlIjoxLCJ1bmxpbmtfc3RhdHVzIjowLCJjcmVhdGVkX2F0IjoiMjAxOS0wMi0wOCAwOTo1MDowNCIsInVwZGF0ZWRfYXQiOiIyMDE5LTA2LTEzIDE2OjQ0OjM5IiwiaXBfYWRkcmVzcyI6Ijo6MSJ9LCJpYXQiOjE1NjE0NTc0OTQsImV4cCI6MTU2MTU0Mzg5NH0.dLyo7u3SWA6Dqu3YCDBzmLhQDCsNNe_CGOfo8IHYSFM', '86400s', '::1', NULL, 'admin', 'token', 1, '2019-06-25 15:11:34', NULL);

-- ----------------------------
-- Table structure for packages
-- ----------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `pkg_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkg_price` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkg_term` enum('12 month','6 month','3 month','1 month') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkg_expiry` int(11) NULL DEFAULT NULL,
  `pkg_features` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of packages
-- ----------------------------
INSERT INTO `packages` VALUES (8, 1, 'test name', '345', '3 month', 90, '{\"chat_id\":false,\"sim_id\":false,\"pgp_email\":false,\"vpn\":false}', '2019-06-20 15:12:49', '2019-06-20 15:12:49');
INSERT INTO `packages` VALUES (7, 1, 'test name', '345', '3 month', 90, '{\"chat_id\":false,\"sim_id\":false,\"pgp_email\":false,\"vpn\":false}', '2019-06-20 15:12:05', '2019-06-20 15:12:05');
INSERT INTO `packages` VALUES (6, 1, 'test name', '345', '3 month', 90, '{\"chat_id\":true,\"sim_id\":true,\"pgp_email\":false,\"vpn\":false}', '2019-06-20 15:09:07', '2019-06-20 15:09:07');

-- ----------------------------
-- Table structure for paginations
-- ----------------------------
DROP TABLE IF EXISTS `paginations`;
CREATE TABLE `paginations`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(10) NOT NULL,
  `record_per_page` int(10) NOT NULL,
  `type` enum('devices','dealer','sdealer','apk','policies','users') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'devices',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unq_dlr_id_pg_typ`(`dealer_id`, `type`) USING BTREE,
  INDEX `dealer_id`(`dealer_id`) USING BTREE,
  CONSTRAINT `paginations_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `admins` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pgp_emails
-- ----------------------------
DROP TABLE IF EXISTS `pgp_emails`;
CREATE TABLE `pgp_emails`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `pgp_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `whitelabel_id`(`whitelabel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pgp_emails
-- ----------------------------
INSERT INTO `pgp_emails` VALUES (1, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (2, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (3, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (4, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (5, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (6, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (7, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (8, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (9, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);
INSERT INTO `pgp_emails` VALUES (10, 2, 'example@domain.com', 0, '2019-06-17 17:26:51', NULL);

-- ----------------------------
-- Table structure for prices
-- ----------------------------
DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `price_for` enum('chat_id','vpn','sim_id','pgp_email') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `unit_price` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `price_term` enum('12 month','6 month','3 month','1 month') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `price_expiry` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_prc_prc_trm`(`price_for`, `whitelabel_id`, `price_term`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prices
-- ----------------------------
INSERT INTO `prices` VALUES (15, 1, 'sim_id', '45', '1 month', 30, '2019-06-20 11:54:00', '2019-06-20 11:55:56');
INSERT INTO `prices` VALUES (16, 1, 'chat_id', '45', '3 month', 90, '2019-06-20 11:54:00', '2019-06-20 11:54:00');
INSERT INTO `prices` VALUES (17, 1, 'sim_id', '45', '6 month', 180, '2019-06-20 11:55:56', '2019-06-20 11:59:26');
INSERT INTO `prices` VALUES (18, 1, 'pgp_email', '45', '3 month', 90, '2019-06-20 11:55:56', '2019-06-20 11:55:56');
INSERT INTO `prices` VALUES (19, 1, 'pgp_email', '45', '6 month', 180, '2019-06-20 11:58:07', '2019-06-20 11:58:07');

-- ----------------------------
-- Table structure for sim_ids
-- ----------------------------
DROP TABLE IF EXISTS `sim_ids`;
CREATE TABLE `sim_ids`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `sim_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `start_date` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `expiry_date` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sim_id_UNIQUE`(`sim_id`) USING BTREE,
  INDEX `whitelabel_id_index`(`whitelabel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES (1, 'admin', 1);
INSERT INTO `user_roles` VALUES (2, 'dealer', 1);
INSERT INTO `user_roles` VALUES (3, 'sdealer', 1);

-- ----------------------------
-- Table structure for white_labels
-- ----------------------------
DROP TABLE IF EXISTS `white_labels`;
CREATE TABLE `white_labels`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `unique_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `command_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `route_uri` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `domain_port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `api_port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_port` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_pass` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_key` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_port` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_pass` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `deletable` tinyint(4) NOT NULL DEFAULT 1,
  `delete_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of white_labels
-- ----------------------------
INSERT INTO `white_labels` VALUES (1, 'screenlocker', 'LockMesh', 'com.secure.launcher1Screen Locker', '#screenlocker', '/lockmesh', 'https://lockmesh.com', '3001', 'https://api.lockmesh.com', '3001', '134.209.124.196', '22', 'root', 'Applock@786#', NULL, NULL, 'dbuser', 'DAtabase$435$', 'lockmesh_db', 1, 1, 0, '2019-05-24 11:37:48', '2019-06-25 15:18:51');
INSERT INTO `white_labels` VALUES (2, 'titan', 'TitanLocker', 'com.secure.launcher1Titan Locker', '#titan', '/titanlocker', NULL, NULL, 'http://165.22.82.254:3000', NULL, '165.22.82.254', '22', 'root', 'Applock@786#', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, '2019-05-24 11:38:48', '2019-06-25 15:19:17');
INSERT INTO `white_labels` VALUES (3, 'lockmesh_dev', 'LockMesh Dev', NULL, '#lockmeshdev', '/lockmesh_dev', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, '2019-06-18 10:06:35', '2019-06-20 15:14:12');

-- ----------------------------
-- Table structure for whitelabel_apks
-- ----------------------------
DROP TABLE IF EXISTS `whitelabel_apks`;
CREATE TABLE `whitelabel_apks`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `whitelabel_id` int(11) NOT NULL,
  `package_name` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apk_icon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_file` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `apk_size` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `unique_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `label` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `version_name` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `version_code` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `is_byod` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_whitelabel_id_package_name`(`whitelabel_id`, `package_name`, `label`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 29 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of whitelabel_apks
-- ----------------------------
INSERT INTO `whitelabel_apks` VALUES (24, 1, 'com.secure.launcher', NULL, 'launcher_apk-1560520036586.apk', '13.32 MB', NULL, 'Screen Locker', '4.85', '479', '0', '2019-06-19 15:11:15', '2019-06-19 16:21:58');
INSERT INTO `whitelabel_apks` VALUES (25, 1, 'com.secure.systemcontrol', NULL, 'sc_apk-1560945021727.apk', '2.19 MB', NULL, 'sysctrls', '1.18', '118', '0', '2019-06-19 15:11:15', '2019-06-19 16:50:32');
INSERT INTO `whitelabel_apks` VALUES (27, 1, 'com.vortexlocker.app', NULL, 'byod_apk-1561382082712.apk', '2.19 MB', NULL, 'Screen', '1.17', '117', '0', '2019-06-19 16:09:48', '2019-06-24 18:14:46');
INSERT INTO `whitelabel_apks` VALUES (28, 1, 'com.secure.launcher', NULL, 'launcher_apk-1560945013551.apk', '13.32 MB', NULL, 'Screen', '4.79', '479', '0', '2019-06-19 16:21:38', '2019-06-19 16:50:32');

SET FOREIGN_KEY_CHECKS = 1;
