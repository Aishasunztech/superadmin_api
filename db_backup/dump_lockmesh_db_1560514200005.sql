/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: device_history
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `device_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_acc_id` int(11) DEFAULT 0,
  `device_id` varchar(255) NOT NULL,
  `dealer_id` int(11) NOT NULL DEFAULT 0,
  `policy_name` varchar(100) DEFAULT NULL,
  `profile_name` varchar(100) DEFAULT '',
  `app_list` text DEFAULT NULL,
  `passwords` text DEFAULT NULL,
  `controls` text DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `push_apps` text DEFAULT NULL,
  `pull_apps` text DEFAULT NULL,
  `imei` text DEFAULT NULL,
  `type` enum(
  'push_apps',
  'pull_apps',
  'history',
  'imei',
  'policy',
  'force_update',
  'profile'
  ) NOT NULL DEFAULT 'history',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_acc_id` (`user_acc_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 163 DEFAULT CHARSET = latin1 ROW_FORMAT = DYNAMIC;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: acc_action_history
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `acc_action_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` enum(
  'DELETE',
  'SUSPENDED',
  'UNLINKED',
  'EXPIRED',
  'ACTIVE',
  'FLAGGED',
  'UNFLAGGED',
  'TRANSFER',
  'Pre-activated',
  'wiped',
  'Pending activation'
  ) NOT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `device_name` varchar(255) DEFAULT NULL,
  `session_id` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `simno` varchar(255) DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `simno2` varchar(255) DEFAULT NULL,
  `imei2` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `online` enum('online', 'offline') NOT NULL DEFAULT 'offline',
  `is_sync` tinyint(4) NOT NULL DEFAULT 0,
  `flagged` enum(
  'Defective',
  'Lost',
  'Stolen',
  'Other',
  'Not flagged'
  ) DEFAULT 'Not flagged',
  `screen_start_date` varchar(50) DEFAULT NULL,
  `reject_status` tinyint(4) NOT NULL DEFAULT 0,
  `account_name` varchar(255) DEFAULT NULL,
  `account_email` varchar(255) DEFAULT NULL,
  `dealer_id` int(11) DEFAULT 0,
  `prnt_dlr_id` int(11) DEFAULT 0,
  `link_code` varchar(50) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `expiry_months` int(100) DEFAULT NULL,
  `expiry_date` varchar(50) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `status` enum('expired', 'active', '') NOT NULL DEFAULT '',
  `device_status` tinyint(4) NOT NULL DEFAULT 0,
  `activation_status` tinyint(4) DEFAULT NULL,
  `wipe_status` varchar(255) DEFAULT NULL,
  `account_status` enum('suspended', '') DEFAULT '',
  `unlink_status` tinyint(4) NOT NULL DEFAULT 0,
  `transfer_status` tinyint(4) unsigned DEFAULT 0,
  `dealer_name` varchar(255) DEFAULT NULL,
  `prnt_dlr_name` varchar(255) DEFAULT NULL,
  `user_acc_id` int(11) DEFAULT NULL,
  `pgp_email` varchar(255) DEFAULT NULL,
  `chat_id` varchar(255) DEFAULT NULL,
  `sim_id` varchar(100) DEFAULT NULL,
  `del_status` tinyint(4) DEFAULT NULL,
  `finalStatus` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 565 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: acl_module_actions_to_user_roles
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `acl_module_actions_to_user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_id` int(11) NOT NULL,
  `module_action_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_type_id` (`user_type_id`) USING BTREE,
  KEY `module_action_id` (`module_action_id`) USING BTREE,
  CONSTRAINT `acl_module_actions_to_user_roles_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_roles` (`id`),
  CONSTRAINT `acl_module_actions_to_user_roles_ibfk_2` FOREIGN KEY (`module_action_id`) REFERENCES `acl_module_actions` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: acl_module_to_user_roles
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `acl_module_to_user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_role_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_role_id` (`user_role_id`) USING BTREE,
  KEY `component_id` (`component_id`) USING BTREE,
  CONSTRAINT `acl_module_to_user_roles_ibfk_1` FOREIGN KEY (`user_role_id`) REFERENCES `user_roles` (`id`),
  CONSTRAINT `acl_module_to_user_roles_ibfk_2` FOREIGN KEY (`component_id`) REFERENCES `acl_modules` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 58 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: acl_modules
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `acl_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `component` varchar(80) NOT NULL,
  `login_required` tinyint(1) NOT NULL DEFAULT 1,
  `sort` int(5) NOT NULL DEFAULT 0,
  `dir` text DEFAULT NULL,
  `uri` varchar(100) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uri_UNIQUE` (`uri`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: apk_details
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `apk_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `apk` text DEFAULT NULL,
  `apk_type` enum('permanent', 'basic', 'other') DEFAULT 'basic',
  `label` text DEFAULT NULL,
  `package_name` text DEFAULT NULL,
  `unique_name` text DEFAULT NULL,
  `version_code` text DEFAULT NULL,
  `version_name` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `apk_bytes` int(100) DEFAULT NULL,
  `apk_size` varchar(255) DEFAULT NULL,
  `logo_bytes` int(100) DEFAULT NULL,
  `logo_size` varchar(255) DEFAULT NULL,
  `dealers` text DEFAULT NULL,
  `status` enum('Off', 'On') NOT NULL DEFAULT 'Off',
  `delete_status` tinyint(4) NOT NULL DEFAULT 0,
  `created` timestamp NULL DEFAULT current_timestamp(),
  `modified` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: apps_info
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `apps_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unique_name` varchar(500) NOT NULL COMMENT 'unique app name (package_name + lable)',
  `label` varchar(50) NOT NULL,
  `package_name` text DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `extension` tinyint(4) DEFAULT 0,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `default_app` tinyint(4) NOT NULL DEFAULT 0,
  `extension_id` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_name_constraints` (`unique_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31037 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: apps_queue_jobs
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `apps_queue_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) NOT NULL,
  `action` enum('pull', 'push') DEFAULT NULL,
  `type` enum('push', 'pull', 'policy') DEFAULT NULL,
  `is_in_process` varchar(255) DEFAULT NULL,
  `total_apps` int(11) DEFAULT 0,
  `complete_apps` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `device_id` (`device_id`) USING BTREE,
  CONSTRAINT `apps_queue_jobs_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 160 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: chat_ids
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `chat_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_acc_id` int(11) DEFAULT NULL,
  `chat_id` varchar(255) NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `chat_id_unique` (`chat_id`) USING BTREE,
  KEY `user_acc_id` (`user_acc_id`) USING BTREE,
  CONSTRAINT `chat_ids_ibfk_1` FOREIGN KEY (`user_acc_id`) REFERENCES `usr_acc` (`id`) ON DELETE
  SET
  NULL ON UPDATE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 30 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dealer_apks
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dealer_apks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `apk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_dealer_id_apk_id` (`dealer_id`, `apk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 971 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dealer_dropdown_list
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dealer_dropdown_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `selected_items` mediumtext DEFAULT NULL,
  `type` enum(
  'devices',
  'dealer',
  'sdealer',
  'apk',
  'policies',
  'users'
  ) NOT NULL DEFAULT 'devices',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unq_dlr_id_drpdwn_type` (`dealer_id`, `type`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  KEY `dealer_id` (`dealer_id`) USING BTREE,
  CONSTRAINT `dealer_dropdown_list_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `dealers` (`dealer_id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 194 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dealer_pagination
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dealer_pagination` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(10) NOT NULL,
  `record_per_page` int(10) NOT NULL,
  `type` enum(
  'devices',
  'dealer',
  'sdealer',
  'apk',
  'policies',
  'users'
  ) NOT NULL DEFAULT 'devices',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unq_dlr_id_pg_typ` (`dealer_id`, `type`) USING BTREE,
  KEY `dealer_id` (`dealer_id`) USING BTREE,
  CONSTRAINT `dealer_pagination_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `dealers` (`dealer_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 50 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dealer_policies
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dealer_policies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `policy_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_dealer_id_apk_id` (`dealer_id`, `policy_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 256 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: dealers
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `dealers` (
  `dealer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `connected_dealer` int(11) NOT NULL DEFAULT 0,
  `dealer_name` varchar(255) NOT NULL,
  `dealer_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `link_code` varchar(10) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  `verification_code` varchar(255) DEFAULT NULL,
  `is_two_factor_auth` tinyint(4) unsigned NOT NULL DEFAULT 0,
  `type` int(4) NOT NULL,
  `unlink_status` tinyint(4) NOT NULL DEFAULT 0,
  `account_status` enum('suspended', '') DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`dealer_id`) USING BTREE,
  UNIQUE KEY `unique_email` (`dealer_email`) USING BTREE,
  UNIQUE KEY `link_code_unique` (`link_code`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `connected_dealer` (`connected_dealer`) USING BTREE,
  CONSTRAINT `dealers_ibfk_1` FOREIGN KEY (`type`) REFERENCES `user_roles` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 242 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: default_apps
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `default_apps` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unique_name` varchar(500) NOT NULL COMMENT 'unique app name (package_name + lable)',
  `label` varchar(50) NOT NULL,
  `package_name` text DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `extension` tinyint(4) DEFAULT 0,
  `visible` tinyint(4) NOT NULL DEFAULT 1,
  `default_app` tinyint(4) NOT NULL DEFAULT 0,
  `extension_id` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_name_constraints` (`unique_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23213 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: default_policies
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `default_policies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `policy_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: acl_module_actions
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `acl_module_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `action` varchar(80) NOT NULL,
  `sort` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `component_id` (`component_id`) USING BTREE,
  CONSTRAINT `acl_module_actions_ibfk_1` FOREIGN KEY (`component_id`) REFERENCES `acl_modules` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: devices
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `session_id` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `simno` varchar(255) DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `simno2` varchar(255) DEFAULT NULL,
  `imei2` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `online` enum('online', 'offline') NOT NULL DEFAULT 'offline',
  `is_sync` tinyint(4) NOT NULL DEFAULT 0,
  `is_push_apps` tinyint(4) DEFAULT 0,
  `flagged` enum(
  'Defective',
  'Lost',
  'Stolen',
  'Other',
  'Not flagged'
  ) DEFAULT 'Not flagged',
  `screen_start_date` varchar(50) DEFAULT NULL,
  `reject_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `device_id` (`device_id`) USING BTREE,
  UNIQUE KEY `unique_mac_address` (`mac_address`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 827 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: imei_history
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `imei_history` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) DEFAULT NULL,
  `Serial_number` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `orignal_imei1` varchar(255) DEFAULT NULL,
  `orignal_imei2` varchar(255) DEFAULT '',
  `imei1` varchar(255) DEFAULT NULL,
  `imei2` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: login_history
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `login_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(11) DEFAULT NULL,
  `dealer_id` varchar(11) DEFAULT NULL,
  `socket_id` varchar(255) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `expiresin` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `logged_in_client` enum('dealer', 'admin', 'device', 'sdealer') DEFAULT NULL,
  `type` enum('socket', 'token') DEFAULT 'token',
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 461 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: pgp_emails
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `pgp_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_acc_id` int(11) DEFAULT NULL,
  `pgp_email` varchar(255) NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_pgp_emails` (`pgp_email`) USING BTREE,
  KEY `user_acc_id` (`user_acc_id`) USING BTREE,
  CONSTRAINT `pgp_emails_ibfk_1` FOREIGN KEY (`user_acc_id`) REFERENCES `usr_acc` (`id`) ON DELETE
  SET
  NULL ON UPDATE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 195 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: policy
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(50) DEFAULT NULL,
  `policy_note` varchar(255) DEFAULT NULL,
  `dealer_id` int(11) DEFAULT NULL,
  `dealer_type` enum('admin', 'dealer', 'sdealer') NOT NULL,
  `command_name` varchar(100) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `app_list` text DEFAULT NULL,
  `push_apps` text DEFAULT NULL,
  `controls` text DEFAULT NULL,
  `dealers` text DEFAULT NULL,
  `passwords` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `delete_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: policy_queue_jobs
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `policy_queue_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_id` int(11) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `is_in_process` tinyint(4) DEFAULT 0,
  `complete_steps` tinyint(4) DEFAULT 0,
  `push_apps` tinyint(4) DEFAULT 0,
  `permission` tinyint(4) DEFAULT 0,
  `app_list` tinyint(4) DEFAULT 0,
  `controls` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: screen_lock_devices
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `screen_lock_devices` (
  `dev_id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(255) DEFAULT NULL,
  `start_date` varchar(60) DEFAULT NULL,
  `end_date` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`dev_id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: secure_market_apps
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `secure_market_apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apk_id` int(11) DEFAULT NULL,
  `dealer_id` int(11) DEFAULT NULL,
  `dealer_type` varchar(255) DEFAULT NULL,
  `is_restrict_uninstall` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `apk_id` (`apk_id`) USING BTREE,
  CONSTRAINT `secure_market_apps_ibfk_1` FOREIGN KEY (`apk_id`) REFERENCES `apk_details` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 912 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sim_ids
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sim_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_acc_id` int(11) DEFAULT NULL,
  `sim_id` varchar(100) NOT NULL,
  `used` tinyint(4) NOT NULL DEFAULT 0,
  `start_date` varchar(100) DEFAULT NULL,
  `expiry_date` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `sim_id_UNIQUE` (`sim_id`) USING BTREE,
  KEY `device_id` (`user_acc_id`) USING BTREE,
  CONSTRAINT `sim_ids_ibfk_1` FOREIGN KEY (`user_acc_id`) REFERENCES `usr_acc` (`id`) ON DELETE
  SET
  NULL ON UPDATE
  SET
  NULL
) ENGINE = InnoDB AUTO_INCREMENT = 85 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: transferred_profiles
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `transferred_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dealer_id` int(11) NOT NULL,
  `connected_dealer` int(11) NOT NULL DEFAULT 0,
  `chat_id` varchar(50) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `session_id` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pgp_email` varchar(255) DEFAULT NULL,
  `link_code` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `sim_id` varchar(255) DEFAULT NULL,
  `simno` varchar(255) DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `sim_id2` varchar(255) DEFAULT NULL,
  `simno2` varchar(255) DEFAULT NULL,
  `imei2` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `s_dealer` varchar(100) DEFAULT NULL,
  `s_dealer_name` varchar(255) DEFAULT NULL,
  `account` varchar(20) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `activation_status` tinyint(4) DEFAULT NULL,
  `online` enum('On', 'off') NOT NULL DEFAULT 'off',
  `device_status` tinyint(4) NOT NULL DEFAULT 0,
  `is_sync` tinyint(4) NOT NULL DEFAULT 0,
  `status` enum('expired', 'active', '') NOT NULL DEFAULT 'active',
  `account_status` enum('suspended', '') DEFAULT '',
  `unlink_status` tinyint(4) NOT NULL DEFAULT 0,
  `screen_start_date` varchar(50) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `expiry_months` int(100) DEFAULT NULL,
  `expiry_date` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user_app_permissions
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_app_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) DEFAULT '0',
  `permissions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `device_setting_id` (`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3394 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user_apps
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_apps` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `device_id` int(50) NOT NULL,
  `app_id` int(10) NOT NULL,
  `guest` tinyint(4) NOT NULL DEFAULT 0,
  `encrypted` tinyint(4) NOT NULL DEFAULT 0,
  `enable` tinyint(4) NOT NULL DEFAULT 0,
  `extension` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `primary_key` (`id`) USING BTREE,
  UNIQUE KEY `user_unique_apps` (`device_id`, `app_id`) USING BTREE,
  KEY `device_id` (`device_id`) USING BTREE,
  KEY `app_id` (`app_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14833 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user_roles
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) CHARACTER SET latin1 NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(225) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` int(4) NOT NULL,
  `dealer_id` int(11) NOT NULL,
  `del_status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `dealer_id` (`dealer_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`dealer_id`) REFERENCES `dealers` (`dealer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 32 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: usr_acc
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `usr_acc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `batch_no` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_email` varchar(255) DEFAULT NULL,
  `dealer_id` int(11) DEFAULT 0,
  `prnt_dlr_id` int(11) DEFAULT 0,
  `link_code` varchar(50) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `start_date` varchar(16) DEFAULT NULL,
  `expiry_months` int(100) DEFAULT NULL,
  `expiry_date` varchar(50) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `status` enum('expired', 'active', '', 'trial') NOT NULL DEFAULT '',
  `device_status` tinyint(4) NOT NULL DEFAULT 0,
  `activation_status` tinyint(4) DEFAULT NULL,
  `wipe_status` varchar(255) DEFAULT NULL,
  `account_status` enum('suspended', '') DEFAULT '',
  `unlink_status` tinyint(4) NOT NULL DEFAULT 0,
  `transfer_status` tinyint(4) unsigned DEFAULT 0,
  `dealer_name` varchar(255) DEFAULT NULL,
  `prnt_dlr_name` varchar(255) DEFAULT NULL,
  `del_status` tinyint(4) DEFAULT 0,
  `trial_status` tinyint(4) DEFAULT 0,
  `validity` tinyint(4) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `device_id` (`device_id`) USING BTREE,
  KEY `dealer_id` (`dealer_id`) USING BTREE,
  KEY `prnt_dealer_id` (`prnt_dlr_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `usr_acc_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `usr_acc_ibfk_2` FOREIGN KEY (`dealer_id`) REFERENCES `dealers` (`dealer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usr_acc_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 222 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: usr_acc_profile
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `usr_acc_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(50) DEFAULT NULL,
  `profile_note` varchar(255) DEFAULT NULL,
  `policy_id` int(11) DEFAULT 0,
  `user_acc_id` int(11) DEFAULT NULL,
  `dealer_id` int(11) DEFAULT NULL,
  `app_list` text DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `controls` text DEFAULT NULL,
  `passwords` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: device_history
# ------------------------------------------------------------

INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    89,
    156,
    'BCFE945075',
    154,
    'test',
    NULL,
    '[{\"id\":4649,\"label\":\"Music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.musicMusic\",\"packageName\":\"com.android.music\",\"defaultApp\":0},{\"id\":4651,\"label\":\"Browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.browserBrowser\",\"packageName\":\"com.android.browser\",\"defaultApp\":0},{\"id\":4652,\"label\":\"Calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.calendarCalendar\",\"packageName\":\"com.android.calendar\",\"defaultApp\":0},{\"id\":4653,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.contactsContacts\",\"packageName\":\"com.android.contacts\",\"defaultApp\":0},{\"id\":4654,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.deskclockClock\",\"packageName\":\"com.android.deskclock\",\"defaultApp\":0},{\"id\":4655,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.dialerPhone\",\"packageName\":\"com.android.dialer\",\"defaultApp\":0},{\"id\":4656,\"label\":\"Email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.emailEmail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":4657,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.gallery3dGallery\",\"packageName\":\"com.android.gallery3d\",\"defaultApp\":0},{\"id\":4658,\"label\":\"Messaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.mmsMessaging\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":4661,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.mediatek.cameraCamera\",\"packageName\":\"com.mediatek.camera\",\"defaultApp\":0},{\"id\":4662,\"label\":\"Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.calculator2Calculator\",\"packageName\":\"com.android.calculator2\",\"defaultApp\":0},{\"id\":4663,\"label\":\"Search\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"packageName\":\"com.android.quicksearchbox\",\"defaultApp\":0},{\"id\":4664,\"label\":\"SIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"packageName\":\"com.android.stk\",\"defaultApp\":0},{\"id\":4665,\"label\":\"System software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"packageName\":\"com.mediatek.systemupdate\",\"defaultApp\":0},{\"id\":4666,\"label\":\"UEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"packageName\":\"com.rim.mobilefusion.client\",\"defaultApp\":0},{\"id\":10121,\"label\":\"Encrypted Notes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"packageName\":\"ca.unlimitedwireless.encryptednotes\",\"defaultApp\":0},{\"id\":12544,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.app.clockpackageClock\",\"packageName\":\"com.sec.android.app.clockpackage\",\"defaultApp\":0},{\"id\":12545,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.gallery3dGallery\",\"packageName\":\"com.sec.android.gallery3d\",\"defaultApp\":0},{\"id\":12547,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.contactsContacts\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12548,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.contactsPhone\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12549,\"label\":\"Messages\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.messagingMessages\",\"packageName\":\"com.samsung.android.messaging\",\"defaultApp\":0},{\"id\":12550,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.app.cameraCamera\",\"packageName\":\"com.sec.android.app.camera\",\"defaultApp\":0},{\"id\":12551,\"label\":\"Voice Search\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.google.android.googlequicksearchboxVoice Search\",\"packageName\":\"com.google.android.googlequicksearchbox\",\"defaultApp\":0},{\"id\":12554,\"label\":\"My Files\",\"icon\":\"icon_My Files.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.app.myfilesMy Files\",\"packageName\":\"com.sec.android.app.myfiles\",\"defaultApp\":0},{\"id\":13122,\"label\":\"MTK Engineer Mode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"packageName\":\"com.zonarmr.mtkengineermode\",\"defaultApp\":0},{\"id\":15610,\"label\":\"E-mail\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.emailE-mail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":15612,\"label\":\"SMS/MMS\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.mmsSMS/MMS\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":15706,\"label\":\"Secure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"packageName\":\"com.secureClear.SecureClearActivity\",\"defaultApp\":0},{\"id\":15929,\"label\":\"Secure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"defaultApp\":0},{\"id\":21827,\"label\":\"Cell Broadcasts\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"packageName\":\"com.android.cellbroadcastreceiver\",\"defaultApp\":0},{\"id\":15926,\"label\":\"System Control\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secure.systemcontrolSystem Control\",\"packageName\":\"com.secure.systemcontrol\",\"defaultApp\":0},{\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"visible\":1,\"defaultApp\":0}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":true,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":4670,\"app_id\":4670,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":4674,\"app_id\":4674,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":1,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"isChanged\":true,\"defaultApp\":0}]',
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"On\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-01 13:25:31',
    '2019-06-01 13:25:52'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    90,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":105,\"apk_id\":105,\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"apk\":\"apk-1559394505349.apk\",\"apk_name\":\"AppLock\",\"guest\":true,\"encrypted\":true,\"enable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-03 04:22:14',
    '2019-06-03 04:22:15'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    91,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":105,\"apk_id\":105,\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"apk\":\"apk-1559394505349.apk\",\"apk_name\":\"AppLock\",\"guest\":false,\"encrypted\":false,\"enable\":false}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-03 04:22:39',
    '2019-06-03 04:22:41'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    92,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":105,\"apk_id\":105,\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"apk\":\"apk-1559394505349.apk\",\"apk_name\":\"AppLock\",\"guest\":true,\"encrypted\":true,\"enable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-03 04:23:03',
    '2019-06-03 04:23:23'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    93,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    '[{\"id\":9145,\"app_id\":4649,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.music\"},{\"id\":9154,\"app_id\":4651,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.browser\"},{\"id\":9149,\"app_id\":4652,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9151,\"app_id\":4653,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9146,\"app_id\":4654,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9144,\"app_id\":4655,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9142,\"app_id\":4656,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.email\"},{\"id\":9143,\"app_id\":4657,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.gallery3d\"},{\"id\":9148,\"app_id\":4658,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.mms\"},{\"id\":9155,\"app_id\":4660,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9160,\"app_id\":4661,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.camera\"},{\"id\":9161,\"app_id\":4662,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calculator2\"},{\"id\":9147,\"app_id\":4663,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9153,\"app_id\":4664,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.stk\"},{\"id\":9156,\"app_id\":4665,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9150,\"app_id\":4666,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9157,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9158,\"app_id\":15706,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9163,\"app_id\":15929,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9152,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9177,\"device_id\":760,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9170,\"device_id\":760,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":9165,\"device_id\":760,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9166,\"device_id\":760,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9173,\"device_id\":760,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9164,\"device_id\":760,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9175,\"device_id\":760,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9168,\"device_id\":760,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9169,\"device_id\":760,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9167,\"device_id\":760,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9174,\"device_id\":760,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9172,\"device_id\":760,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9176,\"device_id\":760,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9171,\"device_id\":760,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9177,\"device_id\":760,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9170,\"device_id\":760,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":9165,\"device_id\":760,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9166,\"device_id\":760,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9173,\"device_id\":760,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9164,\"device_id\":760,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9175,\"device_id\":760,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9168,\"device_id\":760,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9169,\"device_id\":760,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9167,\"device_id\":760,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9174,\"device_id\":760,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9172,\"device_id\":760,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9176,\"device_id\":760,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9171,\"device_id\":760,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-03 04:24:16',
    '2019-06-03 04:40:42'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    94,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":105,\"apk_id\":105,\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"apk\":\"apk-1559394505349.apk\",\"apk_name\":\"AppLock\",\"guest\":false,\"encrypted\":false,\"enable\":false}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-03 04:27:24',
    '2019-06-03 04:27:25'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    95,
    156,
    'BCFE945075',
    154,
    NULL,
    NULL,
    '[{\"id\":9291,\"app_id\":4649,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9287,\"app_id\":4651,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9292,\"app_id\":4652,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":9286,\"app_id\":4653,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":9300,\"app_id\":4654,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":9293,\"app_id\":4655,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":9294,\"app_id\":4656,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9298,\"app_id\":4657,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9289,\"app_id\":4658,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9297,\"app_id\":4660,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9288,\"app_id\":4661,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9304,\"app_id\":4662,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9307,\"app_id\":4663,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9303,\"app_id\":4664,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9299,\"app_id\":4665,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9295,\"app_id\":4666,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9302,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9306,\"app_id\":15706,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9305,\"app_id\":15929,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9290,\"app_id\":4659,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9312,\"device_id\":760,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9313,\"device_id\":760,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":9315,\"device_id\":760,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9320,\"device_id\":760,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9309,\"device_id\":760,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9310,\"device_id\":760,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9316,\"device_id\":760,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9311,\"device_id\":760,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9308,\"device_id\":760,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9319,\"device_id\":760,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9321,\"device_id\":760,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9314,\"device_id\":760,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9317,\"device_id\":760,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9318,\"device_id\":760,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9312,\"device_id\":760,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9313,\"device_id\":760,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":9315,\"device_id\":760,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9320,\"device_id\":760,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9309,\"device_id\":760,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9310,\"device_id\":760,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9316,\"device_id\":760,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9311,\"device_id\":760,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9308,\"device_id\":760,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9319,\"device_id\":760,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9321,\"device_id\":760,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9314,\"device_id\":760,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9317,\"device_id\":760,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9318,\"device_id\":760,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-03 04:34:37',
    '2019-06-03 04:40:42'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    96,
    173,
    'BCFE945075',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":105,\"apk_id\":105,\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"apk\":\"apk-1559394505349.apk\",\"apk_name\":\"AppLock\",\"guest\":true,\"encrypted\":true,\"enable\":true}]',
    NULL,
    NULL,
    'push_apps',
    0,
    '2019-06-03 12:05:57',
    NULL
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    97,
    174,
    'EEEE144909',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":107,\"apk_id\":107,\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"apk\":\"apk-1559550029511.apk\",\"apk_name\":\"Secure VPN\",\"guest\":false,\"encrypted\":false,\"enable\":false},{\"key\":108,\"apk_id\":108,\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"apk\":\"apk-1559550917631.apk\",\"apk_name\":\"YouTube\",\"guest\":true,\"encrypted\":true,\"enable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-03 17:27:14',
    '2019-06-04 01:31:52'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    98,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":107,\"apk_id\":107,\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"apk\":\"apk-1559550029511.apk\",\"apk_name\":\"Secure VPN\",\"guest\":false,\"encrypted\":true,\"enable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-04 04:31:06',
    '2019-06-04 07:29:11'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    99,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calculator2\"},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:34:45',
    '2019-06-04 07:36:51'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    100,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:35:11',
    '2019-06-04 07:36:51'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    101,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:35:50',
    '2019-06-04 07:36:51'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    102,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:36:56',
    '2019-06-04 07:38:44'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    103,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\",\"isChanged\":true},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:37:20',
    '2019-06-04 07:38:44'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    104,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\",\"isChanged\":true},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:37:44',
    '2019-06-04 07:38:44'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    105,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9535,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9531,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9542,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9530,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9529,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9540,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9534,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9548,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9538,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9532,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9537,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9539,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\",\"isChanged\":true},{\"id\":9533,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9543,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9541,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9544,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9536,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9547,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9546,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\",\"isChanged\":true},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"},{\"id\":9528,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9558,\"device_id\":779,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9552,\"device_id\":779,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9556,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9553,\"device_id\":779,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9561,\"device_id\":779,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9554,\"device_id\":779,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9549,\"device_id\":779,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9550,\"device_id\":779,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9551,\"device_id\":779,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9560,\"device_id\":779,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9557,\"device_id\":779,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9559,\"device_id\":779,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9562,\"device_id\":779,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9555,\"device_id\":779,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:37:57',
    '2019-06-04 07:38:44'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    106,
    174,
    'EEEE144909',
    154,
    NULL,
    NULL,
    '[{\"id\":9495,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9501,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9500,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":9498,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":9499,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":9496,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":9497,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9494,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9493,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9507,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9513,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9506,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9508,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9509,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9510,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9512,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9502,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9511,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9503,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9504,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9521,\"device_id\":778,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9516,\"device_id\":778,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9525,\"device_id\":778,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9518,\"device_id\":778,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9520,\"device_id\":778,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9514,\"device_id\":778,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9515,\"device_id\":778,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9517,\"device_id\":778,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9523,\"device_id\":778,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9524,\"device_id\":778,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9519,\"device_id\":778,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9527,\"device_id\":778,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9526,\"device_id\":778,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9522,\"device_id\":778,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":\"1122\",\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":9521,\"device_id\":778,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":9516,\"device_id\":778,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9525,\"device_id\":778,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":9518,\"device_id\":778,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":9520,\"device_id\":778,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":9514,\"device_id\":778,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":9515,\"device_id\":778,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":9517,\"device_id\":778,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":9523,\"device_id\":778,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":9524,\"device_id\":778,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":9519,\"device_id\":778,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":9527,\"device_id\":778,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":9526,\"device_id\":778,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":9522,\"device_id\":778,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:51:51',
    '2019-06-05 07:58:11'
  );
INSERT INTO
  `device_history` (
    `id`,
    `user_acc_id`,
    `device_id`,
    `dealer_id`,
    `policy_name`,
    `profile_name`,
    `app_list`,
    `passwords`,
    `controls`,
    `permissions`,
    `push_apps`,
    `pull_apps`,
    `imei`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    107,
    175,
    'ECAE569003',
    154,
    NULL,
    NULL,
    '[{\"id\":9865,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":9855,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":9856,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":9858,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":9859,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":9857,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":9860,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":9864,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":9871,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":9869,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":9866,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":9861,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":9870,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":9862,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":9868,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":9867,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":9874,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":9872,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":9875,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":9863,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9879,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9889,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9885,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9880,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9886,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9878,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9881,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9890,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9882,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9877,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9887,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9888,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9883,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9884,\"device_id\":779,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":\"1122\",\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":9879,\"device_id\":779,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":9889,\"device_id\":779,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":9885,\"device_id\":779,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":9880,\"device_id\":779,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":9886,\"device_id\":779,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":9878,\"device_id\":779,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":9881,\"device_id\":779,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":9890,\"device_id\":779,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":9882,\"device_id\":779,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":9877,\"device_id\":779,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":9887,\"device_id\":779,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":9888,\"device_id\":779,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":9883,\"device_id\":779,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":9884,\"device_id\":779,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 07:52:25',
    '2019-06-04 07:53:30'
  );
