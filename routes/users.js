var express = require('express');
var router = express.Router();
// import controller here
var user = require('../app/controllers/user');

/* GET users listing. */
router.get('/white-labels', user.getWhiteLabels);

router.get('/white-labels/:labelId', user.getWhiteLabelInfo);

router.put('/update-white-label', user.updateWhiteLabelInfo);

router.post('/upload/:fieldName', user.uploadFile);

router.post('/import/:fieldName', user.importCSV);

router.get('/get_sim_ids', user.getSimIds)

router.get('/get_chat_ids', user.getChatIds)

router.get('/get_pgp_emails', user.getPgpEmails)

router.get('/get_used_sim_ids', user.getUsedSimIds)

router.get('/get_used_chat_ids', user.getUsedChatIds)

router.get('/get_used_pgp_emails', user.getUsedPgpEmails)

router.get('/whitelabel_backups/:whitelabel_id', user.whitelabelBackups)

router.get('/getFile/:file', user.getFile) 


module.exports = router;