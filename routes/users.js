var express = require('express');
var router = express.Router();

// import controller here
var user = require('../app/controllers/user');
var whitelabel = require('../app/controllers/whitelabel');
var acl = require('../app/controllers/acl');
var device = require('../app/controllers/device');
var apk = require('../app/controllers/apk');
var reports = require('../app/controllers/reports');
var ServiceController = require('../app/controllers/services');

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

router.get('/get-domains/:whitelabel_id', whitelabel.getDomains)

router.delete('/delete-domains/:whitelabel_id', whitelabel.deleteDomains)

router.post('/add-domain', whitelabel.addDomain)

router.put('/edit-domain', whitelabel.editDomain)


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

router.get('/delete-package/:pkg_id', user.deletePackage)

router.patch('/save-hardware', user.saveHardware)
router.get('/delete-hardware/:id', user.deleteHardware)

router.patch('/check-package-name', user.checkPackageName)

router.patch('/check-hardware-name', user.checkHardwareName)

router.get('/get-prices/:whitelabel_id', user.getPrices)

router.get('/get-packages/:whitelabel_id', user.getPackages)

router.get('/get-hardwares/:whitelabel_id', user.getHardwares)
router.post('/edit-hardware', user.editHardware)

router.post('/request_for_credits', user.requestCredits)

router.get('/newRequests', user.newRequests)

router.put('/delete_request/:id', user.deleteRequest)

router.put('/accept_request/:id', user.acceptRequest)

router.post('/add_credits_sale_record', user.addCreditsSaleRecord)

// =================================================================================
// Billing

router.get('/get_sales_list', user.getSalesList)
router.get('/get_dealer_list/:labelId', user.getDealerList)
router.get('/get_device_list/:labelId', user.getDeviceList)


//reporting routes
// router.get('/billing/reports/:reportName', reports.generateReport);
router.post('/billing/reports/product', reports.generateProductReport);
router.post('/billing/reports/hardware', reports.generateHardwareReport);
router.post('/billing/reports/payment-history', reports.generatePaymentHistoryReport);

// Invoice and Sales
router.post('/billing/reports/invoice', reports.generateInvoiceReport);
router.post('/billing/reports/sales', reports.generateSalesReport);
router.post('/billing/reports/grace-days', reports.generateGraceDaysReport);


// =================================================================================
// Services

router.post('/create-service-product', ServiceController.createServiceProduct);

router.post('/generate-random-username', ServiceController.generateRandomUsername);

router.post('/check-unique-pgp', ServiceController.checkUniquePgp);

router.post('/validate_sim_id', ServiceController.validateSimID);


module.exports = router;