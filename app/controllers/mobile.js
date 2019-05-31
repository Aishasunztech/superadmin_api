var jwt = require('jsonwebtoken');
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');
const constants = require('../../config/constants')
var path = require('path');
var fs = require("fs");

exports.systemLogin = async function (req, res) {
    let { imei1, imei2, simNo1, simNo2, serial_number, ip, mac_address } = device_helpers.getDeviceInfo(req);

    let device_id = await general_helpers.getDeviceId(serial_number, mac_address);

    let addDeviceQ = "INSERT IGNORE into devices (device_id, mac_address, serial_no, ip_address, simno, imei, simno2, imei2) VALUES ('" + device_id + "', '" + mac_address + "', '" + serial_number + "', '" + ip + "', '', '', '', '')"
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
        let whiteLabelQ = "SELECT * FROM white_labels WHERE model_id='" + req.body.model_id + "'";
        let whiteLabel = await sql.query(whiteLabelQ);
        if (Object.keys(whiteLabel).length) {

            res.send({
                status: true,
                apk: whiteLabel[0].apk_file,
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
        console.log("checking", file);

        res.sendFile(file);
    } else {
        res.send({
            status: false,
            msg: "file not found"
        })
    }

}