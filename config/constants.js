
var HOST_NAME = process.env.HOST_NAME;
var APP_ENV = process.env.APP_ENV;

var APP_TITLE = 'SuperAdmin';
var URL = 'http://localhost:8042';

// App Credentials
var USERNAME = '';
var PASSWORD = '';

// Database 
var DB_HOST = "localhost";
var DB_NAME = "lm_superadmin"
var DB_USERNAME = 'root';
var DB_PASSWORD = '';

// Email
var SMTP_FROM_EMAIL = "admin@meshguard.co";
var SMTP_FROM_NAME = "SuperAdmin";

// PGP Mail Server
var PGP_SERVER_HOST = 'https://smail.lockmesh.com/'
var PGP_SERVER_URL = PGP_SERVER_HOST + 'api/v1';
var PGP_SERVER_KEY = 'Token 29bba6e2fef984ff98e568b602e4aef215dd4b3e';

// Twilio account CREDENTIALS
const accountSid = 'AC2383c4b776efb51c86cc6f9a5cdb4e89';
const authToken = '8f09f2ebc98338bff27e0ac73ea71a23';
var twilioClient = require('twilio')(accountSid, authToken);

if (HOST_NAME) {
	// APP_TITLE = HOST_NAME;

	switch (HOST_NAME) {

		case "SuperAdmin": {
			URL = 'https://sa.lockmesh.com'

			// Database
			// DB_HOST = "localhost";
			// DB_NAME = 'lockmesh_db'
			DB_USERNAME = "web";
			DB_PASSWORD = 'Alibaba@40C#'

			// Email
			SMTP_FROM_EMAIL = "admin@lockmesh.com";
			SMTP_FROM_NAME = "SuperAdmin";
			break;
		}

		case 'SuperAdmin Dev': {
			URL = 'https://devsa.lockmesh.com'

			// DB_HOST = "localhost";
			// DB_NAME = 'lockmesh_db'
			DB_USERNAME = "web";
			DB_PASSWORD = 'Alibaba@40C#'


			// Email
			SMTP_FROM_EMAIL = "admin@lockmesh.com";
			SMTP_FROM_NAME = "SuperAdmin";
			break;
		}
		default:
			break;
	}

} else {
	HOST_NAME = 'localhost',
		APP_ENV = 'local'
}

module.exports = {
	APP_TITLE: APP_TITLE,
	HOST_NAME: HOST_NAME,
	APP_ENV: APP_ENV,
	HOST: URL,
	SECRET: 'keepItSecretWithAuth!@#',
	// EXPIRES_IN: '86400s',
	EXPIRES_IN: '10800s',
	PORT: 8042,

	// APP Credentials
	USERNAME: USERNAME,
	PASSWORD: PASSWORD,

	// SMTP Constants
	SMTP_HOST: 'smtp.office365.com',
	SMTP_PORT: 587,
	SMTP_USERNAME: "admin@lockmesh.com",
	SMTP_PASSWORD: "34e@2!2xder",

	SMTP_FROM_EMAIL: SMTP_FROM_EMAIL,
	SMTP_FROM_NAME: SMTP_FROM_NAME,
	SMTP_COMMON_SUBJECT: `${APP_TITLE} - `,

	// Database Constants
	DB_HOST: DB_HOST,
	DB_NAME: DB_NAME,
	DB_USERNAME: DB_USERNAME,
	DB_PASSWORD: DB_PASSWORD,

	// Fixer API key
	FIXER_API_KEY: 'e612b431d585367d58fa7806cdeae2e0',
	BASE_CURRENCY: 'USD',

	// PGP Mail Server
	PGP_SERVER_HOST: PGP_SERVER_HOST,
	PGP_SERVER_URL: PGP_SERVER_URL,
	PGP_SERVER_KEY: PGP_SERVER_KEY,
	twilioClient: twilioClient
};