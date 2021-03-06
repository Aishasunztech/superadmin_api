// Libraries
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
var moment = require('moment-strftime');
var axios = require('axios');

var crypto = require("crypto");
var md5 = require('md5');

// routes
var authRoutes = require('./auth');
var userRoutes = require('./users');
var mobileRoutes = require('./mobile');
var pub = require('./pub');
var signal = require('./signal');
var sMailRoutes = require('./sMail');

// middleware
var authMiddleware = require('../config/auth');

// var constants = require('../config/constants');

// controllers
var user = require('../app/controllers/user');

// helpers
const general_helpers = require('../helpers/general_helpers');

module.exports = function (app) {
    app.get('/', async function (req, res) {
        res.send("Express.js")
    });

    app.group('/api/v1', function (router) {
        router.use('/auth', authRoutes);
        router.use('/mobile', mobileRoutes);
        router.use('/pub', pub);
        router.use('/signal', signal);
        router.use('/s-mail', sMailRoutes);

        router.get('/users/getFile/:file', user.getFile);
        router.get('/users/getBackupFile/:file', user.getBackupFile);
        router.use('/users', [authMiddleware, multipartMiddleware], userRoutes);

    });

    app.group('/v1', function (router) {
        router.use('/auth', authRoutes);
        router.use('/mobile', mobileRoutes);
        router.use('/pub', pub);
        router.use('/signal', signal);
        router.use('/s-mail', sMailRoutes);

        router.get('/users/getFile/:file', user.getFile);
        router.get('/users/getBackupFile/:file', user.getBackupFile);
        router.use('/users', [authMiddleware, multipartMiddleware], userRoutes);

    });
}
