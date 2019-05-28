var jwt = require('jsonwebtoken');
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');

exports.systemLogin = async function (req, res) {
    let { imei1, imei2, simNo1, simNo2, serial_number, ip, mac_address } = device_helpers.getDeviceInfo(req);

    console.log(imei1, imei2, simNo1, simNo2, serial_number, ip, mac_address);
    let device_id = await general_helpers.getDeviceId(serial_number, mac_address);

    console.log("device_id", device_id);

    let addDeviceQ = "INSERT IGNORE into devices (device_id, mac_address, serial_no, ip_address, simno, imei, simno2, imei2) VALUES ('" + device_id + "', '" + mac_address + "', '" + serial_number + "', '" + ip + "', '', '', '', '')"
    let device = await sql.query(addDeviceQ);
    if (device && device.affectedRow) {
        const sysmtemInfo = {
            serial_number, ip, mac_address, device_id
        };

        jwt.sign(
            {
                sysmtemInfo
            },
            config.secret,
            {
                expiresIn: config.expiresIn
            },
            (err, token) => {
                if (err) {
                    res.json({
                        err: err,
                        status: false,
                        success: false
                    });
                } else {

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
    res.status(404).send({

    })
}