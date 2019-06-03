require('express-group-routes');
var express = require('express');

var app = express();
var multer = require('multer')

var port = process.env.PORT || 8042;
var path = require('path');

var morgan = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var bodyParser = require('body-parser');
var dateFormat = require('dateformat');
var now = new Date();
var cors = require('cors');

var swaggerUi = require('swagger-ui-express'),
swaggerDocument = require('./swagger.json');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

//set up our express application
app.use(morgan('dev')); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)
// app.use(bodyParser()); // get information from html forms


app.use(express.json({ limit: "1000gb" }));
app.use(express.urlencoded({ limit: "1000gb", extended: false, parameterLimit: 100000000 }));


//view engine setup
app.use(express.static(path.join(__dirname, 'public')));
app.set('views', path.join(__dirname, 'app/views'));
app.set('view engine', 'ejs');

app.use(cors("*"));
app.use(function (req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
	res.header('Accept-Encoding', 'gzip,sdch');
	if (req.method === 'OPTIONS') {
		res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
		res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH');
		return res.status(200).json({});
	};
    
	next();
});
// routes ======================================================================
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
// app.set(express_group);
require('./config/routes.js')(app); 



//launch ======================================================================
app.listen(port);
console.log('The magic happens on port ' + port);

//catch 404 and forward to error handler
// app.use(function (req, res, next) {
//     res.status(404).render('404', {title: "Sorry, page not found"});
// });

// app.use(function (req, res, next) {
//     res.status(500).render('404', {title: "Sorry, page not found"});
// });

exports = module.exports = app;