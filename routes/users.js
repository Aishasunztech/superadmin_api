var express = require('express');
var router = express.Router();
// import controller here
var user = require('../app/controllers/user');

/* GET users listing. */
router.get('/white-labels', user.getWhiteLabels);

router.get('/white-labels/:labelId', user.getWhiteLabelInfo);

router.post('/upload', user.uploadFile)
module.exports = router;