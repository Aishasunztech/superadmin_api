const { sql } = require('../../config/database');
const multer = require('multer');
var path = require('path');
var fs = require("fs");
var mime = require('mime');
var XLSX = require('xlsx');
var empty = require('is-empty');
var mime = require('mime');
const axios = require('axios');
var md5 = require('md5');

const Constants = require('../../constants/application');
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const moment = require('moment')
// const fs = require("fs");

const { createInvoice } = require('../../helpers/CreateInvoice')

const smtpTransport = require('../../helpers/mail')

function sendEmail(subject, message, to, callback) {
    let cb = callback;
    subject = "Super Admin Team - " + subject
    let mailOptions = {
        from: "admin@lockmesh.com",
        to: to,
        subject: subject,
        html: message
    };
    // console.log("hello smtp", smtpTransport);
    smtpTransport.sendMail(mailOptions, cb);
}

// export CSV 
exports.exportCSV = async function (req, res) {

    // var verify = await verifyToken(req, res);
    // if (verify['status'] !== undefined && verify.status === true) {
    let fieldName = req.params.fieldName;
    // if (verify.user.user_type === ADMIN) {
    let query = '';
    if (fieldName === "sim_ids") {
        query = "SELECT * FROM sim_ids";
    } else if (fieldName === "chat_ids") {
        query = "SELECT * FROM chat_ids"
    } else if (fieldName === "pgp_emails") {
        query = "SELECT * FROM pgp_emails";
    }
    sql.query(query, async (error, response) => {
        if (error) throw error;
        if (response.length) {
            var data = [];

            if (fieldName === "sim_ids") {
                response.forEach((sim_id) => {
                    data.push({
                        sim_id: sim_id.sim_id,
                        start_date: sim_id.start_date,
                        expiry_date: sim_id.expiry_date
                    });
                });
            } else if (fieldName === "chat_ids") {
                response.forEach((chat_id) => {
                    data.push({
                        chat_id: chat_id.chat_id,
                    });
                });
            } else if (fieldName === "pgp_emails") {
                response.forEach((pgp_email) => {
                    data.push({
                        pgp_email: pgp_email.pgp_email,
                    });
                });
            }

            /* this line is only needed if you are not adding a script tag reference */
            if (data.length) {
                /* make the worksheet */
                var ws = XLSX.utils.json_to_sheet(data);

                /* add to workbook */
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, "People");

                /* generate an XLSX file */
                let fileName = fieldName + '_' + Date.now() + ".xlsx";
                await XLSX.writeFile(wb, path.join(__dirname, "../../uploads/" + fileName));
                res.send({
                    path: fileName,
                    status: true
                });
            } else {
                res.send({
                    status: false,
                    msg: "no data to import"
                })
            }

        }
    })
    // } else {
    //     res.send({
    //         status: false,
    //         msg: "access forbidden"
    //     })
    // }
    // }    
};

exports.uploadFile = async function (req, res) {

    let fileName = "";
    let mimeType = "";
    let fieldName = req.params.fieldName;
    let filePath = "";
    let file = null;

    if (fieldName === 'launcher_apk') {
        file = req.files.launcher_apk;
    }
    else if (fieldName === "sc_apk") {
        file = req.files.sc_apk;
    }
    else if (fieldName === "byod_apk") {
        file = req.files.byod_apk;
    }
    else if (fieldName === Constants.LOGO) {
        file = req.files.logo;
    } else if (fieldName === Constants.APK) {
        file = req.files.apk;
    }
    else {
        res.send({
            status: false,
            msg: "Error while uploading"
        })
        return;
    }

    filePath = file.path;
    mimeType = file.type;
    bytes = file.size
    let formatByte = general_helpers.formatBytes(bytes);

    // if (fieldName === Constants.APK) {
    if (mimeType === "application/vnd.android.package-archive" || mimeType === "application/octet-stream") {
        versionCode = await general_helpers.getAPKVersionCode(filePath);
        if (versionCode) {
            let current_date = moment().format("YYYYMMDDHHmmss")
            fileName = fieldName + '-' + current_date + '-v' + versionCode + '.apk';
            console.log(fileName);
            let target_path = path.join(__dirname, "../../uploads/" + fileName);

            let packageName = await general_helpers.getAPKPackageName(filePath);
            packageName = packageName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
            // console.log("Package Name: ", packageName);
            if (fieldName == 'launcher_apk') {
                if (packageName == Constants.LAUNCHER_PKG_NAME) {
                    general_helpers.move(filePath, target_path, function (error) {
                        console.log(error);
                        if (error) {
                            res.send({
                                status: false,
                                msg: "Error while uploading"
                            })
                            console.log("ERROR", error);
                            return
                        }

                        res.send({
                            msg: 'Uploaded Successfully',
                            status: true,
                            fileName: fileName,
                            size: formatByte
                        })
                        return
                    });
                } else {
                    console.log("HERE");
                    res.send({
                        status: false,
                        msg: "Error: Apk not uploaded. Please ensure that your uploaded apk is Launcher Apk."
                    })
                    return
                }
            } else {
                general_helpers.move(filePath, target_path, function (error) {
                    console.log(error);
                    if (error) {
                        res.send({
                            status: false,
                            msg: "Error while uploading"
                        })
                    }

                    res.send({
                        msg: 'Uploaded Successfully',
                        status: true,
                        fileName: fileName,
                        size: formatByte
                    })
                    return
                });
            }



        } else {
            res.send({
                status: false,
                msg: "Error while uploading"
            })
            return;
        }

    } else if (fieldName === Constants.LOGO) {
        let current_date = moment().format("YYYYMMDDHHmmss")
        fileName = fieldName + '-' + current_date + '.jpg';
        console.log(fileName);
        fileName = fieldName + '-' + Date.now() + '.jpg';
        let target_path = path.join(__dirname, "../../uploads/" + fileName);

        general_helpers.move(filePath, target_path, function (error) {
            console.log(error);
            if (error) {
                res.send({
                    status: false,
                    msg: "Error while uploading"
                })
            }
            data = {
                status: true,
                msg: 'Uploaded Successfully',
                fileName: fileName,
                size: formatByte

            };
            res.send(data)
            return
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
        let model_id = req.body.model_id;
        let command_name = req.body.command_name;
        let apk_files = req.body.apk_files;
        let is_byod = req.body.is_byod ? 1 : 0


        if (!empty(model_id)) {
            sql.query(`UPDATE white_labels SET model_id = '${model_id}', command_name = '${command_name}' WHERE id = '${req.body.id}'`, async function (err, rslts) {
                if (err) {
                    console.log(err, 'error is');
                    data = {
                        status: false,
                        msg: "Error While Uploading"
                    };
                    res.send(data);
                    return;
                } else {
                    // console.log(rslts,'reslts are');
                    if (apk_files.length) {
                        for (let apk of apk_files) {
                            let file = path.join(__dirname, "../../uploads/" + apk);

                            if (fs.existsSync(file)) {
                                let versionCode = '';
                                let versionName = '';
                                let packageName = '';
                                let label = '';
                                let details = '';

                                versionCode = await general_helpers.getAPKVersionCode(file);


                                if (versionCode) {
                                    versionName = await general_helpers.getAPKVersionName(file);
                                    if (!versionName) {
                                        versionName = ''
                                    }
                                    packageName = await general_helpers.getAPKPackageName(file);
                                    if (!packageName) {
                                        packageName = '';
                                    }
                                    label = await general_helpers.getAPKLabel(file);
                                    // console.log(label);
                                    if (!label) {
                                        label = ''
                                    }
                                } else {
                                    versionCode = '';
                                }

                                versionCode = versionCode.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                                versionName = versionName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                                packageName = packageName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                                label = label.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                                details = details.replace(/(\r\n|\n|\r)/gm, "");


                                let apk_stats = fs.statSync(file);

                                let formatByte = general_helpers.formatBytes(apk_stats.size);

                                let whiteLabelId = req.body.id;
                                // let where = (is_byod == 1) ? 'AND is_byod = 1' : ''
                                let query = ''
                                if (is_byod == 1) {
                                    query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , is_byod = ${is_byod}, version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND is_byod = '1' `
                                } else {
                                    query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , is_byod = ${is_byod}, version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND package_name = '${packageName}' AND label = '${label}'`
                                }
                                // console.log(query)


                                sql.query(query, (error, sResult) => {
                                    if (error) {
                                        console.log(sResult, 'error on update', error)
                                        data = {
                                            status: false,
                                            msg: "Error While Uploading"
                                        };
                                        res.send(data);
                                        return;
                                    }
                                    // console.log(sResult.affectedRows)

                                    if (sResult && !sResult.affectedRows) {
                                        console.log(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code , is_byod) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}' , ${is_byod})`);
                                        sql.query(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code , is_byod) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}' , ${is_byod})`);
                                    }
                                });
                            } else {
                                data = {
                                    status: false,
                                    msg: "Error While Uploading"
                                };
                                res.send(data);
                                return;
                            }
                        }

                        // data = {
                        //     status: true,
                        //     msg: "Record Updated"
                        // };
                        // res.send(data);
                        // return;
                    } else {
                        data = {
                            status: false,
                            msg: "Record Updated but Apks not Provided"
                        };
                        res.send(data);
                        return;
                    }

                }

            });

        } else {
            data = {
                status: false,
                msg: "Error While Uploading"
            };
            res.send(data);
            return;
        }
    } catch (err) {
        res.send({
            status: false,
            msg: "Error while Updation",
        });
        return;
    }
}

exports.importCSV = async function (req, res) {
    // console.log('lable is: ', req.body.labelID)
    var loginResponse = ''
    let labelID = req.body.labelID;
    let WHITE_LABEL_BASE_URL = '';
    let getApiURL = await sql.query(`SELECT * from white_labels where id = ${labelID}`)
    if (getApiURL.length) {
        if (getApiURL[0].api_url) {
            WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
            axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                if (response.data.status) {
                    loginResponse = response.data;
                    let fileName = "";
                    let mimeType = "";
                    let fieldName = req.params.fieldName;
                    let filePath = "";
                    let file = null;
                    // let corsConnection = ''
                    console.log(fieldName);

                    // console.log('fieldName', req.files)
                    if (fieldName === 'sim_ids' || fieldName === 'chat_ids' || fieldName === 'pgp_emails') {
                        if (fieldName === 'sim_ids') {
                            file = req.files.sim_ids;
                        } else if (fieldName === 'chat_ids') {
                            file = req.files.chat_ids;
                        } else if (fieldName === 'pgp_emails') {
                            file = req.files.pgp_emails;
                        }
                        filePath = file.path;
                        mimeType = file.type;

                        if (
                            mimeType === "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ||
                            mimeType === "text/csv" ||
                            mimeType === "application/vnd.ms-excel" ||
                            mimeType === "application/octet-stream"
                        ) {
                            var workbook = XLSX.readFile(filePath);

                            workbook.SheetNames.forEach(async (sheet) => {
                                let singleSheet = workbook.Sheets[sheet];
                                let parsedData = XLSX.utils.sheet_to_json(singleSheet, {
                                    raw: true
                                });

                                if (fieldName == "sim_ids") {
                                    let error = false;
                                    let duplicatedSimIds = [];
                                    let InsertableSimIds = [];
                                    let isSimId = parsedData.findIndex(
                                        obj => Object.keys(obj).includes('sim_id')
                                    ) !== -1;
                                    let isStartDate = parsedData.findIndex(
                                        obj => Object.keys(obj).includes('start_date')
                                    ) !== -1;

                                    let isExpiryDate = parsedData.findIndex(
                                        obj => Object.keys(obj).includes('expiry_date')
                                    ) !== -1;

                                    if (isSimId && isStartDate && isExpiryDate) {

                                    } else {
                                        res.send({
                                            status: false,
                                            msg: "Incorrect file data",
                                            "duplicateData": [],
                                        })
                                        return
                                    }

                                    let sim = []
                                    for (let row of parsedData) {
                                        sim.push(row.sim_id)
                                    }

                                    // let slctQ = "SELECT sim_id, whitelabel_id, start_date, expiry_date from sim_ids WHERE sim_id IN (" + sim + ")";
                                    let slctQ = "SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id ) WHERE sim_id IN (" + sim + ")";
                                    // console.log('check query: ', slctQ);
                                    let dataof = await sql.query(slctQ);
                                    if (dataof.length) {
                                        // console.log(dataof, 'daata of & parsedData', parsedData);

                                        for (let row of parsedData) {

                                            let index = dataof.findIndex((item) => item.sim_id == row.sim_id);
                                            if (index >= 0) {
                                                duplicatedSimIds.push(dataof[index])
                                            } else {
                                                InsertableSimIds.push(row)
                                            }
                                        }
                                    }
                                    // console.log('step 2')
                                    // let InsertInWL = false;
                                    if (duplicatedSimIds.length == 0) {
                                        // console.log('step 3')
                                        for (let row of parsedData) {
                                            if (row.sim_id && row.start_date && row.expiry_date) {
                                                // if (corsConnection != '') {

                                                //     let corsInsertQ = `INSERT INTO sim_ids (sim_id, start_date, expiry_date) value ( '${row.sim_id}','${row.start_date}', '${row.expiry_date}')`;
                                                //     // console.log('insert query is: ', insertQ);
                                                //     await corsConnection.query(corsInsertQ);

                                                // }
                                                // let result = await sql.query("INSERT sim_ids (sim_id, start_date, expiry_date) value ('" + row.sim_id + "', '" + row.start_date + "', '" + row.expiry_date + "')");
                                                let insertQ = `INSERT INTO sim_ids (sim_id, whitelabel_id, start_date, expiry_date) value ( '${row.sim_id}', '${labelID}', '${row.start_date}', '${row.expiry_date}')`;
                                                let result = await sql.query(insertQ).catch((err) => {
                                                    error = true
                                                });
                                            } else {
                                                error = true;
                                            }
                                        }
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/sim_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later",
                                                "type": "sim_id",
                                                "duplicateData": [],
                                            };
                                            res.send(data);
                                            return
                                        });;
                                    }

                                    console.log('duplicate data is here', duplicatedSimIds)
                                    // if (InsertInWL) {

                                    if (!error && duplicatedSimIds.length === 0) {
                                        res.send({
                                            "status": true,
                                            "msg": "imported successfully",
                                            "type": "sim_id",
                                            "duplicateData": [],
                                        });
                                    } else {
                                        res.send({
                                            "status": false,
                                            "msg": "File contained invalid data that has been ignored, rest has been imported successfully.",
                                            "type": "sim_id",
                                            "duplicateData": duplicatedSimIds,
                                            "newData": InsertableSimIds
                                        });
                                    }
                                    return;
                                    // } else {
                                    //     res.send({
                                    //         "status": false,
                                    //         "msg": "Data not imported in white label",
                                    //         "type": "sim_id",
                                    //     });
                                    // }
                                } else if (fieldName === "chat_ids") {
                                    let error = false;
                                    let duplicatedChat_ids = [];
                                    let InsertableChat_ids = [];

                                    let isChatId = parsedData.findIndex(
                                        obj => Object.keys(obj).includes('chat_id')
                                    ) !== -1;

                                    if (isChatId) {

                                    } else {
                                        res.send({
                                            status: false,
                                            msg: "Incorrect file data",
                                            "duplicateData": [],
                                        })
                                        return
                                    }



                                    let chat_ids = []
                                    for (let row of parsedData) {
                                        chat_ids.push(`"${row.chat_id.toString()}"`)
                                    }
                                    let slctQ = "SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id ) WHERE chat_id IN (" + chat_ids + ")";
                                    let dataof = await sql.query(slctQ);
                                    if (dataof.length) {
                                        // console.log(parsedData, 'daata of', dataof);

                                        for (let row of parsedData) {

                                            let index = dataof.findIndex((item) => item.chat_id == row.chat_id);

                                            if (index >= 0) {
                                                duplicatedChat_ids.push(dataof[index])
                                            } else {
                                                InsertableChat_ids.push(row)
                                            }
                                        }
                                    }

                                    if (duplicatedChat_ids.length == 0) {
                                        for (let row of parsedData) {
                                            if (row.chat_id) {
                                                // if (corsConnection != '') {
                                                //     let corsInsertQ = `INSERT INTO chat_ids (chat_id) value ('${row.chat_id}')`;
                                                //     // console.log('insert query is: ', insertQ);
                                                //     await corsConnection.query(corsInsertQ);
                                                // }

                                                let result = await sql.query(`INSERT INTO chat_ids (chat_id, whitelabel_id) value ('${row.chat_id}', '${labelID}')`).catch((err) => {
                                                    error = true
                                                });;
                                            } else {
                                                error = true;
                                            }
                                        }
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/chat_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later",
                                                "type": "chat_id",
                                                "duplicateData": [],
                                            };
                                            // console.log(data);
                                            res.send(data);
                                            return
                                        });
                                    }

                                    if (!error && duplicatedChat_ids.length === 0) {
                                        res.send({
                                            "status": true,
                                            "msg": "imported successfully",
                                            "type": "chat_id",
                                            "duplicateData": [],
                                        });
                                    } else {
                                        res.send({
                                            "status": false,
                                            "msg": "File contained invalid data that has been ignored, rest has been imported successfully.",
                                            "type": "chat_id",
                                            "duplicateData": duplicatedChat_ids,
                                            "newData": InsertableChat_ids

                                        });
                                    }
                                    // corsConnection.end()
                                    return;
                                } else if (fieldName === "pgp_emails") {
                                    let error = false;
                                    let duplicatedPgp_emails = [];
                                    let InsertablePgp_emails = [];

                                    let isPgpEmail = parsedData.findIndex(
                                        obj => Object.keys(obj).includes('pgp_email')
                                    ) !== -1;

                                    if (isPgpEmail) {

                                    } else {
                                        res.send({
                                            status: false,
                                            msg: "Incorrect file data",
                                            "duplicateData": [],
                                        })
                                        return;
                                    }

                                    let pgp_emails = []
                                    for (let row of parsedData) {
                                        pgp_emails.push(row.pgp_email)
                                    }
                                    let slctQ = "SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id ) WHERE pgp_email IN (" + pgp_emails.map(item => { return "'" + item + "'" }) + ")";
                                    // console.log('pgp query', slctQ)
                                    let dataof = await sql.query(slctQ);
                                    if (dataof.length) {
                                        // console.log(parsedData, 'daata of', dataof);

                                        for (let row of parsedData) {

                                            let index = dataof.findIndex((item) => item.pgp_email == row.pgp_email);

                                            if (index >= 0) {
                                                duplicatedPgp_emails.push(dataof[index])
                                            } else {
                                                InsertablePgp_emails.push(row)
                                            }
                                        }
                                    }

                                    if (duplicatedPgp_emails.length == 0) {
                                        for (let row of parsedData) {
                                            if (row.pgp_email) {
                                                // if (corsConnection != '') {
                                                //     let corsInsertQ = `INSERT INTO pgp_emails (pgp_email) value ('${row.pgp_email}')`;
                                                //     // console.log('insert query is: ', insertQ);
                                                //     await corsConnection.query(corsInsertQ);

                                                // }

                                                // console.log("working");
                                                await sql.query(`INSERT INTO pgp_emails (pgp_email, whitelabel_id) value ('${row.pgp_email}', '${labelID}')`).catch((err) => {
                                                    error = true
                                                });
                                            } else {
                                                error = true;
                                            }
                                        }


                                        // ************* Add Domains
                                        let domains = []
                                        let all_domains = await sql.query(`SELECT name FROM domains WHERE whitelabel_id= '${labelID}'`)
                                        if (all_domains.length) {
                                            all_domains.map((item) => {
                                                domains.push(item.name)
                                            })
                                        }

                                        console.log('domains===> ', domains);

                                        let checkDuplicateDomains = [];
                                        for (let row of parsedData) {
                                            let domainName = row.pgp_email.split('@').pop();
                                            if (!domains.includes(domainName) && !checkDuplicateDomains.includes(domainName)) {
                                                if (domainName) {
                                                    checkDuplicateDomains.push(domainName);
                                                    let insertQ = `INSERT INTO domains (name, whitelabel_id) value ('${domainName}', '${labelID}')`;
                                                    await sql.query(insertQ);
                                                }
                                            }
                                        }

                                        // let checkDuplicateDomains = [];
                                        // for (let row of parsedData) {
                                        //     let domainName = row.pgp_email.split('@').pop();
                                        //     if (row.pgp_email) {
                                        //         await sql.query(`INSERT INTO domains (name) value ('${row.pgp_email}')`).catch((err) => {
                                        //             error = true
                                        //         });
                                        //     } else {
                                        //         error = true;
                                        //     }
                                        // }

                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/pgp_emails', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later",
                                                "type": "pgp_email",
                                                "duplicateData": [],
                                            };
                                            res.send(data);
                                            return
                                        });;
                                    }

                                    console.log('abaid duplicate data is =========> :: ', duplicatedPgp_emails)
                                    console.log('InsertablePgp_emails data is', InsertablePgp_emails)

                                    if (!error && duplicatedPgp_emails.length === 0) {
                                        res.send({
                                            "status": true,
                                            "msg": "imported successfully",
                                            "type": "pgp_email",
                                            "duplicateData": [],
                                        });
                                    } else {
                                        res.send({
                                            "status": false,
                                            "msg": "File contained invalid data that has been ignored, rest has been imported successfully.",
                                            "type": "pgp_email",
                                            "duplicateData": duplicatedPgp_emails,
                                            "newData": InsertablePgp_emails

                                        });
                                    }
                                    // corsConnection.end()
                                    return;
                                }

                            })
                        } else {
                            res.send({
                                status: false,
                                msg: "Incorrect file data",
                                "duplicateData": [],
                            })
                            return
                            // corsConnection.end()
                        }
                    } else {
                        res.send({
                            status: false,
                            msg: "Incorrect file data",
                            "duplicateData": [],
                        })
                        return
                        // corsConnection.end()
                    }
                }
                else {
                    res.send({
                        status: false,
                        msg: "Not allowed to Insert data.",
                        "duplicateData": []
                    })
                    return
                }
            }).catch((error) => {
                console.log("error", error);
                data = {
                    "status": false,
                    "msg": "White Label server not responding. PLease try again later",
                    "duplicateData": [],
                };
                // console.log("response send 1");
                res.send(data);
                return
            });;
        }
        else {
            res.send({
                status: false,
                msg: "White Label credentials not found.",
                "duplicateData": []
            })
            return
        }
    }
    else {
        res.send({
            status: false,
            msg: "White Label Data not found.",
            "duplicateData": []
        })
        return
    }
}

// save new data ids
exports.saveNewData = async function (req, res) {
    var loginResponse = ''
    let labelID = req.body.labelID;
    let WHITE_LABEL_BASE_URL = '';
    let getApiURL = await sql.query(`SELECT * from white_labels where id = ${labelID}`)
    if (getApiURL.length) {
        if (getApiURL[0].api_url) {
            WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
            axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                if (response.data.status) {
                    loginResponse = response.data;
                    let error = 0
                    if (req.body.type == 'sim_id') {
                        for (let row of req.body.newData) {
                            let result = await sql.query(`INSERT IGNORE sim_ids (sim_id, whitelabel_id, start_date, expiry_date) value ('${row.sim_id}', '${req.body.labelID}', '${row.start_date}', '${row.expiry_date}')`);
                            if (!result.affectedRows) {
                                error += 1;
                            }
                        }
                        await axios.post(WHITE_LABEL_BASE_URL + '/users/save_new_data', { newData: req.body.newData, type: 'sim_id' }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                            data = {
                                "status": false,
                                "msg": "White Label server not responding. PLease try again later"
                            };
                            res.send(data);
                            return
                        });;
                    } else if (req.body.type == 'chat_id') {
                        for (let row of req.body.newData) {
                            // if (corsConnection != '') {
                            //     await corsConnection.query(`INSERT IGNORE chat_ids (chat_id) value ('${row.chat_id}')`);
                            // }
                            let result = await sql.query(`INSERT IGNORE chat_ids (chat_id, whitelabel_id) value ('${row.chat_id}', '${req.body.labelID}')`);
                            if (!result.affectedRows) {
                                error += 1;
                            }
                        }
                        await axios.post(WHITE_LABEL_BASE_URL + '/users/save_new_data', { newData: req.body.newData, type: 'chat_id' }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                            data = {
                                "status": false,
                                "msg": "White Label server not responding. PLease try again later"
                            };
                            // console.log("response send 2");
                            res.send(data);
                            return
                        });;

                    } else if (req.body.type == 'pgp_email') {
                        for (let row of req.body.newData) {
                            // if (corsConnection != '') {
                            //     await corsConnection.query(`INSERT IGNORE pgp_emails (pgp_email) value ('${row.pgp_email}')`);
                            // }

                            let result = await sql.query(`INSERT IGNORE pgp_emails (pgp_email, whitelabel_id) value ('${row.pgp_email}', '${req.body.labelID}')`);
                            if (!result.affectedRows) {
                                error += 1;
                            }
                        }
                        await axios.post(WHITE_LABEL_BASE_URL + '/users/save_new_data', { newData: req.body.newData, type: 'pgp_email' }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                            data = {
                                "status": false,
                                "msg": "White Label server not responding. PLease try again later"
                            };
                            res.send(data);
                            return
                        });;

                    }

                    if (error == 0) {
                        res.send({
                            "status": true,
                            "msg": "Inserted Successfully"
                        })

                    } else {
                        res.send({
                            "status": false,
                            "msg": "Error While Insertion, " + error + " records not Inserted"
                        })
                    }
                }
                else {
                    res.send({
                        status: false,
                        msg: "Not allowed to Insert data.",
                        "duplicateData": []
                    })
                    return
                }
            }).catch((error) => {
                data = {
                    "status": false,
                    "msg": "White Label server not responding. PLease try again later"
                };
                res.send(data);
                return
            });;
        }
        else {
            res.send({
                status: false,
                msg: "White Label credentials not found.",
                "duplicateData": []
            })
            return
        }
    }
    else {
        res.send({
            status: false,
            msg: "White Label Data not found.",
            "duplicateData": []
        })
        return
    }
};

exports.getSimIds = async function (req, res) {
    // let query = "select * from sim_ids where used=0";
    let query = `SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id) WHERE wl.status = 1`;
    sql.query(query, (error, resp) => {
        // console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            // console.log(resp, 'is response')
            res.send({
                status: true,
                msg: "data success",
                data: resp
            });
        } else {
            res.send({
                status: false,
                msg: "data success",
                data: []
            });
        }
    });
}


exports.getChatIds = async function (req, res) {
    // console.log('-------------------------------------------')
    // console.log('hi, test getChatIds api')
    // console.log('-------------------------------------------')

    // let query = "select * from chat_ids where used=0";
    let query = `SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id) WHERE wl.status = 1`;
    sql.query(query, (error, resp) => {
        // console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            // console.log(resp, 'is response')
            res.send({
                status: true,
                msg: "data success",
                data: resp
            });
        } else {
            res.send({
                status: false,
                msg: "data success",
                data: []
            });
        }
    });
}

exports.getPgpEmails = async function (req, res) {
    // let query = "select * from pgp_emails where used=0";
    let query = `SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id) WHERE wl.status = 1`;
    sql.query(query, (error, resp) => {
        // console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            // console.log(resp, 'is response')
            res.send({
                status: true,
                msg: "data success",
                data: resp
            });
        } else {
            res.send({
                status: false,
                msg: "error",
                data: []
            });
        }
    });
}

exports.getFile = async function (req, res) {


    if (fs.existsSync(path.join(__dirname, "../../uploads/" + req.params.file))) {
        let file = path.join(__dirname, "../../uploads/" + req.params.file);
        let fileMimeType = mime.getType(file);
        // let filetypes = /jpeg|jpg|apk|png/;
        // Do something
        // if (filetypes.test(fileMimeType)) {
        res.set('Content-Type', fileMimeType); // mimeType eg. 'image/bmp'
        res.sendFile(path.join(__dirname, "../../uploads/" + req.params.file));
        // } else {
        //     res.send({
        //         "status": false,
        //         "msg": "file not found"
        //     })
        // }
    } else {
        res.send({
            "status": false,
            "msg": "file not found"
        })
    }

}
exports.getBackupFile = async function (req, res) {


    if (fs.existsSync(path.join(__dirname, "../../db_backup/" + req.params.file))) {
        let file = path.join(__dirname, "../../db_backup/" + req.params.file);
        let fileMimeType = mime.getType(file);
        // let filetypes = /jpeg|jpg|apk|png/;
        // Do something
        // if (filetypes.test(fileMimeType)) {
        res.set('Content-Type', fileMimeType); // mimeType eg. 'image/bmp'
        res.sendFile(path.join(__dirname, "../../db_backup/" + req.params.file));
        // } else {
        //     res.send({
        //         "status": false,
        //         "msg": "file not found"
        //     })
        // }
    } else {
        res.send({
            "status": false,
            "msg": "file not found"
        })
    }

}

exports.deviceStatus = async function (req, res) {
    // console.log('deviceStatus at server: ', req.body);
    let id = req.body.data.id;
    let requiredStatus = req.body.requireStatus;
    let start_date = req.body.data.start_date;
    let expiry_date = req.body.data.expiry_date;
    try {
        let updateQ = '';
        if (start_date && expiry_date && id && requiredStatus == Constants.DEVICE_EXTEND) {
            let status = 'expired';
            var varDate = new Date(expiry_date);
            var today = new Date();

            if (varDate > today) {
                status = 'active';
            }
            // console.log('status is: ', status);

            updateQ = `UPDATE devices SET start_date= '${start_date}', status = '${status}', expiry_date = '${expiry_date}', remaining_days = '2' WHERE id = ${id}`;
        } else if (id && requiredStatus == Constants.DEVICE_ACTIVATED) {
            updateQ = `UPDATE devices SET account_status= '', status='active' WHERE id = ${id}`;
        } else if (id && requiredStatus == Constants.DEVICE_SUSPENDED) {
            updateQ = `UPDATE devices SET account_status= 'suspended' WHERE id = ${id}`;
        } else {
            res.send({
                status: false,
                msg: "No data found"
            })
        }
        if (updateQ != '') {
            console.log('deviceStatus update query is: ', updateQ);
            await sql.query(updateQ, async function (err, rslts) {
                if (err) {
                    console.log(err);
                    res.send({
                        status: false,
                        msg: "Error occur"
                    });
                } else {
                    let selectQuery = `SELECT devices.*, white_labels.name as whitelabel FROM devices LEFT JOIN white_labels ON (devices.whitelabel_id = white_labels.id) WHERE devices.id = ${id}`;
                    console.log('select query: ', selectQuery);
                    await sql.query(selectQuery, async function (err, devices) {
                        console.log('selectQuery result is: ', devices);
                        if (err) {
                            console.log(err);
                            res.send({
                                status: false,
                                msg: "Error occur"
                            });
                        } else if (devices.length) {
                            devices.forEach((device) => {
                                device.finalStatus = device_helpers.checkStatus(device)

                                device.whitelabel = general_helpers.checkValue(device.whitelabel);
                                device.fl_dvc_id = general_helpers.checkValue(device.fl_dvc_id)
                                device.wl_dvc_id = general_helpers.checkValue(device.wl_dvc_id)
                                device.status = general_helpers.checkValue(device.status)
                                device.mac_address = general_helpers.checkValue(device.mac_address)
                                device.serial_number = general_helpers.checkValue(device.serial_number);
                            })
                            res.send({
                                status: true,
                                devices: devices,
                                msg: "Offline Device Status Successfully Updated!"
                            })
                        } else {
                            res.send({
                                status: false,
                                devices: [],
                                msg: "Failed to update Offline Device Status!",
                            })
                        }
                    });

                }

            });
        } else {
            res.send({
                status: false,
                msg: "Query not run"
            })
        }
    } catch (error) {
        console.log(error);
        res.send({
            status: false,
            msg: "exception for deviceStatus",
        });
        return;
    }

}
exports.updateDeviceStatus = async function (req, res) {

    let linkToWL = req.body.linkToWL;
    let SN = req.body.SN;
    let mac = req.body.mac;
    let device_id = req.body.device_id;

    if (linkToWL) {
        let query = `UPDATE devices set status= 'deleted', wl_dvc_id='${device_id}' where serial_number = '${SN}' AND mac_address = '${mac}'`
        await sql.query(query);
    } else {
        let start_date = moment();
        let expiry_date = moment(start_date).add(1, 'M');
        start_date = moment(start_date).format('YYYY-MM-DD hh:mm:ss');
        expiry_date = moment(expiry_date).format('YYYY-MM-DD hh:mm:ss');

        let query = `UPDATE devices SET status= 'active', start_date = '${start_date}', expiry_date = '${expiry_date}' , remaining_days = '30' WHERE wl_dvc_id='${device_id}'`
        await sql.query(query)
    }

    res.send();

}


exports.saveIdPrices = async function (req, res) {

    let data = req.body.data;
    if (data) {
        let whitelabel_id = req.body.whitelabel_id;
        if (whitelabel_id) {
            let WHITE_LABEL_BASE_URL = '';
            let getApiURL = await sql.query(`SELECT * from white_labels where id = ${whitelabel_id}`)
            if (getApiURL.length) {
                if (getApiURL[0].api_url) {
                    WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                    axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                        if (response.data.status) {
                            loginResponse = response.data;
                            axios.patch(WHITE_LABEL_BASE_URL + '/users/save-sa-prices', { data }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                                // console.log(response.data.status);
                                if (response.data.status) {
                                    let error = 0;
                                    let month = ''
                                    for (var key in data) {
                                        if (data.hasOwnProperty(key)) {
                                            let outerKey = key;

                                            let innerObject = data[key];
                                            for (var innerKey in innerObject) {
                                                if (innerObject.hasOwnProperty(innerKey)) {
                                                    let days = 0;
                                                    let priceTerm = innerKey;
                                                    if (innerObject[innerKey]) {
                                                        let stringarray = [];

                                                        stringarray = innerKey.split(/(\s+)/).filter(function (e) { return e.trim().length > 0; });
                                                        if (stringarray) {
                                                            if (stringarray.length) {
                                                                month = stringarray[0];
                                                                if (month && stringarray[1]) {
                                                                    if (stringarray[1] == 'month') {
                                                                        days = parseInt(month) * 30
                                                                    } else if (string[1] == 'year') {
                                                                        days = parseInt(month) * 365
                                                                    } else {
                                                                        res.send({
                                                                            status: false,
                                                                            msg: 'ERROR: Error occurred while setting Prices. please try agian'
                                                                        })
                                                                    }
                                                                }
                                                            }

                                                        }
                                                    }

                                                    let updateQuery = "UPDATE prices SET unit_price='" + innerObject[priceTerm] + "', price_expiry='" + days + "' WHERE whitelabel_id='" + whitelabel_id + "' AND price_term='" + priceTerm + "' AND price_for='" + outerKey + "'";
                                                    // console.log(updateQuery, 'update query')
                                                    sql.query(updateQuery, async function (err, result) {
                                                        if (err) throw err;
                                                        if (result) {
                                                            if (!result.affectedRows) {
                                                                let insertQuery = "INSERT INTO prices (price_for, unit_price, price_term, price_expiry, whitelabel_id) VALUES('" + outerKey + "', '" + innerObject[priceTerm] + "', '" + priceTerm + "', '" + days + "', '" + whitelabel_id + "')";
                                                                // console.log('insert query', insertQuery)
                                                                let rslt = await sql.query(insertQuery);
                                                                if (rslt) {
                                                                    if (rslt.affectedRows == 0) {
                                                                        error++;
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    })
                                                }
                                            }
                                        }
                                    }
                                    if (error == 0) {
                                        res.send({
                                            status: true,
                                            msg: 'Prices Set Successfully'
                                        })
                                        return
                                    } else {
                                        res.send({
                                            status: false,
                                            msg: 'ERROR: Error occurred while setting Prices. please try agian'
                                        })
                                        return
                                    }
                                }
                                else {
                                    res.send({
                                        status: false,
                                        msg: 'ERROR: White label server error and Package not saved. please try again.'
                                    })
                                    err = true
                                    return

                                }
                            }).catch((error) => {
                                if (error) {
                                    console.log("ERROR");
                                    // console.log(error);
                                    data = {
                                        "status": false,
                                        "msg": "White Label server not responding. PLease try again later",
                                    };
                                    res.send(data);
                                    err = true
                                    return
                                }
                            })

                        }
                        else {
                            res.send({
                                status: false,
                                msg: "you are not allowed to perform this action.",
                            })
                            err = true
                            return
                        }
                    }).catch((error) => {
                        console.log("error", error);
                        data = {
                            "status": false,
                            "msg": "White Label server not responding. PLease try again later",
                        };
                        // console.log("response send 1");
                        res.send(data);
                        err = true
                        return
                    });
                }
                else {
                    res.send({
                        status: false,
                        msg: "White Label credentials not found.",
                        "duplicateData": []
                    })
                    return
                }
            }
            else {
                res.send({
                    status: false,
                    msg: "White Label Data not found.",
                })
                return
            }

        } else {
            res.send({
                status: false,
                msg: "White Label Data not found.",
            })
            return
        }

    } else {
        res.send({
            status: false,
            msg: 'Invalid Data'
        })
        return
    }
}


exports.savePackage = async function (req, res) {
    // console.log('data is', req.body)

    let data = req.body.data;
    let err = false
    if (data) {
        // console.log(data, 'data')
        let whitelabel_id = req.body.data.whitelabel_id;
        let WHITE_LABEL_BASE_URL = '';
        let getApiURL = await sql.query(`SELECT * from white_labels where id = ${whitelabel_id}`)
        if (getApiURL.length) {
            if (getApiURL[0].api_url) {
                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {
                        loginResponse = response.data;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/save-sa-package', { data }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                            if (response.data.status) {
                                let days = 0;
                                if (data.pkgTerm) {
                                    stringarray = data.pkgTerm.split(/(\s+)/).filter(function (e) { return e.trim().length > 0; });
                                    if (stringarray) {
                                        // console.log(stringarray,'is string lenth', stringarray.length)
                                        if (stringarray.length) {
                                            month = stringarray[0];
                                            // console.log('is month', month, stringarray[1])
                                            if (month && stringarray[1]) {
                                                // console.log('sring[1]', stringarray[1])
                                                if (stringarray[1] == 'month') {
                                                    days = parseInt(month) * 30
                                                } else if (string[1] == 'year') {
                                                    days = parseInt(month) * 365
                                                } else {
                                                    days = 30
                                                }
                                            }
                                        }
                                    }
                                }
                                let pkg_features = JSON.stringify(data.pkgFeatures)
                                let insertQuery = "INSERT INTO packages (pkg_name, pkg_term, pkg_price, pkg_expiry, pkg_features, whitelabel_id) VALUES('" + data.pkgName + "', '" + data.pkgTerm + "', '" + data.pkgPrice + "','" + days + "', '" + pkg_features + "', '" + whitelabel_id + "')";
                                sql.query(insertQuery, async (err, rslt) => {
                                    if (err) throw err;
                                    if (rslt) {
                                        if (rslt.affectedRows) {
                                            insertedRecord = await sql.query("SELECT * FROM packages WHERE whitelabel_id='" + whitelabel_id + "' AND id='" + rslt.insertId + "'")
                                            res.send({
                                                status: true,
                                                msg: 'Package Saved Successfully.',
                                                data: insertedRecord
                                            })
                                            return
                                        } else {
                                            res.send({
                                                status: true,
                                                msg: 'Package Not Saved.Please try again',
                                                data: insertedRecord
                                            })
                                            return
                                        }
                                    }
                                })
                            } else {
                                res.send({
                                    status: false,
                                    msg: 'ERROR: White label server error and Package not saved. please try again.'
                                })
                                err = true
                                return

                            }
                        }).catch((error) => {
                            data = {
                                "status": false,
                                "msg": "White Label server not responding. PLease try again later",
                            };
                            res.send(data);
                            err = true
                            return
                        });;

                    }
                    else {
                        res.send({
                            status: false,
                            msg: "you are not allowed to perform this action.",
                        })
                        err = true
                        return
                    }
                }).catch((error) => {
                    console.log("error", error);
                    data = {
                        "status": false,
                        "msg": "White Label server not responding. PLease try again later",
                    };
                    // console.log("response send 1");
                    res.send(data);
                    err = true
                    return
                });

            }
            else {
                res.send({
                    status: false,
                    msg: "White Label credentials not found.",
                    "duplicateData": []
                })
                return
            }
        }
        else {
            res.send({
                status: false,
                msg: "White Label Data not found.",
            })
            return
        }
    } else {
        res.send({
            status: false,
            msg: 'Invalid Data'
        })
        return
    }
}


exports.getPrices = async function (req, res) {
    let whitelebel_id = req.params.whitelabel_id;
    let sim_id = {};
    let chat_id = {};
    let pgp_email = {};
    let vpn = {};
    // console.log(whitelebel_id, 'whitelebel aid')
    if (whitelebel_id) {
        let selectQuery = "SELECT * FROM prices WHERE whitelabel_id='" + whitelebel_id + "'";
        sql.query(selectQuery, async (err, reslt) => {
            if (err) throw err;
            if (reslt) {
                // console.log('result for get prices are is ', reslt);

                if (reslt.length) {
                    for (let item of reslt) {
                        if (item.price_for == 'sim_id') {
                            sim_id[item.price_term] = item.unit_price
                        } else if (item.price_for == 'chat_id') {
                            chat_id[item.price_term] = item.unit_price
                        } else if (item.price_for == 'pgp_email') {
                            pgp_email[item.price_term] = item.unit_price
                        } else if (item.price_for == 'vpn') {
                            vpn[item.price_term] = item.unit_price
                        }
                    }
                }
                let data = {
                    sim_id: sim_id ? sim_id : {},
                    chat_id: chat_id ? chat_id : {},
                    pgp_email: pgp_email ? pgp_email : {},
                    vpn: vpn ? vpn : {}
                }
                res.send({
                    status: true,
                    msg: "Data found",
                    data: data

                })


            } else {
                let data = {
                    sim_id: sim_id ? sim_id : {},
                    chat_id: chat_id ? chat_id : {},
                    pgp_email: pgp_email ? pgp_email : {},
                    vpn: vpn ? vpn : {}
                }

                res.send({
                    status: true,
                    msg: "Data found",
                    data: data
                })
            }
        })
    } else {

        let data = {
            sim_id: sim_id ? sim_id : {},
            chat_id: chat_id ? chat_id : {},
            pgp_email: pgp_email ? pgp_email : {},
            vpn: vpn ? vpn : {}
        }

        res.send({
            status: false,
            msg: 'Invalid Whitelabel_id',
            data: data

        })
    }
}

exports.getPackages = async function (req, res) {
    let whitelebel_id = req.params.whitelabel_id;
    if (whitelebel_id) {
        let selectQuery = "SELECT * FROM packages WHERE whitelabel_id='" + whitelebel_id + "'";
        sql.query(selectQuery, async (err, reslt) => {
            if (err) throw err;
            if (reslt) {
                // console.log('result for get packages are is ', reslt);

                if (reslt.length) {
                    // console.log(reslt, 'reslt data of prices')
                    res.send({
                        status: true,
                        msg: "Data found",
                        data: reslt

                    })
                } else {
                    res.send({
                        status: true,
                        msg: "Data found",
                        data: []

                    })
                }

            } else {

                res.send({
                    status: true,
                    msg: "Data found",
                    data: []
                })
            }
        })
    } else {

        res.send({
            status: false,
            msg: 'Invalid Whitelabel_id',
            data: []

        })
    }
}

exports.checkPackageName = async function (req, res) {

    try {
        let name = req.body.name !== undefined ? req.body.name : null;

        let checkExistingQ = "SELECT pkg_name FROM packages WHERE pkg_name='" + name + "'";

        let checkExisting = await sql.query(checkExistingQ);
        console.log(checkExistingQ, 'query is')
        if (checkExisting.length) {
            data = {
                status: false,
            };
            res.send(data);
            return;
        }
        else {
            data = {
                status: true,
            };
            res.send(data);
            return;
        }
    } catch (error) {
        throw error
    }

}
exports.requestCredits = async function (req, res) {

    try {
        let dealer_id = req.body.dealer_id
        let dealer_name = req.body.dealer_name
        let dealer_email = req.body.dealer_email
        let label = req.body.label
        let credits = req.body.credits
        let dealer_pin = req.body.dealer_pin
        let request_id = req.body.request_id
        // console.log(dealer_pin);
        if (dealer_id != '' && label != '' && credits != '') {

            let query = `INSERT into credit_requests (dealer_id,dealer_pin,dealer_name,dealer_email,label,request_id ,credits) VALUES (${dealer_id},'${dealer_pin}','${dealer_name}','${dealer_email}','${label}','${request_id}',${credits})`;
            sql.query(query, function (err, result) {
                if (err) throw err
                if (result && result.affectedRows > 0) {
                    let html = "You have a new cash credit request from following. <br>  Dealer Name : " + dealer_name + "<br> White Label : " + label + "<br> No. of Credits : " + credits;
                    try {
                        sendEmail("CASH CREDITS REQUEST", html, 'hamza.dawood007@gmail.com');
                        sendEmail("CASH CREDITS REQUEST", html, 'hamza.dawood007@gmail.com');
                    }
                    catch (err) {
                        throw err
                    }
                    res.send({
                        status: true,
                        msg: "Request has been submitted successfully."
                    })
                    return
                }
                else {
                    res.send({
                        status: false,
                        msg: "Request not submitted successfullly. Please try again later"
                    })
                    return
                }
            })
        } else {
            res.send({
                status: false,
                msg: "Information not provided. Please try again later."
            })
            return
        }

    } catch (error) {
        res.send({
            status: false,
            msg: "Information not provided. Please try again later."
        })
        return
    }

}
exports.newRequests = async function (req, res) {
    try {
        let query = "SELECT * from credit_requests where status = '0'"
        console.log(query);
        sql.query(query, function (err, result) {
            if (err) throw err
            if (result.length) {
                data = {
                    "status": true,
                    "data": result
                };
                res.send(data);
                return
            } else {
                data = {
                    "status": true,
                    "data": []
                };
                res.send(data);
                return
            }
        })
    } catch (error) {
        throw err
    }

}
exports.deleteRequest = async function (req, res) {
    try {
        let id = req.params.id
        let query = "SELECT * from credit_requests where id = " + id + " and  status = '0'"
        console.log(query);
        sql.query(query, async function (err, result) {
            if (err) throw err
            if (result.length) {
                let labelID = await general_helpers.getlabelIdByName(result[0].label)
                // console.log(labelID);
                let getApiURL = await sql.query(`SELECT * FROM white_labels WHERE id = ${labelID}`)
                if (getApiURL.length) {
                    if (getApiURL[0].api_url) {
                        var WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                            // console.log(response);
                            if (response.data.status) {
                                let loginResponse = response.data
                                let data = {
                                    credits: result[0].credits,
                                    dealer_id: result[0].dealer_id,
                                    request_id: result[0].request_id,
                                    type: "rejected"
                                }

                                axios.post(WHITE_LABEL_BASE_URL + '/users/credit-request-ack', { data }, { headers: { 'authorization': loginResponse.token } }).then(async (response) => {
                                    if (response.data.status) {
                                        let updateQuery = "update credit_requests set status = 1 , del_status = 1 where id= " + id
                                        sql.query(updateQuery, function (err, result) {
                                            if (err) throw err
                                            if (result && result.affectedRows > 0) {
                                                data = {
                                                    "status": true,
                                                    "msg": "Request deleted successfully."
                                                };
                                                res.send(data);
                                                return
                                            } else {
                                                data = {
                                                    "status": false,
                                                    "msg": "Request not deleted please try again."
                                                };
                                                res.send(data);
                                                return
                                            }
                                        })
                                    } else {
                                        data = {
                                            "status": false,
                                            "msg": response.data.msg
                                        };
                                        res.send(data);
                                        return
                                    }
                                }).catch((error) => {
                                    data = {
                                        "status": false,
                                        "msg": "White Label server not responding. PLease try again later"
                                    };
                                    res.send(data);
                                    return
                                });
                            }
                            else {
                                data = {
                                    "status": false,
                                    "msg": "User authentication failed.You are not allowed to perform this action."
                                };
                                res.send(data);
                                return
                            }
                        }).catch((error) => {
                            data = {
                                "status": false,
                                "msg": "White Label server not responding. PLease try again later"
                            };
                            res.send(data);
                            return
                        });
                    }
                    else {
                        res.send({
                            status: false,
                            msg: "White Label credentials not found.",
                            "duplicateData": []
                        })
                        return
                    }

                }
                else {
                    res.send({
                        status: false,
                        msg: "White Label Data not found.",
                        // "duplicateData": []
                    })
                    return
                }
            } else {
                data = {
                    status: false,
                    msg: "Request is already deleted"
                };
                res.send(data);
                return
            }
        })
    } catch (error) {
        console.log(error)
        data = {
            status: false,
            msg: "Request not deleted please try again."
        };
        res.send(data);
        return
    }
}
exports.acceptRequest = async function (req, res) {
    try {
        let id = req.params.id
        let pass = req.body.pass
        let password = md5(req.body.pass)
        let requestData = req.body.request
        let order_date = moment(requestData.created_at).format('YYYY-MM-DD hh:mm:ss');
        let dealer_pin = req.body.dealer_pin
        // expiry_date = moment(expiry_date).format('YYYY-MM-DD hh:mm:ss');
        // console.log("Accept Request API", password, requestData , order_date);
        // return
        let checkPassQ = `SELECT * FROM credit_requests WHERE id = ${id} AND password = '${password}'`
        sql.query(checkPassQ, function (err, result) {
            if (err) {
                data = {
                    "status": false,
                    "msg": "Error: Request not accepted. Please try again."
                };
                res.send(data);
                return
            }
            if (result.length) {
                let query = "SELECT * FROM credit_requests WHERE id = " + id + " and  status = '0'"
                // console.log(query);
                sql.query(query, async function (err, result) {
                    if (err) throw err
                    if (result.length) {
                        let labelID = await general_helpers.getlabelIdByName(result[0].label)
                        // console.log(labelID);
                        let getApiURL = await sql.query(`SELECT * FROM white_labels WHERE id = ${labelID}`)
                        if (getApiURL.length) {
                            if (getApiURL[0].api_url) {
                                var WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                                    // console.log(response);
                                    if (response.data.status) {
                                        let loginResponse = response.data
                                        let data = {
                                            credits: result[0].credits,
                                            dealer_id: result[0].dealer_id,
                                            request_id: result[0].request_id,
                                            type: "accepted"
                                        }

                                        axios.post(WHITE_LABEL_BASE_URL + '/users/credit-request-ack', { data }, { headers: { 'authorization': loginResponse.token } }).then(async (response) => {
                                            if (response.data.status) {
                                                let inv_no = "PI123456"
                                                let dealerQ = `SELECT * FROM superadmins_credentials WHERE dealer_pin = ${dealer_pin}`
                                                let dealerData = await sql.query(dealerQ);

                                                let acceptRequestQ = `INSERT INTO sales (dealer_id,dealer_pin,dealer_name,credits,label, accepted_by,inv_no,order_date,account_type,status,pay_type) VALUES(${requestData.dealer_id},'${requestData.dealer_pin}','${requestData.dealer_name}',${requestData.credits},'${requestData.label}','${dealerData[0].dealer_name}','${inv_no}','${order_date}','admin' ,'UNPAID' ,'CASH')`
                                                sql.query(acceptRequestQ)
                                                console.log(acceptRequestQ);
                                                let updateQuery = "update credit_requests set status = 1 where id= " + id
                                                sql.query(updateQuery, function (err, result) {
                                                    if (err) throw err
                                                    if (result && result.affectedRows > 0) {
                                                        data = {
                                                            "status": true,
                                                            "msg": response.data.msg
                                                        };
                                                        res.send(data);
                                                        return
                                                    }
                                                })
                                            } else {
                                                data = {
                                                    "status": false,
                                                    "msg": response.data.msg
                                                };
                                                res.send(data);
                                                return
                                            }
                                        }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later"
                                            };
                                            res.send(data);
                                            return
                                        });
                                    }
                                    else {
                                        data = {
                                            "status": false,
                                            "msg": "User authentication failed.You are not allowed to perform this action."
                                        };
                                        res.send(data);
                                        return
                                    }
                                }).catch((error) => {
                                    if (error) {
                                        console.log(error);
                                        data = {
                                            "status": false,
                                            "msg": "White Label server not responding. PLease try again later"
                                        };
                                        res.send(data);
                                        return
                                    }
                                });
                            }
                            else {
                                res.send({
                                    status: false,
                                    msg: "White Label credentials not found.",
                                    "duplicateData": []
                                })
                                return
                            }

                        }
                        else {
                            res.send({
                                status: false,
                                msg: "White Label Data not found.",
                                // "duplicateData": []
                            })
                            return
                        }


                    } else {
                        data = {
                            "status": true,
                            msg: "Request is already deleted"
                        };
                        res.send(data);
                        return
                    }
                })
            } else {
                data = {
                    "status": false,
                    "msg": "Password does not Match. Please enter a valid password."
                };
                res.send(data);
                return
            }
        })
    } catch (error) {
        // console.log(error)
        data = {
            "status": false,
            "msg": "Error: Request not accepted. Please try again."
        };
        res.send(data);
        return
    }
}
exports.checkPwd = async function (req, res) {
    // console.log(req.decoded);
    if (req.decoded && req.decoded.user) {
        let pwd = md5(req.body.password);
        let query_res = await sql.query(`SELECT * FROM admins WHERE id=${req.decoded.user.id} AND password='${pwd}'`);
        if (query_res.length) {
            res.send({
                "password_matched": true
            });
            return;
        } else {
            res.send({
                "password_matched": false
            });
            return;
        }
    }

}
exports.checkDealerPin = async function (req, res) {
    // console.log(req.decoded);
    // const invoice = {
    //     shipping: {
    //         name: "Hamza Dawood",
    //         // address: "1234 Main Street",
    //         // city: "San Francisco",
    //         // state: "CA",
    //         // country: "US",
    //         // postal_code: 94111
    //     },
    //     items: [
    //         {
    //             item: "Credits",
    //             description: "Credits puchased on cash ",
    //             quantity: 1000,
    //             amount: 100000
    //         },
    //     ],
    //     subtotal: 100000,
    //     paid: 100000,
    //     invoice_nr: 'PI123456'
    // };
    // let filePath = path.join(__dirname, "../../uploads/invoice" + Date.now() + ".pdf")
    // createInvoice(invoice, filePath)
    // return

    if (req.decoded && req.decoded.user) {
        // console.log(req.body);
        let dealer_pin = req.body.dealer_pin;
        let requestData = req.body.requestData
        let enc_pass = md5(requestData.dealer_name + requestData.dealer_email + requestData.id + Date.now())
        // console.log(enc_pass);
        let dbPass = md5(enc_pass);
        let query_res = await sql.query(`SELECT * FROM superadmins_credentials WHERE dealer_pin='${dealer_pin}' limit 1`);
        if (query_res.length) {

            let html = "<b> You are accepting a following request:<br>  Dealer Name : " + requestData.dealer_name + "<br> White Label : " + requestData.label + "<br> No. of Credits : " + requestData.credits + "<br> Your password to accept a CASH REQUEST is " + enc_pass + " </b>";
            // console.log(query_res[0].admin_email);
            try {
                sendEmail("ACCEPT CASH REQUEST", html, query_res[0].dealer_email);
            }
            catch (err) {
                console.log(err);
            }
            sql.query(`UPDATE credit_requests set password = '${dbPass}' WHERE id = ${requestData.id}`);
            res.send({
                "pin_matched": true
            });
            return;
        } else {
            res.send({
                "pin_matched": false
            });
            return;
        }
    }
}
exports.deleteCSVids = async function (req, res) {
    try {
        var fieldName = req.params.fieldName
        var ids = req.body.ids
        var idsKeys = req.body.ids.map((item) => {
            return item.id
        })
        // console.log(ids[0]);
        let labelID = ids[0].whitelabel_id;
        let WHITE_LABEL_BASE_URL = '';

        if (ids.length) {
            let getApiURL = await sql.query(`SELECT * from white_labels where id = ${labelID}`)
            if (getApiURL.length) {
                if (getApiURL[0].api_url) {
                    WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                    // console.log(WHITE_LABEL_BASE_URL);
                    axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                        if (response.data.status) {
                            loginResponse = response.data;
                            // console.log(response.data);
                            await axios.post(WHITE_LABEL_BASE_URL + '/users/delete_CSV_ids/' + fieldName, { ids }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                                if (response.data.status) {
                                    if (fieldName === 'pgp_email') {
                                        let query = "delete from pgp_emails where id IN (" + idsKeys.join() + ")";
                                        sql.query(query, (error, resp) => {
                                            if (error) throw error
                                            if (resp.affectedRows) {
                                                let query = `SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id )`;
                                                sql.query(query, (error, resp) => {
                                                    res.send({
                                                        status: true,
                                                        type: 'pgp',
                                                        msg: "CSV Deleted Successfully From White Label.",
                                                        data: resp
                                                    });
                                                    return
                                                });
                                            } else {
                                                res.send({
                                                    status: false,
                                                    msg: "CSV Not Deleted Please Try Again.",
                                                });
                                                return
                                            }
                                        });
                                    }
                                    else if (fieldName === 'sim_id') {
                                        let query = "DELETE FROM sim_ids where id IN (" + idsKeys.join() + ")";
                                        // console.log(query);
                                        sql.query(query, (error, resp) => {
                                            if (error) throw error
                                            if (resp.affectedRows) {
                                                let query = `SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id )`
                                                sql.query(query, (error, resp) => {
                                                    res.send({
                                                        status: true,
                                                        type: 'sim',
                                                        msg: "CSV Deleted Successfully From White Label.",
                                                        data: resp
                                                    });
                                                    return
                                                });
                                            } else {
                                                res.send({
                                                    status: true,
                                                    msg: "CSV Not Deleted Please Try Again.",
                                                });
                                                return
                                            }
                                        });
                                    }
                                    else if (fieldName === 'chat_id') {
                                        let query = "DELETE FROM chat_ids where id IN (" + idsKeys.join() + ")";
                                        // console.log(query);
                                        sql.query(query, (error, resp) => {
                                            if (error) throw error
                                            if (resp.affectedRows) {

                                                let query = `SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id )`
                                                sql.query(query, (error, resp) => {
                                                    console.log(resp);
                                                    res.send({
                                                        status: true,
                                                        type: 'chat',
                                                        msg: "CSV Deleted Successfully From White Label.",
                                                        data: resp
                                                    });
                                                    return
                                                });
                                            } else {
                                                res.send({
                                                    status: false,
                                                    msg: "CSV Not Deleted Please Try Again.",
                                                });
                                                return
                                            }
                                        });
                                    }
                                }
                                else {
                                    res.send({
                                        status: false,
                                        msg: "CSV Not Deleted Please Try Again.",
                                    });
                                    return
                                }
                            }).catch((error) => {
                                data = {
                                    "status": false,
                                    "msg": "White Label server not responding. PLease try again later"
                                };
                                res.send(data);
                                return
                            });;
                        }
                        else {
                            res.send({
                                status: false,
                                msg: "Not allowed to perform this action.",
                            })
                            return
                        }
                    }).catch((error) => {
                        data = {
                            "status": false,
                            "msg": "White Label server not responding. PLease try again later"
                        };
                        res.send(data);
                        return
                    });
                }
                else {
                    res.send({
                        status: false,
                        msg: "White Label credentials not found.",
                    })
                    return
                }
            }
            else {
                res.send({
                    status: false,
                    msg: "White Label Data not found.",
                })
                return
            }
        }
    } catch (error) {
        console.log(error);
        res.send({
            status: false,
            msg: "Error: CSV not deleted. Please try again",
        })
        return
    }
}
exports.syncCSVIds = async function (req, res) {
    try {
        let allChat_ids = [];
        let allSim_ids = [];
        let allPgp_emials = [];
        let WHITE_LABEL_BASE_URL = '';
        let servererror = false;
        let getApiURL = await sql.query(`SELECT * from white_labels where status = 1`)
        if (getApiURL.length) {
            for (let i = 0; i < getApiURL.length; i++) {
                if (getApiURL[i].api_url) {
                    WHITE_LABEL_BASE_URL = getApiURL[i].api_url;
                    await axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                        if (response.data.status) {
                            loginResponse = response.data;
                            await axios.get(WHITE_LABEL_BASE_URL + '/users/get_csv_ids', { headers: { 'authorization': loginResponse.token } }).then((response) => {
                                if (response.data.status) {
                                    let data = response.data
                                    let sim_ids = data.sim_ids;
                                    let chat_ids = data.chat_ids;
                                    let pgp_emails = data.pgp_emails;
                                    allChat_ids = [...allChat_ids, ...chat_ids]
                                    allSim_ids = [...allSim_ids, ...sim_ids]
                                    allPgp_emials = [...allPgp_emials, ...pgp_emails]
                                }
                            }).catch((error) => {
                                console.log("White Label server not responding. PLease try again later");
                            });
                        }
                    }).catch((error) => {
                        servererror = true
                        console.log("White Label server not responding. PLease try again later");
                    });;
                }
            }

            if (!servererror) {
                for (let i = 0; i < allChat_ids.length; i++) {
                    await sql.query(`UPDATE chat_ids set used = ${allChat_ids[i].used} where chat_id = ${allChat_ids[i].chat_id}`)
                }
                for (let i = 0; i < allSim_ids.length; i++) {
                    await sql.query(`UPDATE sim_ids set used = ${allSim_ids[i].used} where sim_id = ${allSim_ids[i].sim_id}`)
                }
                for (let i = 0; i < allPgp_emials.length; i++) {
                    await sql.query(`UPDATE pgp_emails set used = ${allPgp_emials[i].used} where pgp_email = '${allPgp_emials[i].pgp_email}'`)
                }
                let SA_chat_ids = await sql.query(`SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id) WHERE wl.status = 1`)
                let SA_pgp_emails = await sql.query(`SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id) WHERE wl.status = 1`)
                let SA_sim_ids = await sql.query(`SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id) WHERE wl.status = 1`)
                res.send({
                    status: true,
                    chat_ids: SA_chat_ids,
                    sim_ids: SA_sim_ids,
                    pgp_emails: SA_pgp_emails,
                    msg: "White Label ID's Sync Successfully."
                })
                return

            } else {
                res.send({
                    status: false,
                    msg: "ERROR: White Label server not responding. Please again later"
                })
                return
            }
        }
        else {
            res.send({
                status: false,
                msg: "ERROR: White Label credentials not found."
            })
            return
        }
    } catch (error) {
        console.log(error);
        res.send({
            status: false,
            msg: "ERROR: Error while syncing white label."
        })
        return
    }
}
exports.getSalesList = async function (req, res) {
    // let query = "select * from pgp_emails where used=0";
    let query = `SELECT * FROM sales`;
    sql.query(query, (error, resp) => {
        // console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            // console.log(resp, 'is response')
            res.send({
                status: true,
                msg: "data success",
                data: resp
            });
        } else {
            res.send({
                status: false,
                msg: "error",
                data: []
            });
        }
    });
}
exports.getDealerList = async function (req, res) {
    try {
        let labelId = req.params.labelId;
        let WHITE_LABEL_BASE_URL = '';
        console.log(labelId);
        let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)
        if (getApiURL.length) {
            if (getApiURL[0].api_url) {
                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                // console.log(WHITE_LABEL_BASE_URL + '/users/super_admin_login');
                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {
                        loginResponse = response.data;
                        axios.get(WHITE_LABEL_BASE_URL + '/users/get_dealer_list', { headers: { 'authorization': loginResponse.token } }).then((response) => {
                            console.log(response.data);
                            if (response.data.status) {
                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: response.data.data
                                });
                                return
                            }
                        }).catch((error) => {
                            console.log("White Label server not responding. PLease try again later");
                        });
                    }
                }).catch((error) => {
                    console.log(error);
                    console.log("White Label server not responding. PLease try again later");
                    res.send({
                        status: false,
                        msg: "error",
                        data: []
                    });
                    return
                });;
            } else {
                res.send({
                    status: false,
                    msg: "error",
                    data: []
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "error",
                data: []
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "error",
            data: []
        });
        return

    }
}