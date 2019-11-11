var express = require('express');
var router = express.Router();

// import controller here
var user = require('../app/controllers/user');
var whitelabel = require('../app/controllers/whitelabel');
var acl = require('../app/controllers/acl');
var device = require('../app/controllers/device');
var apk = require('../app/controllers/apk');
var reports = require('../app/controllers/reports');

// ACL
router.post('/check_component', acl.checkComponent);

// ===========================================================================
/* GET users listing. */
router.get('/white-labels/:type', whitelabel.getWhiteLabels);

router.get('/get-white-labels/:labelId', whitelabel.getWhiteLabelInfo);

router.put('/update-white-label', whitelabel.updateWhiteLabelInfo);

router.get('/whitelabel_backups/:whitelabel_id', whitelabel.whitelabelBackups)

router.post('/get_label_sim_ids', whitelabel.getLabelSimIds)

router.post('/get_label_chat_ids', whitelabel.getLabelChatIds)

router.post('/get_label_pgp_emails', whitelabel.getLabelPgpEmails)

router.post('/restart-whitelabel', whitelabel.restartWhitelabel);

router.post('/save_backup', whitelabel.saveBackup);


// ==============================================================================
// apk file

// router.post('/uploadApk/:fieldName', user.uploadApk)

router.get('/apklist', apk.apklist)

router.post('/checkApkName', apk.checkApkName)

router.post('/upload/:fieldName', user.uploadFile);

router.post('/addApk', apk.addApk)

router.post('/apk/delete', apk.deleteApk)

router.post('/edit/apk', apk.editApk)


// ==============================================================================
// Manage Data

router.post('/import/:fieldName', user.importCSV);

router.get('/export/:fieldName', user.exportCSV);

router.get('/get_sim_ids', user.getSimIds)

router.get('/get_chat_ids', user.getChatIds)

router.get('/get_pgp_emails', user.getPgpEmails)

router.post('/save_new_data', user.saveNewData)

router.post('/check-pwd', user.checkPwd)

router.post('/check-dealer_pin', user.checkDealerPin)

router.put('/delete_CSV_ids/:fieldName', user.deleteCSVids)

router.get('/sync_whiteLabels_ids', user.syncCSVIds)



// =================================================================================
// OFFLINE DEVICES SECTION
router.get('/offline-devices', device.offlineDevices);

router.put('/device-status', device.deviceStatus)

router.put('/update_device_details', user.updateDeviceStatus);


// =================================================================================
// PRICING

router.patch('/save-prices', user.saveIdPrices)

router.patch('/save-package', user.savePackage)

router.patch('/check-package-name', user.checkPackageName)

router.get('/get-prices/:whitelabel_id', user.getPrices)

router.get('/get-packages/:whitelabel_id', user.getPackages)

router.post('/request_for_credits', user.requestCredits)

router.get('/newRequests', user.newRequests)

router.put('/delete_request/:id', user.deleteRequest)

router.put('/accept_request/:id', user.acceptRequest)

// =================================================================================
// Billing

router.get('/get_sales_list', user.getSalesList)
router.get('/get_dealer_list/:labelId', user.getDealerList)


//reporting routes
// router.get('/billing/reports/:reportName', reports.generateReport);
router.post('/billing/reports/product', reports.generateProductReport);
router.post('/billing/reports/hardware', reports.generateHardwareReport);
router.post('/billing/reports/invoice', reports.generateInvoiceReport);
router.post('/billing/reports/payment-history', reports.generatePaymentHistoryReport);
router.post('/billing/reports/sales', reports.generateSalesReport);

module.exports = router;