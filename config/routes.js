
// middlewares
var authMiddleware = require('../config/auth');
var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();
var crypto = require("crypto");
var md5 = require('md5');

// routes
var indexRouter = require('../routes/index');
var authRoutes = require('../routes/auth');
var userRoutes = require('../routes/users');
var mobileRoutes = require('../routes/mobile');


module.exports = function (app) {
    app.get('/', function (req, res) {
        res.send("Express Js");
    });
    app.group('/api/v1', function (router) {
        router.use('/auth', authRoutes);
        router.use('/mobile', mobileRoutes);

        // router.use('/users',
        //     [
        //         authMiddleware,
        //         multipartMiddleware
        //     ]
        //     , userRoutes
        // );

        router.use('/users',
            [
                // authMiddleware,
                multipartMiddleware
            ]
            , userRoutes
        );

        // router.use('/', indexRouter);
        router.get('/', function (req, res) {

        });

    });

}
