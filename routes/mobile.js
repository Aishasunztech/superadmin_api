var express = require('express');
var router = express.Router();

// middleware
var authMiddleware = require('../config/auth');

// controller
var mobile = require('../app/controllers/mobile')

// system control login, secure market login
router.post('/systemlogin', mobile.systemLogin);

router.post('/get-whitelabel', authMiddleware , mobile.getWhiteLabel);

/** Get Apk **/
router.get("/getApk/:apk", mobile.getApk);

router.post('/check_expiry', mobile.checkExpiry)

module.exports = router;