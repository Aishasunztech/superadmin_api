const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');
const multer = require('multer');

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
    let whiteLabelQ = "SELECT id, name, model_id, apk_file, route_uri FROM white_labels WHERE id =" + req.params.labelId + " limit 1";
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

    let filename = "";
    let mimeType = "";
    let fieldName = "";
    // console.log(req.files.apk);
    let packagename = await general_helpers.getAPKPackageName(req.files.apk.path);
    console.log(packagename);
    // var storage = multer.diskStorage({
    //     destination: function (req, file, callback) {
    //         callback(null, '../../uploads');
    //     },

    //     filename: function (req, file, callback) {
    //         mimeType = file.mimetype;
    //         fieldName = file.fieldname;
    //         var filetypes = /jpeg|jpg|apk|png/;
    //         // let type = mime.getExtension(file.)
    //         // console.log('files', file.path);

    //         // let data = fs.readFile(file.path, function () {

    //         // });
    //         // console.log("file", data);

    //         // if (fieldName === Constants.LOGO && filetypes.test(mimeType)) {
    //         //     fileUploaded = true;
    //         //     filename = fieldName + '-' + Date.now() + '.jpg';

    //         //     callback(null, filename);
    //         // } else if (fieldName === Constants.APK && mimeType === "application/vnd.android.package-archive") {
    //         //     fileUploaded = true;
    //         //     filename = fieldName + '-' + Date.now() + '.apk';
    //         //     // apk manifest should be check here
    //         //     // helpers.getAPKVersionCode(req.files.apk);
    //         //     callback(null, filename);
    //         // } else {
    //         //     callback("file not supported");
    //         // }
    //     }
    // });

    // var upload = multer({
    //     storage: storage,
    //     limits: { fileSize: "100mb" }
    // }).fields(
    //     [
    //         {
    //             name: 'logo',
    //             maxCount: 1
    //         }, 
    //         {
    //             name: 'apk',
    //             maxCount: 1
    //         },
    //         // {
    //         //     name: ""
    //         // }
    //     ]
    // );

    // upload(req, res, async function (err) {
    //     if (err) {
    //         return res.send({
    //             status: false,
    //             msg: "Error while Uploading"
    //         });
    //     }

    //     if (fileUploaded) {

    //         if (fieldName === Constants.APK) {
    //             let file = path.join(__dirname, "../uploads/" + filename);
    //             let versionCode = await helpers.getAPKVersionCode(file);
    //             console.log("version code", versionCode);
    //             let apk_stats = fs.statSync(file);

    //             let formatByte = helpers.formatBytes(apk_stats.size);
    //             if (versionCode) {

    //                 data = {
    //                     status: true,
    //                     msg: 'Uploaded Successfully',
    //                     fileName: filename,
    //                     size: formatByte

    //                 };
    //                 res.send(data);
    //                 return;
    //             } else {
    //                 data = {
    //                     status: false,
    //                     msg: "Error while Uploading",
    //                 };
    //                 res.send(data);
    //                 return;
    //             }
    //         } else if (fieldName === Constants.LOGO) {
    //             data = {
    //                 status: true,
    //                 msg: 'Uploaded Successfully',
    //                 fileName: filename,
    //             };
    //             res.send(data);
    //             return;
    //         } else {
    //             data = {
    //                 status: false,
    //                 msg: "Error while Uploading"
    //             }
    //             res.send(data);
    //             return;
    //         }
    //     } else {
    //         data = {
    //             status: false,
    //             msg: "Error while Uploading",
    //         };
    //         res.send(data);
    //         return;
    //     }
    // });
}