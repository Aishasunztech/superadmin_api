var express = require('express');
var router = express.Router();
// import controller here
var user = require('../app/controllers/user');

// ACL
router.post('/check_component', user.checkComponent);

// ===========================================================================
/* GET users listing. */
router.get('/white-labels', user.getWhiteLabels);

router.get('/white-labels/:labelId', user.getWhiteLabelInfo);

router.put('/update-white-label', user.updateWhiteLabelInfo);

router.post('/upload/:fieldName', user.uploadFile);

router.get('/apklist', user.apklist)

router.post('/checkApkName', user.checkApkName)

router.get('/whitelabel_backups/:whitelabel_id', user.whitelabelBackups)

// ==============================================================================
// apk file
router.post('/uploadApk/:fieldName', user.uploadApk)

router.post('/addApk', user.addApk)

router.post('/apk/delete', user.deleteApk)

router.post('/edit/apk', user.editApk)

// ==============================================================================
// Manage Data
router.post('/import/:fieldName', user.importCSV);

router.get('/export/:fieldName', user.exportCSV);

router.get('/get_sim_ids', user.getSimIds)

router.get('/get_chat_ids', user.getChatIds)

router.get('/get_pgp_emails', user.getPgpEmails)

router.post('/get_label_sim_ids', user.getSimIdsLabel)

router.post('/get_label_chat_ids', user.getChatIdsLabel)

router.post('/get_label_pgp_emails', user.getPgpEmailsLabel)

router.post('/save_new_data', user.saveNewData)
// router.get('/get_used_sim_ids', user.getUsedSimIds)

// router.get('/get_used_chat_ids', user.getUsedChatIds)

// router.get('/get_used_pgp_emails', user.getUsedPgpEmails)

// =================================================================================
// OFFLINE DEVICES SECTION
router.get('/offline-devices', user.offlineDevices);


router.patch('/save-prices', user.saveIdPrices)

router.patch('/save-package', user.savePackage)





module.exports = router;