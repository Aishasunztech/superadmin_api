var express = require('express');
// const sql = require('../helper/sql.js');
// var multer = require('multer');
// var upload = multer({ dest: 'uploads/' });
var fs = require("fs");
var path = require('path');


var app_constants = require('../constants/application');

module.exports = {

    saveActionHistory: async (device, action) => {
        // console.log('SAVE HISTORY', action, device);
        let query = `INSERT INTO acc_action_history (action, device_id, device_name, session_id, model, ip_address, simno, imei, simno2, imei2, serial_number, mac_address, fcm_token, online, is_sync, flagged, screen_start_date, reject_status, account_email, dealer_id, prnt_dlr_id, link_code, client_id, start_date, expiry_months, expiry_date, activation_code, status, device_status, activation_status, wipe_status, account_status, unlink_status, transfer_status, dealer_name, prnt_dlr_name, user_acc_id, pgp_email, chat_id, sim_id, finalStatus) VALUES `
        let finalQuery = ''
        if (action === Constants.DEVICE_UNLINKED || action === Constants.UNLINK_DEVICE_DELETE) {
            finalQuery = query + `('${action}', '${device.device_id}', '${device.name}', '${device.session_id}', '${device.model}', '${device.ip_address}', '${device.simno}', '${device.imei}', '${device.simno2}', '${device.imei2}', ${device.serial_number}', '${device.mac_address}', '${device.fcm_token}', 'off', '${device.is_sync}', '${device.flagged}', '${device.screen_start_date}', '${device.reject_status}', '${device.account_email}', '${device.dealer_id}', '${device.prnt_dlr_id}', '${device.link_code}', '${device.client_id}', '', ${device.expiry_months}, '', '${device.activation_code}', '', 0 , null, '${device.wipe_status}', '${device.account_status}', 1, '${device.transfer_status}', '${device.dealer_name}', '${device.prnt_dlr_name}', '${device.id}', '${device.pgp_email}', '${device.chat_id}', '${device.sim_id}', 'Unlinked')`
        } else {
            finalQuery = query + `('${action}', ${device.device_id}', ${device.name}', ${device.session_id}' ,'${device.model}', ${device.ip_address}', ${device.simno}', ${device.imei}', ${device.simno2}', ${device.imei2}', ${device.serial_number}', ${device.mac_address}', ${device.fcm_token}', ${device.online}', ${device.is_sync}', ${device.flagged}', ${device.screen_start_date}', ${device.reject_status}', ${device.account_email}', ${device.dealer_id}', ${device.prnt_dlr_id}', ${device.link_code}', '${device.client_id}', '${device.start_date}', ${device.expiry_months}, '${device.expiry_date}', ${device.activation_code}', ${device.status}', ${device.device_status}', ${device.activation_status}', ${device.wipe_status}', ${device.account_status}', ${device.unlink_status}', ${device.transfer_status}', ${device.dealer_name}', ${device.prnt_dlr_name}', ${device.id}', ${device.pgp_email}', ${device.chat_id}', ${device.sim_id}', ${device.finalStatus}')`;

        }
        await sql.query(finalQuery)

    },
    getDeviceInfo: (req) => {
        var imei = (req.body.imei !== undefined && req.body.imei !== null) ? req.body.imei : null;
        var ip = req.body.ip;
        var simNo = (req.body.simNo !== null && req.body.simNo !== null) ? req.body.simNo : null;
        var serial_number = req.body.serialNo;
        var mac_address = req.body.macAddr;

        var imei1 = null;
        var imei2 = null;
        var simNo1 = null;
        var simNo2 = null;
        //geting imei's
        if (imei !== undefined && imei !== null) {
            imei1 = (imei[0] !== undefined && imei[0] !== null && imei[0] !== 'null') ? imei[0] : null;
            imei2 = (imei[1] !== undefined && imei[0] !== null && imei[1] !== 'null') ? imei[1] : null;
        }

        if (simNo !== undefined && simNo !== null) {
            simNo1 = (simNo[0] !== undefined && simNo[0] !== null && simNo[0] !== 'null') ? simNo[0] : null;
            simNo2 = (simNo[1] !== undefined && simNo[1] !== null && simNo[0] !== 'null') ? simNo[1] : null;
        }

        return {
            imei1, imei2, simNo1, simNo2, serial_number, ip, mac_address
        }
    },

    checkvalidImei: async (s) => {
        var etal = /^[0-9]{15}$/;
        if (!etal.test(s))
            return false;
        sum = 0; mul = 2; l = 14;
        for (i = 0; i < l; i++) {
            digit = s.substring(l - i - 1, l - i);
            tp = parseInt(digit, 10) * mul;
            if (tp >= 10)
                sum += (tp % 10) + 1;
            else
                sum += tp;
            if (mul == 1)
                mul++;
            else
                mul--;
        }
        chk = ((10 - (sum % 10)) % 10);
        if (chk != parseInt(s.substring(14, 15), 10))
            return false;
        return true;
    },
    checkStatus: function (device) {
        let status = "";

        if (device.account_status === app_constants.DEVICE_SUSPENDED) {
            status = app_constants.DEVICE_SUSPENDED;
        } else if (device.status === app_constants.DEVICE_ACTIVATED && (device.account_status === '' || device.account_status === null)) {
            status = app_constants.DEVICE_ACTIVATED
        } else if (device.status === app_constants.DEVICE_EXPIRED && (device.account_status === '' || device.account_status === null)) {
            status = app_constants.DEVICE_EXPIRED;
        } else if (device.status === app_constants.DEVICE_DELETE && (device.account_status === '' || device.account_status === null)) {
            status = app_constants.DEVICE_DELETE;
        } else {
            status = 'N/A';
        }
        return status;

    },
    checkRemainDays: async (createDate, validity) => {
        var createdDateTime, today, days;
        if (validity != null) {

            createdDateTime = new Date(createDate);
            createdDateTime.setDate(createdDateTime.getDate() + validity);
            today = new Date();
            var difference_ms = createdDateTime.getTime() - today.getTime();

            //Get 1 day in milliseconds
            var one_day = 1000 * 60 * 60 * 24;

            // Convert back to days and return
            days = Math.round(difference_ms / one_day);
        } else {
            days = validity
        }

        if (days > 0) return days; else if (days <= 0 && days !== null) return "Expired"; else return "Not Announced";
    },

}