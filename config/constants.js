const HOST_NAME = process.env.HOST_NAME;
let APP_TITLE = 'SuperAdmin';
let URL = 'http://localhost:8042';

// Database 
let DB_HOST = "localhost";
let DB_NAME = "lm_superadmin"
let DB_USERNAME = 'root';
let DB_PASSWORD = '';

// Email
let SMTP_FROM_EMAIL = "admin@meshguard.co";
let SMTP_FROM_NAME = "SuperAdmin";

if (HOST_NAME) {
	// APP_TITLE = HOST_NAME;
	
	switch (HOST_NAME) {
		case '':
		case 'localhost':
			break;
		case "SuperAdmin":
			URL = 'https://meshguad.co'
			
			// Database
			// DB_HOST = "localhost";
			// DB_NAME = 'lockmesh_db'
			DB_USERNAME = "web";
			DB_PASSWORD = 'Alibaba@40C#'

			// Email
			SMTP_FROM_EMAIL = "admin@lockmesh.com";
			SMTP_FROM_NAME = "SuperAdmin";
			break;
		case 'SuperAdmin Dev':
			URL = 'https://dev.meshguard.co'
			
			// DB_HOST = "localhost";
			// DB_NAME = 'lockmesh_db'
			DB_USERNAME = "web";
			DB_PASSWORD = 'Alibaba@40C#'

			
			// Email
			SMTP_FROM_EMAIL = "admin@lockmesh.com";
			SMTP_FROM_NAME = "SuperAdmin";
			break;
		default:
			break;
	}

}

module.exports = {
	PROJECT_NAME: APP_TITLE,
	HOST: URL,
	SECRET: 'kepitsecretwithauth!@#',
  	EXPIRES_IN: '86400s',

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
	FIXER_API_KEY:'e612b431d585367d58fa7806cdeae2e0',
	BASE_CURRENCY: 'USD'
};