module.exports = {

    // ACL
    ADMIN: "admin",
    DEALER: "dealer",
    SDEALER: "sdealer",
    DEVICE: 'device',
    SOCKET: 'socket',
    TOKEN: "token",
    SUPERADMIN_CREDENTIALS: {
        email: 'super123!admin@gmail.com',
        password: 'super!123admin',
        name: 'SuperAdmin!786'
    },
    // dealers
    ADMIN_ACTIVE: "active",
    ADMIN_SUSPENDED: "suspended",
    ADMIN_UNLINKED: "unlinked",

    // devices
    DEVICE_ACTIVATED: "active",
    DEVICE_SUSPENDED: "suspended",
    DEVICE_EXPIRED: "expired",
    DEVICE_UNLINKED: "Unlinked",
    DEVICE_DELETE: "deleted",
    DEVICE_EXTEND: "extended",

    DEVICE_ONLINE: "On",
    DEVICE_OFFLINE: "off",

    // Device History Enumerables
    DEVICE_HISTORY_PUSH_APPS: 'push_apps',
    DEVICE_HISTORY_PULL_APPS: 'pull_apps',
    DEVICE_HISTORY: 'history',
    DEVICE_HISTORY_IMEI: 'imei',
    DEVICE_HISTORY_POLICY: 'policy',
    DEVICE_HISTORY_FORCE_UPDATE: 'force_update',

    // sockets
    GET_SYNC_STATUS: "get_sync_status_",
    GET_APPLIED_SETTINGS: "get_applied_settings_",
    SETTING_APPLIED_STATUS: "settings_applied_status_",
    DEVICE_STATUS: 'device_status_',
    WRITE_IMEI: 'write_imei_',
    IMEI_CHANGED: 'imei_changed_',
    IMEI_APPLIED: 'imei_applied_',
    FINISH_IMEI: 'finish_imei',


    SEND_APPS: "sendApps_",
    SEND_EXTENSIONS: "sendExtensions_",
    SEND_SETTINGS: "sendSettings_",
    DISCONNECT: "disconnect",
    CONNECT_TIMEOUT: "connect_timeout",
    ERROR: "error",
    CONNECT_ERROR: 'connect_error',
    RECONNECT: "reconnect",
    RECONNECT_ATTEMPT: "reconnect_attempt",
    RECONNECTING: "reconnecting",
    RECONNECT_ERROR: "reconnect_error",
    RECONNECT_FAILED: "reconnect_failed",

    // push apps
    GET_PUSHED_APPS: 'get_pushed_apps_',
    SEND_PUSHED_APPS_STATUS: 'send_pushed_apps_status_',
    FINISHED_PUSH_APPS: 'finished_push_apps_',
    ACK_PUSHED_APPS: 'ack_pushed_apps_',
    ACK_FINISHED_PUSH_APPS: 'ack_finished_push_apps_',
    ACK_SINGLE_PUSH_APP: 'ack_single_push_app_',

    // pull apps
    GET_PULLED_APPS: 'get_pulled_apps_',
    SEND_PULLED_APPS_STATUS: 'send_pulled_apps_status_',
    FINISHED_PULL_APPS: 'finished_pulled_apps_',
    ACK_pull_APPS: 'ack_pull_apps_',
    ACK_FINISHED_PULL_APPS: 'ack_finished_pull_apps_',
    ACK_SINGLE_PULL_APP: 'ack_single_pull_app_',
    ACTION_IN_PROCESS: 'action_in_process',

    // Policy
    LOAD_POLICY: 'load_policy_',
    GET_POLICY: 'get_policy_',
    FINISH_POLICY_PUSH_APPS: "finish_policy_push_apps_",
    FINISH_POLICY_APPS: "finish_policy_apps_",
    FINISH_POLICY_SETTINGS: "finish_policy_settings_",
    FINISH_POLICY_EXTENSIONS: "finish_policy_extensions_",
    FINISH_POLICY: 'finish_policy_',

    // force update
    FORCE_UPDATE_CHECK: 'force_update_check_',

    PING: "ping",
    PONG: "pong",

    PRE_DEFINED_SERIAL_NUMBER: "0123456789ABCDEF",
    PRE_DEFINED_MAC_ADDRESS: "02:00:00:00:00:00",

    LAUNCHER_PKG_NAME: 'com.secure.launcher',
    SYS_CONTROL_PKG_NAME: 'com.secure.systemcontrol',
    LOGO: 'logo',
    APK: 'apk'
}