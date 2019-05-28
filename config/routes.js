
// middlewares
var authMiddleware = require('../config/auth');

// routes
var indexRouter = require('../routes/index');
var authRoutes = require('../routes/auth');
var userRoutes = require('../routes/users');
var mobileRoutes = require('../routes/mobile');


module.exports = function (app) {
    app.group('/api/v1', function (router){
        router.use('/auth', authRoutes);
        router.use('/mobile', mobileRoutes);
        router.use('/users', userRoutes);
        // router.use('/', indexRouter);

    })
    // test APIS
    // app.use('/api/v1', router.use('/', indexRouter));
    
    // login API
    // app.user('/api/v1', router.use('/',))

}
