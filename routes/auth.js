var express = require('express');
var router = express.Router();
var auth = require('../app/controllers/auth')
/* GET home page. */

router.post('/login', auth.login);

router.post('/white_label_login', auth.wlLogin)

router.post('/verify_code', auth.verifyCode);


module.exports = router;
