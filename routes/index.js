
// middlewares
var authMiddleware = require('../config/auth');
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
var moment = require('moment-strftime');

var crypto = require("crypto");
var md5 = require('md5');

// routes
var authRoutes = require('./auth');
var userRoutes = require('./users');
var mobileRoutes = require('./mobile');
var pub = require('./pub');

// controllers
var user = require('../app/controllers/user');



module.exports = function (app) {
    app.get('/', async function (req, res) {
        res.send("Express Js");
    });

    app.get("/itest", function (req, res) {
        console.log("iTest failed successfully!!");
        stackify.log("info", "hey! - iTest failed successfully!!");
        throw new Error("throw new Error - iTest failed successfully!!");
        res.send("iTest failed successfully!!");
    });

    app.group('/api/v1', function (router) {
        router.use('/auth', authRoutes);
        router.use('/mobile', mobileRoutes);
        router.use('/pub', pub);
        router.get('/users/getFile/:file', user.getFile);
        router.use('/users',
            [
                authMiddleware,
                multipartMiddleware
            ]
            , userRoutes
        );




    });

}
