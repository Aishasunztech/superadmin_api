/**
 * Stackify Node APM Configuration
 */

var serverEnv = "localhost";
if (process.env.HOST_NAME) serverEnv = process.env.HOST_NAME;

exports.config = {
	application_name: "SupperAdmin",
	environment_name: serverEnv
};
