var express = require('express');
var router = express.Router();
var datetime = require('node-datetime');
// var moment = require('moment');
// import ADMIN from "../constants/Application";
var { sql } = require('../config/database');

var moment = require('moment-strftime');
var app_constants = require('../constants/application');
const device_helpers = require('./device_helpers');
var util = require('util')
const exec = util.promisify(require('child_process').exec);

var ApkReader = require('node-apk-parser');

var md5 = require('md5');
var randomize = require('randomatic'); 
const mysql_import = require('mysql-import');
var path = require('path');
var fs = require('fs');

const mysql = require('mysql');


module.exports = {
	// secure helpers
	getDBCon: async function (host, dbUser, dbPass, dbName) {
		const sqlPool = mysql.createPool({
			//connectionLimit: 1000,
			//connectTimeout: 60 * 60 * 1000,
			//aquireTimeout: 60 * 60 * 1000,
			//timeout: 60 * 60 * 1000,

			host: host,
			user: dbUser,
			password: dbPass,
			database: dbName,

			supportBigNumbers: true,
			bigNumberStrings: true,
			dateStrings: true
		});


		sqlPool.getConnection((err, connection) => {
			if (err) {
				if (err.code === 'PROTOCOL_CONNECTION_LOST') {
					console.error('Database connection was closed.')
					return false;
				}

				if (err.code === 'ER_CON_COUNT_ERROR') {
					console.error('Database has too many connections.')
					return false;
				}

				if (err.code === 'ECONNREFUSED') {
					console.error('Database connection was refused.')
					return false;
				}
			}
			if (connection) connection.release()
			return
		});

		sqlPool.query = util.promisify(sqlPool.query); // Magic happens here.
		return sqlPool;
	},

	// ACL helpers functions
	isAdmin: async function (userId) {
		var query1 = `SELECT type FROM dealers where dealer_id = ${userId}`;
		var user = await sql.query(query1);
		if (user.length) {
			var query2 = `SELECT * FROM user_roles where id =${user[0].type} and role='admin'`;
			var role = await sql.query(query2);
			if (role.length) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	},
	getUserType: async function (userId) {
		var query1 = `SELECT type FROM dealers where dealer_id = ${userId}`;
		var user = await sql.query(query1);
		if (user.length) {
			var query2 = "SELECT * FROM user_roles where id =" + user[0].type;
			var role = await sql.query(query2);
			if (role.length) {
				return role[0].role;
			} else {
				return false;
			}
		} else {
			return false;
		}
	},
	getUserTypeId: async function (userId) {
		var query1 = "SELECT type FROM admins as user left join user_roles as role on( role.id = user.type) where user.id =" + userId;
		// console.log(query1);

		var user = await sql.query(query1);
		if (user.length) {
			return user[0].type;

		} else {
			return false;
		}
	},
	getUserTypeByTypeId: async function (userTypeId) {
		var query2 = "SELECT * FROM user_roles where id =" + userTypeId;
		var role = await sql.query(query2);
		if (role.length) {
			return role[0].role;
		} else {
			return false;
		}

	},
	getDealerTypeIdByName: async function (dealerType) {
		var query = "SELECT * FROM user_roles where role ='" + dealerType + "' and role!='admin'";
		var dType = await sql.query(query);
		if (dType.length) {
			return dType[0].id;
		}
	},
	getAllUserTypes: async function () {
		var query = "SELECT * FROM user_roles";
		var userRoles = await sql.query(query);
		return userRoles;
	},
	getAllComponents: async function () {
		var query = "SELECT * FROM acl_modules";
		var aclModules = await sql.query(query);
		return aclModules;
	},
	getComponentId: async function (componentId) {
		var component = await sql.query("SELECT * FROM acl_modules where id =" + componentId);
		if (component.length) {
			return component[0].id;
		} else {
			return false;
		}
	},
	getComponentIdByName: async function (componentName) {
		var component = await sql.query("SELECT * FROM acl_modules WHERE component ='" + componentName + "'");
		if (component.length) {
			return component[0].id;
		} else {
			return false;
		}
	},
	getComponentIdByUri: async function (componentUri) {
		// console.log(componentUri);

		if (componentUri.includes("/connect-device/")) {
			componentUri = "/connect-device/:deviceId";
		}
		// console.log(componentUri);

		var component = await sql.query("SELECT * FROM acl_modules WHERE uri ='" + componentUri + "' ");
		// console.log("SELECT * FROM acl_modules WHERE uri ='" + componentUri + "' ");
		if (component.length) {
			// console.log("hello", component);
			return component[0];
		} else {
			return false;
		}
	},
	getActionId: async function (actionId) {
		var component = await sql.query("SELECT * FROM acl_module_actions where id =" + actionId);
		if (component.length) {
			return component[0].id;
		} else {
			return false;
		}
	},
	getAllComponentActions: async function (componentId) {
		var query = "SELECT * FROM acl_module_actions where component_id =" + componentId;
		var actions = await sql.query(query);
		return actions;
	},
	isLoginRequired: async function (componentId) {
		var query = "SELECT * FROM acl_modules where id =" + componentId;
		var component = await sql.query(query);
		if (component.length) {
			if (component[0].login_required == 1) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	},
	isAllowedComponent: async function (componentId, userId) {
		var role = await this.getUserTypeId(userId);
		var component = await this.getComponentId(componentId);
		if (role && component) {
			var query = "SELECT * FROM acl_module_to_user_roles where user_role_id =" + role + " and component_id =" + component;
			var isComponent = await sql.query(query);
			if (isComponent.length) {
				return true;
			} else {
				return false;
			}
		} else {
			false;
		}
		//var component = await sql.query("SELECT * FROM acl_modules where id ="+ componentId);
	},
	isAllowedComponentByName: async function (componentName, userId) {
		var role = await this.getUserTypeId(userId);
		var component = await this.getComponentIdByUri(componentName);
		if (role && component) {
			var query = "SELECT * FROM acl_module_to_user_roles where user_role_id =" + role + " and component_id =" + component;
			var isComponent = await sql.query(query);
			if (isComponent.length) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
		//var component = await sql.query("SELECT * FROM acl_modules where id ="+ componentId);
	},
	isAllowedComponentByUri: async function (componentUri, userId) {
		// console.log(componentUri);

		var role = await this.getUserTypeId(userId);
		// console.log(role);
		var component = await this.getComponentIdByUri(componentUri);
		// console.log(component);
		if (role && component) {
			// console.log("hello hello hello");
			// console.log(component);

			if (component.login_required == 0) {
				return true;
			}

			var query = "SELECT * FROM acl_module_to_user_roles where user_role_id =" + role + " and component_id =" + component.id;
			var isComponent = await sql.query(query);
			if (isComponent.length) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
		//var component = await sql.query("SELECT * FROM acl_modules where id ="+ componentId);
	},
	isAllowedAction: async function (componentId, actionId, userId) {

	},
	getuserTypeIdByName: async function (userType) {
		console.log(userType);
		var query = "SELECT * FROM user_roles where role ='" + userType + "'";
		var dType = await sql.query(query);
		if (dType.length) {
			return dType[0].id;
		} else {
			return false;
		}
	},

	getAdminStatus: (admin) => {
		if ((admin.account_status === '' || admin.account_status === null) && (admin.unlink_status === 0)) {
			return app_constants.ADMIN_ACTIVE;
		} else if (admin.unlink_status === 1) {
			return app_constants.ADMIN_UNLINKED;
		} else if (admin.account_status === 'suspended') {
			return app_constants.ADMIN_SUSPENDED;
		} else {
			return 'N/A';
		}
	},


	//Helper function to get unique device_id in format like "ASGH457862" 
	getDeviceId: async function (sn, mac) {

		var key = md5(sn + mac);

		var num = "";
		var str = "";

		for (i = 0; i < key.length; i++) {

			if (isNaN(key[i])) {
				if (str.length < 4) {
					str += key[i];
				}
			} else {
				if (num.length < 6) {
					num += key[i];
				}
			}
		}
		var deviceId = str.toUpperCase() + num;
		return deviceId;
	},
	getSuperAdminDvcId: async function (sn, mac) {

		var key = md5(sn + mac);

		var num = "";

		for (i = 0; i < key.length; i++) {

			if (!isNaN(key[i])) {
				if (num.length < 6) {
					num += key[i];
				}

			}
		}
		var deviceId = "OF" + num;
		return deviceId;
	},
	getExpDateByMonth: function (currentDate, expiryMonth) {
		return moment(currentDate, "YYYY-MM-DD").add(expiryMonth, 'M').strftime("%Y/%m/%d");
	},
	validateEmail: (email) => {
		var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(String(email).toLowerCase());
	},


	// APK helpers
	// windows
	getWindowAPKPackageNameScript: async (filePath) => {
		try {
			let cmd = "aapt dump badging " + filePath + " | findstr /C:\"package: name\"";
			const { stdout, stderr, error } = await exec(cmd);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}
			if (stderr) {
				return false;
			}
			if (stdout) {
				let array = stdout.split(' ');
				let packageName = array[1].split('=');
				return (packageName[1]) ? packageName[1].replace(/\'/g, '') : false;
			}
			return false;
		} catch (error) {
			return false;
		}

	},
	getWindowAPKVersionCodeScript: async (filePath) => {
		try {
			let cmd = "aapt dump badging " + filePath + " | findstr /C:\"package: name\"";
			// console.log(cmd);
			const { stdout, stderr, error } = await exec(cmd);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}
			if (stderr) {
				return false;
			}
			if (stdout) {
				let array = stdout.split(' ');
				let versionCode = array[2].split('=');
				return (versionCode[1]) ? versionCode[1].replace(/\'/g, '') : false;
			}
			return false;
		} catch (error) {
			return false;
		}
	},
	getWindowAPKVersionNameScript: async (filePath) => {
		try {
			let cmd = "aapt dump badging " + filePath + " | findstr /C:\"package: name\"";
			console.log(cmd);
			const { stdout, stderr, error } = await exec(cmd);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}
			if (stderr) {
				return false;
			}
			if (stdout) {
				let array = stdout.split(' ');
				let versionName = array[2].split('=');
				return (versionName[1]) ? versionName[1].replace(/\'/g, '') : false;
			}
			return false;
		} catch (error) {
			return false;
		}
	},
	getWindowAPKLabelScript: async function (filePath) {
		try {
			let cmd = "aapt dump badging " + filePath + " | findstr /C:\"application:\"";
			const { stdout, stderr, error } = await exec(cmd);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}
			if (stderr) {
				return false;
			}
			if (stdout) {
				let array = stdout.split(' ');
				console.log("arr", array);
				let label = array[1].split('=');
				console.log("label", label);

				return (label[1]) ? label[1].replace(/\'/g, '') : false;
			}
			return false;
		} catch (error) {
			return false;
		}
	},

	// linux scripts
	getAPKPackageNameScript: async function (filePath) {
		try {
			let packageName = "aapt list -a " + filePath + " | awk -v FS='\"' '/package=/{print $2}'";
			const { stdout, stderr, error } = await exec(packageName);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}
			if (stderr) {
				return false;
			}
			if (stdout) {
				return stdout;
			}
			return false;
		} catch (error) {
			return await this.getWindowAPKPackageNameScript(filePath);
		}

	},
	getAPKVersionCodeScript: async function (filePath) {
		try {
			let versionCode = "aapt dump badging " + filePath + " | grep \"versionCode\" | sed -e \"s/.*versionCode='//\" -e \"s/' .*//\"";
			const { stdout, stderr, error } = await exec(versionCode);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);

			if (error) {
				return false;
			}

			if (stderr) {
				return false;
			}
			if (stdout) {
				return stdout;
			}
			return false;
		} catch (error) {
			return await this.getWindowAPKVersionCodeScript(filePath);
		}

	},
	getAPKVersionNameScript: async function (filePath) {
		try {
			let versionName = "aapt dump badging " + filePath + " | grep \"versionName\" | sed -e \"s/.*versionName='//\" -e \"s/' .*//\"";
			const { stdout, stderr, error } = await exec(versionName);
			// console.log('stdout:', stdout);
			// console.log('stderr:', stderr);
			if (error) {
				return false;
			}

			if (stderr) {
				return false
			}
			if (stdout) {
				return stdout;
			}
			return false;
		} catch (error) {
			return await this.getWindowAPKVersionNameScript(filePath);
		}

	},
	getAPKLabelScript: async function (filePath) {
		try {
			let label = "aapt dump badging " + filePath + " | grep \"application\" | sed -e \"s/.*label='//\" -e \"s/' .*//\""
				;
			const { stdout, stderr, error } = await exec(label);
			console.log('stdout:', stdout);
			console.log('stderr:', stderr);
			if (error) {
				return false;
			}

			if (stderr) {
				return false
			}
			if (stdout) {
				let array = stdout.split(/\r?\n/);
				let label = array[0].split(':');

				return (label[1]) ? label[1].replace(/\'/g, '') : false;

			}
			return false;

		} catch (error) {
			return await this.getWindowAPKLabelScript(filePath);
		}
	},

	// Getting APK
	getAPKPackageName: async function (filePath) {
		try {
			var reader = ApkReader.readFile(filePath);
			var manifest = reader.readManifestSync();
			let res = JSON.parse(JSON.stringify(manifest));
			return res.package

		} catch (error) {
			return await this.getAPKPackageNameScript(filePath);
		}
	},
	getAPKVersionCode: async function (filePath) {
		try {
			var reader = ApkReader.readFile(filePath);
			var manifest = reader.readManifestSync();
			// console.log("manifest", manifest);
			// let apk = util.inspect(manifest, {depth:null});
			let res = JSON.parse(JSON.stringify(manifest));
			return res.versionCode
		} catch (e) {
			return await this.getAPKVersionCodeScript(filePath);
		}

	},
	getAPKVersionName: async function (filePath) {
		try {
			var reader = ApkReader.readFile(filePath);
			var manifest = reader.readManifestSync();
			let res = JSON.parse(JSON.stringify(manifest));
			return res.versionName;
		} catch (e) {
			return await this.getAPKVersionNameScript(filePath);
		}

	},
	getAPKDetails: async function (filePath) {
		try {
			var reader = ApkReader.readFile(filePath);
			var manifest = reader.readManifestSync();
			// let apk = util.inspect(manifest, {depth:null});
			let res = JSON.parse(JSON.stringify(manifest));
			return res;
		} catch (e) {
			throw (e);
		}

	},
	getAPKLabel: async function (filePath) {
		return await this.getAPKLabelScript(filePath)
	},
	formatBytes: function (bytes, decimals = 2) {
		if (bytes === 0) return '0 Bytes';

		const k = 1024;
		const dm = decimals < 0 ? 0 : decimals;
		const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

		const i = Math.floor(Math.log(bytes) / Math.log(k));


		return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
	},
	bytesToSize: function (bytes) {
		var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
		if (bytes == 0) return '0 Byte';
		var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
		return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
	},


	// Login Helpers
	saveAdminLogin: async function (user, loginClient, type, status) {
		let insertQ = "INSERT INTO login_history ";
		let commonFields = " token, expiresin, ip_address, logged_in_client, type, status ";
		let values = " VALUES ( ";
		let commonValues = " '" + user.token + "', '" + user.expiresIn + "', '" + user.ip_address + "', '" + loginClient + "', '" + type + "', " + status + " ";

		if (loginClient === app_constants.DEVICE) {
			if (type === app_constants.SOCKET) {
				insertQ = insertQ + " (device_id, socket_id, " + commonFields + " ) ";
				values = values + " '" + user.device_id + "', '" + user.socket_id + "', " + commonValues + " ) "
			} else if (type === Constants.TOKEN) {
				insertQ = insertQ + " (device_id, " + commonFields + " ) ";
				values = values + " '" + user.device_id + "', " + commonValues + " ) ";
			}
		} else {
			if (type === app_constants.SOCKET) {
				insertQ = insertQ + " (user_id, socket_id, " + commonFields + " ) ";
				values = values + " '" + user.id + "', '" + user.socket_id + "', " + commonValues + " ) "
			} else if (type === app_constants.TOKEN) {
				insertQ = insertQ + " (user_id, " + commonFields + " ) ";
				values = values + " '" + user.id + "', " + commonValues + " ) ";
			}
		}
		await sql.query(insertQ + values)
	},
	getLoginByToken: async function (token) {
		let loginQ = "SELECT * from login_history WHERE token ='" + token + "'";
		let res = await sql.query(loginQ);
		if (res.length) {
			return res[0];
		} else {
			return false;
		}
	},
	getLoginByDealerID: async function (dealerId) {
		let loginQ = "SELECT * from login_history WHERE dealer_id ='" + dealerId + "'";
		let res = await sql.query(loginQ);
		// console.log("resrserse", res);
		if (res.length) {
			return res[0];
		} else {
			return false;
		}
	},
	getLoginByDeviceID: async function (deviceId) {
		let loginQ = "SELECT * from login_history WHERE device_id ='" + deviceId + "'";
		let res = await sql.query(loginQ);
		if (res.length) {
			return res[0];
		} else {
			return false;
		}
	},
	expireLoginByToken: async function (token) {
		let loginQ = "UPDATE login_history SET status=0 WHERE token='" + token + "'";
		sql.query(loginQ);
	},
	expireAllLogin: async function () {
		let loginQ = "UPDATE login_history SET status=0";
		sql.query(loginQ);
	},

	// General Helpers
	checkValue: (value) => {
		if (value !== undefined && value !== '' && value !== null && value !== 'undefined' && value !== 'Undefined' && value !== "UNDEFINED" && value !== 'null' && value !== 'Null' && value !== 'NULL') {
			return value;
		} else {
			return 'N/A';
		}
	},
	move: (oldPath, newPath, callback) => {

		fs.rename(oldPath, newPath, function (err) {
			if (err) {
				if (err.code === 'EXDEV') {
					copy();
				} else {
					callback(err);
				}
				return;
			}
			callback();
		});

		function copy() {
			var readStream = fs.createReadStream(oldPath);
			var writeStream = fs.createWriteStream(newPath);

			readStream.on('error', callback);
			writeStream.on('error', callback);

			readStream.on('close', function () {
				fs.unlink(oldPath, callback);
			});

			readStream.pipe(writeStream);
		}
	},
	resetDB: function () {
		var importer1 = mysql_import.config({
			host: 'localhost',
			user: 'root',
			password: '',
			database: 'mydb',
			onerror: err => console.log(err.message)
		});
		let sqlFile = path.join(__dirname + '/../_DB/reset_db.sql');
		importer1.import(sqlFile).then(() => {
			console.log('DB1 has finished importing')
		});
	},
	formatBytes: function (bytes, decimals = 2) {
		if (bytes === 0) return '0 Bytes';

		const k = 1024;
		const dm = decimals < 0 ? 0 : decimals;
		const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

		const i = Math.floor(Math.log(bytes) / Math.log(k));


		return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
	}
}