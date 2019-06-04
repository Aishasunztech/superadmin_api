const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');
const multer = require('multer');
var path = require('path');
var fs = require("fs");

exports.getWhiteLabels = async function (req, res) {

    let whiteLabelsQ = "SELECT id, name, route_uri FROM white_labels";
    let whiteLabels = await sql.query(whiteLabelsQ);
    if (Object.keys(whiteLabels).length) {
        res.send({
            status: true,
            whiteLabels: whiteLabels,
            msg: "data found"
        })
    } else {
        res.send({
            status: false,
            whiteLabels: [],
            msg: "data not found"
        })
    }
}

exports.getWhiteLabelInfo = async function (req, res) {
    let whiteLabelQ = "SELECT id, name, model_id, apk_file,command_name, route_uri FROM white_labels WHERE id =" + req.params.labelId + " limit 1";
    let whiteLabel = await sql.query(whiteLabelQ);
    if (Object.keys(whiteLabel).length) {
        res.send({
            status: true,
            whiteLabel: whiteLabel[0],
            msg: "Data found"
        })
    } else {
        res.send({
            status: false,
            whiteLabel: {},
            msg: "Data not found"
        })
    }
    // res.send(req.params.labelID);
}

exports.uploadFile = async function (req, res) {
    let fileUploaded = false;

    let fileName = "";
    let mimeType = "";
    let fieldName = "";
    let filePath = "";
    let file = req.files.apk;
    
    fieldName = file.fieldName;
    filePath = file.path;
    mimeType = file.type;
    
    if (file.fieldName === 'apk' && mimeType === "application/vnd.android.package-archive") {
        
        fileName = fieldName + '-' + Date.now() + '.apk';
        let target_path = path.join(__dirname, "../../uploads/" + fileName);

        general_helpers.move(filePath, target_path, function(error){
            console.log(error);
            if(error){
                res.send({
                    status: false,
                    msg: "Error while uploading"
                })
            }

            res.send({
                status: true,
                fileName: fieldName
            })
        });

    } else {
        res.send({
            status: false,
            msg: "Error while uploading"
        })
    }
}

exports.updateWhiteLabelInfo = async function (req, res) {
    try {
        let logo = req.body.logo;
        let apk = req.body.apk;
        let apk_name = req.body.name;
        if (!empty(logo) && !empty(apk) && !empty(apk_name)) {

            let file = path.join(__dirname, "../uploads/" + apk);
            if (fs.existsSync(file)) {
                let versionCode = '';
                let versionName = '';
                let packageName = '';
                let label = '';
                let details = '';

                versionCode = await helpers.getAPKVersionCode(file);
                if (versionCode) {
                    versionName = await helpers.getAPKVersionName(file);
                    if (!versionName) {
                        versionName = ''
                    }
                    packageName = await helpers.getAPKPackageName(file);
                    if (!packageName) {
                        packageName = '';
                    }
                    label = await helpers.getAPKLabel(file);
                    if (!label) {
                        label = ''
                    }
                } else {
                    versionCode = '';
                }

                versionCode = versionCode.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                versionName = versionName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                packageName = packageName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                // label = label.replace(/(\r\n|\n|\r)/gm, "");
                details = details.replace(/(\r\n|\n|\r)/gm, "");
                // console.log("versionName", versionName);
                // console.log("pKGName", packageName);
                // console.log("version Code", versionCode);
                console.log("label", label);
                // console.log('detai')

                // let apk_type = (verify.user.user_type === AUTO_UPDATE_ADMIN) ? 'permanent' : 'basic'

                let apk_stats = fs.statSync(file);

                let formatByte = helpers.formatBytes(apk_stats.size);
                // console.log("update apk_details set app_name = '" + apk_name + "', logo = '" + logo + "', apk = '" + apk + "', version_code = '" + versionCode + "', version_name = '" + versionName + "', package_name='" + packageName + "', details='" + details + "', apk_byte='" + apk_stats.size + "',  apk_size='"+ formatByte +"'  where id = '" + req.body.apk_id + "'");

                sql.query("update apk_details set app_name = '" + apk_name + "', logo = '" + logo + "', apk = '" + apk + "', version_code = '" + versionCode + "', version_name = '" + versionName + "', package_name='" + packageName + "', details='" + details + "', apk_bytes='" + apk_stats.size + "',  apk_size='" + formatByte + "'  where id = '" + req.body.apk_id + "'", function (err, rslts) {

                    if (err) throw err;
                    data = {
                        status: true,
                        msg: "Record Updated"

                    };
                    res.send(data);
                    return;
                });


            } else {
                data = {
                    status: false,
                    msg: "Error While Uploading"
                };
                res.send(data);
                return;
            }

        } else {
            data = {
                status: false,
                msg: "Error While Uploading"
            };
            res.send(data);
            return;
        }
    } catch (error) {
        data = {
            status: false,
            msg: "Error while Uploading",
        };
        res.send(data);
        return;
    }
}