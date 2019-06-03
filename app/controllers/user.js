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