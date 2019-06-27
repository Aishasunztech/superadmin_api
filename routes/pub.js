
var express = require('express');
var router = express.Router();
var pub = require('../app/controllers/pub');

router.get('/exchange-currency/:toCr', pub.exchangeCurrency)
module.exports = router;