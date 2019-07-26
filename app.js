require("stackify-node-apm");
require('express-group-routes');
var express = require('express');

var app = express();
var multer = require('multer')

var port = process.env.PORT || 8042;
var path = require('path');

var crons = require('./crons/index');

var morgan = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var cors = require('cors');

var swaggerUi = require('swagger-ui-express'),
	swaggerDocument = require('./swagger.json');


var serverEnv = "localhost";
if (process.env.HOST_NAME) serverEnv = process.env.HOST_NAME;
stackify.start({
	apiKey: "8Yl8Cw1Cv4Df8Tl3Jk3Ne1Yf1Qz7Sm2Mn0Aj6An",
	appName: "SupperAdmin",
	env: serverEnv
});
app.use(stackify.expressExceptionHandler);


// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({extended: true}));
// app.use(bodyParser.json({limit: "1000gb"}));
// app.use(bodyParser.urlencoded({limit: "1000gb", extended: false, parameterLimit:100000000}));
app.use(express.json({ limit: "1000gb" }));
app.use(express.urlencoded({ limit: "1000gb", extended: false, parameterLimit: 100000000 }));


//set up our express application
app.use(morgan('dev')); // log every request to the console
app.use(cookieParser()); // read cookies (needed for auth)
// app.use(bodyParser()); // get information from html forms




//view engine setup
app.use(express.static(path.join(__dirname, 'public')));
app.set('views', path.join(__dirname, 'app/views'));
app.set('view engine', 'ejs');

app.options('*', cors());
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

app.get("/itest", function (req, res) {
	console.log("iTest failed successfully!!");
	stackify.log("info", "hey! - iTest failed successfully!!");
	throw new Error("throw new Error - iTest failed successfully!!");
	res.send("iTest failed successfully!!");
});



app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
// app.set(express_group);
require('./routes/index.js')(app);



//launch ======================================================================
app.listen(port);
console.log('The magic happens on port ' + port);

exports = module.exports = app;