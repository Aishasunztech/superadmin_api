var express = require('express');
var router = express.Router();

// import controller here
var signal = require('../app/controllers/signal');

router.post('/user', signal.checkChatID);

module.exports = router;