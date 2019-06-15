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

 Date: 15/06/2019 12:12:34
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acl_modules
-- ----------------------------
INSERT INTO `acl_modules` VALUES (1, 'Devices', 'DevicesComponent', 1, 0, '/devices', '/devices');
INSERT INTO `acl_modules` VALUES (2, 'Login', 'LoginComponent', 0, 0, '/login', '/login');
INSERT INTO `acl_modules` VALUES (3, 'Dealers', 'DealerComponent', 1, 0, '/dealer', '/dealer/dealer');
INSERT INTO `acl_modules` VALUES (4, 'Sub Dealers', 'DealerComponent', 1, 0, '/dealer', '/dealer/sdealer');
INSERT INTO `acl_modules` VALUES (5, 'Add Devices', 'AddDeviceComponent', 1, 0, '/add-device', 'add-device');
INSERT INTO `acl_modules` VALUES (6, 'Create Dealers', 'CreateDealer', 1, 0, '/create-dealer', '/create-dealer/dealer');
INSERT INTO `acl_modules` VALUES (7, 'Create Sub-Dealer', 'CreateDealer', 1, 0, '/create-sdealer', '/create-dealer/sdealer');
INSERT INTO `acl_modules` VALUES (8, 'Connect Devices', 'ConnectDevicesComponent', 1, 0, '/connect-device', '/connect-device/:deviceId');
INSERT INTO `acl_modules` VALUES (30, '', 'ProfileComponent', 1, 0, '/profile', '/profile');
INSERT INTO `acl_modules` VALUES (31, '', 'CreateClientComponent', 1, 0, NULL, '/create/client');
INSERT INTO `acl_modules` VALUES (32, '', 'UploadApkComponent', 1, 0, NULL, '/upload-apk');
INSERT INTO `acl_modules` VALUES (33, '', 'ApkListComponent', 1, 0, NULL, '/apk-list');
INSERT INTO `acl_modules` VALUES (35, '', 'SettingsComponent', 1, 0, NULL, 'settings');
INSERT INTO `acl_modules` VALUES (36, 'Profile List', 'ProfileListComponent', 1, 0, 'components/profile-list', 'profile-list');
INSERT INTO `acl_modules` VALUES (37, 'Account', 'AccountComponent', 1, 0, 'components/account', '/account');
INSERT INTO `acl_modules` VALUES (38, 'Invalid Page', 'InvalidPage', 0, 0, 'components/account', '/invalid_page');
INSERT INTO `acl_modules` VALUES (39, 'App', 'App', 1, 0, NULL, '/app');
INSERT INTO `acl_modules` VALUES (40, 'Policy', 'Policy', 1, 0, NULL, '/policy');
INSERT INTO `acl_modules` VALUES (41, 'Users', 'Users', 1, 0, NULL, '/users');
INSERT INTO `acl_modules` VALUES (42, 'AppMarket', 'AppMarket', 1, 0, NULL, '/app-market');

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
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
  `spr_admn_dvc_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `device_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `whitelabel_id` int(11) NULL DEFAULT NULL,
  `session_id` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `mac_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `serial_no` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `simno2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `imei2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_device_id`(`device_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of devices
-- ----------------------------
INSERT INTO `devices` VALUES (3, NULL, 'AECE977918', NULL, NULL, '00:27:15:3D:FF:C8', 'VSP1001901S00172', '192.168.0.103', '', '', '', '', '2019-05-28 15:34:08', '2019-05-28 15:34:08');
INSERT INTO `devices` VALUES (2, NULL, 'CEBB647431', NULL, NULL, '00:FF:8A:15:B2:A2', '0123456789ABCDEF', '192.168.0.102', '', '', '', '', '2019-05-24 15:36:08', '2019-05-24 15:36:08');
INSERT INTO `devices` VALUES (4, NULL, 'AEBE885997', NULL, NULL, '00:3D:8F:58:A1:D9', '0123456789ABCDEF', '192.168.0.101', '', '', '', '', '2019-05-29 14:36:56', '2019-05-29 14:36:56');
INSERT INTO `devices` VALUES (5, NULL, 'CBFB073737', NULL, NULL, '00:6D:8B:A3:57:A5', '0123456789ABCDEF', '192.168.0.108', '', '', '', '', '2019-06-04 11:04:34', '2019-06-04 11:04:34');
INSERT INTO `devices` VALUES (6, NULL, 'FFAE075182', NULL, NULL, '00:E6:84:7F:40:6A', '0123456789ABCDEF', '192.168.18.250', '', '', '', '', '2019-06-14 16:25:21', '2019-06-14 16:25:21');

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
) ENGINE = MyISAM AUTO_INCREMENT = 231 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
  `user_acc_id` int(11) NULL DEFAULT NULL,
  `pgp_email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_pgp_emails`(`pgp_email`) USING BTREE,
  INDEX `whitelabel_id`(`user_acc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
  `command_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `route_uri` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `domain_port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `api_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `api_port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_pass` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ssh_key` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_pass` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `db_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `deletable` tinyint(4) NOT NULL DEFAULT 1,
  `delete_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of white_labels
-- ----------------------------
INSERT INTO `white_labels` VALUES (1, 'lockmesh123', 'LockMesh', '#lockmesh123', '/lockmesh', 'https://lockmesh.com', '3001', 'https://api.lockmesh.com', '3001', '134.209.124.196', 'root', NULL, NULL, 'dbuser', 'DAtabase$435$', 'lockmesh_db', 1, 1, 0, '2019-05-24 11:37:48', '2019-06-15 05:39:42');
INSERT INTO `white_labels` VALUES (2, 'titanlocker123', 'TitanLocker', '#titanlocker123', '/titanlocker', NULL, NULL, 'http://165.22.82.254:3000', NULL, '165.22.82.254', 'root', NULL, NULL, 'root', 'Applock@786#', 'lockmesh', 1, 1, 0, '2019-05-24 11:38:48', '2019-06-15 05:42:34');

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_whitelabel_id_package_name`(`whitelabel_id`, `package_name`, `label`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of whitelabel_apks
-- ----------------------------
INSERT INTO `whitelabel_apks` VALUES (19, 1, 'com.secure.systemcontrol', NULL, 'sc_apk-1560529124305.apk', '2.19 MB', NULL, 'sysctrls', '1.18', '18');
INSERT INTO `whitelabel_apks` VALUES (18, 1, 'com.secure.launcher', NULL, 'launcher_apk-1560529126130.apk', '13.32 MB', NULL, 'Screen Locker', '4.80', '480');

SET FOREIGN_KEY_CHECKS = 1;
