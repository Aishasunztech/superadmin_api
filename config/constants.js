module.exports = {
	PROJECT_NAME: 'SuperAdmin',
	HOST: "http://localhost:8042",
	SECRET: 'kepitsecretwithauth!@#',
  	EXPIRES_IN: '86400s',

	// SMTP Constants
	SMTP_HOST: 'smtp.office365.com',
	SMTP_PORT: 587,
	SMTP_USERNAME: "admin@lockmesh.com",
	SMTP_PASSWORD: "34e@2!2xder",
	
	SMTP_FROM_EMAIL: "admin@lockmesh.com",
	SMTP_FROM_NAME: "Super Admin",
	SMTP_COMMON_SUBJECT: "Lockmesh.com Team - ",

	// Database Constants
	DB_HOST: "localhost",
	DB_NAME:"lm_superadmin",
	DB_USERNAME: "root",
	DB_PASSWORD: "",
};