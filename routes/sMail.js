var express = require('express');
var router = express.Router();

// middleware
var authMiddleware = require('../config/auth');

// import controller here
var pgpEmailController = require('../app/controllers/sMail');

router.post('/validate', pgpEmailController.validatePgpEmail);

router.put('/status', authMiddleware, pgpEmailController.disablePgpEmail);

module.exports = router;