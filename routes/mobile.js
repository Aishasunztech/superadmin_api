var express = require('express');
var router = express.Router();

// middleware
var authMiddleware = require('../config/auth');

// controller
var mobile = require('../app/controllers/mobile')

// system control login, secure market login
router.post('/systemlogin', mobile.systemLogin);

/** Get Apk **/
router.get("/getApk/:apk",
    // authMiddleware,
    mobile.getApk
);

router.post('/get-whitelabel', authMiddleware, mobile.getWhiteLabel);

router.post('/check_expiry', mobile.checkExpiry);

router.get('/getUpdate/:version/:uniqueName/:label', authMiddleware, mobile.getUpdate);


module.exports = router;