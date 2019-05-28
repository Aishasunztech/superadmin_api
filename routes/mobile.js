var express = require('express');
var router = express.Router();
var mobile = require('../app/controllers/mobile')
var authMiddleware = require('../config/auth');

// system control login, secure market login
router.post('/systemlogin', mobile.systemLogin);

router.post('/get-whitelabel', authMiddleware , mobile.getWhiteLabel);

module.exports = router;