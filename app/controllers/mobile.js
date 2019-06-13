// packages libraries
var jwt = require('jsonwebtoken');
var path = require('path');
var fs = require("fs");

// user defined libraries
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');
const constants = require('../../config/constants');
const app_constants = require('../../constants/application');


exports.systemLogin = async function (req, res) {
    let { imei1, imei2, simNo1, simNo2, serial_number, ip, mac_address } = device_helpers.getDeviceInfo(req);
    let device_id = '';

    // if(serial_number === app_constants.PRE_DEFINED_SERIAL_NUMBER){
    //     device_id = await general_helpers.getDeviceId(null, mac_address)
    // } else if(mac_address === app_constants.PRE_DEFINED_MAC_ADDRESS) {
    //     device_id = await general_helpers.getDeviceId(serial_number, null);
    // } else {
    // }

    device_id = await general_helpers.getDeviceId(serial_number, mac_address);

    let addDeviceQ = `INSERT IGNORE into devices (device_id, mac_address, serial_no, ip_address, simno, imei, simno2, imei2) VALUES ('${device_id}', '${mac_address}', '${serial_number}', '${ip}', '', '', '', '')`;
    let device = await sql.query(addDeviceQ);
    if (device) {
        const sysmtemInfo = {
            serial_number, ip, mac_address, device_id
        };

        jwt.sign(
            {
                ...sysmtemInfo
            },
            constants.SECRET,
            {
                expiresIn: constants.EXPIRES_IN
            },
            (err, token) => {
                if (err) {
                    res.json({
                        err: err,
                        status: false,
                        success: false
                    });
                }

                if (token) {

                    res.json({
                        token: token,
                        status: true,
                        success: true
                    });
                    return;
                }
            }
        );
    } else {
        res.json({
            status: false,
            success: false
        });
        return;
    }

}

exports.getWhiteLabel = async function (req, res) {
    if (req.decoded && req.decoded.device_id) {
        let whiteLabelQ = `SELECT id, model_id, name, command_name FROM white_labels WHERE command_name='${req.body.model_id}'`;
        let whiteLabel = await sql.query(whiteLabelQ);
        
        if (Object.keys(whiteLabel).length) {
            
            let whiteLabelAPKQ=`SELECT apk_file, package_name FROM whitelabel_apks WHERE whitelabel_id = ${whiteLabel[0].id}`;
            let whiteLabelAPKS = await sql.query(whiteLabelAPKQ);
         
            res.send({
                status: true,
                apks: whiteLabelAPKS,
                msg: "Whitelabel exist",
                model_id: whiteLabel[0].model_id
            })
        } else {
            res.send({
                status: false,
                msg: ""
            });
        }
    } else {
        res.send({
            status: false,
            msg: ""
        })
    }
}

exports.getApk = async (req, res) => {

    let file = path.join(__dirname, "../../uploads/" + req.params.apk + '.apk');
    if (fs.existsSync(file)) {
        res.sendFile(file);
    } else {
        res.send({
            status: false,
            msg: "file not found"
        })
    }

}

exports.checkExpiry = async (req, res) => {
    console.log(req.body);
    res.send({
        status: true,

    })
}

exports.getUpdate = async (req, res) => {
    let versionName = req.params.version;
    let uniqueName = req.params.uniqueName;
    let label = req.params.label;

    let query = `SELECT * FROM whitelabel_apks WHERE package_name = '${uniqueName}' AND ( label = '${label}' OR label = '' OR label = null)`;
    
    sql.query(query, function (error, response) {

        if (error) {
            res.send({
                success: true,
                status: false,
                msg: "Error in Query"
            });
        }

        let isAvail = false;

        if (Object.keys(response).length) {
            for (let i = 0; i < Object.keys(response).length; i++) {

                if (Number(response[i].version_code) > Number(versionName)) {
                    isAvail = true;
                    res.send({
                        apk_status: true,
                        success: true,
                        apk_url: response[i].apk_file
                    });

                    break;
                }
            }
            if (!isAvail) {
                res.send({
                    apk_status: false,
                    success: true,
                });
            }

        } else {
            res.send({
                apk_status: false,
                success: true,
            });
        }
    })

}