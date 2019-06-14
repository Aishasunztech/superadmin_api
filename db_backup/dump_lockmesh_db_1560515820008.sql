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
    108,
    174,
    'EEEE144909',
    154,
    NULL,
    NULL,
    '[{\"id\":10046,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":10048,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":10069,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":10070,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":10045,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":10044,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":10047,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":10056,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":10057,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":10050,\"app_id\":4660,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.soundrecorder\"},{\"id\":10061,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":10058,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":10059,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":10052,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":10055,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":10051,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":10054,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":10067,\"app_id\":10116,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Mail\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"ca.unlimitedwireless.mailpgpMail\",\"icon\":\"icon_Mail.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"ca.unlimitedwireless.mailpgp\"},{\"id\":10066,\"app_id\":10118,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Emergency Wipe\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.srz.unlimited.wiperEmergency Wipe\",\"icon\":\"icon_Emergency Wipe.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.srz.unlimited.wiper\"},{\"id\":10065,\"app_id\":10121,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Encrypted Notes\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"ca.unlimitedwireless.encryptednotes\"},{\"id\":10060,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":10064,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":10068,\"app_id\":20863,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"ArmorSec\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.armorsec.armor1ArmorSec\",\"icon\":\"icon_ArmorSec.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.armorsec.armor1\"},{\"id\":10049,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10083,\"device_id\":778,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":10075,\"device_id\":778,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":10072,\"device_id\":778,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":10073,\"device_id\":778,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":10076,\"device_id\":778,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":10078,\"device_id\":778,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":10080,\"device_id\":778,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":10084,\"device_id\":778,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":10082,\"device_id\":778,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":10071,\"device_id\":778,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":10077,\"device_id\":778,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":10081,\"device_id\":778,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":10079,\"device_id\":778,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":10074,\"device_id\":778,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10083,\"device_id\":778,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":10075,\"device_id\":778,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":10072,\"device_id\":778,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":10073,\"device_id\":778,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":10076,\"device_id\":778,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":10078,\"device_id\":778,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":10080,\"device_id\":778,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":10084,\"device_id\":778,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":10082,\"device_id\":778,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":10071,\"device_id\":778,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":10077,\"device_id\":778,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":10081,\"device_id\":778,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":10079,\"device_id\":778,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":10074,\"device_id\":778,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-04 08:00:06',
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
    109,
    174,
    'EEEE144909',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":108,\"apk_id\":108,\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"apk\":\"apk-1559550917631.apk\",\"apk_name\":\"YouTube\",\"guest\":false,\"encrypted\":false,\"enable\":false}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-04 08:00:55',
    '2019-06-04 08:00:56'
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
    110,
    176,
    'EAFA418535',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":107,\"apk_id\":107,\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"apk\":\"apk-1559550029511.apk\",\"apk_name\":\"Secure VPN\",\"guest\":false,\"encrypted\":false,\"enable\":false}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-04 08:23:58',
    '2019-06-04 08:23:59'
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
    111,
    176,
    'EAFA418535',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"key\":107,\"apk_id\":107,\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"apk\":\"apk-1559550029511.apk\",\"apk_name\":\"Secure VPN\",\"guest\":false,\"encrypted\":false,\"enable\":false},{\"key\":108,\"apk_id\":108,\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"apk\":\"apk-1559550917631.apk\",\"apk_name\":\"YouTube\",\"guest\":false,\"encrypted\":false,\"enable\":false}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-04 08:28:05',
    '2019-06-04 13:36:03'
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
    112,
    177,
    'CBDC381935',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-05 11:20:25',
    '2019-06-05 11:20:28'
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
    113,
    177,
    'CBDC381935',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-05 11:22:32',
    '2019-06-05 11:22:32'
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
    114,
    177,
    'CBDC381935',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"457202983569260\",\"imei2\":null}',
    'imei',
    1,
    '2019-06-05 11:26:26',
    '2019-06-05 11:26:26'
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
    115,
    177,
    'CBDC381935',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":null,\"imei2\":\"513616646303712\"}',
    'imei',
    1,
    '2019-06-05 11:26:43',
    '2019-06-05 11:26:43'
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
    116,
    178,
    'CDDA766328',
    223,
    NULL,
    NULL,
    '[{\"id\":10768,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":10766,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":10757,\"app_id\":4652,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":10749,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":10754,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":10752,\"app_id\":4655,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":10764,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":10750,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":10756,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":10753,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":10765,\"app_id\":4662,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":10763,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":10759,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":10755,\"app_id\":4665,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":10751,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":10758,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":10767,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":10761,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":10760,\"app_id\":4659,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10775,\"device_id\":782,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":10771,\"device_id\":782,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":10778,\"device_id\":782,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":10776,\"device_id\":782,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":10769,\"device_id\":782,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":10773,\"device_id\":782,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":10782,\"device_id\":782,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":10780,\"device_id\":782,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":10770,\"device_id\":782,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":10779,\"device_id\":782,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":10772,\"device_id\":782,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":10781,\"device_id\":782,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":10774,\"device_id\":782,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":10777,\"device_id\":782,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10775,\"device_id\":782,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":10771,\"device_id\":782,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":10778,\"device_id\":782,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":10776,\"device_id\":782,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":10769,\"device_id\":782,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":10773,\"device_id\":782,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":10782,\"device_id\":782,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":10780,\"device_id\":782,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":10770,\"device_id\":782,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":10779,\"device_id\":782,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":10772,\"device_id\":782,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":10781,\"device_id\":782,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":10774,\"device_id\":782,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":10777,\"device_id\":782,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-05 15:04:12',
    '2019-06-05 15:10:30'
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
    117,
    178,
    'CDDA766328',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-05 15:18:03',
    '2019-06-05 16:12:57'
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
    118,
    178,
    'CDDA766328',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":110,\"apk_name\":\"sys ctrls\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-05 16:56:04',
    '2019-06-05 16:56:05'
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
    119,
    178,
    'CDDA766328',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-05 16:58:34',
    '2019-06-05 17:03:37'
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
    120,
    177,
    'CBDC381935',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":110,\"apk_name\":\"sys ctrls\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-05 17:22:01',
    '2019-06-05 19:39:25'
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
    121,
    178,
    'CDDA766328',
    154,
    NULL,
    NULL,
    '[{\"id\":10925,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":10924,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":10934,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":10922,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":10937,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":10923,\"app_id\":4655,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":10942,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":10930,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":10943,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":10927,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":10929,\"app_id\":4662,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":10931,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":10928,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":10939,\"app_id\":4665,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":10932,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":10936,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":10935,\"app_id\":15706,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":10938,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":10926,\"app_id\":4659,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10953,\"device_id\":782,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":10946,\"device_id\":782,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":10956,\"device_id\":782,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":10947,\"device_id\":782,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":10954,\"device_id\":782,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":10944,\"device_id\":782,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":10957,\"device_id\":782,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":10948,\"device_id\":782,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":10945,\"device_id\":782,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":10949,\"device_id\":782,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":10952,\"device_id\":782,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":10950,\"device_id\":782,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":10951,\"device_id\":782,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":10955,\"device_id\":782,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":10953,\"device_id\":782,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":10946,\"device_id\":782,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":10956,\"device_id\":782,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":10947,\"device_id\":782,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":10954,\"device_id\":782,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":10944,\"device_id\":782,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":10957,\"device_id\":782,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":10948,\"device_id\":782,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":10945,\"device_id\":782,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":10949,\"device_id\":782,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":10952,\"device_id\":782,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":10950,\"device_id\":782,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":10951,\"device_id\":782,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":10955,\"device_id\":782,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-05 20:46:09',
    '2019-06-05 21:03:34'
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
    122,
    180,
    'CCDB002066',
    223,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-06 05:05:50',
    '2019-06-06 05:05:51'
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
    123,
    180,
    'CCDB002066',
    154,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-06 05:16:38',
    '2019-06-06 05:25:55'
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
    124,
    182,
    'BCBD957340',
    224,
    NULL,
    NULL,
    '[{\"id\":11253,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.music\"},{\"id\":11254,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.browser\"},{\"id\":11255,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":11256,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":11257,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":11266,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":11252,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":11251,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":11262,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.mms\"},{\"id\":11259,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":11260,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calculator2\"},{\"id\":11270,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":11267,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":11263,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":11268,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":11269,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":11265,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":11264,\"app_id\":15929,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":11258,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":11280,\"device_id\":787,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":11284,\"device_id\":787,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":11276,\"device_id\":787,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":11273,\"device_id\":787,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":11274,\"device_id\":787,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":11279,\"device_id\":787,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":11272,\"device_id\":787,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":11282,\"device_id\":787,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":11277,\"device_id\":787,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":11271,\"device_id\":787,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":11278,\"device_id\":787,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":11283,\"device_id\":787,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":11281,\"device_id\":787,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":11275,\"device_id\":787,\"app_id\":23213,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":11280,\"device_id\":787,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":11284,\"device_id\":787,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":11276,\"device_id\":787,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":11273,\"device_id\":787,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":11274,\"device_id\":787,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":11279,\"device_id\":787,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":11272,\"device_id\":787,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":11282,\"device_id\":787,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":11277,\"device_id\":787,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":11271,\"device_id\":787,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":11278,\"device_id\":787,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":11283,\"device_id\":787,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":11281,\"device_id\":787,\"app_id\":23212,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":0,\"id\":11275,\"device_id\":787,\"app_id\":23213,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-07 09:20:49',
    '2019-06-07 11:19:57'
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
    125,
    182,
    'BCBD957340',
    224,
    NULL,
    NULL,
    '[{\"id\":11253,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":11254,\"app_id\":4651,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":11255,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":11256,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":11257,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":11266,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":11252,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":11251,\"app_id\":4657,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":11262,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":11259,\"app_id\":4661,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":11260,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":11270,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":11267,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":11263,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":11268,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":11269,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":11265,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":11264,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":11258,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":11280,\"device_id\":787,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":11284,\"device_id\":787,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":11276,\"device_id\":787,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":11273,\"device_id\":787,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":11274,\"device_id\":787,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":11279,\"device_id\":787,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":11272,\"device_id\":787,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":11282,\"device_id\":787,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":11277,\"device_id\":787,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":11271,\"device_id\":787,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":11278,\"device_id\":787,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":11283,\"device_id\":787,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":11281,\"device_id\":787,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":11275,\"device_id\":787,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":11280,\"device_id\":787,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":11284,\"device_id\":787,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":11276,\"device_id\":787,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":11273,\"device_id\":787,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":11274,\"device_id\":787,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":11279,\"device_id\":787,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":11272,\"device_id\":787,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":11282,\"device_id\":787,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":11277,\"device_id\":787,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":11271,\"device_id\":787,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":11278,\"device_id\":787,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":11283,\"device_id\":787,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":11281,\"device_id\":787,\"app_id\":23212,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode\",\"guest\":0,\"label\":\"Airplane mode\",\"icon\":\"icon_Airplane mode.png\",\"encrypted\":1,\"id\":11275,\"device_id\":787,\"app_id\":23213,\"default_app\":0,\"isChanged\":true}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-07 09:21:25',
    '2019-06-07 11:19:57'
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
    126,
    182,
    'BCBD957340',
    224,
    'vincevsp200',
    NULL,
    '[{\"id\":4649,\"label\":\"Music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.musicMusic\",\"packageName\":\"com.android.music\",\"defaultApp\":0},{\"id\":4651,\"label\":\"Browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true,\"uniqueName\":\"com.android.browserBrowser\",\"packageName\":\"com.android.browser\",\"defaultApp\":0},{\"id\":4652,\"label\":\"Calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.calendarCalendar\",\"packageName\":\"com.android.calendar\",\"defaultApp\":0},{\"id\":4653,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.contactsContacts\",\"packageName\":\"com.android.contacts\",\"defaultApp\":0},{\"id\":4654,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.deskclockClock\",\"packageName\":\"com.android.deskclock\",\"defaultApp\":0},{\"id\":4655,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.dialerPhone\",\"packageName\":\"com.android.dialer\",\"defaultApp\":0},{\"id\":4656,\"label\":\"Email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":false,\"uniqueName\":\"com.android.emailEmail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":4657,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true,\"uniqueName\":\"com.android.gallery3dGallery\",\"packageName\":\"com.android.gallery3d\",\"defaultApp\":0},{\"id\":4658,\"label\":\"Messaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.mmsMessaging\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":4661,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true,\"uniqueName\":\"com.mediatek.cameraCamera\",\"packageName\":\"com.mediatek.camera\",\"defaultApp\":0},{\"id\":4662,\"label\":\"Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.calculator2Calculator\",\"packageName\":\"com.android.calculator2\",\"defaultApp\":0},{\"id\":4663,\"label\":\"Search\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"packageName\":\"com.android.quicksearchbox\",\"defaultApp\":0},{\"id\":4664,\"label\":\"SIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"packageName\":\"com.android.stk\",\"defaultApp\":0},{\"id\":4665,\"label\":\"System software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"packageName\":\"com.mediatek.systemupdate\",\"defaultApp\":0},{\"id\":4666,\"label\":\"UEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"packageName\":\"com.rim.mobilefusion.client\",\"defaultApp\":0},{\"id\":10121,\"label\":\"Encrypted Notes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"packageName\":\"ca.unlimitedwireless.encryptednotes\",\"defaultApp\":0},{\"id\":12544,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.sec.android.app.clockpackageClock\",\"packageName\":\"com.sec.android.app.clockpackage\",\"defaultApp\":0},{\"id\":12545,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.gallery3dGallery\",\"packageName\":\"com.sec.android.gallery3d\",\"defaultApp\":0},{\"id\":12547,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.contactsContacts\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12548,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.contactsPhone\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12549,\"label\":\"Messages\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.samsung.android.messagingMessages\",\"packageName\":\"com.samsung.android.messaging\",\"defaultApp\":0},{\"id\":12550,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.app.cameraCamera\",\"packageName\":\"com.sec.android.app.camera\",\"defaultApp\":0},{\"id\":12551,\"label\":\"Voice Search\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.google.android.googlequicksearchboxVoice Search\",\"packageName\":\"com.google.android.googlequicksearchbox\",\"defaultApp\":0},{\"id\":13122,\"label\":\"MTK Engineer Mode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"packageName\":\"com.zonarmr.mtkengineermode\",\"defaultApp\":0},{\"id\":15610,\"label\":\"E-mail\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.emailE-mail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":15612,\"label\":\"SMS/MMS\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.mmsSMS/MMS\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":15706,\"label\":\"Secure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"packageName\":\"com.secureClear.SecureClearActivity\",\"defaultApp\":0},{\"id\":15929,\"label\":\"Secure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"defaultApp\":0},{\"id\":21827,\"label\":\"Cell Broadcasts\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"packageName\":\"com.android.cellbroadcastreceiver\",\"defaultApp\":0},{\"id\":15926,\"label\":\"System Control\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null,\"uniqueName\":\"com.secure.systemcontrolSystem Control\",\"packageName\":\"com.secure.systemcontrol\",\"defaultApp\":0},{\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"visible\":1,\"defaultApp\":0}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":4670,\"app_id\":4670,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":4674,\"app_id\":4674,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":1,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"isChanged\":true,\"defaultApp\":0}]',
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-07 09:28:23',
    '2019-06-07 09:28:29'
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
    127,
    183,
    'DABC790128',
    224,
    'vincevsp200',
    NULL,
    '[{\"id\":4649,\"unique_name\":\"com.android.musicMusic\",\"label\":\"Music\",\"package_name\":\"com.android.music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4651,\"unique_name\":\"com.android.browserBrowser\",\"label\":\"Browser\",\"package_name\":\"com.android.browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4652,\"unique_name\":\"com.android.calendarCalendar\",\"label\":\"Calendar\",\"package_name\":\"com.android.calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4653,\"unique_name\":\"com.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4654,\"unique_name\":\"com.android.deskclockClock\",\"label\":\"Clock\",\"package_name\":\"com.android.deskclock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4655,\"unique_name\":\"com.android.dialerPhone\",\"label\":\"Phone\",\"package_name\":\"com.android.dialer\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4656,\"unique_name\":\"com.android.emailEmail\",\"label\":\"Email\",\"package_name\":\"com.android.email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":false},{\"id\":4657,\"unique_name\":\"com.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4658,\"unique_name\":\"com.android.mmsMessaging\",\"label\":\"Messaging\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4661,\"unique_name\":\"com.mediatek.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.mediatek.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4662,\"unique_name\":\"com.android.calculator2Calculator\",\"label\":\"Calculator\",\"package_name\":\"com.android.calculator2\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4663,\"unique_name\":\"com.android.quicksearchboxSearch\",\"label\":\"Search\",\"package_name\":\"com.android.quicksearchbox\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4664,\"unique_name\":\"com.android.stkSIM Toolkit\",\"label\":\"SIM Toolkit\",\"package_name\":\"com.android.stk\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4665,\"unique_name\":\"com.mediatek.systemupdateSystem software updates\",\"label\":\"System software updates\",\"package_name\":\"com.mediatek.systemupdate\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false},{\"id\":4666,\"unique_name\":\"com.rim.mobilefusion.clientUEM Client\",\"label\":\"UEM Client\",\"package_name\":\"com.rim.mobilefusion.client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":10121,\"unique_name\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"label\":\"Encrypted Notes\",\"package_name\":\"ca.unlimitedwireless.encryptednotes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12544,\"unique_name\":\"com.sec.android.app.clockpackageClock\",\"label\":\"Clock\",\"package_name\":\"com.sec.android.app.clockpackage\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":12545,\"unique_name\":\"com.sec.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.sec.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12547,\"unique_name\":\"com.samsung.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12548,\"unique_name\":\"com.samsung.android.contactsPhone\",\"label\":\"Phone\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12549,\"unique_name\":\"com.samsung.android.messagingMessages\",\"label\":\"Messages\",\"package_name\":\"com.samsung.android.messaging\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12550,\"unique_name\":\"com.sec.android.app.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.sec.android.app.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12551,\"unique_name\":\"com.google.android.googlequicksearchboxVoice Search\",\"label\":\"Voice Search\",\"package_name\":\"com.google.android.googlequicksearchbox\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":13122,\"unique_name\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"label\":\"MTK Engineer Mode\",\"package_name\":\"com.zonarmr.mtkengineermode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15610,\"unique_name\":\"com.android.emailE-mail\",\"label\":\"E-mail\",\"package_name\":\"com.android.email\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15612,\"unique_name\":\"com.android.mmsSMS/MMS\",\"label\":\"SMS/MMS\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15706,\"unique_name\":\"com.secureClear.SecureClearActivitySecure Clear\",\"label\":\"Secure Clear\",\"package_name\":\"com.secureClear.SecureClearActivity\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15929,\"unique_name\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"label\":\"Secure Market\",\"package_name\":\"com.secureMarket.SecureMarketActivity\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":21827,\"unique_name\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"label\":\"Cell Broadcasts\",\"package_name\":\"com.android.cellbroadcastreceiver\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15926,\"unique_name\":\"com.secure.systemcontrolSystem Control\",\"label\":\"System Control\",\"package_name\":\"com.secure.systemcontrol\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"default_app\":0,\"visible\":1}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":4670,\"app_id\":4670,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":4674,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":1,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"default_app\":0,\"isChanged\":true}]',
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-07 11:09:12',
    '2019-06-07 11:09:27'
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
    128,
    183,
    'DABC790128',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"334168734153689\",\"imei2\":null}',
    'imei',
    1,
    '2019-06-07 11:12:21',
    '2019-06-07 11:12:22'
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
    129,
    183,
    'DABC790128',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":null,\"imei2\":\"910577510673631\"}',
    'imei',
    1,
    '2019-06-07 11:12:35',
    '2019-06-07 11:12:35'
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
    130,
    182,
    'BCBD957340',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"521124211928336\",\"imei2\":null}',
    'imei',
    1,
    '2019-06-07 11:24:28',
    '2019-06-07 11:25:06'
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
    131,
    182,
    'BCBD957340',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"521124211928336\",\"imei2\":\"331561426782703\"}',
    'imei',
    1,
    '2019-06-07 11:24:41',
    '2019-06-07 11:25:06'
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
    132,
    184,
    'FDDE106484',
    224,
    'vincevsp200',
    NULL,
    '[{\"id\":4649,\"unique_name\":\"com.android.musicMusic\",\"label\":\"Music\",\"package_name\":\"com.android.music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4651,\"unique_name\":\"com.android.browserBrowser\",\"label\":\"Browser\",\"package_name\":\"com.android.browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4652,\"unique_name\":\"com.android.calendarCalendar\",\"label\":\"Calendar\",\"package_name\":\"com.android.calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4653,\"unique_name\":\"com.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4654,\"unique_name\":\"com.android.deskclockClock\",\"label\":\"Clock\",\"package_name\":\"com.android.deskclock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4655,\"unique_name\":\"com.android.dialerPhone\",\"label\":\"Phone\",\"package_name\":\"com.android.dialer\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4656,\"unique_name\":\"com.android.emailEmail\",\"label\":\"Email\",\"package_name\":\"com.android.email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":false},{\"id\":4657,\"unique_name\":\"com.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4658,\"unique_name\":\"com.android.mmsMessaging\",\"label\":\"Messaging\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4661,\"unique_name\":\"com.mediatek.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.mediatek.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4662,\"unique_name\":\"com.android.calculator2Calculator\",\"label\":\"Calculator\",\"package_name\":\"com.android.calculator2\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":4663,\"unique_name\":\"com.android.quicksearchboxSearch\",\"label\":\"Search\",\"package_name\":\"com.android.quicksearchbox\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4664,\"unique_name\":\"com.android.stkSIM Toolkit\",\"label\":\"SIM Toolkit\",\"package_name\":\"com.android.stk\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false,\"guest\":true},{\"id\":4665,\"unique_name\":\"com.mediatek.systemupdateSystem software updates\",\"label\":\"System software updates\",\"package_name\":\"com.mediatek.systemupdate\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":false},{\"id\":4666,\"unique_name\":\"com.rim.mobilefusion.clientUEM Client\",\"label\":\"UEM Client\",\"package_name\":\"com.rim.mobilefusion.client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":10121,\"unique_name\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"label\":\"Encrypted Notes\",\"package_name\":\"ca.unlimitedwireless.encryptednotes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12544,\"unique_name\":\"com.sec.android.app.clockpackageClock\",\"label\":\"Clock\",\"package_name\":\"com.sec.android.app.clockpackage\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":false,\"enable\":true,\"guest\":true},{\"id\":12545,\"unique_name\":\"com.sec.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.sec.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12547,\"unique_name\":\"com.samsung.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12548,\"unique_name\":\"com.samsung.android.contactsPhone\",\"label\":\"Phone\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12549,\"unique_name\":\"com.samsung.android.messagingMessages\",\"label\":\"Messages\",\"package_name\":\"com.samsung.android.messaging\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12550,\"unique_name\":\"com.sec.android.app.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.sec.android.app.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":12551,\"unique_name\":\"com.google.android.googlequicksearchboxVoice Search\",\"label\":\"Voice Search\",\"package_name\":\"com.google.android.googlequicksearchbox\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":13122,\"unique_name\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"label\":\"MTK Engineer Mode\",\"package_name\":\"com.zonarmr.mtkengineermode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15610,\"unique_name\":\"com.android.emailE-mail\",\"label\":\"E-mail\",\"package_name\":\"com.android.email\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15612,\"unique_name\":\"com.android.mmsSMS/MMS\",\"label\":\"SMS/MMS\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15706,\"unique_name\":\"com.secureClear.SecureClearActivitySecure Clear\",\"label\":\"Secure Clear\",\"package_name\":\"com.secureClear.SecureClearActivity\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15929,\"unique_name\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"label\":\"Secure Market\",\"package_name\":\"com.secureMarket.SecureMarketActivity\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":21827,\"unique_name\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"label\":\"Cell Broadcasts\",\"package_name\":\"com.android.cellbroadcastreceiver\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":15926,\"unique_name\":\"com.secure.systemcontrolSystem Control\",\"label\":\"System Control\",\"package_name\":\"com.secure.systemcontrol\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"default_app\":0,\"visible\":1}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":4670,\"app_id\":4670,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":4674,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":1,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"default_app\":0,\"isChanged\":true}]',
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-07 12:17:31',
    '2019-06-07 12:17:40'
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
    133,
    184,
    'FDDE106484',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"994217934569367\",\"imei2\":null}',
    'imei',
    1,
    '2019-06-07 18:45:41',
    '2019-06-07 18:45:41'
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
    134,
    184,
    'FDDE106484',
    224,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":null,\"imei2\":\"997264595879567\"}',
    'imei',
    1,
    '2019-06-07 18:45:56',
    '2019-06-07 18:45:56'
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
    135,
    190,
    'AECE977918',
    232,
    'barry',
    '',
    '[{\"id\":4649,\"unique_name\":\"com.android.musicMusic\",\"label\":\"Music\",\"package_name\":\"com.android.music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4651,\"unique_name\":\"com.android.browserBrowser\",\"label\":\"Browser\",\"package_name\":\"com.android.browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":4652,\"unique_name\":\"com.android.calendarCalendar\",\"label\":\"Calendar\",\"package_name\":\"com.android.calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4653,\"unique_name\":\"com.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4654,\"unique_name\":\"com.android.deskclockClock\",\"label\":\"Clock\",\"package_name\":\"com.android.deskclock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4655,\"unique_name\":\"com.android.dialerPhone\",\"label\":\"Phone\",\"package_name\":\"com.android.dialer\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":4656,\"unique_name\":\"com.android.emailEmail\",\"label\":\"Email\",\"package_name\":\"com.android.email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4657,\"unique_name\":\"com.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"encrypted\":true,\"enable\":true},{\"id\":4658,\"unique_name\":\"com.android.mmsMessaging\",\"label\":\"Messaging\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4661,\"unique_name\":\"com.mediatek.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.mediatek.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"encrypted\":true,\"enable\":true},{\"id\":4662,\"unique_name\":\"com.android.calculator2Calculator\",\"label\":\"Calculator\",\"package_name\":\"com.android.calculator2\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true},{\"id\":4663,\"unique_name\":\"com.android.quicksearchboxSearch\",\"label\":\"Search\",\"package_name\":\"com.android.quicksearchbox\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"guest\":true},{\"id\":4664,\"unique_name\":\"com.android.stkSIM Toolkit\",\"label\":\"SIM Toolkit\",\"package_name\":\"com.android.stk\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4665,\"unique_name\":\"com.mediatek.systemupdateSystem software updates\",\"label\":\"System software updates\",\"package_name\":\"com.mediatek.systemupdate\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4666,\"unique_name\":\"com.rim.mobilefusion.clientUEM Client\",\"label\":\"UEM Client\",\"package_name\":\"com.rim.mobilefusion.client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true},{\"id\":10121,\"unique_name\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"label\":\"Encrypted Notes\",\"package_name\":\"ca.unlimitedwireless.encryptednotes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null},{\"id\":12544,\"unique_name\":\"com.sec.android.app.clockpackageClock\",\"label\":\"Clock\",\"package_name\":\"com.sec.android.app.clockpackage\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":12545,\"unique_name\":\"com.sec.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.sec.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":12547,\"unique_name\":\"com.samsung.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":12548,\"unique_name\":\"com.samsung.android.contactsPhone\",\"label\":\"Phone\",\"package_name\":\"com.samsung.android.contacts\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":12549,\"unique_name\":\"com.samsung.android.messagingMessages\",\"label\":\"Messages\",\"package_name\":\"com.samsung.android.messaging\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":12550,\"unique_name\":\"com.sec.android.app.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.sec.android.app.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":12551,\"unique_name\":\"com.google.android.googlequicksearchboxVoice Search\",\"label\":\"Voice Search\",\"package_name\":\"com.google.android.googlequicksearchbox\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null},{\"id\":13122,\"unique_name\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"label\":\"MTK Engineer Mode\",\"package_name\":\"com.zonarmr.mtkengineermode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null},{\"id\":15610,\"unique_name\":\"com.android.emailE-mail\",\"label\":\"E-mail\",\"package_name\":\"com.android.email\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null},{\"id\":15612,\"unique_name\":\"com.android.mmsSMS/MMS\",\"label\":\"SMS/MMS\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null},{\"id\":15706,\"unique_name\":\"com.secureClear.SecureClearActivitySecure Clear\",\"label\":\"Secure Clear\",\"package_name\":\"com.secureClear.SecureClearActivity\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true},{\"id\":15929,\"unique_name\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"label\":\"Secure Market\",\"package_name\":\"com.secureMarket.SecureMarketActivity\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true},{\"id\":21827,\"unique_name\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"label\":\"Cell Broadcasts\",\"package_name\":\"com.android.cellbroadcastreceiver\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"default_app\":0,\"visible\":1},{\"id\":15926,\"unique_name\":\"com.secure.systemcontrolSystem Control\",\"label\":\"System Control\",\"package_name\":\"com.secure.systemcontrol\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null,\"encrypted\":false}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":false,\"id\":4668,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":false,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":4670,\"app_id\":4670,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":4674,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":false,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":true,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":0,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"default_app\":0,\"isChanged\":true}]',
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-10 15:33:17',
    '2019-06-10 15:33:54'
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
    136,
    176,
    'EAFA418535',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-11 03:46:59',
    '2019-06-11 03:47:07'
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
    137,
    176,
    'EAFA418535',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-11 03:48:52',
    '2019-06-11 03:49:54'
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
    138,
    202,
    'AECE977918',
    232,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-11 15:10:52',
    '2019-06-11 15:15:43'
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
    139,
    202,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 15:20:50',
    '2019-06-11 15:53:02'
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
    140,
    202,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 15:54:03',
    '2019-06-11 15:54:04'
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
    141,
    202,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-11 15:54:40',
    '2019-06-11 15:55:07'
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
    142,
    202,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 15:55:27',
    '2019-06-11 15:55:29'
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
    143,
    202,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 15:59:13',
    '2019-06-11 15:59:17'
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
    144,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-11 16:19:18',
    '2019-06-11 16:19:40'
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
    145,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 16:19:58',
    '2019-06-11 16:19:59'
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
    146,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":\"015922198702423\",\"imei2\":null}',
    'imei',
    1,
    '2019-06-11 16:35:17',
    '2019-06-11 16:36:26'
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
    147,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '{\"imei1\":null,\"imei2\":\"302548124110431\"}',
    'imei',
    1,
    '2019-06-11 16:38:19',
    '2019-06-11 16:38:20'
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
    148,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-11 16:41:49',
    '2019-06-11 16:41:50'
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
    149,
    211,
    'AECE977918',
    154,
    'barry',
    '',
    '[{\"id\":4649,\"label\":\"Music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.musicMusic\",\"packageName\":\"com.android.music\",\"defaultApp\":0},{\"id\":4651,\"label\":\"Browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.browserBrowser\",\"packageName\":\"com.android.browser\",\"defaultApp\":0},{\"id\":4652,\"label\":\"Calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.calendarCalendar\",\"packageName\":\"com.android.calendar\",\"defaultApp\":0},{\"id\":4653,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.contactsContacts\",\"packageName\":\"com.android.contacts\",\"defaultApp\":0},{\"id\":4654,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.deskclockClock\",\"packageName\":\"com.android.deskclock\",\"defaultApp\":0},{\"id\":4655,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.dialerPhone\",\"packageName\":\"com.android.dialer\",\"defaultApp\":0},{\"id\":4656,\"label\":\"Email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.emailEmail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":4657,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.android.gallery3dGallery\",\"packageName\":\"com.android.gallery3d\",\"defaultApp\":0},{\"id\":4658,\"label\":\"Messaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.mmsMessaging\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":4661,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.mediatek.cameraCamera\",\"packageName\":\"com.mediatek.camera\",\"defaultApp\":0},{\"id\":4662,\"label\":\"Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.calculator2Calculator\",\"packageName\":\"com.android.calculator2\",\"defaultApp\":0},{\"id\":4663,\"label\":\"Search\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"guest\":true,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"packageName\":\"com.android.quicksearchbox\",\"defaultApp\":0},{\"id\":4664,\"label\":\"SIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"packageName\":\"com.android.stk\",\"defaultApp\":0},{\"id\":4665,\"label\":\"System software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"packageName\":\"com.mediatek.systemupdate\",\"defaultApp\":0},{\"id\":4666,\"label\":\"UEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"packageName\":\"com.rim.mobilefusion.client\",\"defaultApp\":0},{\"id\":10121,\"label\":\"Encrypted Notes\",\"icon\":\"icon_Encrypted Notes.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-28 01:12:00\",\"updated_at\":null,\"uniqueName\":\"ca.unlimitedwireless.encryptednotesEncrypted Notes\",\"packageName\":\"ca.unlimitedwireless.encryptednotes\",\"defaultApp\":0},{\"id\":12544,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.sec.android.app.clockpackageClock\",\"packageName\":\"com.sec.android.app.clockpackage\",\"defaultApp\":0},{\"id\":12545,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.sec.android.gallery3dGallery\",\"packageName\":\"com.sec.android.gallery3d\",\"defaultApp\":0},{\"id\":12547,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.samsung.android.contactsContacts\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12548,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.samsung.android.contactsPhone\",\"packageName\":\"com.samsung.android.contacts\",\"defaultApp\":0},{\"id\":12549,\"label\":\"Messages\",\"icon\":\"icon_Messages.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.samsung.android.messagingMessages\",\"packageName\":\"com.samsung.android.messaging\",\"defaultApp\":0},{\"id\":12550,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.sec.android.app.cameraCamera\",\"packageName\":\"com.sec.android.app.camera\",\"defaultApp\":0},{\"id\":12551,\"label\":\"Voice Search\",\"icon\":\"icon_Voice Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-29 16:38:43\",\"updated_at\":null,\"uniqueName\":\"com.google.android.googlequicksearchboxVoice Search\",\"packageName\":\"com.google.android.googlequicksearchbox\",\"defaultApp\":0},{\"id\":13122,\"label\":\"MTK Engineer Mode\",\"icon\":\"icon_MTK Engineer Mode.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-30 08:56:25\",\"updated_at\":null,\"uniqueName\":\"com.zonarmr.mtkengineermodeMTK Engineer Mode\",\"packageName\":\"com.zonarmr.mtkengineermode\",\"defaultApp\":0},{\"id\":15610,\"label\":\"E-mail\",\"icon\":\"icon_E-mail.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"uniqueName\":\"com.android.emailE-mail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":15612,\"label\":\"SMS/MMS\",\"icon\":\"icon_SMS/MMS.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 07:46:18\",\"updated_at\":null,\"uniqueName\":\"com.android.mmsSMS/MMS\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":15706,\"label\":\"Secure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"packageName\":\"com.secureClear.SecureClearActivity\",\"defaultApp\":0},{\"id\":15929,\"label\":\"Secure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"defaultApp\":0},{\"id\":21827,\"label\":\"Cell Broadcasts\",\"icon\":\"icon_Cell Broadcasts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-27 09:10:24\",\"updated_at\":null,\"uniqueName\":\"com.android.cellbroadcastreceiverCell Broadcasts\",\"packageName\":\"com.android.cellbroadcastreceiver\",\"defaultApp\":0},{\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"visible\":1,\"defaultApp\":0},{\"id\":15926,\"label\":\"System Control\",\"icon\":\"icon_System Control.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":null,\"encrypted\":false,\"uniqueName\":\"com.secure.systemcontrolSystem Control\",\"packageName\":\"com.secure.systemcontrol\",\"defaultApp\":0}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":false,\"id\":4668,\"app_id\":4668,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":false,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":4670,\"app_id\":4670,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":4674,\"app_id\":4674,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":false,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":true,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":0,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"isChanged\":true,\"defaultApp\":0}]',
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    1,
    '2019-06-11 16:42:10',
    '2019-06-11 16:42:42'
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
    150,
    180,
    'CCDB002066',
    154,
    NULL,
    'barry_test_2',
    '[{\"id\":13633,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":13631,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":13634,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":13639,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":13632,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":13638,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":13635,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":13641,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":13637,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":13640,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":13646,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":13651,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":13642,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":13643,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":13645,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":13644,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":13649,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":13648,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":13647,\"app_id\":24499,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Contact Support\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.contactSupport.ChatActivityContact Support\",\"icon\":\"icon_Contact Support.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.contactSupport.ChatActivity\"}]',
    '{}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":1,\"encrypted\":1,\"enable\":1,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":13657,\"device_id\":784,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":13660,\"device_id\":784,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":13663,\"device_id\":784,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":13659,\"device_id\":784,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":13662,\"device_id\":784,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":13654,\"device_id\":784,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":13658,\"device_id\":784,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":13655,\"device_id\":784,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":13652,\"device_id\":784,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":13656,\"device_id\":784,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":13664,\"device_id\":784,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":13653,\"device_id\":784,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":13661,\"device_id\":784,\"app_id\":23212,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1}]',
    NULL,
    NULL,
    NULL,
    'profile',
    1,
    '2019-06-12 09:17:48',
    '2019-06-12 09:18:00'
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
    151,
    180,
    'CCDB002066',
    154,
    NULL,
    'barry_test_2',
    '[{\"id\":13633,\"app_id\":4649,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.music\"},{\"id\":13631,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.browser\"},{\"id\":13634,\"app_id\":4652,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calendar\"},{\"id\":13639,\"app_id\":4653,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.contacts\"},{\"id\":13632,\"app_id\":4654,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.deskclock\"},{\"id\":13638,\"app_id\":4655,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.dialer\"},{\"id\":13635,\"app_id\":4656,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.email\"},{\"id\":13641,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.gallery3d\"},{\"id\":13637,\"app_id\":4658,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.mms\"},{\"id\":13640,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.camera\"},{\"id\":13646,\"app_id\":4662,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.calculator2\"},{\"id\":13651,\"app_id\":4663,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":13642,\"app_id\":4664,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.stk\"},{\"id\":13643,\"app_id\":4665,\"guest\":true,\"encrypted\":false,\"enable\":false,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":13645,\"app_id\":4666,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":13644,\"app_id\":9686,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.vortexlocker.app\"},{\"id\":13649,\"app_id\":15706,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":13648,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":13647,\"app_id\":24499,\"guest\":false,\"encrypted\":true,\"enable\":true,\"label\":\"Contact Support\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.contactSupport.ChatActivityContact Support\",\"icon\":\"icon_Contact Support.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.contactSupport.ChatActivity\"}]',
    '{}',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":1,\"encrypted\":1,\"enable\":1,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":13657,\"device_id\":784,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":13660,\"device_id\":784,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":13663,\"device_id\":784,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":13659,\"device_id\":784,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":13662,\"device_id\":784,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":13654,\"device_id\":784,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":13658,\"device_id\":784,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":13655,\"device_id\":784,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":13652,\"device_id\":784,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":13656,\"device_id\":784,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":13664,\"device_id\":784,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":13653,\"device_id\":784,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":13661,\"device_id\":784,\"app_id\":23212,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1}]',
    NULL,
    NULL,
    NULL,
    'profile',
    1,
    '2019-06-12 09:18:30',
    '2019-06-12 09:23:36'
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
    152,
    186,
    'CBFB073737',
    154,
    'barrytest',
    '',
    '[{\"id\":4649,\"label\":\"Music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.musicMusic\",\"packageName\":\"com.android.music\",\"defaultApp\":0},{\"id\":4651,\"label\":\"Browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"encrypted\":true,\"enable\":true,\"guest\":true,\"uniqueName\":\"com.android.browserBrowser\",\"packageName\":\"com.android.browser\",\"defaultApp\":0},{\"id\":4652,\"label\":\"Calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.calendarCalendar\",\"packageName\":\"com.android.calendar\",\"defaultApp\":0},{\"id\":4653,\"label\":\"Contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.contactsContacts\",\"packageName\":\"com.android.contacts\",\"defaultApp\":0},{\"id\":4654,\"label\":\"Clock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.deskclockClock\",\"packageName\":\"com.android.deskclock\",\"defaultApp\":0},{\"id\":4655,\"label\":\"Phone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.dialerPhone\",\"packageName\":\"com.android.dialer\",\"defaultApp\":0},{\"id\":4656,\"label\":\"Email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.emailEmail\",\"packageName\":\"com.android.email\",\"defaultApp\":0},{\"id\":4657,\"label\":\"Gallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.gallery3dGallery\",\"packageName\":\"com.android.gallery3d\",\"defaultApp\":0},{\"id\":4658,\"label\":\"Messaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.mmsMessaging\",\"packageName\":\"com.android.mms\",\"defaultApp\":0},{\"id\":4660,\"label\":\"Sound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":\"0000-00-00 00:00:00\",\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"packageName\":\"com.android.soundrecorder\",\"defaultApp\":0},{\"id\":4661,\"label\":\"Camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.mediatek.cameraCamera\",\"packageName\":\"com.mediatek.camera\",\"defaultApp\":0},{\"id\":4662,\"label\":\"Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.calculator2Calculator\",\"packageName\":\"com.android.calculator2\",\"defaultApp\":0},{\"id\":4663,\"label\":\"Search\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"packageName\":\"com.android.quicksearchbox\",\"defaultApp\":0},{\"id\":4664,\"label\":\"SIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"packageName\":\"com.android.stk\",\"defaultApp\":0},{\"id\":4665,\"label\":\"System software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"packageName\":\"com.mediatek.systemupdate\",\"defaultApp\":0},{\"id\":4666,\"label\":\"UEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"packageName\":\"com.rim.mobilefusion.client\",\"defaultApp\":0},{\"id\":15706,\"label\":\"Secure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"packageName\":\"com.secureClear.SecureClearActivity\",\"defaultApp\":0},{\"id\":15929,\"label\":\"Secure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"packageName\":\"com.secureMarket.SecureMarketActivity\",\"defaultApp\":0},{\"encrypted\":true,\"enable\":true},{\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"visible\":1,\"defaultApp\":0}]',
    NULL,
    '{\"wifi_status\":true,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":4670,\"app_id\":4670,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":4674,\"app_id\":4674,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":0,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"isChanged\":true,\"defaultApp\":0},{\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"isChanged\":true,\"defaultApp\":0}]',
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"On\",\"deleteable\":true,\"isChanged\":true}]',
    NULL,
    NULL,
    'policy',
    0,
    '2019-06-13 06:11:23',
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
    153,
    212,
    'EBFA937942',
    224,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-13 15:21:47',
    '2019-06-13 15:21:52'
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
    154,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    '[{\"id\":14236,\"app_id\":4649,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.music\"},{\"id\":14238,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.browser\"},{\"id\":14237,\"app_id\":4652,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":14232,\"app_id\":4653,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":14234,\"app_id\":4654,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":14233,\"app_id\":4655,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":14253,\"app_id\":4656,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.email\"},{\"id\":14239,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.gallery3d\"},{\"id\":14235,\"app_id\":4658,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.mms\"},{\"id\":14250,\"app_id\":4660,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.soundrecorder\"},{\"id\":14240,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.camera\"},{\"id\":14244,\"app_id\":4662,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calculator2\"},{\"id\":14247,\"app_id\":4663,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":14248,\"app_id\":4664,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.stk\"},{\"id\":14245,\"app_id\":4665,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":14246,\"app_id\":4666,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":14242,\"app_id\":9686,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.appScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.vortexlocker.app\"},{\"id\":14254,\"app_id\":15706,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":14256,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":14252,\"app_id\":16940,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Lite\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.facebook.mliteLite\",\"icon\":\"icon_Lite.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.facebook.mlite\"},{\"id\":14258,\"app_id\":22049,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"YouTube\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.paraphron.youtubeYouTube\",\"icon\":\"icon_YouTube.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.paraphron.youtube\"},{\"id\":14243,\"app_id\":24499,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Contact Support\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.contactSupport.ChatActivityContact Support\",\"icon\":\"icon_Contact Support.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.contactSupport.ChatActivity\"},{\"id\":14251,\"app_id\":27721,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secure.launcherScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secure.launcher\"},{\"id\":14241,\"app_id\":4659,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":14266,\"device_id\":816,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":14263,\"device_id\":816,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":14259,\"device_id\":816,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":14265,\"device_id\":816,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":14269,\"device_id\":816,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":14267,\"device_id\":816,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":14262,\"device_id\":816,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":14264,\"device_id\":816,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":14260,\"device_id\":816,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":14261,\"device_id\":816,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":14271,\"device_id\":816,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":14270,\"device_id\":816,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":14268,\"device_id\":816,\"app_id\":23212,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":14266,\"device_id\":816,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":14263,\"device_id\":816,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":14259,\"device_id\":816,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":14265,\"device_id\":816,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":14269,\"device_id\":816,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":14267,\"device_id\":816,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":14262,\"device_id\":816,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":14264,\"device_id\":816,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":14260,\"device_id\":816,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":14261,\"device_id\":816,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":14271,\"device_id\":816,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":14270,\"device_id\":816,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":14268,\"device_id\":816,\"app_id\":23212,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    1,
    '2019-06-13 19:00:30',
    '2019-06-13 19:11:54'
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
    155,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-13 19:02:15',
    '2019-06-13 19:02:17'
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
    156,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-13 19:02:59',
    '2019-06-13 19:03:56'
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
    157,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-13 19:04:21',
    '2019-06-13 19:04:23'
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
    158,
    211,
    'AECE977918',
    154,
    NULL,
    '',
    '[{\"id\":14729,\"app_id\":4649,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Music\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.musicMusic\",\"icon\":\"icon_Music.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.music\"},{\"id\":14738,\"app_id\":4651,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Browser\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.browserBrowser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.browser\"},{\"id\":14721,\"app_id\":4652,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calendar\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calendarCalendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calendar\"},{\"id\":14742,\"app_id\":4653,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Contacts\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.contactsContacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.contacts\"},{\"id\":14728,\"app_id\":4654,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Clock\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.deskclockClock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.deskclock\"},{\"id\":14730,\"app_id\":4655,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Phone\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.dialerPhone\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.dialer\"},{\"id\":14725,\"app_id\":4656,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Email\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.emailEmail\",\"icon\":\"icon_Email.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.email\"},{\"id\":14720,\"app_id\":4657,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Gallery\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.gallery3dGallery\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.gallery3d\"},{\"id\":14727,\"app_id\":4658,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Messaging\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.mmsMessaging\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.mms\"},{\"id\":14737,\"app_id\":4660,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Sound Recorder\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.soundrecorderSound Recorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.soundrecorder\"},{\"id\":14724,\"app_id\":4661,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Camera\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.cameraCamera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.camera\"},{\"id\":14722,\"app_id\":4662,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Calculator\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.calculator2Calculator\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.calculator2\"},{\"id\":14739,\"app_id\":4663,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Search\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.quicksearchboxSearch\",\"icon\":\"icon_Search.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.quicksearchbox\"},{\"id\":14740,\"app_id\":4664,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"SIM Toolkit\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.android.stkSIM Toolkit\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.android.stk\"},{\"id\":14726,\"app_id\":4665,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"System software updates\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.mediatek.systemupdateSystem software updates\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.mediatek.systemupdate\"},{\"id\":14733,\"app_id\":4666,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"UEM Client\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.rim.mobilefusion.clientUEM Client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.rim.mobilefusion.client\"},{\"id\":14731,\"app_id\":15706,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Clear\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureClear.SecureClearActivitySecure Clear\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureClear.SecureClearActivity\"},{\"id\":14734,\"app_id\":15929,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Market\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.secureMarket.SecureMarketActivity\"},{\"id\":14732,\"app_id\":16445,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Screen Locker\",\"default_app\":1,\"visible\":1,\"uniqueName\":\"com.vortexlocker.apScreen Locker\",\"icon\":\"icon_Screen Locker.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.vortexlocker.ap\"},{\"id\":14736,\"app_id\":16940,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Lite\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.facebook.mliteLite\",\"icon\":\"icon_Lite.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.facebook.mlite\"},{\"id\":14741,\"app_id\":24499,\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Contact Support\",\"default_app\":0,\"visible\":1,\"uniqueName\":\"com.contactSupport.ChatActivityContact Support\",\"icon\":\"icon_Contact Support.png\",\"extension\":0,\"extension_id\":0,\"isChanged\":true,\"packageName\":\"com.contactSupport.ChatActivity\"},{\"id\":14723,\"app_id\":4659,\"guest\":false,\"encrypted\":false,\"enable\":false,\"label\":\"Settings\",\"default_app\":0,\"visible\":0,\"uniqueName\":\"com.android.settingsSettings\",\"icon\":\"icon_Settings.png\",\"extension\":0,\"extension_id\":0,\"packageName\":\"com.android.settings\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"subExtension\":[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":14746,\"device_id\":816,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":14743,\"device_id\":816,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":14744,\"device_id\":816,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":14749,\"device_id\":816,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":14747,\"device_id\":816,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":14750,\"device_id\":816,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":14754,\"device_id\":816,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":14752,\"device_id\":816,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":14751,\"device_id\":816,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":14755,\"device_id\":816,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":14745,\"device_id\":816,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":14753,\"device_id\":816,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":14748,\"device_id\":816,\"app_id\":23212,\"default_app\":0}],\"visible\":1,\"default_app\":0,\"extension\":1,\"packageName\":\"com.secureSetting.SecureSettingsMain\"}]',
    '{\"admin_password\":null,\"guest_password\":null,\"encrypted_password\":null,\"duress_password\":null}',
    '{}',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":0,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":14746,\"device_id\":816,\"app_id\":4668,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":0,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":14743,\"device_id\":816,\"app_id\":4669,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":0,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":14744,\"device_id\":816,\"app_id\":4670,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":14749,\"device_id\":816,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":14747,\"device_id\":816,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":14750,\"device_id\":816,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":14754,\"device_id\":816,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":14752,\"device_id\":816,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":14751,\"device_id\":816,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":14755,\"device_id\":816,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":14745,\"device_id\":816,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":14753,\"device_id\":816,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":14748,\"device_id\":816,\"app_id\":23212,\"default_app\":0}]',
    NULL,
    NULL,
    NULL,
    'history',
    0,
    '2019-06-13 19:15:27',
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
    159,
    184,
    'FDDE106484',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":true,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-13 22:56:08',
    '2019-06-13 22:56:16'
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
    160,
    184,
    'FDDE106484',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-13 22:56:43',
    '2019-06-13 22:56:44'
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
    161,
    184,
    'FDDE106484',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":false,\"enable\":true,\"deleteable\":true}]',
    NULL,
    NULL,
    'push_apps',
    1,
    '2019-06-13 22:57:53',
    '2019-06-13 22:57:59'
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
    162,
    184,
    'FDDE106484',
    154,
    NULL,
    '',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    '[{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":false,\"encrypted\":false,\"enable\":false,\"deleteable\":true}]',
    NULL,
    'pull_apps',
    1,
    '2019-06-13 22:58:19',
    '2019-06-13 22:58:20'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: acc_action_history
# ------------------------------------------------------------

INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    465,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.123',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    225,
    0,
    '541763',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Hamza Dawood',
    'null',
    156,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-01 13:06:26',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    466,
    'Pending activation',
    'EACE961253',
    'null',
    'null',
    'null',
    '192.168.0.157',
    'null',
    '354444076297110',
    'null',
    '354444076297128',
    'VSP1001901S00370',
    '00:27:15:22:AD:74',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    157,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-02 20:04:42',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    467,
    'SUSPENDED',
    'BCFE945075',
    'undefined',
    '0LJVCaXRYOMPfBAtAA3w',
    'null',
    '192.168.0.123',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'hamza.dawood007@gmail.com',
    225,
    225,
    '541763',
    'null',
    '2019/06/01',
    NULL,
    '2019/12/01',
    'null',
    'active',
    1,
    0,
    'undefined',
    'suspended',
    0,
    0,
    'Hamza Dawood',
    'Hamza Dawood',
    156,
    '791BFT@TITANSECURE.BIZ',
    'N/A',
    'N/A',
    NULL,
    'Suspended',
    '2019-06-03 04:21:38',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    468,
    'ACTIVE',
    'BCFE945075',
    'undefined',
    '0LJVCaXRYOMPfBAtAA3w',
    'null',
    '192.168.0.123',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'hamza.dawood007@gmail.com',
    225,
    225,
    '541763',
    'null',
    '2019/06/01',
    NULL,
    '2019/12/01',
    'null',
    'active',
    1,
    0,
    'undefined',
    '',
    0,
    0,
    'Hamza Dawood',
    'Hamza Dawood',
    156,
    '791BFT@TITANSECURE.BIZ',
    'N/A',
    'N/A',
    NULL,
    'Active',
    '2019-06-03 04:21:43',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    469,
    'UNLINKED',
    'BCFE945075',
    'undefined',
    'dWSv81GtbCk-WnVtAA4L',
    'null',
    '192.168.0.123',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'hamza.dawood007@gmail.com',
    225,
    225,
    '541763',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Hamza Dawood',
    'Hamza Dawood',
    156,
    '791BFT@TITANSECURE.BIZ',
    'N/A',
    'N/A',
    1,
    'Unlinked',
    '2019-06-03 09:36:09',
    '2019-06-03 09:36:09'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    470,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    158,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:00',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    471,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    158,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:03',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    472,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    159,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:04',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    473,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    159,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:05',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    474,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    160,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:07',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    475,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    160,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:14',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    476,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    161,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:15',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    477,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    161,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:20',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    478,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    162,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:22',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    479,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    162,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:23',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    480,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    163,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:24',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    481,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    163,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:24',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    482,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    164,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:25',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    483,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    164,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:26',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    484,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    165,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:26',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    485,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    165,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:27',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    486,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    166,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:28',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    487,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    166,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:28',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    488,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    167,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:29',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    489,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    167,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:29',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    490,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    168,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:30',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    491,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    168,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:30',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    492,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    169,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:31',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    493,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    169,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:31',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    494,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    170,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:32',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    495,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    170,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 04:50:32',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    496,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    171,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 04:50:33',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    497,
    'UNLINKED',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.100',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    171,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-03 05:39:45',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    498,
    'Pending activation',
    'ACDA931851',
    'null',
    'null',
    'null',
    '192.168.0.102',
    '8992042306182528852f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:66:BC:ED:E0:B7',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    225,
    0,
    '541763',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Hamza Dawood',
    'null',
    172,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 09:31:43',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    499,
    'Pending activation',
    'BCFE945075',
    'null',
    'null',
    'null',
    '192.168.0.101',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    173,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 12:04:27',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    500,
    'Pending activation',
    'EEEE144909',
    'null',
    'null',
    'null',
    '192.168.0.227',
    '8901260852296619117f',
    '300844813987599',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:1E:D3:41:79:88',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    174,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 16:51:55',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    501,
    'Pending activation',
    'ECAE569003',
    'null',
    'null',
    'null',
    '192.168.0.71',
    'null',
    'null',
    'null',
    'null',
    'OUKIC11000010686',
    '00:3A:F4:7C:F9:18',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    175,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-03 17:02:49',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    502,
    'Pending activation',
    'EAFA418535',
    'null',
    'null',
    'null',
    '192.168.31.144',
    'null',
    '505951191664618',
    'null',
    '354444076424243',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    176,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-04 07:58:28',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    503,
    'Pending activation',
    'CBDC381935',
    'null',
    'null',
    'null',
    '192.168.0.116',
    '8901260852291397214f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:27:32:0B:CB:0B',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    177,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-05 11:13:27',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    504,
    'Pre-activated',
    'null',
    'barry',
    'null',
    'undefined',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'barrybarrygood@hotmail.com',
    223,
    0,
    '610192',
    'undefined',
    'null',
    3,
    '2019/09/05',
    '5361459',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    178,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pre-activated',
    '2019-06-05 14:57:42',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    505,
    'UNLINKED',
    'CDDA766328',
    'barry',
    'null',
    'undefined',
    '192.168.31.11',
    'null',
    '543326403828323',
    'null',
    '014990923163675',
    '0123456789ABCDEF',
    '00:83:22:FE:E3:6C',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'barrybarrygood@hotmail.com',
    223,
    0,
    '610192',
    'undefined',
    '',
    3,
    '',
    '5361459',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Barry',
    'null',
    178,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-06 04:43:34',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    506,
    'Pending activation',
    'CDBE553230',
    'null',
    'null',
    'null',
    '192.168.31.11',
    'null',
    '455296770304917',
    'null',
    '014990923163675',
    '68768768776',
    '00:83:22:FE:E3:6C',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    179,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-06 04:44:24',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    507,
    'UNLINKED',
    'CDBE553230',
    'null',
    'null',
    'null',
    '192.168.31.11',
    'null',
    '455296770304917',
    'null',
    '014990923163675',
    '68768768776',
    '00:83:22:FE:E3:6C',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Barry',
    'null',
    179,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-06 04:46:17',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    508,
    'Pending activation',
    'CCDB002066',
    'null',
    'null',
    'null',
    '192.168.31.11',
    'null',
    '455296770304917',
    'null',
    '014990923163675',
    'VSP200190500001',
    '00:83:22:FE:E3:6C',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    223,
    0,
    '610192',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Barry',
    'null',
    180,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-06 04:51:05',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    509,
    'Pending activation',
    'EBCA987553',
    'null',
    'null',
    'null',
    '192.168.0.164',
    '8901260852291397164f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:B3:99:5B:E9:53',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    181,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-06 08:16:36',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    510,
    'FLAGGED',
    'CBDC381935',
    'undefined',
    'null',
    'null',
    '192.168.0.116',
    '8901260852291397214f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:27:32:0B:CB:0B',
    'null',
    'offline',
    1,
    'Other',
    'null',
    0,
    NULL,
    'zaid@vortexapp.ca',
    224,
    0,
    '417695',
    'null',
    '2019/06/05',
    NULL,
    '2019/12/05',
    'null',
    'active',
    1,
    0,
    'undefined',
    'suspended',
    0,
    0,
    'zaid',
    'null',
    177,
    '349VFT@TITANSECURE.BIZ',
    '5141281332',
    '2',
    NULL,
    'Suspended',
    '2019-06-06 08:17:01',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    511,
    'UNLINKED',
    'CBDC381935',
    'undefined',
    'null',
    'null',
    '192.168.0.116',
    '8901260852291397214f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:27:32:0B:CB:0B',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'zaid@vortexapp.ca',
    224,
    0,
    '417695',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    'suspended',
    1,
    0,
    'zaid',
    'null',
    177,
    '349VFT@TITANSECURE.BIZ',
    '5141281332',
    '2',
    1,
    'Unlinked',
    '2019-06-12 19:15:54',
    '2019-06-12 19:15:54'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    512,
    'UNLINKED',
    'BCFE945075',
    'undefined',
    'null',
    'null',
    '192.168.0.101',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    232,
    '674794',
    '12542',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'Muhammad mehran',
    173,
    '599NGT@TITANSECURE.BIZ',
    '6',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-06 08:17:17',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    513,
    'Pending activation',
    'BCBD957340',
    'null',
    'null',
    'null',
    '192.168.0.150',
    '8901260852291397164f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:08:2F:55:9D:A6',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    182,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-07 09:16:07',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    514,
    'Pending activation',
    'DABC790128',
    'null',
    'null',
    'null',
    '192.168.0.182',
    '8901260852291397214f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:A5:86:AB:F1:1D',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    183,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-07 11:08:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    515,
    'Pending activation',
    'FDDE106484',
    'null',
    'null',
    'null',
    '192.168.0.187',
    '8901260852291394641f',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:A9:21:1C:94:23',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    184,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-07 12:17:01',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    516,
    'Pending activation',
    'CBFB073737',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:6D:8B:A3:57:A5',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    185,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 05:32:51',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    517,
    'UNLINKED',
    'CBFB073737',
    'undefined',
    'null',
    'null',
    '192.168.0.103',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:6D:8B:A3:57:A5',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    232,
    '674794',
    '12542',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'Muhammad mehran',
    185,
    '5438DNE@ARMORSEC.XYZ',
    '1',
    '8',
    NULL,
    'Unlinked',
    '2019-06-10 05:36:47',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    518,
    'Pending activation',
    'CBFB073737',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    'null',
    'null',
    'null',
    '0123456789ABCDEF',
    '00:6D:8B:A3:57:A5',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    186,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 05:38:28',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    519,
    'Pending activation',
    'FEBE718436',
    'null',
    'null',
    'null',
    '10.156.140.228',
    '8992042306182528795',
    '355468080559917',
    'null',
    'null',
    'LGH872d603b454',
    'DC:0B:34:C4:E4:1C',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    187,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 08:43:42',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    520,
    'Pending activation',
    'DFFB715052',
    'null',
    'null',
    'null',
    '10.155.248.45',
    '8992042306182528803F',
    '868598033592605',
    'null',
    '868598033628615',
    'FFY5T18117023569',
    '10:44:00:BA:F3:E2',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    188,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 09:37:59',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    521,
    'Pending activation',
    'AECE977918',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    189,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 15:27:51',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    522,
    'UNLINKED',
    'AECE977918',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    189,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-10 15:32:37',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    523,
    'Pending activation',
    'AECE977918',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    190,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 15:32:56',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    524,
    'SUSPENDED',
    'AECE977918',
    'undefined',
    'eK5fXiVp5AjQYDMhAAGq',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    232,
    '674794',
    'null',
    '2019/06/10',
    NULL,
    '2020/06/10',
    'null',
    'active',
    1,
    0,
    'undefined',
    'suspended',
    0,
    0,
    'Muhammad mehran',
    'Muhammad mehran',
    190,
    '3669NBQ@ARMORSEC.XYZ',
    'N/A',
    'N/A',
    NULL,
    'Suspended',
    '2019-06-10 15:33:47',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    525,
    'ACTIVE',
    'AECE977918',
    'undefined',
    'eK5fXiVp5AjQYDMhAAGq',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    232,
    '674794',
    'null',
    '2019/06/10',
    NULL,
    '2020/06/10',
    'null',
    'active',
    1,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'Muhammad mehran',
    190,
    '3669NBQ@ARMORSEC.XYZ',
    'N/A',
    'N/A',
    NULL,
    'Active',
    '2019-06-10 15:33:53',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    526,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '5391064',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    191,
    '5147DXT@ARMORSEC.XYZ',
    '8',
    '9',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    527,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '7276467',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    192,
    '8244SRE@ARMORSEC.XYZ',
    '10',
    '10',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    528,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '7464533',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    193,
    '5412JJN@ARMORSEC.XYZ',
    '5',
    '5',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    529,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '1932013',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    194,
    '4134PTE@ARMORSEC.XYZ',
    '3',
    '4',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    530,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '0279944',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    195,
    '2954PAJ@ARMORSEC.XYZ',
    '2',
    '6',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    531,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '5957751',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    196,
    '6845YAY@ARMORSEC.XYZ',
    '9',
    '11',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    532,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '7275613',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    197,
    '7992PFY@ARMORSEC.XYZ',
    '5141281333',
    '7',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    533,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '7214842',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    198,
    '4967GCM@ARMORSEC.XYZ',
    '5141281334',
    '3',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    534,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '6739817',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    199,
    '5373SAJ@ARMORSEC.XYZ',
    '5141281336',
    '12',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    535,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    12,
    '2020/06/10',
    '2227434',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    200,
    '1233NPX@ARMORSEC.XYZ',
    '5141281337',
    '13',
    1,
    'Pre-activated',
    '2019-06-10 15:49:04',
    '2019-06-10 15:49:04'
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    536,
    'UNLINKED',
    'AECE977918',
    'undefined',
    'l1FVtS4yOxuNXoVdAAH_',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    232,
    '674794',
    'null',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'Muhammad mehran',
    190,
    '3669NBQ@ARMORSEC.XYZ',
    'N/A',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-10 15:53:37',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    537,
    'Pending activation',
    'AECE977918',
    'null',
    'null',
    'null',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    232,
    0,
    '674794',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-10 16:03:20',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    538,
    'SUSPENDED',
    'AECE977918',
    'undefined',
    'RHQPlZZxUFgfWq5lAAAf',
    'N/A',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'N/A',
    '2019/06/11',
    NULL,
    '2020/06/11',
    'null',
    'active',
    1,
    0,
    'undefined',
    'suspended',
    0,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    '8',
    'N/A',
    NULL,
    'Suspended',
    '2019-06-11 14:36:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    539,
    'ACTIVE',
    'AECE977918',
    'undefined',
    'RHQPlZZxUFgfWq5lAAAf',
    'N/A',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'N/A',
    '2019/06/11',
    NULL,
    '2020/06/11',
    'null',
    'active',
    1,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    '8',
    'N/A',
    NULL,
    'Active',
    '2019-06-11 14:36:21',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    540,
    'SUSPENDED',
    'AECE977918',
    'undefined',
    'RHQPlZZxUFgfWq5lAAAf',
    'N/A',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'N/A',
    '2019/06/11',
    NULL,
    '2020/06/11',
    'null',
    'active',
    1,
    0,
    'undefined',
    'suspended',
    0,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    '8',
    'N/A',
    NULL,
    'Suspended',
    '2019-06-11 14:36:33',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    541,
    'ACTIVE',
    'AECE977918',
    'undefined',
    'RHQPlZZxUFgfWq5lAAAf',
    'N/A',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'N/A',
    '2019/06/11',
    NULL,
    '2020/06/11',
    'null',
    'active',
    1,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    '8',
    'N/A',
    NULL,
    'Active',
    '2019-06-11 14:36:38',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    542,
    'UNLINKED',
    'AECE977918',
    'undefined',
    'RHQPlZZxUFgfWq5lAAAf',
    'N/A',
    '192.168.0.103',
    'null',
    '354444076293150',
    'null',
    '354444076293168',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'N/A',
    '',
    NULL,
    '',
    'null',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    201,
    'N/A',
    '8',
    'N/A',
    NULL,
    'Unlinked',
    '2019-06-11 14:36:44',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    543,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '8951644',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    202,
    '5147DXT@ARMORSEC.XYZ',
    '10',
    '9',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    544,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '6576863',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    203,
    '8244SRE@ARMORSEC.XYZ',
    '5',
    '10',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    545,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '1357753',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    204,
    '5412JJN@ARMORSEC.XYZ',
    '3',
    '5',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    546,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '7330919',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    205,
    '4134PTE@ARMORSEC.XYZ',
    '2',
    '4',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    547,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '6941045',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    206,
    '2954PAJ@ARMORSEC.XYZ',
    '9',
    '6',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    548,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '2518317',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    207,
    '6845YAY@ARMORSEC.XYZ',
    '5141281333',
    '11',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    549,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '0452855',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    208,
    '7992PFY@ARMORSEC.XYZ',
    '5141281334',
    '7',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    550,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '5887314',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    209,
    '4967GCM@ARMORSEC.XYZ',
    '5141281336',
    '3',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    551,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '7115112',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    210,
    '5373SAJ@ARMORSEC.XYZ',
    '5141281337',
    '12',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    552,
    'Pre-activated',
    'null',
    'Mehran',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    'null',
    1,
    '2019/07/11',
    '0855035',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    211,
    '1233NPX@ARMORSEC.XYZ',
    '5141281338',
    '13',
    NULL,
    'Pre-activated',
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    553,
    'UNLINKED',
    'AECE977918',
    'Mehran',
    '2paogt5Gzy6fM-u_AAB7',
    'null',
    '192.168.0.102',
    '89410062105442269285',
    '494113679796791',
    'null',
    '450452728961606',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'offline',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    '',
    1,
    '',
    '8951644',
    '',
    0,
    NULL,
    'undefined',
    '',
    1,
    0,
    'Muhammad mehran',
    'null',
    202,
    '5147DXT@ARMORSEC.XYZ',
    '10',
    '9',
    NULL,
    'Unlinked',
    '2019-06-11 16:18:12',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    554,
    'Pending activation',
    'EBFA937942',
    'null',
    'null',
    'null',
    '192.168.0.153',
    '8901260852291397198f',
    '354444076292210',
    'null',
    '354444076292228',
    'VSP1001901S00125',
    '00:27:15:41:D7:00',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    212,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:18:30',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    555,
    'Pending activation',
    'DDEA755394',
    'null',
    'null',
    'null',
    '192.168.0.113',
    '8901260852296618291f',
    '354444076298050',
    'null',
    '354444076298068',
    'VSP1001901S00417',
    '00:27:15:7B:44:E4',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    213,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:20:27',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    556,
    'Pending activation',
    'FBAC150553',
    'null',
    'null',
    'null',
    '192.168.0.141',
    'null',
    '354444076294877',
    'null',
    '354444076294885',
    'VSP1001901S00258',
    '00:27:15:8C:C5:BB',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    214,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:34:05',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    557,
    'Pending activation',
    'BFDA939981',
    'null',
    'null',
    'null',
    '192.168.0.103',
    '8931163200317782875f',
    '354444076293713',
    'null',
    '354444076293721',
    'VSP1001901S00200',
    '00:27:15:8F:DC:ED',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    215,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:40:42',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    558,
    'Pending activation',
    'AAFE485998',
    'null',
    'null',
    'null',
    '192.168.0.143',
    '8901260852296616196f',
    '354444076299678',
    'null',
    '354444076299686',
    'VSP1001901S00498',
    '00:27:15:6B:7F:7A',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    216,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:44:50',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    559,
    'Pending activation',
    'DFCA760576',
    'null',
    'null',
    'null',
    '192.168.0.145',
    'null',
    '354444076294539',
    'null',
    '354444076294547',
    'VSP1001901S00241',
    '00:27:15:81:08:EB',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    217,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:44:51',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    560,
    'Pending activation',
    'DABD696724',
    'null',
    'null',
    'null',
    '192.168.0.151',
    '8901260852293381588f',
    '354444076291915',
    'null',
    '354444076291923',
    'VSP1001901S00110',
    '00:27:15:60:EF:AE',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    218,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:47:40',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    561,
    'Pending activation',
    'AAAC945758',
    'null',
    'null',
    'null',
    '192.168.0.193',
    '8931163200316367033f',
    '354444076294752',
    'null',
    '354444076294760',
    'VSP1001901S00252',
    '00:27:15:B0:ED:C3',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    219,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:52:48',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    562,
    'Pending activation',
    'BAFB097798',
    'null',
    'null',
    'null',
    '192.168.0.187',
    '8901260852296618309f',
    '354444076298191',
    'null',
    '354444076298209',
    'VSP1001901S00424',
    '00:27:15:F8:12:CA',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    220,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 15:59:20',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    563,
    'Pending activation',
    'BDDE853697',
    'null',
    'null',
    'null',
    '192.168.0.130',
    '8931163200317782909f',
    '354444076293515',
    'null',
    '354444076293523',
    'VSP1001901S00190',
    '00:27:15:AB:86:FB',
    'null',
    'offline',
    0,
    'Not flagged',
    'null',
    0,
    NULL,
    'null',
    224,
    0,
    '417695',
    'null',
    'null',
    NULL,
    'null',
    'null',
    '',
    0,
    0,
    'undefined',
    '',
    0,
    0,
    'zaid',
    'null',
    221,
    'N/A',
    'N/A',
    'N/A',
    NULL,
    'Pending activation',
    '2019-06-13 16:06:27',
    NULL
  );
INSERT INTO
  `acc_action_history` (
    `id`,
    `action`,
    `device_id`,
    `device_name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `account_name`,
    `account_email`,
    `dealer_id`,
    `prnt_dlr_id`,
    `link_code`,
    `client_id`,
    `start_date`,
    `expiry_months`,
    `expiry_date`,
    `activation_code`,
    `status`,
    `device_status`,
    `activation_status`,
    `wipe_status`,
    `account_status`,
    `unlink_status`,
    `transfer_status`,
    `dealer_name`,
    `prnt_dlr_name`,
    `user_acc_id`,
    `pgp_email`,
    `chat_id`,
    `sim_id`,
    `del_status`,
    `finalStatus`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    564,
    'wiped',
    'AECE977918',
    'Mehran',
    '19avEhX1XB4O7EkfAAVn',
    'null',
    '192.168.0.102',
    '89410062105442269285',
    '015922198702423',
    'null',
    '302548124110431',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    'null',
    'online',
    1,
    'Not flagged',
    'null',
    0,
    NULL,
    'imuhammadmehran@gmail.com',
    232,
    0,
    '674794',
    'null',
    '2019/06/11',
    1,
    '2019/07/11',
    '0855035',
    'active',
    1,
    0,
    'undefined',
    '',
    0,
    0,
    'Muhammad mehran',
    'null',
    211,
    '1233NPX@ARMORSEC.XYZ',
    '5141281338',
    '13',
    NULL,
    'Active',
    '2019-06-13 19:16:21',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: acl_module_actions_to_user_roles
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: acl_module_to_user_roles
# ------------------------------------------------------------

INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (1, 1, 1);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (2, 2, 1);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (3, 3, 1);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (4, 1, 3);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (5, 1, 4);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (6, 2, 4);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (7, 1, 6);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (26, 1, 7);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (27, 2, 7);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (28, 1, 8);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (29, 2, 8);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (30, 3, 8);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (40, 1, 30);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (41, 2, 30);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (42, 3, 30);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (43, 1, 33);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (44, 1, 32);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (45, 1, 37);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (46, 1, 39);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (47, 1, 40);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (48, 2, 39);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (49, 2, 33);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (50, 2, 40);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (51, 1, 41);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (52, 2, 41);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (53, 3, 41);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (54, 1, 42);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (55, 2, 42);
INSERT INTO
  `acl_module_to_user_roles` (`id`, `user_role_id`, `component_id`)
VALUES
  (56, 4, 43);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: acl_modules
# ------------------------------------------------------------

INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    1,
    'Devices',
    'DevicesComponent',
    1,
    0,
    '/devices',
    '/devices'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (2, 'Login', 'LoginComponent', 0, 0, '/login', '/login');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    3,
    'Dealers',
    'DealerComponent',
    1,
    0,
    '/dealer',
    '/dealer/dealer'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    4,
    'Sub Dealers',
    'DealerComponent',
    1,
    0,
    '/dealer',
    '/dealer/sdealer'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    5,
    'Add Devices',
    'AddDeviceComponent',
    1,
    0,
    '/add-device',
    'add-device'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    6,
    'Create Dealers',
    'CreateDealer',
    1,
    0,
    '/create-dealer',
    '/create-dealer/dealer'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    7,
    'Create Sub-Dealer',
    'CreateDealer',
    1,
    0,
    '/create-sdealer',
    '/create-dealer/sdealer'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    8,
    'Connect Devices',
    'ConnectDevicesComponent',
    1,
    0,
    '/connect-device',
    '/connect-device/:deviceId'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    30,
    '',
    'ProfileComponent',
    1,
    0,
    '/profile',
    '/profile'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    31,
    '',
    'CreateClientComponent',
    1,
    0,
    NULL,
    '/create/client'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    32,
    '',
    'UploadApkComponent',
    1,
    0,
    NULL,
    '/upload-apk'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (33, '', 'ApkListComponent', 1, 0, NULL, '/apk-list');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (35, '', 'SettingsComponent', 1, 0, NULL, 'settings');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    36,
    'Profile List',
    'ProfileListComponent',
    1,
    0,
    'components/profile-list',
    'profile-list'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    37,
    'Account',
    'AccountComponent',
    1,
    0,
    'components/account',
    '/account'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    38,
    'Invalid Page',
    'InvalidPage',
    0,
    0,
    'components/account',
    '/invalid_page'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (39, 'App', 'App', 1, 0, NULL, '/app');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (40, 'Policy', 'Policy', 1, 0, NULL, '/policy');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (41, 'Users', 'Users', 1, 0, NULL, '/users');
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    42,
    'AppMarket',
    'AppMarket',
    1,
    0,
    NULL,
    '/app-market'
  );
INSERT INTO
  `acl_modules` (
    `id`,
    `title`,
    `component`,
    `login_required`,
    `sort`,
    `dir`,
    `uri`
  )
VALUES
  (
    43,
    'AutoUpdate',
    'AutoUpdate',
    1,
    0,
    NULL,
    '/apk-list/autoupdate'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: apk_details
# ------------------------------------------------------------

INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    100,
    'SL version 4.79',
    'logo-1559110870786.jpg',
    'apk-1560270192806.apk',
    'permanent',
    NULL,
    'com.vortexlocker.app',
    NULL,
    '479',
    '4.79',
    '',
    13960705,
    '13.31 MB',
    NULL,
    NULL,
    NULL,
    'Off',
    0,
    '2019-05-29 06:21:46',
    '2019-06-11 16:23:22'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    105,
    'AppLock',
    'logo-1559394492336.jpg',
    'apk-1559394505349.apk',
    'basic',
    NULL,
    'com.domobile.applock',
    NULL,
    '2019030701',
    '2.8.10',
    '',
    8494808,
    '8.1 MB',
    NULL,
    NULL,
    '[239,235,234,233,232,231,230,229,228,227,226,225,224,223,222,238]',
    'On',
    0,
    '2019-06-01 13:08:29',
    '2019-06-01 13:08:37'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    106,
    'sysctrl.apk1.17',
    'logo-1560270320062.jpg',
    'apk-1560270270165.apk',
    'permanent',
    NULL,
    'com.secure.systemcontrol',
    NULL,
    '117',
    '1.17',
    '',
    2292614,
    '2.19 MB',
    NULL,
    NULL,
    NULL,
    'Off',
    0,
    '2019-06-01 13:21:53',
    '2019-06-11 16:25:23'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    107,
    'Secure VPN',
    'logo-1559550038594.jpg',
    'apk-1559550029511.apk',
    'basic',
    NULL,
    'com.secure.vpn',
    NULL,
    '7',
    '1.07',
    '',
    5440465,
    '5.19 MB',
    NULL,
    NULL,
    '[224]',
    'Off',
    0,
    '2019-06-03 08:20:44',
    '2019-06-03 08:23:04'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    108,
    'YouTube',
    'logo-1559550908309.jpg',
    'apk-1559550917631.apk',
    'basic',
    NULL,
    'com.paraphron.youtube',
    NULL,
    '102455135',
    '10.24.55 (mod) ',
    '',
    12921621,
    '12.32 MB',
    NULL,
    NULL,
    '[241,239,235,234,233,232,231,230,229,228,227,226,225,224,223,222,238]',
    'Off',
    0,
    '2019-06-03 08:35:20',
    '2019-06-03 08:35:59'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    109,
    'Super VPN',
    'logo-1559752885994.jpg',
    'apk-1559752933656.apk',
    'basic',
    NULL,
    'com.jrzheng.supervpnfree',
    NULL,
    '84',
    '2.5.4',
    '',
    7893646,
    '7.53 MB',
    NULL,
    NULL,
    '[223]',
    'On',
    0,
    '2019-06-05 16:44:22',
    '2019-06-05 20:38:55'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    110,
    'sys ctrls v1.16',
    'logo-1559753228033.jpg',
    'apk-1559753250179.apk',
    'basic',
    NULL,
    'com.secure.systemcontrol',
    NULL,
    '116',
    '1.16',
    '',
    2291629,
    '2.19 MB',
    NULL,
    NULL,
    '[223]',
    'Off',
    0,
    '2019-06-05 16:47:33',
    '2019-06-05 19:45:14'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    113,
    'NeutralLauncher.v.4.78',
    'logo-1560178527157.jpg',
    'apk-1560178563547.apk',
    'basic',
    NULL,
    'com.secure.launcher',
    NULL,
    '478',
    '4.78',
    '',
    3170354,
    '3.02 MB',
    NULL,
    NULL,
    NULL,
    'On',
    0,
    '2019-06-10 14:56:07',
    '2019-06-11 05:01:20'
  );
INSERT INTO
  `apk_details` (
    `id`,
    `app_name`,
    `logo`,
    `apk`,
    `apk_type`,
    `label`,
    `package_name`,
    `unique_name`,
    `version_code`,
    `version_name`,
    `details`,
    `apk_bytes`,
    `apk_size`,
    `logo_bytes`,
    `logo_size`,
    `dealers`,
    `status`,
    `delete_status`,
    `created`,
    `modified`
  )
VALUES
  (
    114,
    'sysctrls.nl.v.1.16',
    'logo-1560178585432.jpg',
    'apk-1560178594248.apk',
    'basic',
    NULL,
    'com.secure.systemcontrol',
    NULL,
    '116',
    '1.16',
    '',
    2271149,
    '2.17 MB',
    NULL,
    NULL,
    '[]',
    'Off',
    0,
    '2019-06-10 14:56:48',
    '2019-06-12 06:57:49'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: apps_info
# ------------------------------------------------------------

INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4649,
    'com.android.musicMusic',
    'Music',
    'com.android.music',
    'icon_Music.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4650,
    'com.secureSetting.SecureSettingsMainSecure Settings',
    'Secure Settings',
    'com.secureSetting.SecureSettingsMain',
    'icon_Secure Settings.png',
    1,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4651,
    'com.android.browserBrowser',
    'Browser',
    'com.android.browser',
    'icon_Browser.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4652,
    'com.android.calendarCalendar',
    'Calendar',
    'com.android.calendar',
    'icon_Calendar.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4653,
    'com.android.contactsContacts',
    'Contacts',
    'com.android.contacts',
    'icon_Contacts.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4654,
    'com.android.deskclockClock',
    'Clock',
    'com.android.deskclock',
    'icon_Clock.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4655,
    'com.android.dialerPhone',
    'Phone',
    'com.android.dialer',
    'icon_Phone.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4656,
    'com.android.emailEmail',
    'Email',
    'com.android.email',
    'icon_Email.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4657,
    'com.android.gallery3dGallery',
    'Gallery',
    'com.android.gallery3d',
    'icon_Gallery.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4658,
    'com.android.mmsMessaging',
    'Messaging',
    'com.android.mms',
    'icon_Messaging.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4659,
    'com.android.settingsSettings',
    'Settings',
    'com.android.settings',
    'icon_Settings.png',
    0,
    0,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4660,
    'com.android.soundrecorderSound Recorder',
    'Sound Recorder',
    'com.android.soundrecorder',
    'icon_Sound Recorder.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4661,
    'com.mediatek.cameraCamera',
    'Camera',
    'com.mediatek.camera',
    'icon_Camera.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4662,
    'com.android.calculator2Calculator',
    'Calculator',
    'com.android.calculator2',
    'icon_Calculator.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4663,
    'com.android.quicksearchboxSearch',
    'Search',
    'com.android.quicksearchbox',
    'icon_Search.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4664,
    'com.android.stkSIM Toolkit',
    'SIM Toolkit',
    'com.android.stk',
    'icon_SIM Toolkit.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4665,
    'com.mediatek.systemupdateSystem software updates',
    'System software updates',
    'com.mediatek.systemupdate',
    'icon_System software updates.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4666,
    'com.rim.mobilefusion.clientUEM Client',
    'UEM Client',
    'com.rim.mobilefusion.client',
    'icon_UEM Client.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4667,
    'com.titanlocker.secureTitan Locker',
    'Titan Locker',
    'com.titanlocker.secure',
    'icon_Titan Locker.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    '2019-05-21 17:05:59'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4668,
    'com.secureSetting.SecureSettingsMainSecure SettingsBattery',
    'Battery',
    NULL,
    'icon_Battery.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4669,
    'com.secureSetting.SecureSettingsMainSecure Settingswi-fi',
    'wi-fi',
    NULL,
    'icon_wi-fi.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4670,
    'com.secureSetting.SecureSettingsMainSecure SettingsBluetooth',
    'Bluetooth',
    NULL,
    'icon_Bluetooth.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4671,
    'com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards',
    'SIM Cards',
    NULL,
    'icon_SIM Cards.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4672,
    'com.secureSetting.SecureSettingsMainSecure SettingsData Roaming',
    'Data Roaming',
    NULL,
    'icon_Data Roaming.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4673,
    'com.secureSetting.SecureSettingsMainSecure SettingsMobile Data',
    'Mobile Data',
    NULL,
    'icon_Mobile Data.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4674,
    'com.secureSetting.SecureSettingsMainSecure SettingsHotspot',
    'Hotspot',
    NULL,
    'icon_Hotspot.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4675,
    'com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock',
    'Finger Print + Lock',
    NULL,
    'icon_Finger Print + Lock.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4676,
    'com.secureSetting.SecureSettingsMainSecure SettingsBrightness',
    'Brightness',
    NULL,
    'icon_Brightness.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4677,
    'com.secureSetting.SecureSettingsMainSecure SettingsSleep',
    'Sleep',
    NULL,
    'icon_Sleep.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4678,
    'com.secureSetting.SecureSettingsMainSecure SettingsSound',
    'Sound',
    NULL,
    'icon_Sound.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4679,
    'com.secureSetting.SecureSettingsMainSecure SettingsDate & Time',
    'Date & Time',
    NULL,
    'icon_Date & Time.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9684,
    'com.secure.vpnSecure VPN',
    'Secure VPN',
    'com.secure.vpn',
    'icon_Secure VPN.png',
    0,
    1,
    0,
    0,
    '2019-04-26 02:51:19',
    '2019-06-13 22:53:53'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9686,
    'com.vortexlocker.appScreen Locker',
    'Screen Locker',
    'com.vortexlocker.app',
    'icon_Screen Locker.png',
    0,
    1,
    1,
    0,
    '2019-04-26 02:51:19',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10116,
    'ca.unlimitedwireless.mailpgpMail',
    'Mail',
    'ca.unlimitedwireless.mailpgp',
    'icon_Mail.png',
    0,
    1,
    0,
    0,
    '2019-04-28 01:12:00',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10118,
    'com.srz.unlimited.wiperEmergency Wipe',
    'Emergency Wipe',
    'com.srz.unlimited.wiper',
    'icon_Emergency Wipe.png',
    0,
    1,
    0,
    0,
    '2019-04-28 01:12:00',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10121,
    'ca.unlimitedwireless.encryptednotesEncrypted Notes',
    'Encrypted Notes',
    'ca.unlimitedwireless.encryptednotes',
    'icon_Encrypted Notes.png',
    0,
    1,
    0,
    0,
    '2019-04-28 01:12:00',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10123,
    'com.titansecure.titan1Titan Secure',
    'Titan Secure',
    'com.titansecure.titan1',
    'icon_Titan Secure.png',
    0,
    1,
    0,
    0,
    '2019-04-28 01:12:00',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12544,
    'com.sec.android.app.clockpackageClock',
    'Clock',
    'com.sec.android.app.clockpackage',
    'icon_Clock.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12545,
    'com.sec.android.gallery3dGallery',
    'Gallery',
    'com.sec.android.gallery3d',
    'icon_Gallery.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12547,
    'com.samsung.android.contactsContacts',
    'Contacts',
    'com.samsung.android.contacts',
    'icon_Contacts.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12548,
    'com.samsung.android.contactsPhone',
    'Phone',
    'com.samsung.android.contacts',
    'icon_Phone.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12549,
    'com.samsung.android.messagingMessages',
    'Messages',
    'com.samsung.android.messaging',
    'icon_Messages.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12550,
    'com.sec.android.app.cameraCamera',
    'Camera',
    'com.sec.android.app.camera',
    'icon_Camera.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12551,
    'com.google.android.googlequicksearchboxVoice Search',
    'Voice Search',
    'com.google.android.googlequicksearchbox',
    'icon_Voice Search.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12552,
    'com.google.android.googlequicksearchboxGoogle',
    'Google',
    'com.google.android.googlequicksearchbox',
    'icon_Google.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12553,
    'com.samsung.attvvmVisual Voicemail',
    'Visual Voicemail',
    'com.samsung.attvvm',
    'icon_Visual Voicemail.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12554,
    'com.sec.android.app.myfilesMy Files',
    'My Files',
    'com.sec.android.app.myfiles',
    'icon_My Files.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12555,
    'com.synchronoss.dcs.att.r2gSetup & Transfer',
    'Setup & Transfer',
    'com.synchronoss.dcs.att.r2g',
    'icon_Setup & Transfer.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12558,
    'com.codeproof.device.securityCodeproof® MDM',
    'Codeproof® MDM',
    'com.codeproof.device.security',
    'icon_Codeproof® MDM.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12562,
    'com.titansecure.bizTitan Secure',
    'Titan Secure',
    'com.titansecure.biz',
    'icon_Titan Secure.png',
    0,
    1,
    0,
    0,
    '2019-04-29 16:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12692,
    'org.thoughtcrime.securesmsSignal',
    'Signal',
    'org.thoughtcrime.securesms',
    'icon_Signal.png',
    0,
    1,
    0,
    0,
    '2019-04-29 20:35:59',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12852,
    'com.whatsappWhatsApp',
    'WhatsApp',
    'com.whatsapp',
    'icon_WhatsApp.png',
    0,
    1,
    0,
    0,
    '2019-04-29 20:56:49',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    13122,
    'com.zonarmr.mtkengineermodeMTK Engineer Mode',
    'MTK Engineer Mode',
    'com.zonarmr.mtkengineermode',
    'icon_MTK Engineer Mode.png',
    0,
    1,
    0,
    0,
    '2019-04-30 08:56:25',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15606,
    'com.android.browserNavigateur',
    'Navigateur',
    'com.android.browser',
    'icon_Navigateur.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15607,
    'com.android.calendarAgenda',
    'Agenda',
    'com.android.calendar',
    'icon_Agenda.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15608,
    'com.android.deskclockHorloge',
    'Horloge',
    'com.android.deskclock',
    'icon_Horloge.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15609,
    'com.android.dialerTéléphone',
    'Téléphone',
    'com.android.dialer',
    'icon_Téléphone.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15610,
    'com.android.emailE-mail',
    'E-mail',
    'com.android.email',
    'icon_E-mail.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15611,
    'com.android.gallery3dGalerie',
    'Galerie',
    'com.android.gallery3d',
    'icon_Galerie.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15612,
    'com.android.mmsSMS/MMS',
    'SMS/MMS',
    'com.android.mms',
    'icon_SMS/MMS.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15613,
    'com.android.musicMusique',
    'Musique',
    'com.android.music',
    'icon_Musique.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15614,
    'com.android.settingsParamètres',
    'Paramètres',
    'com.android.settings',
    'icon_Paramètres.png',
    0,
    0,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15615,
    'com.android.soundrecorderMagnétophone',
    'Magnétophone',
    'com.android.soundrecorder',
    'icon_Magnétophone.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15616,
    'com.mediatek.cameraAppareil photo',
    'Appareil photo',
    'com.mediatek.camera',
    'icon_Appareil photo.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15617,
    'com.android.calculator2Calculatrice',
    'Calculatrice',
    'com.android.calculator2',
    'icon_Calculatrice.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15618,
    'com.android.stkBoîte à outils SIM',
    'Boîte à outils SIM',
    'com.android.stk',
    'icon_Boîte à outils SIM.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15619,
    'com.mediatek.systemupdateMises à jour du logiciel système',
    'Mises à jour du logiciel système',
    'com.mediatek.systemupdate',
    'icon_Mises à jour du logiciel système.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15620,
    'ca.unlimitedwireless.mailpgpCourrier',
    'Courrier',
    'ca.unlimitedwireless.mailpgp',
    'icon_Courrier.png',
    0,
    1,
    0,
    0,
    '2019-05-01 07:46:18',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15706,
    'com.secureClear.SecureClearActivitySecure Clear',
    'Secure Clear',
    'com.secureClear.SecureClearActivity',
    'icon_Secure Clear.png',
    0,
    1,
    0,
    0,
    '2019-05-01 08:03:46',
    '2019-05-25 11:59:04'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15926,
    'com.secure.systemcontrolSystem Control',
    'System Control',
    'com.secure.systemcontrol',
    'icon_System Control.png',
    0,
    1,
    0,
    0,
    '2019-05-11 04:49:02',
    '2019-06-12 03:15:34'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15929,
    'com.secureMarket.SecureMarketActivitySecure Market',
    'Secure Market',
    'com.secureMarket.SecureMarketActivity',
    'icon_Secure Market.png',
    0,
    1,
    0,
    0,
    '2019-05-11 04:49:02',
    '2019-05-25 11:59:04'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16067,
    'com.facebook.liteLite',
    'Lite',
    'com.facebook.lite',
    'icon_Lite.png',
    0,
    1,
    0,
    0,
    '2019-05-11 10:31:17',
    '2019-06-03 12:04:54'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16445,
    'com.vortexlocker.apScreen Locker',
    'Screen Locker',
    'com.vortexlocker.ap',
    'icon_Screen Locker.png',
    0,
    1,
    1,
    0,
    '2019-05-14 10:04:38',
    '2019-05-21 09:39:27'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16871,
    'com.facebook.mliteMessenger Lite',
    'Messenger Lite',
    'com.facebook.mlite',
    'icon_Messenger Lite.png',
    0,
    0,
    0,
    0,
    '2019-05-15 16:14:49',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16940,
    'com.facebook.mliteLite',
    'Lite',
    'com.facebook.mlite',
    'icon_Lite.png',
    0,
    1,
    0,
    0,
    '2019-05-15 16:15:58',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    17626,
    'com.estrongs.android.popES File Explorer',
    'ES File Explorer',
    'com.estrongs.android.pop',
    'icon_ES File Explorer.png',
    0,
    1,
    0,
    0,
    '2019-05-16 06:59:30',
    '2019-06-04 08:02:22'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18288,
    'com.amazon.anowPrime Now',
    'Prime Now',
    'com.amazon.anow',
    'icon_Prime Now.png',
    0,
    0,
    0,
    0,
    '2019-05-16 07:59:45',
    '2019-05-16 08:01:28'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18398,
    'com.google.android.ttsGoogle Text-to-speech Engine',
    'Google Text-to-speech Engine',
    'com.google.android.tts',
    'icon_Google Text-to-speech Engine.png',
    0,
    0,
    0,
    0,
    '2019-05-16 08:01:28',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18547,
    'com.cricbuzz.androidCricbuzz',
    'Cricbuzz',
    'com.cricbuzz.android',
    'icon_Cricbuzz.png',
    0,
    0,
    0,
    0,
    '2019-05-16 08:29:06',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19254,
    'com.secureSetting.SecureSettingsMainSecure SettingsAirplan mode',
    'Airplan mode',
    NULL,
    'icon_Airplan mode.png',
    1,
    1,
    0,
    4650,
    '2019-05-20 12:50:13',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19890,
    'org.videolan.vlcVLC',
    'VLC',
    'org.videolan.vlc',
    'icon_VLC.png',
    0,
    1,
    0,
    0,
    '2019-05-21 08:18:29',
    '2019-06-10 09:38:43'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20722,
    'de.blinkt.openvpnOpenVPN for Android',
    'OpenVPN for Android',
    'de.blinkt.openvpn',
    'icon_OpenVPN for Android.png',
    0,
    1,
    0,
    0,
    '2019-05-22 06:22:14',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20863,
    'com.armorsec.armor1ArmorSec',
    'ArmorSec',
    'com.armorsec.armor1',
    'icon_ArmorSec.png',
    0,
    1,
    0,
    0,
    '2019-05-24 00:41:38',
    '2019-06-04 07:55:11'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21461,
    'com.secureSetting.SecureSettingsMainSecure SettingsLanguages',
    'Languages',
    NULL,
    'icon_Languages.png',
    1,
    1,
    0,
    4650,
    '2019-05-25 10:38:45',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21827,
    'com.android.cellbroadcastreceiverCell Broadcasts',
    'Cell Broadcasts',
    'com.android.cellbroadcastreceiver',
    'icon_Cell Broadcasts.png',
    0,
    1,
    0,
    0,
    '2019-05-27 09:10:24',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21830,
    'com.android.fmradioFM Radio',
    'FM Radio',
    'com.android.fmradio',
    'icon_FM Radio.png',
    0,
    1,
    0,
    0,
    '2019-05-27 09:10:24',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    22049,
    'com.paraphron.youtubeYouTube',
    'YouTube',
    'com.paraphron.youtube',
    'icon_YouTube.png',
    0,
    1,
    0,
    0,
    '2019-05-27 10:53:50',
    '2019-06-11 17:57:35'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23212,
    'com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input',
    'Languages & Input',
    NULL,
    'icon_Languages & Input.png',
    1,
    1,
    0,
    4650,
    '2019-05-29 19:14:05',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23213,
    'com.secureSetting.SecureSettingsMainSecure SettingsAirplane mode',
    'Airplane mode',
    NULL,
    'icon_Airplane mode.png',
    1,
    1,
    0,
    4650,
    '2019-05-29 19:14:05',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23787,
    'com.teslacoilsw.launcherNova Launcher',
    'Nova Launcher',
    'com.teslacoilsw.launcher',
    'icon_Nova Launcher.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:23',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23795,
    'com.example.sasukay.myapplicationBus Service system',
    'Bus Service system',
    'com.example.sasukay.myapplication',
    'icon_Bus Service system.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:23',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23827,
    'com.secure.launcherSecure Launcher',
    'Secure Launcher',
    'com.secure.launcher',
    'icon_Secure Launcher.png',
    0,
    0,
    0,
    0,
    '2019-06-01 13:35:25',
    '2019-06-12 03:15:34'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23828,
    'com.suphi.lightlaunchLightLaunch',
    'LightLaunch',
    'com.suphi.lightlaunch',
    'icon_LightLaunch.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:25',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23836,
    'de.blinkt.openvpnSecure VPN',
    'Secure VPN',
    'de.blinkt.openvpn',
    'icon_Secure VPN.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:25',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23837,
    'com.lenovo.anyshare.gpsSHAREit',
    'SHAREit',
    'com.lenovo.anyshare.gps',
    'icon_SHAREit.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:25',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23838,
    'free.vpn.unblock.proxy.gulfVPNGulf VPN',
    'Gulf VPN',
    'free.vpn.unblock.proxy.gulfVPN',
    'icon_Gulf VPN.png',
    0,
    1,
    0,
    0,
    '2019-06-01 13:35:25',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24089,
    'com.domobile.applockAppLock',
    'AppLock',
    'com.domobile.applock',
    'icon_AppLock.png',
    0,
    0,
    0,
    0,
    '2019-06-02 20:05:28',
    '2019-06-11 14:17:15'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24499,
    'com.contactSupport.ChatActivityContact Support',
    'Contact Support',
    'com.contactSupport.ChatActivity',
    'icon_Contact Support.png',
    0,
    1,
    0,
    0,
    '2019-06-03 12:04:54',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25298,
    'com.jrzheng.supervpnfreeSuperVPN',
    'SuperVPN',
    'com.jrzheng.supervpnfree',
    'icon_SuperVPN.png',
    0,
    0,
    0,
    0,
    '2019-06-04 08:02:22',
    '2019-06-12 11:25:17'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26601,
    'undefined',
    'Secure Settings',
    'undefined',
    'icon_Secure Settings.png',
    1,
    1,
    0,
    0,
    '2019-06-07 09:32:26',
    '2019-06-12 03:15:34'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26938,
    'com.vortexsecure.androidEncrypted Chat',
    'Encrypted Chat',
    'com.vortexsecure.android',
    'icon_Encrypted Chat.png',
    0,
    1,
    0,
    0,
    '2019-06-07 12:25:45',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26939,
    'ca.unlimitedwireless.encryptednotesEncrypted-Notes',
    'Encrypted-Notes',
    'ca.unlimitedwireless.encryptednotes',
    'icon_Encrypted-Notes.png',
    0,
    1,
    0,
    0,
    '2019-06-07 12:25:45',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27688,
    'com.jaz.telecomJazTelecom',
    'JazTelecom',
    'com.jaz.telecom',
    'icon_JazTelecom.png',
    0,
    1,
    0,
    0,
    '2019-06-07 18:42:26',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27721,
    'com.secure.launcherScreen Locker',
    'Screen Locker',
    'com.secure.launcher',
    'icon_Screen Locker.png',
    0,
    1,
    0,
    0,
    '2019-06-10 05:33:21',
    '2019-06-13 11:40:19'
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27929,
    'com.android.chromeChrome',
    'Chrome',
    'com.android.chrome',
    'icon_Chrome.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27932,
    'com.android.mediacenterMusic',
    'Music',
    'com.android.mediacenter',
    'icon_Music.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27933,
    'com.android.contactsDialer',
    'Dialer',
    'com.android.contacts',
    'icon_Dialer.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27936,
    'com.example.android.notepadNotepad',
    'Notepad',
    'com.example.android.notepad',
    'icon_Notepad.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27937,
    'com.google.android.apps.docs.editors.docsDocs',
    'Docs',
    'com.google.android.apps.docs.editors.docs',
    'icon_Docs.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27938,
    'com.google.android.apps.docs.editors.slidesSlides',
    'Slides',
    'com.google.android.apps.docs.editors.slides',
    'icon_Slides.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27939,
    'com.android.vendingPlay Store',
    'Play Store',
    'com.android.vending',
    'icon_Play Store.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27940,
    'com.google.android.apps.docs.editors.sheetsSheets',
    'Sheets',
    'com.google.android.apps.docs.editors.sheets',
    'icon_Sheets.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27941,
    'com.google.android.apps.mapsMaps',
    'Maps',
    'com.google.android.apps.maps',
    'icon_Maps.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27942,
    'com.google.android.apps.photosPhotos',
    'Photos',
    'com.google.android.apps.photos',
    'icon_Photos.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27943,
    'com.google.android.apps.tachyonDuo',
    'Duo',
    'com.google.android.apps.tachyon',
    'icon_Duo.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27944,
    'com.google.android.apps.docsDrive',
    'Drive',
    'com.google.android.apps.docs',
    'icon_Drive.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27945,
    'com.google.android.gmGmail',
    'Gmail',
    'com.google.android.gm',
    'icon_Gmail.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27946,
    'com.google.android.musicPlay Music',
    'Play Music',
    'com.google.android.music',
    'icon_Play Music.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27947,
    'com.huawei.hidiskFiles',
    'Files',
    'com.huawei.hidisk',
    'icon_Files.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27948,
    'com.huawei.cameraCamera',
    'Camera',
    'com.huawei.camera',
    'icon_Camera.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27949,
    'com.google.android.talkHangouts',
    'Hangouts',
    'com.google.android.talk',
    'icon_Hangouts.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27950,
    'com.ubercabUber',
    'Uber',
    'com.ubercab',
    'icon_Uber.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27951,
    'com.huawei.himovie.overseasHUAWEI Video',
    'HUAWEI Video',
    'com.huawei.himovie.overseas',
    'icon_HUAWEI Video.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27952,
    'io.faceappFaceApp',
    'FaceApp',
    'io.faceapp',
    'icon_FaceApp.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27953,
    'com.google.android.youtubeYouTube',
    'YouTube',
    'com.google.android.youtube',
    'icon_YouTube.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27954,
    'org.mozilla.firefoxFirefox',
    'Firefox',
    'org.mozilla.firefox',
    'icon_Firefox.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27955,
    'org.zwanoo.android.speedtestSpeedtest',
    'Speedtest',
    'org.zwanoo.android.speedtest',
    'icon_Speedtest.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27957,
    'com.android.documentsuiDownloads',
    'Downloads',
    'com.android.documentsui',
    'icon_Downloads.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27958,
    'com.android.hwmirrorMirror',
    'Mirror',
    'com.android.hwmirror',
    'icon_Mirror.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27959,
    'com.android.soundrecorderRecorder',
    'Recorder',
    'com.android.soundrecorder',
    'icon_Recorder.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27962,
    'com.huawei.KoBackupBackup & restore',
    'Backup & restore',
    'com.huawei.KoBackup',
    'icon_Backup & restore.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27963,
    'com.huawei.android.FMRadioFM Radio',
    'FM Radio',
    'com.huawei.android.FMRadio',
    'icon_FM Radio.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27964,
    'com.hicloud.android.clonePhone Clone',
    'Phone Clone',
    'com.hicloud.android.clone',
    'icon_Phone Clone.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27965,
    'com.android.systemuiFlashlight',
    'Flashlight',
    'com.android.systemui',
    'icon_Flashlight.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27966,
    'com.huawei.android.thememanagerThemes',
    'Themes',
    'com.huawei.android.thememanager',
    'icon_Themes.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27967,
    'com.huawei.android.totemweatherappWeather',
    'Weather',
    'com.huawei.android.totemweatherapp',
    'icon_Weather.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27968,
    'com.huawei.appmarketAppGallery',
    'AppGallery',
    'com.huawei.appmarket',
    'icon_AppGallery.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27969,
    'com.huawei.android.hwoucSystem update',
    'System update',
    'com.huawei.android.hwouc',
    'icon_System update.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27970,
    'com.huawei.healthHealth',
    'Health',
    'com.huawei.health',
    'icon_Health.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27971,
    'com.huawei.compassCompass',
    'Compass',
    'com.huawei.compass',
    'icon_Compass.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27972,
    'com.huawei.systemmanagerPhone Manager',
    'Phone Manager',
    'com.huawei.systemmanager',
    'icon_Phone Manager.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27973,
    'com.touchtype.swiftkeySwiftKey Keyboard',
    'SwiftKey Keyboard',
    'com.touchtype.swiftkey',
    'icon_SwiftKey Keyboard.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27974,
    'com.stupeflix.replayQuik',
    'Quik',
    'com.stupeflix.replay',
    'icon_Quik.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27975,
    'com.accuweather.androidAccuWeather',
    'AccuWeather',
    'com.accuweather.android',
    'icon_AccuWeather.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27976,
    'com.huawei.phoneserviceHiCare',
    'HiCare',
    'com.huawei.phoneservice',
    'icon_HiCare.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27977,
    'com.app.superbatvpnSuperBat VPN',
    'SuperBat VPN',
    'com.app.superbatvpn',
    'icon_SuperBat VPN.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27978,
    'com.asana.appAsana',
    'Asana',
    'com.asana.app',
    'icon_Asana.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27979,
    'com.bitsmedia.android.muslimproMuslim Pro',
    'Muslim Pro',
    'com.bitsmedia.android.muslimpro',
    'icon_Muslim Pro.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27980,
    'com.careem.acmaCareem',
    'Careem',
    'com.careem.acma',
    'icon_Careem.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27981,
    'com.daraz.androidDaraz',
    'Daraz',
    'com.daraz.android',
    'icon_Daraz.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27982,
    'com.example.javatestJavaTest',
    'JavaTest',
    'com.example.javatest',
    'icon_JavaTest.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27983,
    'com.facebook.katanaFacebook',
    'Facebook',
    'com.facebook.katana',
    'icon_Facebook.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27984,
    'com.facebook.orcaMessenger',
    'Messenger',
    'com.facebook.orca',
    'icon_Messenger.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27985,
    'com.fix.rizwanmushtaq.fixE Labour',
    'E Labour',
    'com.fix.rizwanmushtaq.fix',
    'icon_E Labour.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27986,
    'com.google.android.inputmethod.latinGboard',
    'Gboard',
    'com.google.android.inputmethod.latin',
    'icon_Gboard.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27987,
    'com.freelancer.android.messengerFreelancer',
    'Freelancer',
    'com.freelancer.android.messenger',
    'icon_Freelancer.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27988,
    'com.hikvision.hikconnectHik-Connect',
    'Hik-Connect',
    'com.hikvision.hikconnect',
    'icon_Hik-Connect.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27989,
    'com.imo.android.imoimimo',
    'imo',
    'com.imo.android.imoim',
    'icon_imo.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27990,
    'com.islam360Islam360',
    'Islam360',
    'com.islam360',
    'icon_Islam360.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27992,
    'com.mustakbilMustakbil',
    'Mustakbil',
    'com.mustakbil',
    'icon_Mustakbil.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27993,
    'com.olx.pkOLX Pakistan',
    'OLX Pakistan',
    'com.olx.pk',
    'icon_OLX Pakistan.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27994,
    'com.payoneer.androidPayoneer',
    'Payoneer',
    'com.payoneer.android',
    'icon_Payoneer.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27995,
    'com.pickytestPicky Assist',
    'Picky Assist',
    'com.pickytest',
    'icon_Picky Assist.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27996,
    'com.scb.pk.bmwSC',
    'SC',
    'com.scb.pk.bmw',
    'icon_SC.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27999,
    'com.tencent.mmWeChat',
    'WeChat',
    'com.tencent.mm',
    'icon_WeChat.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28000,
    'com.skype.raiderSkype',
    'Skype',
    'com.skype.raider',
    'icon_Skype.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28002,
    'com.yystudio.stopwatchfullStopWatch',
    'StopWatch',
    'com.yystudio.stopwatchfull',
    'icon_StopWatch.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28003,
    'com.zong.customercareMy Zong',
    'My Zong',
    'com.zong.customercare',
    'icon_My Zong.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28005,
    'free.vpn.unblock.proxy.vpnproSnap VPN',
    'Snap VPN',
    'free.vpn.unblock.proxy.vpnpro',
    'icon_Snap VPN.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28006,
    'net.WisdomStar.PingPing',
    'Ping',
    'net.WisdomStar.Ping',
    'icon_Ping.png',
    0,
    1,
    0,
    0,
    '2019-06-10 09:38:43',
    NULL
  );
INSERT INTO
  `apps_info` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    29082,
    'com.secure.launcherTitan Locker',
    'Titan Locker',
    'com.secure.launcher',
    'icon_Titan Locker.png',
    0,
    1,
    0,
    0,
    '2019-06-12 03:15:34',
    '2019-06-12 03:33:27'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: apps_queue_jobs
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: chat_ids
# ------------------------------------------------------------

INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    NULL,
    '6',
    1,
    '2019-04-22 17:34:23',
    '2019-06-03 12:04:47'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    NULL,
    '1',
    1,
    '2019-04-22 17:34:23',
    '2019-06-10 05:33:16'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    182,
    '7',
    1,
    '2019-04-22 17:34:23',
    '2019-06-07 09:19:13'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    187,
    '4',
    1,
    '2019-04-22 17:34:23',
    '2019-06-10 08:45:35'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    NULL,
    '8',
    1,
    '2019-04-22 17:34:23',
    '2019-06-11 14:35:58'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    NULL,
    '10',
    1,
    '2019-04-22 17:34:23',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    NULL,
    '5',
    0,
    '2019-04-22 17:34:23',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    NULL,
    '3',
    0,
    '2019-04-22 17:34:23',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    NULL,
    '2',
    0,
    '2019-04-22 17:34:23',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    NULL,
    '9',
    0,
    '2019-04-22 17:34:23',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    11,
    157,
    '5141281331',
    1,
    '2019-05-07 08:18:25',
    '2019-06-02 20:05:19'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12,
    NULL,
    '5141281332',
    1,
    '2019-05-07 08:18:25',
    '2019-06-05 11:19:22'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    13,
    NULL,
    '5141281333',
    0,
    '2019-05-07 08:18:25',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    14,
    NULL,
    '5141281334',
    0,
    '2019-05-07 08:18:25',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15,
    NULL,
    '5141281336',
    0,
    '2019-05-07 08:18:25',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16,
    NULL,
    '5141281337',
    0,
    '2019-05-07 08:18:25',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    17,
    211,
    '5141281338',
    1,
    '2019-05-07 08:18:25',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18,
    212,
    '5141281339',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 15:20:37'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19,
    213,
    '5141281340',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 15:22:33'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20,
    220,
    '5141281341',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:08:01'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21,
    214,
    '5141281345',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:08:35'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    22,
    219,
    '5141281342',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:09:13'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23,
    218,
    '5141281344',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:09:33'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24,
    217,
    '5141281343',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:09:56'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25,
    216,
    '5141281346',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:10:23'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26,
    215,
    '5141281347',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:10:39'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27,
    NULL,
    '5141281348',
    0,
    '2019-05-07 08:18:25',
    '2019-06-01 12:13:25'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28,
    221,
    '5141281349',
    1,
    '2019-05-07 08:18:25',
    '2019-06-13 17:07:10'
  );
INSERT INTO
  `chat_ids` (
    `id`,
    `user_acc_id`,
    `chat_id`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    29,
    184,
    '5141281335',
    1,
    '2019-05-07 08:18:25',
    '2019-06-07 12:17:31'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dealer_apks
# ------------------------------------------------------------

INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (253, 222, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (243, 222, 30);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (329, 222, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (899, 222, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (839, 222, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (915, 222, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (950, 222, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (252, 223, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (242, 223, 30);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (328, 223, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (898, 223, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (838, 223, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (880, 223, 99);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (878, 223, 101);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (882, 223, 102);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (884, 223, 103);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (914, 223, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (949, 223, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (952, 223, 109);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (953, 223, 110);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (251, 224, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (280, 224, 30);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (327, 224, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (897, 224, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (879, 224, 99);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (877, 224, 101);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (881, 224, 102);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (883, 224, 103);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (913, 224, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (934, 224, 107);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (948, 224, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (250, 225, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (288, 225, 30);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (326, 225, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (896, 225, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (836, 225, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (912, 225, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (947, 225, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (249, 226, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (325, 226, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (895, 226, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (835, 226, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (911, 226, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (946, 226, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (312, 227, 29);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (324, 227, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (894, 227, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (753, 227, 64);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (834, 227, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (910, 227, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (945, 227, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (323, 228, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (893, 228, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (909, 228, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (944, 228, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (322, 229, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (892, 229, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (832, 229, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (908, 229, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (943, 229, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (321, 230, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (891, 230, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (907, 230, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (942, 230, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (318, 231, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (890, 231, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (830, 231, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (906, 231, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (941, 231, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (320, 232, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (889, 232, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (748, 232, 64);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (829, 232, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (905, 232, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (940, 232, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (319, 233, 48);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (888, 233, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (747, 233, 64);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (828, 233, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (904, 233, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (939, 233, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (887, 234, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (777, 234, 64);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (621, 234, 65);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (622, 234, 70);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (623, 234, 71);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (624, 234, 72);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (827, 234, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (903, 234, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (938, 234, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (886, 235, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (876, 235, 75);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (826, 235, 91);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (902, 235, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (937, 235, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (900, 238, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (916, 238, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (951, 238, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (885, 239, 62);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (901, 239, 105);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (936, 239, 108);
INSERT INTO
  `dealer_apks` (`id`, `dealer_id`, `apk_id`)
VALUES
  (935, 241, 108);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dealer_dropdown_list
# ------------------------------------------------------------

INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    167,
    225,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-01 12:05:22',
    '2019-06-01 12:05:26'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    168,
    154,
    '[\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\",\"DEVICE ID\"]',
    'devices',
    '2019-06-01 12:06:05',
    '2019-06-14 06:26:14'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    169,
    154,
    '[\"DEALER ID\",\"DEALER NAME\",\"DEALER EMAIL\",\"DEALER PIN\",\"DEVICES\",\"TOKENS\"]',
    'dealer',
    '2019-06-01 12:06:15',
    '2019-06-01 12:12:00'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    170,
    154,
    '[\"DEALER ID\",\"DEALER NAME\",\"DEALER EMAIL\",\"DEALER PIN\",\"DEVICES\",\"TOKENS\",\"PARENT DEALER\",\"PARENT DEALER ID\"]',
    'sdealer',
    '2019-06-01 12:06:24',
    '2019-06-01 12:06:29'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    173,
    154,
    '[\"PERMISSION\",\"SHOW ON DEVICE\",\"APK\",\"APP NAME\",\"APP LOGO\"]',
    'apk',
    '2019-06-01 12:06:34',
    '2019-06-01 12:06:36'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    174,
    238,
    '[\"PERMISSION\",\"SHOW ON DEVICE\",\"APK\",\"APP NAME\",\"APP LOGO\"]',
    'apk',
    '2019-06-01 12:10:25',
    '2019-06-01 13:23:13'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    175,
    224,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-02 20:04:59',
    '2019-06-12 19:17:57'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    176,
    222,
    '[\"ACTIONS\"]',
    'devices',
    '2019-06-03 06:37:00',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    177,
    222,
    '[\"DEALER ID\",\"DEALER NAME\",\"DEALER EMAIL\",\"DEALER PIN\",\"DEVICES\",\"TOKENS\",\"PARENT DEALER\",\"PARENT DEALER ID\"]',
    'sdealer',
    '2019-06-03 06:37:02',
    '2019-06-03 06:37:56'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    179,
    241,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-03 06:37:15',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    180,
    241,
    '[\"DEALER ID\",\"DEALER NAME\",\"DEALER EMAIL\",\"DEALER PIN\",\"DEVICES\",\"TOKENS\"]',
    'dealer',
    '2019-06-03 06:37:15',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    181,
    241,
    '[\"SHOW ON DEVICE\",\"APK\",\"APP NAME\",\"APP LOGO\"]',
    'apk',
    '2019-06-03 06:37:15',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    182,
    241,
    '[\"DEALER ID\",\"DEALER NAME\",\"DEALER EMAIL\",\"DEALER PIN\",\"DEVICES\",\"TOKENS\",\"PARENT DEALER\",\"PARENT DEALER ID\"]',
    'sdealer',
    '2019-06-03 06:37:15',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    183,
    239,
    '[\"ACTIONS\"]',
    'devices',
    '2019-06-03 09:59:56',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    184,
    239,
    '[\"ACTIONS\"]',
    'sdealer',
    '2019-06-03 10:01:06',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    185,
    232,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-03 12:04:10',
    '2019-06-03 12:05:02'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    187,
    231,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-03 13:06:20',
    '2019-06-10 06:27:06'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    188,
    223,
    '[\"DEVICE ID\",\"USER ID\",\"REMAINING DAYS\",\"FLAGGED\",\"STATUS\",\"MODE\",\"DEVICE NAME\",\"ACTIVATION CODE\",\"ACCOUNT EMAIL\",\"PGP EMAIL\",\"CHAT ID\",\"CLIENT ID\",\"DEALER ID\",\"DEALER PIN\",\"MAC ADDRESS\",\"SIM ID\",\"IMEI 1\",\"SIM 1\",\"IMEI 2\",\"SIM 2\",\"SERIAL NUMBER\",\"MODEL\",\"START DATE\",\"EXPIRY DATE\",\"DEALER NAME\",\"S-DEALER\",\"S-DEALER NAME\"]',
    'devices',
    '2019-06-03 16:52:24',
    '2019-06-10 14:03:47'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    189,
    223,
    '[\"PERMISSION\",\"SHOW ON DEVICE\",\"APK\",\"APP NAME\",\"APP LOGO\"]',
    'apk',
    '2019-06-05 13:50:13',
    '2019-06-05 13:50:39'
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    190,
    232,
    '[\"ACTIONS\"]',
    'sdealer',
    '2019-06-10 09:49:41',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    192,
    224,
    '[\"ACTIONS\"]',
    'sdealer',
    '2019-06-10 16:27:24',
    NULL
  );
INSERT INTO
  `dealer_dropdown_list` (
    `id`,
    `dealer_id`,
    `selected_items`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    193,
    224,
    '[\"PERMISSION\",\"SHOW ON DEVICE\",\"APK\",\"APP NAME\",\"APP LOGO\"]',
    'apk',
    '2019-06-10 16:27:37',
    '2019-06-13 17:48:10'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dealer_pagination
# ------------------------------------------------------------

INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    154,
    20,
    'devices',
    '2019-04-02 16:18:12',
    '2019-06-10 09:49:13'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    154,
    20,
    'dealer',
    '2019-04-03 15:23:13',
    '2019-05-31 11:06:39'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    222,
    20,
    'devices',
    '2019-04-08 12:11:22',
    '2019-05-07 09:49:11'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    154,
    20,
    'apk',
    '2019-04-08 16:18:47',
    '2019-05-08 11:30:03'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    154,
    100,
    'sdealer',
    '2019-04-09 14:14:40',
    '2019-04-11 04:13:58'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (9, 223, 10, 'devices', '2019-04-10 09:46:55', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (10, 224, 10, 'devices', '2019-04-10 21:08:53', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (11, 224, 10, 'sdealer', '2019-04-10 22:15:02', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (12, 225, 10, 'devices', '2019-04-11 10:40:39', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (13, 226, 10, 'devices', '2019-04-12 07:12:13', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (14, 225, 10, 'sdealer', '2019-04-12 11:20:00', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (15, 228, 10, 'devices', '2019-04-24 17:43:55', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (16, 230, 10, 'devices', '2019-04-27 23:22:23', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (17, 229, 10, 'devices', '2019-04-27 23:24:38', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (18, 229, 10, 'sdealer', '2019-04-27 23:27:13', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (19, 231, 10, 'devices', '2019-04-29 09:52:13', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20,
    154,
    20,
    'users',
    '2019-04-29 16:10:09',
    '2019-06-10 15:27:24'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (21, 224, 10, 'users', '2019-04-29 16:36:26', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (22, 232, 10, 'devices', '2019-04-30 08:00:32', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (23, 232, 10, 'users', '2019-04-30 08:08:52', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (24, 229, 10, 'users', '2019-04-30 16:11:07', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (25, 231, 10, 'users', '2019-05-02 06:57:43', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (26, 231, 10, 'sdealer', '2019-05-02 07:00:37', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (27, 233, 10, 'users', '2019-05-02 07:30:02', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28,
    154,
    20,
    'policies',
    '2019-05-07 09:33:08',
    '2019-06-13 12:57:17'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    29,
    222,
    10,
    'policies',
    '2019-05-14 16:54:58',
    '2019-05-15 12:19:08'
  );
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (30, 223, 10, 'policies', '2019-05-15 12:46:41', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (31, 223, 10, 'users', '2019-05-15 12:46:52', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (32, 228, 10, 'policies', '2019-05-16 06:33:45', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (33, 234, 10, 'devices', '2019-05-16 09:47:47', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (34, 234, 10, 'users', '2019-05-16 10:10:09', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (35, 234, 10, 'policies', '2019-05-16 10:41:27', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (36, 228, 10, 'users', '2019-05-16 11:03:51', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (37, 224, 10, 'policies', '2019-05-18 20:20:37', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (38, 224, 10, 'apk', '2019-05-27 10:13:49', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (39, 233, 10, 'devices', '2019-05-28 12:05:59', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (40, 238, 10, 'apk', '2019-05-29 06:06:26', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (41, 225, 10, 'users', '2019-05-31 12:20:05', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (42, 222, 10, 'sdealer', '2019-06-03 06:37:02', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (43, 222, 10, 'users', '2019-06-03 06:38:10', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (44, 225, 10, 'policies', '2019-06-03 09:47:37', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (46, 239, 10, 'devices', '2019-06-03 09:59:56', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (47, 239, 10, 'users', '2019-06-03 10:00:55', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (48, 223, 10, 'apk', '2019-06-05 13:50:13', NULL);
INSERT INTO
  `dealer_pagination` (
    `id`,
    `dealer_id`,
    `record_per_page`,
    `type`,
    `created_at`,
    `updated_at`
  )
VALUES
  (49, 232, 10, 'sdealer', '2019-06-10 09:49:42', NULL);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dealer_policies
# ------------------------------------------------------------

INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (12, 222, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (150, 222, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (210, 222, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (227, 222, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (243, 222, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (11, 223, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (149, 223, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (209, 223, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (211, 223, 7);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (168, 223, 8);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (226, 223, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (242, 223, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (245, 223, 20);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (248, 223, 21);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (251, 223, 22);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (255, 223, 23);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (10, 224, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (148, 224, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (208, 224, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (196, 224, 7);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (225, 224, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (241, 224, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (247, 224, 21);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (252, 224, 22);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (9, 225, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (147, 225, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (207, 225, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (224, 225, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (240, 225, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (8, 226, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (146, 226, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (206, 226, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (223, 226, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (239, 226, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (7, 227, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (145, 227, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (205, 227, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (222, 227, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (238, 227, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (6, 228, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (144, 228, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (204, 228, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (221, 228, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (237, 228, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (5, 229, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (143, 229, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (203, 229, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (220, 229, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (236, 229, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (4, 230, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (142, 230, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (202, 230, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (219, 230, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (235, 230, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (3, 231, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (141, 231, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (201, 231, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (218, 231, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (234, 231, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (2, 232, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (140, 232, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (200, 232, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (217, 232, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (233, 232, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (249, 232, 20);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (24, 233, 1);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (139, 233, 2);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (199, 233, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (216, 233, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (232, 233, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (198, 234, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (215, 234, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (231, 234, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (197, 235, 6);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (214, 235, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (230, 235, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (228, 238, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (244, 238, 19);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (213, 239, 18);
INSERT INTO
  `dealer_policies` (`id`, `dealer_id`, `policy_id`)
VALUES
  (229, 239, 19);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: dealers
# ------------------------------------------------------------

INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    154,
    'Neha',
    'Kashyap',
    0,
    'admin',
    'admin@gmail.com',
    'e6e061838856bf47e1de730719fb2609',
    '',
    0,
    '',
    0,
    1,
    0,
    NULL,
    '2019-02-08 09:50:04',
    '2019-02-08 09:50:04'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    222,
    NULL,
    NULL,
    0,
    'usman hafeez',
    'usmanhafeez147@gmail.com',
    '944e1c90f9915c1aabded2fb0ed19a69',
    '433523',
    0,
    '',
    0,
    2,
    0,
    '',
    '2019-04-03 15:23:26',
    '2019-04-03 15:23:26'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    223,
    NULL,
    NULL,
    0,
    'Barry',
    'barrybarrygood@hotmail.com',
    '9a3bf1fdeae0a3291ae4e4d62d691f06',
    '610192',
    1,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-10 09:14:30',
    '2019-04-10 09:14:30'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    224,
    NULL,
    NULL,
    0,
    'zaid',
    'zaid@vortexapp.ca',
    '5af4debfa9cb2b889be0c0d299e590e4',
    '417695',
    1,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-10 21:06:51',
    '2019-04-10 21:06:51'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    225,
    NULL,
    NULL,
    0,
    'Hamza Dawood',
    'hamza.dawood007@gmail.com',
    'ce475832a49b645ea151bb52a666b23a',
    '541763',
    1,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-11 10:39:50',
    '2019-04-11 10:39:50'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    226,
    NULL,
    NULL,
    0,
    'Arfan ali',
    'arawan77rb@gmail.com',
    'c3c6b034a0622448ec602efda5c0964f',
    '262165',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-12 07:10:40',
    '2019-04-12 07:10:40'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    227,
    NULL,
    NULL,
    225,
    'Hamza123',
    'hamza.jutt004@gmail.com',
    'e43a2b055b93736a42bcf71f257398ec',
    '753909',
    0,
    NULL,
    0,
    3,
    0,
    NULL,
    '2019-04-18 06:31:19',
    '2019-04-18 06:31:19'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    228,
    NULL,
    NULL,
    0,
    'Omegamoon',
    'omegamoon@gmail.com',
    '78db4f647cbd8a14782b620b8e305242',
    '187854',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-24 16:55:43',
    '2019-04-24 16:55:43'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    229,
    NULL,
    NULL,
    0,
    'titan',
    'dealer@titansecure.mobi',
    '66cd3187390abbb19fea16e5ed7b1eaf',
    '690957',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-27 23:10:08',
    '2019-04-27 23:10:08'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    230,
    NULL,
    NULL,
    229,
    'titan-subdealer',
    'subdealer@titansecure.mobi',
    '7eb95339f4ae8e0a0b1d7f606c2c728e',
    '428146',
    0,
    NULL,
    0,
    3,
    0,
    NULL,
    '2019-04-27 23:11:11',
    '2019-04-27 23:11:11'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    231,
    NULL,
    NULL,
    0,
    'Adeel',
    'adeel@sunztech.com',
    'a96e1e296399f5c9f704b9088c6e9785',
    '166778',
    0,
    NULL,
    0,
    2,
    0,
    '',
    '2019-04-29 09:47:08',
    '2019-04-29 09:47:08'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    232,
    NULL,
    NULL,
    0,
    'Muhammad mehran',
    'imuhammadmehran@gmail.com',
    '8d0f9c1394ac6832a67773e0cc1d26c6',
    '674794',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-04-30 07:59:15',
    '2019-04-30 07:59:15'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    233,
    NULL,
    NULL,
    231,
    'Adeel S-dealer',
    'adeelsunztech@gmail.com',
    '8788fe086257e6aa8072409beacb01ac',
    '718785',
    0,
    NULL,
    0,
    3,
    0,
    '',
    '2019-05-02 07:01:26',
    '2019-05-02 07:01:26'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    234,
    NULL,
    NULL,
    0,
    'Adeel New',
    'adeelmehmoodgill@gmail.com',
    'b98c2294a8f3b875347f2efc0902a290',
    '714015',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-05-16 09:46:35',
    '2019-05-16 09:46:35'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    235,
    NULL,
    NULL,
    234,
    'Adeel S-dealer new',
    'adeeljutt9@gmail.com',
    'e7fbfd4b477a2fac8ecc3c2594684150',
    '177588',
    0,
    NULL,
    0,
    3,
    1,
    '',
    '2019-05-22 10:25:23',
    '2019-05-22 10:25:23'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    238,
    NULL,
    NULL,
    0,
    'Auto Updater',
    'autoupdate@gmail.com',
    '74109cb6586dad2d0510f20dc7a88dbf',
    NULL,
    0,
    NULL,
    0,
    4,
    0,
    NULL,
    '2019-06-04 10:26:44',
    '2019-06-04 10:26:48'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    239,
    NULL,
    NULL,
    0,
    'Paul',
    'paulhoe@circletech.email',
    'f49a33898123aeefbbe7e33749b11386',
    '091047',
    0,
    NULL,
    0,
    2,
    0,
    NULL,
    '2019-05-30 03:45:01',
    '2019-05-30 03:45:01'
  );
INSERT INTO
  `dealers` (
    `dealer_id`,
    `first_name`,
    `last_name`,
    `connected_dealer`,
    `dealer_name`,
    `dealer_email`,
    `password`,
    `link_code`,
    `verified`,
    `verification_code`,
    `is_two_factor_auth`,
    `type`,
    `unlink_status`,
    `account_status`,
    `created`,
    `modified`
  )
VALUES
  (
    241,
    NULL,
    NULL,
    222,
    'usman hafeez',
    'usman@sunztech.com',
    '3bfd77299548fbd551684a22b0dec289',
    '890202',
    0,
    NULL,
    0,
    3,
    0,
    NULL,
    '2019-06-03 06:37:15',
    '2019-06-03 06:37:15'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: default_apps
# ------------------------------------------------------------

INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4649,
    'com.android.musicMusic',
    'Music',
    'com.android.music',
    'icon_Music.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4650,
    'com.secureSetting.SecureSettingsMainSecure Settings',
    'Secure Settings',
    'com.secureSetting.SecureSettingsMain',
    'icon_Secure Settings.png',
    1,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4651,
    'com.android.browserBrowser',
    'Browser',
    'com.android.browser',
    'icon_Browser.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4652,
    'com.android.calendarCalendar',
    'Calendar',
    'com.android.calendar',
    'icon_Calendar.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4653,
    'com.android.contactsContacts',
    'Contacts',
    'com.android.contacts',
    'icon_Contacts.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4654,
    'com.android.deskclockClock',
    'Clock',
    'com.android.deskclock',
    'icon_Clock.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4655,
    'com.android.dialerPhone',
    'Phone',
    'com.android.dialer',
    'icon_Phone.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4656,
    'com.android.emailEmail',
    'Email',
    'com.android.email',
    'icon_Email.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4657,
    'com.android.gallery3dGallery',
    'Gallery',
    'com.android.gallery3d',
    'icon_Gallery.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4658,
    'com.android.mmsMessaging',
    'Messaging',
    'com.android.mms',
    'icon_Messaging.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4659,
    'com.android.settingsSettings',
    'Settings',
    'com.android.settings',
    'icon_Settings.png',
    0,
    0,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4660,
    'com.android.soundrecorderSound Recorder',
    'Sound Recorder',
    'com.android.soundrecorder',
    'icon_Sound Recorder.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    '2019-06-12 16:35:20'
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4661,
    'com.mediatek.cameraCamera',
    'Camera',
    'com.mediatek.camera',
    'icon_Camera.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4662,
    'com.android.calculator2Calculator',
    'Calculator',
    'com.android.calculator2',
    'icon_Calculator.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4663,
    'com.android.quicksearchboxSearch',
    'Search',
    'com.android.quicksearchbox',
    'icon_Search.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4664,
    'com.android.stkSIM Toolkit',
    'SIM Toolkit',
    'com.android.stk',
    'icon_SIM Toolkit.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4665,
    'com.mediatek.systemupdateSystem software updates',
    'System software updates',
    'com.mediatek.systemupdate',
    'icon_System software updates.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4666,
    'com.rim.mobilefusion.clientUEM Client',
    'UEM Client',
    'com.rim.mobilefusion.client',
    'icon_UEM Client.png',
    0,
    1,
    0,
    0,
    '2019-04-22 12:49:21',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4668,
    'com.secureSetting.SecureSettingsMainSecure SettingsBattery',
    'Battery',
    NULL,
    'icon_Battery.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4669,
    'com.secureSetting.SecureSettingsMainSecure Settingswi-fi',
    'wi-fi',
    NULL,
    'icon_wi-fi.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4670,
    'com.secureSetting.SecureSettingsMainSecure SettingsBluetooth',
    'Bluetooth',
    NULL,
    'icon_Bluetooth.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4671,
    'com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards',
    'SIM Cards',
    NULL,
    'icon_SIM Cards.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4672,
    'com.secureSetting.SecureSettingsMainSecure SettingsData Roaming',
    'Data Roaming',
    NULL,
    'icon_Data Roaming.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4673,
    'com.secureSetting.SecureSettingsMainSecure SettingsMobile Data',
    'Mobile Data',
    NULL,
    'icon_Mobile Data.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4674,
    'com.secureSetting.SecureSettingsMainSecure SettingsHotspot',
    'Hotspot',
    NULL,
    'icon_Hotspot.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4675,
    'com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock',
    'Finger Print + Lock',
    NULL,
    'icon_Finger Print + Lock.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4676,
    'com.secureSetting.SecureSettingsMainSecure SettingsBrightness',
    'Brightness',
    NULL,
    'icon_Brightness.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4677,
    'com.secureSetting.SecureSettingsMainSecure SettingsSleep',
    'Sleep',
    NULL,
    'icon_Sleep.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4678,
    'com.secureSetting.SecureSettingsMainSecure SettingsSound',
    'Sound',
    NULL,
    'icon_Sound.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4679,
    'com.secureSetting.SecureSettingsMainSecure SettingsDate & Time',
    'Date & Time',
    NULL,
    'icon_Date & Time.png',
    1,
    1,
    0,
    4650,
    '2019-04-22 12:49:22',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15706,
    'com.secureClear.SecureClearActivitySecure Clear',
    'Secure Clear',
    'com.secureClear.SecureClearActivity',
    'icon_Secure Clear.png',
    0,
    1,
    0,
    0,
    '2019-05-01 08:03:46',
    '2019-05-25 11:59:04'
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15929,
    'com.secureMarket.SecureMarketActivitySecure Market',
    'Secure Market',
    'com.secureMarket.SecureMarketActivity',
    'icon_Secure Market.png',
    0,
    1,
    0,
    0,
    '2019-05-11 04:49:02',
    '2019-05-25 11:59:04'
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21461,
    'com.secureSetting.SecureSettingsMainSecure SettingsLanguages',
    'Languages',
    NULL,
    'icon_Languages.png',
    1,
    1,
    0,
    4650,
    '2019-05-25 10:38:45',
    NULL
  );
INSERT INTO
  `default_apps` (
    `id`,
    `unique_name`,
    `label`,
    `package_name`,
    `icon`,
    `extension`,
    `visible`,
    `default_app`,
    `extension_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23212,
    'com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input',
    'Languages & Input',
    NULL,
    'icon_Languages & Input.png',
    1,
    1,
    0,
    4650,
    '2019-05-29 19:14:05',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: default_policies
# ------------------------------------------------------------

INSERT INTO
  `default_policies` (
    `id`,
    `dealer_id`,
    `policy_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    225,
    3,
    '2019-05-14 12:46:43',
    '2019-05-14 12:48:39'
  );
INSERT INTO
  `default_policies` (
    `id`,
    `dealer_id`,
    `policy_id`,
    `created_at`,
    `updated_at`
  )
VALUES
  (5, 223, 20, '2019-06-05 13:56:54', NULL);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: acl_module_actions
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: devices
# ------------------------------------------------------------

INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    761,
    'EACE961253',
    'undefined',
    NULL,
    'null',
    '192.168.0.157',
    NULL,
    '354444076297110',
    NULL,
    '354444076297128',
    'VSP1001901S00370',
    '00:27:15:22:AD:74',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-02 20:04:42',
    '2019-06-10 04:14:09'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    778,
    'EEEE144909',
    'undefined',
    'sW7U0I5i1Ek_JZMEACcM',
    'Vsp100 (EU)',
    '192.168.0.227',
    '8901260852296619117f',
    '300844813987599',
    NULL,
    NULL,
    '0123456789ABCDEF',
    '00:1E:D3:41:79:88',
    NULL,
    'online',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-03 16:51:55',
    '2019-06-10 01:12:24'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    779,
    'ECAE569003',
    'undefined',
    NULL,
    'Vsp100 (EU) (no imei)',
    '192.168.0.71',
    NULL,
    NULL,
    NULL,
    NULL,
    'OUKIC11000010686',
    '00:3A:F4:7C:F9:18',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-03 17:02:49',
    '2019-06-09 06:47:08'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    780,
    'EAFA418535',
    'undefined',
    '8sYT1PZW8YA0-g43AAMg',
    'tester',
    '192.168.31.144',
    NULL,
    '505951191664618',
    NULL,
    '354444076424243',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    NULL,
    'online',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-04 07:58:28',
    '2019-06-14 12:37:07'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    784,
    'CCDB002066',
    'undefined',
    'xzWYjuumAtW3_9jRAAMf',
    'null',
    '192.168.31.11',
    NULL,
    '455296770304917',
    NULL,
    '014990923163675',
    'VSP200190500001',
    '00:83:22:FE:E3:6C',
    NULL,
    'online',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-06 04:51:05',
    '2019-06-14 12:37:00'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    787,
    'BCBD957340',
    'undefined',
    NULL,
    'null',
    '192.168.0.150',
    '8901260852291397164f',
    NULL,
    NULL,
    NULL,
    '0123456789ABCDEF',
    '00:08:2F:55:9D:A6',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-07 09:16:07',
    '2019-06-10 17:41:32'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    788,
    'DABC790128',
    'undefined',
    NULL,
    'null',
    '192.168.0.182',
    '8901260852291397214f',
    NULL,
    NULL,
    NULL,
    '0123456789ABCDEF',
    '00:A5:86:AB:F1:1D',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-07 11:08:16',
    '2019-06-10 15:47:33'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    789,
    'FDDE106484',
    'undefined',
    '8O-8nTxh8iOmRnQYAAMe',
    'null',
    '192.168.0.187',
    '8901260852291394641f',
    NULL,
    NULL,
    NULL,
    '0123456789ABCDEF',
    '00:A9:21:1C:94:23',
    NULL,
    'online',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-07 12:17:01',
    '2019-06-14 12:36:48'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    791,
    'CBFB073737',
    'undefined',
    NULL,
    'null',
    '192.168.0.103',
    NULL,
    NULL,
    NULL,
    NULL,
    '0123456789ABCDEF',
    '00:6D:8B:A3:57:A5',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 05:38:28',
    '2019-06-13 06:37:54'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    792,
    'FEBE718436',
    'undefined',
    NULL,
    'Mi ',
    '10.156.140.228',
    '8992042306182528795',
    '355468080559917',
    NULL,
    NULL,
    'LGH872d603b454',
    'DC:0B:34:C4:E4:1C',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 08:43:42',
    '2019-06-10 09:01:20'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    793,
    'DFFB715052',
    'undefined',
    NULL,
    'null',
    '10.155.248.45',
    '8992042306182528803F',
    '868598033592605',
    NULL,
    '868598033628615',
    'FFY5T18117023569',
    '10:44:00:BA:F3:E2',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 09:37:59',
    '2019-06-10 09:51:32'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    796,
    NULL,
    'Mehran',
    NULL,
    'undefined',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    '2019-06-10 15:48:42'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    797,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    798,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    799,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    800,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    801,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    802,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    803,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    804,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    805,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-10 15:47:36',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    808,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    809,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    810,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    811,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    812,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    813,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    814,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    815,
    NULL,
    'Mehran',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    NULL
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    816,
    'AECE977918',
    'Mehran',
    NULL,
    NULL,
    '192.168.0.102',
    '89410062105442269285',
    '015922198702423',
    'null',
    '302548124110431',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-11 15:09:16',
    '2019-06-13 19:16:38'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    817,
    'EBFA937942',
    'undefined',
    NULL,
    'null',
    '192.168.0.153',
    '8901260852291397198f',
    '354444076292210',
    NULL,
    '354444076292228',
    'VSP1001901S00125',
    '00:27:15:41:D7:00',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:18:29',
    '2019-06-13 16:05:35'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    818,
    'DDEA755394',
    'undefined',
    NULL,
    'null',
    '192.168.0.113',
    '8901260852296618291f',
    '354444076298050',
    NULL,
    '354444076298068',
    'VSP1001901S00417',
    '00:27:15:7B:44:E4',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:20:27',
    '2019-06-13 15:49:22'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    819,
    'FBAC150553',
    'undefined',
    NULL,
    'null',
    '192.168.0.141',
    NULL,
    '354444076294877',
    NULL,
    '354444076294885',
    'VSP1001901S00258',
    '00:27:15:8C:C5:BB',
    NULL,
    'offline',
    1,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:34:05',
    '2019-06-13 18:09:31'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    820,
    'BFDA939981',
    'undefined',
    NULL,
    'null',
    '192.168.0.103',
    '8931163200317782875f',
    '354444076293713',
    NULL,
    '354444076293721',
    'VSP1001901S00200',
    '00:27:15:8F:DC:ED',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:40:42',
    '2019-06-13 17:10:39'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    821,
    'AAFE485998',
    'undefined',
    NULL,
    'null',
    '192.168.0.143',
    '8901260852296616196f',
    '354444076299678',
    NULL,
    '354444076299686',
    'VSP1001901S00498',
    '00:27:15:6B:7F:7A',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:44:50',
    '2019-06-13 17:10:23'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    822,
    'DFCA760576',
    'undefined',
    NULL,
    'null',
    '192.168.0.145',
    NULL,
    '354444076294539',
    NULL,
    '354444076294547',
    'VSP1001901S00241',
    '00:27:15:81:08:EB',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:44:51',
    '2019-06-13 17:09:56'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    823,
    'DABD696724',
    'undefined',
    NULL,
    'null',
    '192.168.0.151',
    '8901260852293381588f',
    '354444076291915',
    NULL,
    '354444076291923',
    'VSP1001901S00110',
    '00:27:15:60:EF:AE',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:47:40',
    '2019-06-13 17:09:33'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    824,
    'AAAC945758',
    'undefined',
    NULL,
    'null',
    '192.168.0.193',
    '8931163200316367033f',
    '354444076294752',
    NULL,
    '354444076294760',
    'VSP1001901S00252',
    '00:27:15:B0:ED:C3',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:52:48',
    '2019-06-13 17:09:13'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    825,
    'BAFB097798',
    'undefined',
    NULL,
    'null',
    '192.168.0.187',
    '8901260852296618309f',
    '354444076298191',
    NULL,
    '354444076298209',
    'VSP1001901S00424',
    '00:27:15:F8:12:CA',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 15:59:20',
    '2019-06-13 17:08:01'
  );
INSERT INTO
  `devices` (
    `id`,
    `device_id`,
    `name`,
    `session_id`,
    `model`,
    `ip_address`,
    `simno`,
    `imei`,
    `simno2`,
    `imei2`,
    `serial_number`,
    `mac_address`,
    `fcm_token`,
    `online`,
    `is_sync`,
    `is_push_apps`,
    `flagged`,
    `screen_start_date`,
    `reject_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    826,
    'BDDE853697',
    'undefined',
    NULL,
    'null',
    '192.168.0.130',
    '8931163200317782909f',
    '354444076293515',
    NULL,
    '354444076293523',
    'VSP1001901S00190',
    '00:27:15:AB:86:FB',
    NULL,
    'offline',
    0,
    0,
    'Not flagged',
    NULL,
    0,
    '2019-06-13 16:06:27',
    '2019-06-13 17:07:10'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: imei_history
# ------------------------------------------------------------

INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12,
    'ECCB212734',
    '0123456789ABCDEF',
    '00:69:06:45:00:CC',
    'null',
    'null',
    'null',
    'null',
    '2019-05-11 11:18:20',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    13,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    '354444076293150',
    '354444076293168',
    '354444076293150',
    '354444076293168',
    '2019-05-14 10:04:32',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    14,
    'BDBD107716',
    '0123456789ABCDEF',
    '00:2F:F2:7F:EC:94',
    NULL,
    '',
    'null',
    'null',
    '2019-05-15 15:58:58',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    15,
    'DDAF250244',
    'VSP1001901S00431',
    '00:27:15:2E:8E:BD',
    '354444076298332',
    '354444076298340',
    '354444076298332',
    '354444076298340',
    '2019-05-15 16:03:48',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    16,
    'DDAF250244',
    'VSP1001901S00431',
    '00:27:15:2E:8E:BD',
    NULL,
    '',
    '495194165943955',
    '354444076298340',
    '2019-05-15 12:46:23',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    17,
    'EAFA418535',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    '354444076424235',
    '354444076424243',
    '354444076424235',
    '354444076424243',
    '2019-05-15 14:05:45',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    18,
    'EAFA418535',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    NULL,
    '',
    '982892361846324',
    '354444076424243',
    '2019-05-15 14:09:56',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    19,
    'EAFA418535',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    NULL,
    '',
    '101954467757619',
    '354444076424243',
    '2019-05-15 14:12:03',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    20,
    'CECB272225',
    '0123456789ABCDEF',
    '02:00:00:00:00:00',
    NULL,
    '',
    '493395712558806',
    '533102433841285',
    '2019-05-16 06:27:08',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    21,
    'DDAF250244',
    'VSP1001901S00431',
    '00:27:15:2E:8E:BD',
    NULL,
    '',
    '495194165943955',
    '354444076298340',
    '2019-05-16 06:53:37',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    22,
    'FBCF189957',
    'RF8K61NKPPL',
    '4C:DD:31:BB:B4:68',
    '359117091179738',
    '359118091179736',
    '359117091179738',
    '359118091179736',
    '2019-05-16 09:23:25',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    23,
    'BDBD107716',
    '0123456789ABCDEF',
    '00:2F:F2:7F:EC:94',
    NULL,
    '',
    '101356701778668',
    '910476756338936',
    '2019-05-16 10:00:33',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24,
    'DDAF250244',
    'VSP1001901S00431',
    '00:27:15:2E:8E:BD',
    NULL,
    '',
    '354444076298332',
    '354444076298340',
    '2019-05-16 10:12:28',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25,
    'CECB272225',
    '0123456789ABCDEF',
    '02:00:00:00:00:00',
    NULL,
    '',
    '493395712558806',
    '533102433841285',
    '2019-05-16 11:06:42',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    26,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '442980748003471',
    '868544930962657',
    '2019-05-20 09:14:09',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    27,
    'EDFE562714',
    '0123456789ABCDEF',
    '00:45:4A:13:F2:F3',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-05-20 12:44:06',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    28,
    'FBEE021680',
    '0123456789ABCDEF',
    '00:EA:A3:3A:0C:F9',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-05-20 13:22:09',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    29,
    'EACE961253',
    'VSP1001901S00370',
    '00:27:15:22:AD:74',
    '354444076297110',
    '354444076297128',
    '354444076297110',
    '354444076297128',
    '2019-05-20 13:42:54',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    30,
    'FBEE021680',
    '0123456789ABCDEF',
    '00:EA:A3:3A:0C:F9',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-05-21 04:24:56',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    31,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '354444076293150',
    '354444076293168',
    '2019-05-21 16:36:33',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    32,
    'EADA792020',
    'VSP1001901S00327',
    '00:27:15:CB:C1:FA',
    '354444076296252',
    '354444076296260',
    '354444076296252',
    '354444076296260',
    '2019-05-24 00:40:48',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    33,
    'BFCF358930',
    'VSP1001901S00491',
    '00:27:15:15:86:CC',
    '354444076299538',
    '354444076299546',
    '354444076299538',
    '354444076299546',
    '2019-05-24 00:47:14',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    34,
    'EAFC990189',
    'VSP1001901S00154',
    '00:27:15:F8:04:C8',
    '354444076292798',
    '354444076292806',
    '354444076292798',
    '354444076292806',
    '2019-05-24 00:54:58',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    35,
    'CEAB974351',
    'VSP1001901S00222',
    '00:27:15:DE:DF:1B',
    '354444076294158',
    '354444076294166',
    '354444076294158',
    '354444076294166',
    '2019-05-24 01:10:40',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    36,
    'ECCA287941',
    'VSP1001901S00105',
    '00:27:15:E6:C2:31',
    '354444076291816',
    '354444076291824',
    '354444076291816',
    '354444076291824',
    '2019-05-24 01:27:59',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    37,
    'EAFA418535',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    NULL,
    '',
    '354444076424235',
    '354444076424243',
    '2019-05-25 11:41:43',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    38,
    'ADFE865420',
    '0123456789ABCDEF',
    '00:F8:9E:51:1B:44',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-05-25 22:48:55',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    39,
    'EDFF641493',
    'VSP1001901S00052',
    '00:27:15:86:BE:0B',
    '354444076290750',
    '354444076290768',
    '354444076290750',
    '354444076290768',
    '2019-05-27 09:09:51',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    40,
    'DDFA228315',
    'VSP1001901S00205',
    '00:27:15:1A:85:31',
    '354444076293812',
    '354444076293820',
    '354444076293812',
    '354444076293820',
    '2019-05-27 10:07:47',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    41,
    'AEBE885997',
    '0123456789ABCDEF',
    '00:3D:8F:58:A1:D9',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-05-29 12:22:23',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    42,
    'ECAE569003',
    'OUKIC11000010686',
    '00:3A:F4:7C:F9:18',
    'null',
    'null',
    'null',
    'null',
    '2019-05-29 15:19:01',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    43,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:27:47',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    44,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:33:28',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    45,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:35:07',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    46,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:36:14',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    47,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:37:07',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    48,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:39:58',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    49,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:42:00',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    50,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:43:01',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    51,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:47:00',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    52,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 12:53:39',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    53,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-01 13:06:26',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    54,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:00',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    55,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:04',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    56,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:07',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    57,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:15',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    58,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:22',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    59,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:24',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    60,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:25',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    61,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:26',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    62,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:28',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    63,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:29',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    64,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:30',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    65,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:31',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    66,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:32',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    67,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 04:50:33',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    68,
    'ACDA931851',
    '0123456789ABCDEF',
    '00:66:BC:ED:E0:B7',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 09:31:43',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    69,
    'BCFE945075',
    '0123456789ABCDEF',
    '00:88:A7:EC:C2:FE',
    NULL,
    '',
    '493395712558806',
    'null',
    '2019-06-03 12:04:27',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    70,
    'EEEE144909',
    '0123456789ABCDEF',
    '00:1E:D3:41:79:88',
    NULL,
    '',
    '300844813987599',
    'null',
    '2019-06-03 16:51:55',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    71,
    'ECAE569003',
    'OUKIC11000010686',
    '00:3A:F4:7C:F9:18',
    NULL,
    '',
    'null',
    'null',
    '2019-06-03 17:02:49',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    72,
    'EAFA418535',
    'VSP1001904S02686',
    '00:27:15:CE:7D:7B',
    NULL,
    '',
    '505951191664618',
    '354444076424243',
    '2019-06-04 07:58:28',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    73,
    'CBDC381935',
    '0123456789ABCDEF',
    '00:27:32:0B:CB:0B',
    NULL,
    '',
    '300844813987599',
    'null',
    '2019-06-05 11:13:27',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    74,
    'CDDA766328',
    '0123456789ABCDEF',
    '00:83:22:FE:E3:6C',
    NULL,
    '',
    '543326403828323',
    '014990923163675',
    '2019-06-05 14:57:55',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    75,
    'CDBE553230',
    '68768768776',
    '00:83:22:FE:E3:6C',
    NULL,
    '',
    '455296770304917',
    '014990923163675',
    '2019-06-06 04:44:24',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    76,
    'EBCA987553',
    '0123456789ABCDEF',
    '00:B3:99:5B:E9:53',
    NULL,
    '',
    '543326403828323',
    'null',
    '2019-06-06 08:16:36',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    77,
    'BCBD957340',
    '0123456789ABCDEF',
    '00:08:2F:55:9D:A6',
    NULL,
    '',
    '543326403828323',
    'null',
    '2019-06-07 09:16:07',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    78,
    'DABC790128',
    '0123456789ABCDEF',
    '00:A5:86:AB:F1:1D',
    NULL,
    '',
    '543326403828323',
    'null',
    '2019-06-07 11:08:16',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    79,
    'FDDE106484',
    '0123456789ABCDEF',
    '00:A9:21:1C:94:23',
    NULL,
    '',
    '543326403828323',
    'null',
    '2019-06-07 12:17:01',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    81,
    'CBFB073737',
    '0123456789ABCDEF',
    '00:6D:8B:A3:57:A5',
    NULL,
    '',
    '543326403828323',
    'null',
    '2019-06-10 05:38:28',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    82,
    'FEBE718436',
    'LGH872d603b454',
    'DC:0B:34:C4:E4:1C',
    '355468080559917',
    'null',
    '355468080559917',
    'null',
    '2019-06-10 08:43:42',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    83,
    'DFFB715052',
    'FFY5T18117023569',
    '10:44:00:BA:F3:E2',
    '868598033592605',
    '868598033628615',
    '868598033592605',
    '868598033628615',
    '2019-06-10 09:37:59',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    84,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '494113679796791',
    '450452728961606',
    '2019-06-11 15:09:35',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    85,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '354444076293150',
    '354444076293168',
    '2019-06-11 16:18:40',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    86,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '015922198702423',
    '354444076293168',
    '2019-06-11 16:37:42',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    87,
    'AECE977918',
    'VSP1001901S00172',
    '00:27:15:3D:FF:C8',
    NULL,
    '',
    '015922198702423',
    '302548124110431',
    '2019-06-11 16:39:34',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    88,
    'EBFA937942',
    'VSP1001901S00125',
    '00:27:15:41:D7:00',
    '354444076292210',
    '354444076292228',
    '354444076292210',
    '354444076292228',
    '2019-06-13 15:18:30',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    89,
    'DDEA755394',
    'VSP1001901S00417',
    '00:27:15:7B:44:E4',
    '354444076298050',
    '354444076298068',
    '354444076298050',
    '354444076298068',
    '2019-06-13 15:20:27',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    90,
    'FBAC150553',
    'VSP1001901S00258',
    '00:27:15:8C:C5:BB',
    '354444076294877',
    '354444076294885',
    '354444076294877',
    '354444076294885',
    '2019-06-13 15:34:05',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    91,
    'BFDA939981',
    'VSP1001901S00200',
    '00:27:15:8F:DC:ED',
    '354444076293713',
    '354444076293721',
    '354444076293713',
    '354444076293721',
    '2019-06-13 15:40:42',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    92,
    'AAFE485998',
    'VSP1001901S00498',
    '00:27:15:6B:7F:7A',
    '354444076299678',
    '354444076299686',
    '354444076299678',
    '354444076299686',
    '2019-06-13 15:44:50',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    93,
    'DFCA760576',
    'VSP1001901S00241',
    '00:27:15:81:08:EB',
    '354444076294539',
    '354444076294547',
    '354444076294539',
    '354444076294547',
    '2019-06-13 15:44:51',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    94,
    'DABD696724',
    'VSP1001901S00110',
    '00:27:15:60:EF:AE',
    '354444076291915',
    '354444076291923',
    '354444076291915',
    '354444076291923',
    '2019-06-13 15:47:40',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    95,
    'AAAC945758',
    'VSP1001901S00252',
    '00:27:15:B0:ED:C3',
    '354444076294752',
    '354444076294760',
    '354444076294752',
    '354444076294760',
    '2019-06-13 15:52:48',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    96,
    'BAFB097798',
    'VSP1001901S00424',
    '00:27:15:F8:12:CA',
    '354444076298191',
    '354444076298209',
    '354444076298191',
    '354444076298209',
    '2019-06-13 15:59:20',
    NULL
  );
INSERT INTO
  `imei_history` (
    `id`,
    `device_id`,
    `Serial_number`,
    `mac_address`,
    `orignal_imei1`,
    `orignal_imei2`,
    `imei1`,
    `imei2`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    97,
    'BDDE853697',
    'VSP1001901S00190',
    '00:27:15:AB:86:FB',
    '354444076293515',
    '354444076293523',
    '354444076293515',
    '354444076293523',
    '2019-06-13 16:06:27',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: login_history
# ------------------------------------------------------------

INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    425,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNTAzODAsImV4cCI6MTU2MDMzNjc4MH0.p3ROCUoZcPecBmL0WiFBPdIQGxH9KwZZ6PaBLN8Q0fU',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 10:53:00',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    426,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNTk5MDgsImV4cCI6MTU2MDM0NjMwOH0.QQRQwuWqKSTm9nha2O6PcfU5LaPs874ttvE5c94QznI',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 13:31:48',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    427,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNjM3MDcsImV4cCI6MTU2MDM1MDEwN30.lpI-CCySdG4eIbgZMnCNJ6xCErXYpNhbrHCtp1fSeIc',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 14:35:07',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    428,
    NULL,
    '232',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMzIsImRlYWxlcl9pZCI6MjMyLCJlbWFpbCI6ImltdWhhbW1hZG1laHJhbkBnbWFpbC5jb20iLCJsYXN0TmFtZSI6bnVsbCwibmFtZSI6Ik11aGFtbWFkIG1laHJhbiIsImZpcnN0TmFtZSI6bnVsbCwiZGVhbGVyX25hbWUiOiJNdWhhbW1hZCBtZWhyYW4iLCJkZWFsZXJfZW1haWwiOiJpbXVoYW1tYWRtZWhyYW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiNjc0Nzk0IiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMTMifV0sImFjY291bnRfc3RhdHVzIjpudWxsLCJ1c2VyX3R5cGUiOiJkZWFsZXIiLCJjcmVhdGVkIjoiMjAxOS0wNC0zMCAwNzo1OToxNSIsIm1vZGlmaWVkIjoiMjAxOS0wNC0zMCAwNzo1OToxNSIsInR3b19mYWN0b3JfYXV0aCI6MCwiaXBfYWRkcmVzcyI6IjEzNy41OS4yMjUuMTU5In0sImlhdCI6MTU2MDI2NTA2MywiZXhwIjoxNTYwMzUxNDYzfQ.Nytz5fl4UwhyXHhprflliHIXlFDe_67269dTNdyExUg',
    '86400s',
    '137.59.225.159',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-11 14:57:43',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    429,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNjYzNjYsImV4cCI6MTU2MDM1Mjc2Nn0.5MzosmJzvdNuF-xQuxAqRbzkkXv1l1k4z1PnoLGU_Uw',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 15:19:26',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    430,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNjY2MDEsImV4cCI6MTU2MDM1MzAwMX0.DPFQJOl9Cl0TyPn6XASsflmSX1pyKhXtLZi-xLDpUew',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 15:23:21',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    431,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAyNzA4NjIsImV4cCI6MTU2MDM1NzI2Mn0.HyniylrjU3UhWSoHOSRHQdZtQXFqaaTrlFe6AuAsBEg',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-11 16:34:22',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    432,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxNDcuNzUuOTIuNzYifSwiaWF0IjoxNTYwMzE1NDcyLCJleHAiOjE1NjA0MDE4NzJ9.kwAIgfQaFR57dii8Rpb003b343HaAaPG2_7yTM6q1sA',
    '86400s',
    '147.75.92.76',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 04:57:52',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    433,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAzMTY0NzEsImV4cCI6MTU2MDQwMjg3MX0.x7aEgQtgwCZvpcdYRm8XUP1rCZE9Otha4M-ZE9nGKu4',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 05:14:31',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    434,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAzMTkyMDcsImV4cCI6MTU2MDQwNTYwN30.jAn-4qql0rsOlE80dkoPRxNF3yKUQSTXAEGaRioktQo',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 06:00:07',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    435,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMTMuMTA0LjIzMS43NyJ9LCJpYXQiOjE1NjAzMjI2MTksImV4cCI6MTU2MDQwOTAxOX0.Q3ENauGckaVBpm5SEFu3Mnch3YnrQyeDuy6sUuHL-rQ',
    '86400s',
    '113.104.231.77',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 06:56:59',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    436,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMTMuMTA0LjIzMS43NyJ9LCJpYXQiOjE1NjAzMjQ3NTksImV4cCI6MTU2MDQxMTE1OX0.sS3rYdDyk8xD2FJPszgFFjWPTLHFX1FHLrLAG9doPrQ',
    '86400s',
    '113.104.231.77',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 07:32:39',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    437,
    NULL,
    '231',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMzEsImRlYWxlcl9pZCI6MjMxLCJlbWFpbCI6ImFkZWVsQHN1bnp0ZWNoLmNvbSIsImxhc3ROYW1lIjpudWxsLCJuYW1lIjoiQWRlZWwiLCJmaXJzdE5hbWUiOm51bGwsImRlYWxlcl9uYW1lIjoiQWRlZWwiLCJkZWFsZXJfZW1haWwiOiJhZGVlbEBzdW56dGVjaC5jb20iLCJsaW5rX2NvZGUiOiIxNjY3NzgiLCJjb25uZWN0ZWRfZGVhbGVyIjowLCJjb25uZWN0ZWRfZGV2aWNlcyI6W3sidG90YWwiOiIwIn1dLCJhY2NvdW50X3N0YXR1cyI6IiIsInVzZXJfdHlwZSI6ImRlYWxlciIsImNyZWF0ZWQiOiIyMDE5LTA0LTI5IDA5OjQ3OjA4IiwibW9kaWZpZWQiOiIyMDE5LTA0LTI5IDA5OjQ3OjA4IiwidHdvX2ZhY3Rvcl9hdXRoIjowLCJpcF9hZGRyZXNzIjoiMTM3LjU5LjIyNS4xNTkifSwiaWF0IjoxNTYwMzI1MTkwLCJleHAiOjE1NjA0MTE1OTB9._mVSCBs1rrGCSkHn9ouNk9bZzW_Hg5JTXs5LnYwg43U',
    '86400s',
    '137.59.225.159',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-12 07:39:50',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    438,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAzMjg2NTEsImV4cCI6MTU2MDQxNTA1MX0.lgsIr9h-FOJnEyRUOycq9k8sFlg04XvmjFgQ49sN870',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 08:37:31',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    439,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI0Mi4yMDEuMTc3LjEyOSJ9LCJpYXQiOjE1NjAzMzU5MzgsImV4cCI6MTU2MDQyMjMzOH0.wVlmDNV7KDMW2XmaNFt-gkJ7isZ2Y5_9pIUIknbrDiY',
    '86400s',
    '42.201.177.129',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 10:38:58',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    440,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjAzNDg4MjUsImV4cCI6MTU2MDQzNTIyNX0.arXGNf4nUwqnZCcHXbmZKRmU_ohSiOfuj_Q2aGpBWyA',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 14:13:45',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    441,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI2Ni4xMzEuMjIyLjczIn0sImlhdCI6MTU2MDM2MzcyNCwiZXhwIjoxNTYwNDUwMTI0fQ.qj6mO1fD-BylKvRhdXy1VjxkAAI2prLcPCAGp2Feqm4',
    '86400s',
    '66.131.222.73',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-12 18:22:04',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    442,
    NULL,
    '224',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMjQsImRlYWxlcl9pZCI6MjI0LCJlbWFpbCI6InphaWRAdm9ydGV4YXBwLmNhIiwibGFzdE5hbWUiOm51bGwsIm5hbWUiOiJ6YWlkIiwiZmlyc3ROYW1lIjpudWxsLCJkZWFsZXJfbmFtZSI6InphaWQiLCJkZWFsZXJfZW1haWwiOiJ6YWlkQHZvcnRleGFwcC5jYSIsImxpbmtfY29kZSI6IjQxNzY5NSIsImNvbm5lY3RlZF9kZWFsZXIiOjAsImNvbm5lY3RlZF9kZXZpY2VzIjpbeyJ0b3RhbCI6IjQifV0sImFjY291bnRfc3RhdHVzIjpudWxsLCJ1c2VyX3R5cGUiOiJkZWFsZXIiLCJjcmVhdGVkIjoiMjAxOS0wNC0xMCAyMTowNjo1MSIsIm1vZGlmaWVkIjoiMjAxOS0wNC0xMCAyMTowNjo1MSIsInR3b19mYWN0b3JfYXV0aCI6MCwiaXBfYWRkcmVzcyI6IjY2LjEzMS4yMjIuNzMifSwiaWF0IjoxNTYwMzY2NjI2LCJleHAiOjE1NjA0NTMwMjZ9.Y8QjLU4HVJ-kN5JAR8d4pQFqdgT4l_Vexr-RJGwWxyk',
    '86400s',
    '66.131.222.73',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-12 19:10:26',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    443,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDAxMjIsImV4cCI6MTU2MDQ4NjUyMn0.w8BHP52G353sZCEDFzWzvUuIsKir1tEhU2BD_hu2akQ',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 04:28:42',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    444,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDAxNzAsImV4cCI6MTU2MDQ4NjU3MH0.Vl12IKank7BS-vlpn7126MTGdOsCvJklBRU-q7zDjiU',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 04:29:30',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    445,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDAxODgsImV4cCI6MTU2MDQ4NjU4OH0.jBq05WeVq99bEvW96VHziJ5_0WHep5uwOQyblOJEBAw',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 04:29:48',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    446,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDEzMDEsImV4cCI6MTU2MDQ4NzcwMX0.v0TXXhNSpyo5CY9xPpOtugI7tUMqb5BO6at-BQCMWgM',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 04:48:21',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    447,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDEzMTIsImV4cCI6MTU2MDQ4NzcxMn0.Mlj3T6B4DQnV72FHyg3MVeah-Axf5Sw3ZSh8a9xdy98',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 04:48:32',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    448,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDI2NDcsImV4cCI6MTU2MDQ4OTA0N30.-UoXM7YhN6BjsuRaeYcMSkyUy5j2r3u9JC0RHHv5smY',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 05:10:47',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    449,
    NULL,
    '231',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMzEsImRlYWxlcl9pZCI6MjMxLCJlbWFpbCI6ImFkZWVsQHN1bnp0ZWNoLmNvbSIsImxhc3ROYW1lIjpudWxsLCJuYW1lIjoiQWRlZWwiLCJmaXJzdE5hbWUiOm51bGwsImRlYWxlcl9uYW1lIjoiQWRlZWwiLCJkZWFsZXJfZW1haWwiOiJhZGVlbEBzdW56dGVjaC5jb20iLCJsaW5rX2NvZGUiOiIxNjY3NzgiLCJjb25uZWN0ZWRfZGVhbGVyIjowLCJjb25uZWN0ZWRfZGV2aWNlcyI6W3sidG90YWwiOiIwIn1dLCJhY2NvdW50X3N0YXR1cyI6IiIsInVzZXJfdHlwZSI6ImRlYWxlciIsImNyZWF0ZWQiOiIyMDE5LTA0LTI5IDA5OjQ3OjA4IiwibW9kaWZpZWQiOiIyMDE5LTA0LTI5IDA5OjQ3OjA4IiwidHdvX2ZhY3Rvcl9hdXRoIjowLCJpcF9hZGRyZXNzIjoiMTM3LjU5LjIyNS4xNTkifSwiaWF0IjoxNTYwNDA2MTk4LCJleHAiOjE1NjA0OTI1OTh9.N6f8WvahHftkmwfq6I7eB2edl7C1Igu5xSnVU5OmV9A',
    '86400s',
    '137.59.225.159',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-13 06:09:58',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    450,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0MDYyNDAsImV4cCI6MTU2MDQ5MjY0MH0.ebvvsAe7IUX9hcNoA7qr64bHg9dAd1tVcuCgbqiruwI',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 06:10:40',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    451,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI4NS4yMDMuNDcuMzgifSwiaWF0IjoxNTYwNDEzNzYzLCJleHAiOjE1NjA1MDAxNjN9.qk-qOwm7TijReRGf3XbBLvkC_QWPzUSmB2Npz3ZyUOE',
    '86400s',
    '85.203.47.38',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 08:16:03',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    452,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI2Ni4xMzEuMjIyLjczIn0sImlhdCI6MTU2MDQzOTA5MCwiZXhwIjoxNTYwNTI1NDkwfQ.TxJSYWWzIIclfg6Pq9guq6uukoMMZCBFFt8hyrPoshg',
    '86400s',
    '66.131.222.73',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 15:18:10',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    453,
    NULL,
    '224',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMjQsImRlYWxlcl9pZCI6MjI0LCJlbWFpbCI6InphaWRAdm9ydGV4YXBwLmNhIiwibGFzdE5hbWUiOm51bGwsIm5hbWUiOiJ6YWlkIiwiZmlyc3ROYW1lIjpudWxsLCJkZWFsZXJfbmFtZSI6InphaWQiLCJkZWFsZXJfZW1haWwiOiJ6YWlkQHZvcnRleGFwcC5jYSIsImxpbmtfY29kZSI6IjQxNzY5NSIsImNvbm5lY3RlZF9kZWFsZXIiOjAsImNvbm5lY3RlZF9kZXZpY2VzIjpbeyJ0b3RhbCI6IjUifV0sImFjY291bnRfc3RhdHVzIjpudWxsLCJ1c2VyX3R5cGUiOiJkZWFsZXIiLCJjcmVhdGVkIjoiMjAxOS0wNC0xMCAyMTowNjo1MSIsIm1vZGlmaWVkIjoiMjAxOS0wNC0xMCAyMTowNjo1MSIsInR3b19mYWN0b3JfYXV0aCI6MCwiaXBfYWRkcmVzcyI6IjY2LjEzMS4yMjIuNzMifSwiaWF0IjoxNTYwNDM5MjEyLCJleHAiOjE1NjA1MjU2MTJ9.xj_4nsWafy8FZirSV5tFZ_7JtBe1NBiD7QvaUB-wPTQ',
    '86400s',
    '66.131.222.73',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-13 15:20:12',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    454,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxODIuMTg2LjEzNi4yMTMifSwiaWF0IjoxNTYwNDM5Nzk0LCJleHAiOjE1NjA1MjYxOTR9.udCMvd47IM_-5-S7vjdTFH0Gk1jQHF-eFSzAoOGblKw',
    '86400s',
    '182.186.136.213',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 15:29:54',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    455,
    NULL,
    '224',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoyMjQsImRlYWxlcl9pZCI6MjI0LCJlbWFpbCI6InphaWRAdm9ydGV4YXBwLmNhIiwibGFzdE5hbWUiOm51bGwsIm5hbWUiOiJ6YWlkIiwiZmlyc3ROYW1lIjpudWxsLCJkZWFsZXJfbmFtZSI6InphaWQiLCJkZWFsZXJfZW1haWwiOiJ6YWlkQHZvcnRleGFwcC5jYSIsImxpbmtfY29kZSI6IjQxNzY5NSIsImNvbm5lY3RlZF9kZWFsZXIiOjAsImNvbm5lY3RlZF9kZXZpY2VzIjpbeyJ0b3RhbCI6IjE0In1dLCJhY2NvdW50X3N0YXR1cyI6bnVsbCwidXNlcl90eXBlIjoiZGVhbGVyIiwiY3JlYXRlZCI6IjIwMTktMDQtMTAgMjE6MDY6NTEiLCJtb2RpZmllZCI6IjIwMTktMDQtMTAgMjE6MDY6NTEiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI2Ni4xMzEuMjIyLjczIn0sImlhdCI6MTU2MDQ0NjMyMywiZXhwIjoxNTYwNTMyNzIzfQ.5QVY1XYj8qGftRz-3yidWWJzantzIEkvsAX6rlo1ze4',
    '86400s',
    '66.131.222.73',
    NULL,
    'dealer',
    'token',
    1,
    '2019-06-13 17:18:43',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    456,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI2Ni4xMzEuMjIyLjczIn0sImlhdCI6MTU2MDQ2NjUzNSwiZXhwIjoxNTYwNTUyOTM1fQ.nqrD9jpi0dnfU_XpxYoCxHePbJlzzKhmLSppGxbV_IA',
    '86400s',
    '66.131.222.73',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-13 22:55:35',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    457,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0OTA1NjgsImV4cCI6MTU2MDU3Njk2OH0.zRrESr3ENbtQEwGJoF6854tcPljr9k2fRPu6VO6ONAY',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-14 05:36:08',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    458,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA0OTM4MzksImV4cCI6MTU2MDU4MDIzOX0.WQYigDNz84gXiI6W1imDgeweZlaqPZFKZPZCwMwoQ0s',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-14 06:30:39',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    459,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiI4NS4yMDMuNDcuMjE1In0sImlhdCI6MTU2MDQ5NTAyMCwiZXhwIjoxNTYwNTgxNDIwfQ.FnHqVbT2htvKypCORoKEVZnG6RzAjCyeSg2XxoxkNB0',
    '86400s',
    '85.203.47.215',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-14 06:50:20',
    NULL
  );
INSERT INTO
  `login_history` (
    `id`,
    `device_id`,
    `dealer_id`,
    `socket_id`,
    `token`,
    `expiresin`,
    `ip_address`,
    `mac_address`,
    `logged_in_client`,
    `type`,
    `status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    460,
    NULL,
    '154',
    NULL,
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNTQsImRlYWxlcl9pZCI6MTU0LCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsImxhc3ROYW1lIjoiS2FzaHlhcCIsIm5hbWUiOiJhZG1pbiIsImZpcnN0TmFtZSI6Ik5laGEiLCJkZWFsZXJfbmFtZSI6ImFkbWluIiwiZGVhbGVyX2VtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwibGlua19jb2RlIjoiIiwiY29ubmVjdGVkX2RlYWxlciI6MCwiY29ubmVjdGVkX2RldmljZXMiOlt7InRvdGFsIjoiMCJ9XSwiYWNjb3VudF9zdGF0dXMiOm51bGwsInVzZXJfdHlwZSI6ImFkbWluIiwiY3JlYXRlZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJtb2RpZmllZCI6IjIwMTktMDItMDggMDk6NTA6MDQiLCJ0d29fZmFjdG9yX2F1dGgiOjAsImlwX2FkZHJlc3MiOiIxMzcuNTkuMjI1LjE1OSJ9LCJpYXQiOjE1NjA1MDg1NjksImV4cCI6MTU2MDU5NDk2OX0.ElQG9CMo8tDzpBQq7Wal1VrRk5F2XGZlgGIheiKF_Yc',
    '86400s',
    '137.59.225.159',
    NULL,
    'admin',
    'token',
    1,
    '2019-06-14 10:36:09',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: pgp_emails
# ------------------------------------------------------------

INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    125,
    157,
    '358GTR@TITANSECURE.BIZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-02 20:05:19'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    126,
    NULL,
    '599NGT@TITANSECURE.BIZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-03 12:04:47'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    127,
    NULL,
    '349VFT@TITANSECURE.BIZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-05 11:19:22'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    128,
    NULL,
    '791BFT@TITANSECURE.BIZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-01 13:06:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    129,
    182,
    '1619DKV@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-07 09:19:13'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    130,
    NULL,
    '5438DNE@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-10 05:33:16'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    131,
    183,
    '2675DKN@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-07 11:09:12'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    132,
    188,
    '3754ZUB@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-10 09:38:18'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    133,
    187,
    '4338GQG@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-10 08:45:35'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    134,
    NULL,
    '3669NBQ@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-10 15:33:17'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    135,
    NULL,
    '5147DXT@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:08',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    136,
    NULL,
    '8244SRE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:08',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    137,
    NULL,
    '5412JJN@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:08',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    138,
    NULL,
    '4134PTE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    139,
    NULL,
    '2954PAJ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    140,
    NULL,
    '6845YAY@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    141,
    NULL,
    '7992PFY@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    142,
    NULL,
    '4967GCM@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    143,
    NULL,
    '5373SAJ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    144,
    211,
    '1233NPX@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    145,
    212,
    '7921MKT@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 15:20:37'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    146,
    213,
    '2188PBW@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 15:22:33'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    147,
    220,
    '2535MPM@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:08:01'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    148,
    214,
    '4254PMS@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:08:36'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    149,
    219,
    '4511AXM@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:09:13'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    150,
    218,
    '4437CZC@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:09:33'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    151,
    217,
    '8729YAM@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:09:56'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    152,
    216,
    '7497CXZ@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:10:23'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    153,
    215,
    '5464NJF@ARMORSEC.XYZ',
    1,
    '2019-04-08 10:58:09',
    '2019-06-13 17:10:39'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    154,
    NULL,
    '6362MBN@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    155,
    NULL,
    '5752CXB@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    156,
    NULL,
    '9498NBS@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    157,
    NULL,
    '3789NZU@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    158,
    NULL,
    '9643NZE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    159,
    NULL,
    '9347SKJ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    160,
    NULL,
    '8837ZRE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    161,
    NULL,
    '7245BCB@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    162,
    NULL,
    '9279GBS@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    163,
    NULL,
    '1747BBV@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    164,
    NULL,
    '4288DXZ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:02'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    165,
    NULL,
    '2474VJS@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    166,
    NULL,
    '1976JSN@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    167,
    NULL,
    '1879TWV@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    168,
    NULL,
    '2458VZC@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    169,
    NULL,
    '1842WKX@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    170,
    NULL,
    '5225CHG@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    171,
    NULL,
    '4337VZF@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-05-16 06:50:05'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    172,
    NULL,
    '5734TXZ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    173,
    NULL,
    '4763XEK@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    174,
    NULL,
    '2196GNW@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    175,
    NULL,
    '8931APD@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    176,
    NULL,
    '8478YXA@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    177,
    NULL,
    '9437TPJ@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    178,
    NULL,
    '4347HVE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    179,
    NULL,
    '5945VEC@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    180,
    NULL,
    '2583AUF@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    181,
    NULL,
    '7574XDR@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    182,
    NULL,
    '8497KRA@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    183,
    NULL,
    '6497NVE@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    184,
    NULL,
    '3371GCF@ARMORSEC.XYZ',
    0,
    '2019-04-08 10:58:09',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    185,
    NULL,
    'test3@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    186,
    NULL,
    'test6@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    187,
    NULL,
    'test5@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    188,
    NULL,
    'test9@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    189,
    NULL,
    'test7@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    190,
    NULL,
    'test8@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    191,
    NULL,
    'test4@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    192,
    221,
    'test1@titansecure.biz',
    1,
    '2019-04-27 23:19:20',
    '2019-06-13 17:07:10'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    193,
    NULL,
    'test2@titansecure.biz',
    0,
    '2019-04-27 23:19:20',
    '2019-06-01 12:13:15'
  );
INSERT INTO
  `pgp_emails` (
    `id`,
    `user_acc_id`,
    `pgp_email`,
    `used`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    194,
    184,
    '955MNH@TITANSECURE.BIZ',
    1,
    '2019-05-31 12:55:16',
    '2019-06-07 12:17:31'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: policy
# ------------------------------------------------------------

INSERT INTO
  `policy` (
    `id`,
    `policy_name`,
    `policy_note`,
    `dealer_id`,
    `dealer_type`,
    `command_name`,
    `permissions`,
    `app_list`,
    `push_apps`,
    `controls`,
    `dealers`,
    `passwords`,
    `status`,
    `delete_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    24,
    'test123',
    'hamza',
    154,
    'admin',
    '#test123',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":1,\"id\":4668,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":1,\"id\":4669,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":1,\"id\":4670,\"app_id\":4670,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":1,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":1,\"id\":4671,\"app_id\":4671,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":1,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":1,\"id\":4672,\"app_id\":4672,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":1,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":1,\"id\":4673,\"app_id\":4673,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":1,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":1,\"id\":4674,\"app_id\":4674,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":1,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":1,\"id\":4675,\"app_id\":4675,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":1,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":1,\"id\":4676,\"app_id\":4676,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":1,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":1,\"id\":4677,\"app_id\":4677,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":1,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":1,\"id\":4678,\"app_id\":4678,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":1,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":1,\"id\":4679,\"app_id\":4679,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":1,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":1,\"id\":21461,\"app_id\":21461,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":1,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":1,\"id\":23212,\"app_id\":23212,\"default_app\":0,\"isChanged\":true}]',
    '[{\"id\":4649,\"unique_name\":\"com.android.musicMusic\",\"label\":\"Music\",\"package_name\":\"com.android.music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4651,\"unique_name\":\"com.android.browserBrowser\",\"label\":\"Browser\",\"package_name\":\"com.android.browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4652,\"unique_name\":\"com.android.calendarCalendar\",\"label\":\"Calendar\",\"package_name\":\"com.android.calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4653,\"unique_name\":\"com.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4654,\"unique_name\":\"com.android.deskclockClock\",\"label\":\"Clock\",\"package_name\":\"com.android.deskclock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4655,\"unique_name\":\"com.android.dialerPhone\",\"label\":\"Phone\",\"package_name\":\"com.android.dialer\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4656,\"unique_name\":\"com.android.emailEmail\",\"label\":\"Email\",\"package_name\":\"com.android.email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4657,\"unique_name\":\"com.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4658,\"unique_name\":\"com.android.mmsMessaging\",\"label\":\"Messaging\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4660,\"unique_name\":\"com.android.soundrecorderSound Recorder\",\"label\":\"Sound Recorder\",\"package_name\":\"com.android.soundrecorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":\"2019-06-12 16:35:20\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4661,\"unique_name\":\"com.mediatek.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.mediatek.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4662,\"unique_name\":\"com.android.calculator2Calculator\",\"label\":\"Calculator\",\"package_name\":\"com.android.calculator2\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4663,\"unique_name\":\"com.android.quicksearchboxSearch\",\"label\":\"Search\",\"package_name\":\"com.android.quicksearchbox\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4664,\"unique_name\":\"com.android.stkSIM Toolkit\",\"label\":\"SIM Toolkit\",\"package_name\":\"com.android.stk\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4665,\"unique_name\":\"com.mediatek.systemupdateSystem software updates\",\"label\":\"System software updates\",\"package_name\":\"com.mediatek.systemupdate\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":4666,\"unique_name\":\"com.rim.mobilefusion.clientUEM Client\",\"label\":\"UEM Client\",\"package_name\":\"com.rim.mobilefusion.client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null,\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":15706,\"unique_name\":\"com.secureClear.SecureClearActivitySecure Clear\",\"label\":\"Secure Clear\",\"package_name\":\"com.secureClear.SecureClearActivity\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"id\":15929,\"unique_name\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"label\":\"Secure Market\",\"package_name\":\"com.secureMarket.SecureMarketActivity\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\",\"isChanged\":true,\"guest\":true,\"encrypted\":true,\"enable\":true},{\"guest\":true,\"encrypted\":true,\"enable\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"default_app\":0,\"visible\":1}]',
    '[{\"apk_id\":105,\"apk_name\":\"AppLock\",\"logo\":\"logo-1559394492336.jpg\",\"apk\":\"apk-1559394505349.apk\",\"package_name\":\"com.domobile.applock\",\"version_name\":\"2.8.10\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"On\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":107,\"apk_name\":\"Secure VPN\",\"logo\":\"logo-1559550038594.jpg\",\"apk\":\"apk-1559550029511.apk\",\"package_name\":\"com.secure.vpn\",\"version_name\":\"1.07\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":108,\"apk_name\":\"YouTube\",\"logo\":\"logo-1559550908309.jpg\",\"apk\":\"apk-1559550917631.apk\",\"package_name\":\"com.paraphron.youtube\",\"version_name\":\"10.24.55 (mod) \",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":109,\"apk_name\":\"Super VPN\",\"logo\":\"logo-1559752885994.jpg\",\"apk\":\"apk-1559752933656.apk\",\"package_name\":\"com.jrzheng.supervpnfree\",\"version_name\":\"2.5.4\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"On\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":110,\"apk_name\":\"sys ctrls v1.16\",\"logo\":\"logo-1559753228033.jpg\",\"apk\":\"apk-1559753250179.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":113,\"apk_name\":\"NeutralLauncher.v.4.78\",\"logo\":\"logo-1560178527157.jpg\",\"apk\":\"apk-1560178563547.apk\",\"package_name\":\"com.secure.launcher\",\"version_name\":\"4.78\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"On\",\"deleteable\":true,\"isChanged\":true},{\"apk_id\":114,\"apk_name\":\"sysctrls.nl.v.1.16\",\"logo\":\"logo-1560178585432.jpg\",\"apk\":\"apk-1560178594248.apk\",\"package_name\":\"com.secure.systemcontrol\",\"version_name\":\"1.16\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"apk_status\":\"Off\",\"deleteable\":true,\"isChanged\":true}]',
    '{\"wifi_status\":true,\"bluetooth_status\":true,\"screenshot_status\":true,\"location_status\":true,\"hotspot_status\":true}',
    '[]',
    NULL,
    1,
    1,
    '2019-06-14 05:15:57',
    '2019-06-14 05:16:18'
  );
INSERT INTO
  `policy` (
    `id`,
    `policy_name`,
    `policy_note`,
    `dealer_id`,
    `dealer_type`,
    `command_name`,
    `permissions`,
    `app_list`,
    `push_apps`,
    `controls`,
    `dealers`,
    `passwords`,
    `status`,
    `delete_status`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    25,
    'test',
    'sdfsdf',
    154,
    'admin',
    '#test',
    '[{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBattery\",\"guest\":1,\"label\":\"Battery\",\"icon\":\"icon_Battery.png\",\"encrypted\":0,\"id\":4668,\"app_id\":4668,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure Settingswi-fi\",\"guest\":1,\"label\":\"wi-fi\",\"icon\":\"icon_wi-fi.png\",\"encrypted\":0,\"id\":4669,\"app_id\":4669,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBluetooth\",\"guest\":1,\"label\":\"Bluetooth\",\"icon\":\"icon_Bluetooth.png\",\"encrypted\":0,\"id\":4670,\"app_id\":4670,\"default_app\":0,\"isChanged\":true},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSIM Cards\",\"guest\":0,\"label\":\"SIM Cards\",\"icon\":\"icon_SIM Cards.png\",\"encrypted\":0,\"id\":4671,\"app_id\":4671,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsData Roaming\",\"guest\":0,\"label\":\"Data Roaming\",\"icon\":\"icon_Data Roaming.png\",\"encrypted\":0,\"id\":4672,\"app_id\":4672,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsMobile Data\",\"guest\":0,\"label\":\"Mobile Data\",\"icon\":\"icon_Mobile Data.png\",\"encrypted\":0,\"id\":4673,\"app_id\":4673,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsHotspot\",\"guest\":0,\"label\":\"Hotspot\",\"icon\":\"icon_Hotspot.png\",\"encrypted\":0,\"id\":4674,\"app_id\":4674,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsFinger Print + Lock\",\"guest\":0,\"label\":\"Finger Print + Lock\",\"icon\":\"icon_Finger Print + Lock.png\",\"encrypted\":0,\"id\":4675,\"app_id\":4675,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsBrightness\",\"guest\":0,\"label\":\"Brightness\",\"icon\":\"icon_Brightness.png\",\"encrypted\":0,\"id\":4676,\"app_id\":4676,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSleep\",\"guest\":0,\"label\":\"Sleep\",\"icon\":\"icon_Sleep.png\",\"encrypted\":0,\"id\":4677,\"app_id\":4677,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsSound\",\"guest\":0,\"label\":\"Sound\",\"icon\":\"icon_Sound.png\",\"encrypted\":0,\"id\":4678,\"app_id\":4678,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsDate & Time\",\"guest\":0,\"label\":\"Date & Time\",\"icon\":\"icon_Date & Time.png\",\"encrypted\":0,\"id\":4679,\"app_id\":4679,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages\",\"guest\":0,\"label\":\"Languages\",\"icon\":\"icon_Languages.png\",\"encrypted\":0,\"id\":21461,\"app_id\":21461,\"default_app\":0},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"uniqueExtension\":\"com.secureSetting.SecureSettingsMainSecure SettingsLanguages & Input\",\"guest\":0,\"label\":\"Languages & Input\",\"icon\":\"icon_Languages & Input.png\",\"encrypted\":0,\"id\":23212,\"app_id\":23212,\"default_app\":0}]',
    '[{\"id\":4649,\"unique_name\":\"com.android.musicMusic\",\"label\":\"Music\",\"package_name\":\"com.android.music\",\"icon\":\"icon_Music.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4651,\"unique_name\":\"com.android.browserBrowser\",\"label\":\"Browser\",\"package_name\":\"com.android.browser\",\"icon\":\"icon_Browser.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4652,\"unique_name\":\"com.android.calendarCalendar\",\"label\":\"Calendar\",\"package_name\":\"com.android.calendar\",\"icon\":\"icon_Calendar.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4653,\"unique_name\":\"com.android.contactsContacts\",\"label\":\"Contacts\",\"package_name\":\"com.android.contacts\",\"icon\":\"icon_Contacts.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4654,\"unique_name\":\"com.android.deskclockClock\",\"label\":\"Clock\",\"package_name\":\"com.android.deskclock\",\"icon\":\"icon_Clock.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4655,\"unique_name\":\"com.android.dialerPhone\",\"label\":\"Phone\",\"package_name\":\"com.android.dialer\",\"icon\":\"icon_Phone.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4656,\"unique_name\":\"com.android.emailEmail\",\"label\":\"Email\",\"package_name\":\"com.android.email\",\"icon\":\"icon_Email.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4657,\"unique_name\":\"com.android.gallery3dGallery\",\"label\":\"Gallery\",\"package_name\":\"com.android.gallery3d\",\"icon\":\"icon_Gallery.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4658,\"unique_name\":\"com.android.mmsMessaging\",\"label\":\"Messaging\",\"package_name\":\"com.android.mms\",\"icon\":\"icon_Messaging.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4660,\"unique_name\":\"com.android.soundrecorderSound Recorder\",\"label\":\"Sound Recorder\",\"package_name\":\"com.android.soundrecorder\",\"icon\":\"icon_Sound Recorder.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":\"2019-06-12 16:35:20\"},{\"id\":4661,\"unique_name\":\"com.mediatek.cameraCamera\",\"label\":\"Camera\",\"package_name\":\"com.mediatek.camera\",\"icon\":\"icon_Camera.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4662,\"unique_name\":\"com.android.calculator2Calculator\",\"label\":\"Calculator\",\"package_name\":\"com.android.calculator2\",\"icon\":\"icon_Calculator.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4663,\"unique_name\":\"com.android.quicksearchboxSearch\",\"label\":\"Search\",\"package_name\":\"com.android.quicksearchbox\",\"icon\":\"icon_Search.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4664,\"unique_name\":\"com.android.stkSIM Toolkit\",\"label\":\"SIM Toolkit\",\"package_name\":\"com.android.stk\",\"icon\":\"icon_SIM Toolkit.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4665,\"unique_name\":\"com.mediatek.systemupdateSystem software updates\",\"label\":\"System software updates\",\"package_name\":\"com.mediatek.systemupdate\",\"icon\":\"icon_System software updates.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":4666,\"unique_name\":\"com.rim.mobilefusion.clientUEM Client\",\"label\":\"UEM Client\",\"package_name\":\"com.rim.mobilefusion.client\",\"icon\":\"icon_UEM Client.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-04-22 12:49:21\",\"updated_at\":null},{\"id\":15706,\"unique_name\":\"com.secureClear.SecureClearActivitySecure Clear\",\"label\":\"Secure Clear\",\"package_name\":\"com.secureClear.SecureClearActivity\",\"icon\":\"icon_Secure Clear.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-01 08:03:46\",\"updated_at\":\"2019-05-25 11:59:04\"},{\"id\":15929,\"unique_name\":\"com.secureMarket.SecureMarketActivitySecure Market\",\"label\":\"Secure Market\",\"package_name\":\"com.secureMarket.SecureMarketActivity\",\"icon\":\"icon_Secure Market.png\",\"extension\":0,\"visible\":1,\"default_app\":0,\"extension_id\":0,\"created_at\":\"2019-05-11 04:49:02\",\"updated_at\":\"2019-05-25 11:59:04\"},{\"uniqueName\":\"com.secureSetting.SecureSettingsMainSecure Settings\",\"guest\":true,\"encrypted\":true,\"enable\":true,\"label\":\"Secure Settings\",\"extension\":1,\"default_app\":0,\"visible\":1}]',
    '[]',
    '{\"wifi_status\":false,\"bluetooth_status\":false,\"screenshot_status\":false,\"location_status\":false,\"hotspot_status\":false}',
    '[]',
    NULL,
    1,
    1,
    '2019-06-14 05:37:25',
    '2019-06-14 05:39:12'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: policy_queue_jobs
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: screen_lock_devices
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: secure_market_apps
# ------------------------------------------------------------

INSERT INTO
  `secure_market_apps` (
    `id`,
    `apk_id`,
    `dealer_id`,
    `dealer_type`,
    `is_restrict_uninstall`,
    `created_at`,
    `updated_at`
  )
VALUES
  (902, 105, 154, 'admin', 0, '2019-06-12 06:46:06', NULL);
INSERT INTO
  `secure_market_apps` (
    `id`,
    `apk_id`,
    `dealer_id`,
    `dealer_type`,
    `is_restrict_uninstall`,
    `created_at`,
    `updated_at`
  )
VALUES
  (903, 110, 154, 'admin', 0, '2019-06-12 06:46:06', NULL);
INSERT INTO
  `secure_market_apps` (
    `id`,
    `apk_id`,
    `dealer_id`,
    `dealer_type`,
    `is_restrict_uninstall`,
    `created_at`,
    `updated_at`
  )
VALUES
  (904, 114, 154, 'admin', 0, '2019-06-12 06:46:06', NULL);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sim_ids
# ------------------------------------------------------------

INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    1,
    NULL,
    '8',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-10 05:33:16'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2,
    NULL,
    '9',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3,
    NULL,
    '10',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    4,
    187,
    '1',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-10 08:45:35'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    5,
    NULL,
    '2',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-05 11:19:22'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    6,
    NULL,
    '5',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    7,
    NULL,
    '4',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    8,
    NULL,
    '6',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    9,
    NULL,
    '11',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    10,
    NULL,
    '7',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    11,
    NULL,
    '3',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    12,
    NULL,
    '12',
    0,
    '26-3-2019',
    '26-4-2019',
    '2019-04-22 17:34:31',
    '2019-06-13 19:17:46'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    61,
    211,
    '13',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:28:19',
    '2019-06-11 15:09:16'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    63,
    182,
    '21',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:28:19',
    '2019-06-07 09:19:13'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    74,
    221,
    '5345',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:47:25',
    '2019-06-13 17:07:10'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    77,
    212,
    '1231231',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:47:25',
    '2019-06-13 15:20:37'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    78,
    157,
    '123123',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:47:25',
    '2019-06-02 20:05:19'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    79,
    213,
    '1233332',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:47:25',
    '2019-06-13 15:22:33'
  );
INSERT INTO
  `sim_ids` (
    `id`,
    `user_acc_id`,
    `sim_id`,
    `used`,
    `start_date`,
    `expiry_date`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    83,
    184,
    '3345',
    1,
    '26-3-2019',
    '26-4-2019',
    '2019-05-07 08:47:25',
    '2019-06-07 12:17:31'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: transferred_profiles
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user_app_permissions
# ------------------------------------------------------------

INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2403,
    'NZNH883530',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-04-28 02:38:21',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2413,
    'FBED031936',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-04-29 17:04:14',
    '2019-05-01 05:33:40'
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2434,
    'DEQM506647',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-04-30 07:58:06',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2680,
    'YISC356974',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-01 04:49:19',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2699,
    'CABC611976',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":false}',
    '2019-05-03 13:01:42',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2717,
    'ECCB212734',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-11 10:57:47',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2870,
    'CECB272225',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-20 12:35:36',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2871,
    'EDFE562714',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-20 12:50:13',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2898,
    'FBEE021680',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-21 05:27:57',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2936,
    'DDAF250244',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-22 06:22:17',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2956,
    'EADA792020',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-24 00:45:52',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2959,
    'BFCF358930',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-24 00:48:44',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2962,
    'EAFC990189',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-24 00:56:53',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2965,
    'CEAB974351',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-24 01:15:28',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    2968,
    'ECCA287941',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-24 01:29:27',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3034,
    'DDFA228315',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":false}',
    '2019-05-28 14:16:06',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3042,
    'EDFF641493',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-05-29 08:55:04',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3071,
    'AEBE885997',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-01 13:35:25',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3072,
    'FDAB380068',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-01 13:37:43',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3099,
    'BCFE945075',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-03 12:06:58',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3153,
    'EEEE144909',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-05 08:10:14',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3160,
    'CBDC381935',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-05 11:19:52',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3178,
    'CDDA766328',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-05 21:03:36',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3180,
    'ECAE569003',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-06 04:58:40',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3204,
    'DABC790128',
    'null',
    '2019-06-07 11:15:38',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3233,
    'EACE961253',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-10 04:02:42',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3243,
    'DFFB715052',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":false}',
    '2019-06-10 09:39:02',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3254,
    'BCBD957340',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-10 17:07:49',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3259,
    'CBFB073737',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-11 10:24:44',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3342,
    'CCDB002066',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-12 10:06:51',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3354,
    'EAFA418535',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-12 18:50:20',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3371,
    'DDEA755394',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-13 15:48:52',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3377,
    'EBFA937942',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-13 15:56:13',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3383,
    'FBAC150553',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-13 17:31:50',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3390,
    'AECE977918',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-13 19:15:43',
    NULL
  );
INSERT INTO
  `user_app_permissions` (
    `id`,
    `device_id`,
    `permissions`,
    `created_at`,
    `updated_at`
  )
VALUES
  (
    3393,
    'FDDE106484',
    '{\"bluetooth_status\":false,\"call_status\":false,\"hotspot_status\":false,\"screenshot_status\":false,\"wifi_status\":true}',
    '2019-06-13 22:53:54',
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user_apps
# ------------------------------------------------------------

INSERT INTO
  `user_apps` (
    `id`,
    `device_id`,
    `app_id`,
    `guest`,
    `encrypted`,
    `enable`,
    `extension`,
    `created_at`,
    `updated_at`
  )
VALUES
  (397, 643, 4649, 1, 0, 0, 0, '2019-04-22 12:49:22', NULL);
