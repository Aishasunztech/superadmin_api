var express = require('express');
var router = express.Router();

// import controller here
var pgpEmailController = require('../app/controllers/sMail');

router.post('/validate', pgpEmailController.validatePgpEmail);

module.exports = router;