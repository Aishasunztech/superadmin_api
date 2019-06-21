const { sql } = require('../../config/database');
const multer = require('multer');
var path = require('path');
var fs = require("fs");
var mime = require('mime');
var XLSX = require('xlsx');
var empty = require('is-empty');
var mime = require('mime');
const axios = require('axios');

const Constants = require('../../constants/application');
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const moment = require('moment')

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
    let whiteLabelQ = "SELECT id, name, model_id, command_name, route_uri FROM white_labels WHERE id =" + req.params.labelId + " limit 1";
    let whiteLabel = await sql.query(whiteLabelQ);
    if (Object.keys(whiteLabel).length) {
        let whiteLabelApksQ = "SELECT * FROM whitelabel_apks WHERE whitelabel_id = " + whiteLabel[0].id;
        let whiteLabelApks = await sql.query(whiteLabelApksQ);
        whiteLabel[0].apks = whiteLabelApks;
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
}

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
    if (mimeType === "application/vnd.android.package-archive") {
        versionCode = await general_helpers.getAPKVersionCode(filePath);
        if (versionCode) {
            fileName = fieldName + '-' + Date.now() + '.apk';
            let target_path = path.join(__dirname, "../../uploads/" + fileName);

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
        } else {
            res.send({
                status: false,
                msg: "Error while uploading"
            })
            return;
        }

    } else if (fieldName === Constants.LOGO) {
        // console.log(req.files);


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
                    console.log(err);
                    data = {
                        status: false,
                        msg: "Error While Uploading"
                    };
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
                                    console.log(label);
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
                                    query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , is_byod = '${is_byod}', version_name='${versionName}', version_code='${versionCode}' WHERE is_byod = '1' `
                                } else {
                                    query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , is_byod = '${is_byod}', version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND package_name = '${packageName}' AND label = '${label}'`
                                }

                                sql.query(query, (error, sResult) => {
                                    if (error) {
                                        data = {
                                            status: false,
                                            msg: "Error While Uploading"
                                        };
                                        res.send(data);
                                        return;
                                    }

                                    if (sResult && !sResult.affectedRows) {
                                        console.log(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code , is_byod) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}' , '${is_byod}')`);
                                        sql.query(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code , is_byod) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}' , '${is_byod}')`);
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

                        data = {
                            status: true,
                            msg: "Record Updated"
                        };
                        res.send(data);
                        return;
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



    } catch (error) {
        data = {
            status: false,
            msg: "Error while Uploading",
        };
        res.send(data);
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
                            mimeType === "application/vnd.ms-excel"
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
                                                let result = await sql.query(insertQ);
                                            } else {
                                                error = true;
                                            }
                                        }
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/sim_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } });
                                        // InsertInWL = await axios.post(WHITE_LABEL_BASE_URL + '/users/import/sim_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } });
                                        // if (InsertInWL.data.status) {
                                        //     InsertInWL = true
                                        // } else {
                                        //     InsertInWL = false
                                        // }
                                    }

                                    // console.log('duplicate data is here', duplicatedSimIds)
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
                                        chat_ids.push(row.chat_id.toString())
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

                                                let result = await sql.query(`INSERT INTO chat_ids (chat_id, whitelabel_id) value ('${row.chat_id}', '${labelID}')`);
                                            } else {
                                                error = true;
                                            }
                                        }
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/chat_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } });
                                    }

                                    // console.log('duplicate data is', duplicatedChat_ids)

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


                                                let result = await sql.query(`INSERT INTO pgp_emails (pgp_email, whitelabel_id) value ('${row.pgp_email}', '${labelID}')`);
                                            } else {
                                                error = true;
                                            }
                                        }
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/pgp_emails', { parsedData }, { headers: { 'authorization': loginResponse.token } });
                                    }

                                    // console.log('duplicate data is', duplicatedPgp_emails)

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

                            });
                        } else {
                            res.send({
                                status: false,
                                msg: "Incorrect file data",
                                "duplicateData": [],
                            })
                            // corsConnection.end()
                        }
                    } else {
                        res.send({
                            status: false,
                            msg: "Incorrect file data",
                            "duplicateData": [],
                        })
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
            "duplicateData": []
        })
        return
    }
}

exports.whitelabelBackups = async function (req, res) {
    let id = req.params.whitelabel_id;
    // console.log(id, 'id is')
    if (id !== undefined && id !== '' && id !== null) {
        let query = "select * from db_backups where whitelabel_id='" + id + "'";
        sql.query(query, (error, resp) => {
            // console.log(resp, 'is response')
            if (error) throw error;
            if (resp) {
                res.send({
                    status: false,
                    msg: "data success",
                    data: resp
                });
            }
        });
    } else {
        res.send({
            status: false,
            msg: "Error ",
            data: []
        });
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
                        await axios.post(WHITE_LABEL_BASE_URL + '/users//save_new_data', { newData: req.body.newData, type: 'sim_id' }, { headers: { 'authorization': loginResponse.token } });
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
                        await axios.post(WHITE_LABEL_BASE_URL + '/users//save_new_data', { newData: req.body.newData, type: 'chat_id' }, { headers: { 'authorization': loginResponse.token } });

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
                        await axios.post(WHITE_LABEL_BASE_URL + '/users//save_new_data', { newData: req.body.newData, type: 'pgp_email' }, { headers: { 'authorization': loginResponse.token } });

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
            "duplicateData": []
        })
        return
    }
};

exports.getSimIds = async function (req, res) {
    // let query = "select * from sim_ids where used=0";
    let query = `SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id )`;
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            console.log(resp, 'is response')
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
    let query = `SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id)`;
    sql.query(query, (error, resp) => {
        // console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            console.log(resp, 'is response')
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
    let query = `SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id)`;
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        if (error) throw error
        if (resp.length) {
            console.log(resp, 'is response')
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



// get ids with label

exports.getSimIdsLabel = async function (req, res) {
    console.log('getSimIdsLabel at server:: ', req.body.labelID)
    // let query = "select * from sim_ids where used=0";
    let query = `SELECT sim_ids.*, wl.name FROM sim_ids JOIN white_labels as wl on (wl.id = sim_ids.whitelabel_id ) where sim_ids.whitelabel_id = ${req.body.labelID}`;
    sql.query(query, (error, resp) => {
        if (error) throw error
        if (resp.length) {
            console.log(resp, 'is response')
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
exports.getChatIdsLabel = async function (req, res) {
    console.log('getChatIdsLabel at server:: ', req.body.labelID)
    // let query = "select * from chat_ids where used=0";
    let query = `SELECT chat_ids.*, wl.name FROM chat_ids JOIN white_labels as wl on (wl.id = chat_ids.whitelabel_id) where chat_ids.whitelabel_id = ${req.body.labelID}`;
    sql.query(query, (error, resp) => {
        if (error) throw error
        if (resp.length) {
            data = {
                status: false,
                msg: "data success",
                data: resp
            }
            console.log(resp, 'is response')
            res.send(data);
        } else {
            data = {
                status: false,
                msg: "error",
                data: []
            }
            res.send(data);
        }
    });
}

exports.getPgpEmailsLabel = async function (req, res) {
    // let query = "select * from pgp_emails where used=0";
    let data = {}
    let query = `SELECT pgp_emails.*, wl.name FROM pgp_emails JOIN white_labels as wl on (wl.id = pgp_emails.whitelabel_id) where pgp_emails.whitelabel_id = ${req.body.labelID}`;
    sql.query(query, (error, resp) => {
        if (error) throw error
        if (resp.length) {
            console.log(resp, 'is response')
            data = {
                status: true,
                msg: "data success",
                data: resp
            }
            res.send(data);
        } else {
            data = {
                status: false,
                msg: "data success",
                data: []
            }
            res.send(data);
        }
    });
}


// // get used ids 

// exports.getUsedSimIds = async function (req, res) {
//     let query = "select * from sim_ids where used=1";
//     sql.query(query, (error, resp) => {
//         console.log(resp, 'is response')
//         res.send({
//             status: false,
//             msg: "data success",
//             data: resp
//         });
//     });
// }

// exports.getUsedChatIds = async function (req, res) {
//     let query = "select * from chat_ids where used=1";
//     sql.query(query, (error, resp) => {
//         console.log(resp, 'is response')
//         res.send({
//             status: false,
//             msg: "data success",
//             data: resp
//         });
//     });
// }

// exports.getUsedPgpEmails = async function (req, res) {
//     let query = "select * from pgp_emails where used=1";
//     sql.query(query, (error, resp) => {
//         console.log(resp, 'is response')
//         res.send({
//             status: false,
//             msg: "data success",
//             data: resp
//         });
//     });
// }
exports.apklist = async function (req, res) {
    console.log(req.decoded);
    let data = []
    sql.query("select * from apk_details where delete_status=0 AND apk_type = 'permanent' order by id ASC", async function (error, results) {
        if (error) throw error;

        if (results.length > 0) {
            // let adminRoleId = await helpers.getuserTypeIdByName(Constants.ADMIN);
            // let dealerCount = await helpers.dealerCount(adminRoleId);
            // console.log("dealer count", dealerCount)
            for (var i = 0; i < results.length; i++) {
                // let permissions = (results[i].dealers !== undefined && results[i].dealers !== null) ? JSON.parse(results[i].dealers) : JSON.parse('[]');
                // let permissionCount = (permissions !== undefined && permissions !== null && permissions !== '[]') ? permissions.length : 0;
                // let permissionC = ((dealerCount == permissionCount) && (permissionCount > 0)) ? "All" : permissionCount.toString();
                dta = {
                    "apk_id": results[i].id,
                    "apk_name": results[i].app_name,
                    "logo": results[i].logo,
                    "apk": results[i].apk_file,
                    "permissions": [],
                    "apk_status": results[i].status,
                    "size": results[i].apk_size,
                    "permission_count": '',
                    "deleteable": (results[i].apk_type == "permanent") ? false : true
                }
                data.push(dta);
            }

            return res.json({
                status: true,
                success: true,
                list: data
            });

        } else {
            data = {
                status: false,
                msg: "No result found",
                list: []
            }
            res.send(data);
        }

    });
}
exports.checkApkName = async function (req, res) {
    try {
        // console.log(req.body);
        let apkName = req.body.name;
        let apk_id = req.body.apk_id
        let query = '';
        // console.log(apk_id);
        if (apkName != '' || apkName != null) {
            if (apk_id == '') {
                query = "SELECT * from apk_details where app_name = '" + apkName + "' AND delete_status != 1"
            }
            else {
                query = "SELECT * from apk_details where app_name = '" + apkName + "' AND delete_status != 1 AND id != " + apk_id;
            }
            // console.log(query);
            let isUniqueName = await sql.query(query)
            if (isUniqueName.length) {
                res.send({
                    status: false,
                })
            } else {
                res.send({
                    status: true
                })
            }
        } else {
            res.send({
                status: true
            })
        }
    } catch (error) {
        throw error
    }
}
exports.uploadApk = async function (req, res) {
    let fileUploaded = false;
    let fileName = "";
    let mimeType = "";
    let fieldName = req.params.fieldName;

    let file = null
    if (fieldName === Constants.LOGO) {
        file = req.files.logo;
    } else if (fieldName === Constants.APK) {
        file = req.files.apk;
    } else {
        res.send({
            status: false,
            msg: "Error while uploading"
        })
        return;
    }

    console.log(file);
    filePath = file.path;
    mimeType = file.type;
    bytes = file.size
    let formatByte = general_helpers.formatBytes(bytes);
    console.log(formatByte);

    if (fieldName === Constants.APK) {
        // let file = path.join(__dirname, "../uploads/" + filename);
        let versionCode = await general_helpers.getAPKVersionCode(filePath);
        // console.log("version code", versionCode);
        // let apk_stats = fs.statSync(file);

        // let formatByte = helpers.formatBytes(apk_stats.size);
        if (versionCode) {

            fileName = fieldName + '-' + Date.now() + '.apk';
            let target_path = path.join(__dirname, "../../uploads/" + fileName);

            general_helpers.move(filePath, target_path, function (error) {
                console.log(error);
                if (error) {
                    res.send({
                        status: false,
                        msg: "Error while uploading"
                    })
                }
                console.log(fileName);
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
            data = {
                status: false,
                msg: "Error while Uploading",
            };
            res.send(data);
            return;
        }
    } else if (fieldName === Constants.LOGO) {
        // console.log(req.files);


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
    }
    else {
        data = {
            status: false,
            msg: "Error while Uploading"
        }
        res.send(data);
        return;
    }
}
exports.addApk = async function (req, res) {
    try {
        let logo = req.body.logo;
        let apk = req.body.apk;
        let apk_name = req.body.name;
        if (!empty(logo) && !empty(apk) && !empty(apk_name)) {

            let file = path.join(__dirname, "../../uploads/" + apk);
            console.log("File", file);
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
                    console.log("Label", label);

                    if (!label) {
                        label = ''

                    }
                } else {
                    versionCode = '';
                }

                versionCode = versionCode.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                versionName = versionName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                packageName = packageName.toString().replace(/(\r\n|\n|\r)/gm, "").replace(/['"]+/g, '');
                // label = label.toString().replace(/(\r\n|\n|\r)/gm, "");
                details = details.toString().replace(/(\r\n|\n|\r)/gm, "");

                let apk_type = 'permanent'

                let apk_stats = fs.statSync(file);

                let formatByte = general_helpers.formatBytes(apk_stats.size);

                sql.query(`INSERT INTO apk_details (app_name, logo, apk_file, apk_type, version_code, version_name, package_name, details, apk_bytes, apk_size, label) VALUES ('${apk_name}' , '${logo}' , '${apk}', '${apk_type}', '${versionCode}', '${versionName}', '${packageName}', '${details}', ${apk_stats.size}, '${formatByte}', '${label}')`, async function (err, rslts) {
                    let newData = await sql.query("SELECT * from apk_details where id = " + rslts.insertId)
                    // console.log(newData[0]);
                    dta = {
                        apk_id: newData[0].id,
                        apk_name: newData[0].app_name,
                        logo: newData[0].logo,
                        apk: newData[0].apk_file,
                        permissions: [],
                        apk_status: newData[0].status,
                        permission_count: 0,
                        deleteable: (newData[0].apk_type == "permanent") ? false : true,
                        apk_type: newData[0].apk_type,
                        size: newData[0].apk_size,
                    }


                    if (err) throw err;
                    data = {
                        status: true,
                        msg: "Apk is uploaded",
                        data: dta
                    };
                    res.send(data);
                    return;
                });

            } else {
                console.log("file not found");
                res.send({
                    status: false,
                    msg: "Error While Uploading"
                })
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
        console.log(error);
        data = {
            status: false,
            msg: "Error while Uploading",
        };
        return;
    }
}
exports.deleteApk = async function (req, res) {
    if (!empty(req.body.apk_id)) {
        sql.query("update `apk_details` set delete_status='1' WHERE id='" + req.body.apk_id + "'", async function (error, results) {
            console.log(results);

            if (error) throw error;
            if (results.affectedRows == 0) {
                data = {
                    "status": false,
                    "msg": "Apk not deleted.",
                    "rdlt": results
                };
            } else {
                let deletedRecord = "SELECT * FROM apk_details where id=" + req.body.apk_id + " and delete_status='1'";
                let result = await sql.query(deletedRecord);
                if (result.length) {

                    data = {
                        "status": true,
                        "msg": "Apk deleted successfully.",
                        "apk": result[0]
                    };
                } else {
                    data = {
                        "status": false,
                        "msg": "Apk not deleted.",
                        "rdlt": results
                    };
                }

            }
            res.send(data);
        });
    } else {
        data = {
            "status": false,
            "msg": "Some error occurred."

        }
        res.send(data);
    }
}
exports.editApk = async function (req, res) {
    // console.log(req.body);
    try {
        let logo = req.body.logo;
        let apk = req.body.apk;
        let apk_name = req.body.name;
        if (!empty(logo) && !empty(apk) && !empty(apk_name)) {
            // console.log("object");
            let file = path.join(__dirname, "../../uploads/" + apk);
            // console.log(file);
            if (fs.existsSync(file)) {
                let versionCode = '';
                let versionName = '';
                let packageName = ' ';
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
                    console.log("Label", label);

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
                // console.log("label", label);
                // console.log('detai')

                // let apk_type = (verify.user.user_type === AUTO_UPDATE_ADMIN) ? 'permanent' : 'basic'

                let apk_stats = fs.statSync(file);

                let formatByte = general_helpers.formatBytes(apk_stats.size);
                // console.log("update apk_details set app_name = '" + apk_name + "', logo = '" + logo + "', apk = '" + apk + "', version_code = '" + versionCode + "', version_name = '" + versionName + "', package_name='" + packageName + "', details='" + details + "', apk_byte='" + apk_stats.size + "',  apk_size='"+ formatByte +"'  where id = '" + req.body.apk_id + "'");

                sql.query("update apk_details set app_name = '" + apk_name + "', logo = '" + logo + "', apk_file = '" + apk + "', version_code = '" + versionCode + "', version_name = '" + versionName + "', package_name='" + packageName + "', details='" + details + "', apk_bytes='" + apk_stats.size + "',  apk_size='" + formatByte + "'  where id = '" + req.body.apk_id + "'", function (err, rslts) {

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

exports.checkComponent = async function (req, res) {
    //   console.log(req.decoded.user.id);
    var componentUri = req.body.ComponentUri;
    var userId = req.decoded.user.id;
    var result = await general_helpers.isAllowedComponentByUri(componentUri, userId);
    let getUser = "SELECT * from admins where id =" + userId;
    let user = await sql.query(getUser);
    // var get_connected_devices = await sql.query("SELECT count(*) as total from usr_acc where dealer_id='" + userId + "'");

    // console.log(user);

    if (user.length) {

        const usr = {
            id: user[0].dealer_id,
            dealer_id: user[0].dealer_id,
            email: user[0].dealer_email,
            lastName: user[0].last_name,
            name: `${user[0].first_name} ${user[0].last_name}`,
            firstName: user[0].first_name,
            admin_name: `${user[0].first_name} ${user[0].last_name}`,
            dealer_email: user[0].dealer_email,
            link_code: user[0].link_code,
            connected_dealer: user[0].connected_dealer,
            // connected_devices: [],
            // account_status: user[0].account_status,
            user_type: req.decoded.user.user_type,
            created: user[0].created,
            modified: user[0].modified,
            two_factor_auth: user[0].is_two_factor_auth,
            verified: user[0].verified
        }

        res.json({
            'status': true,
            'msg': '',
            user: usr,
            ComponentAllowed: result
        });
    } else {
        res.send({
            status: false,
            msg: "authentication failed"
        });
    }
}

exports.offlineDevices = async function (req, res) {
    let devicesQ = `SELECT devices.*, white_labels.name as whitelabel FROM devices LEFT JOIN white_labels ON (devices.whitelabel_id = white_labels.id)`;
    let devices = await sql.query(devicesQ);
    devices.forEach((device) => {
        device.finalStatus = device_helpers.checkStatus(device)

        device.whitelabel = general_helpers.checkValue(device.whitelabel);
        device.fl_dvc_id = general_helpers.checkValue(device.fl_dvc_id)
        device.wl_dvc_id = general_helpers.checkValue(device.wl_dvc_id)
        device.status = general_helpers.checkValue(device.status)
        device.mac_address = general_helpers.checkValue(device.mac_address)
        device.serial_number = general_helpers.checkValue(device.serial_number);
    })
    if (devices.length) {
        res.send({
            status: true,
            devices
        })
    } else {
        res.send({
            status: false,
            msg: "No data found",
        })
    }

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

exports.deviceStatus = async function (req, res) {
    // console.log('deviceStatus at server: ', req.body);
    let id = req.body.data.id;
    let requiredStatus = req.body.requireStatus;
    let start_date = req.body.data.start_date;
    let expiry_date = req.body.data.expiry_date;
    try {
        let updateQ = '';
        if (start_date && expiry_date && id && requiredStatus == Constants.DEVICE_EXTEND) {
            updateQ = `UPDATE devices SET start_date= '${start_date}', expiry_date = '${expiry_date}', remaining_days = '2' WHERE id = ${id}`;
            console.log('update query is: ', updateQ);

        } else if (id && requiredStatus == Constants.DEVICE_ACTIVATED) {
            updateQ = `UPDATE devices SET account_status= '', status='active' WHERE id = ${id}`;
            console.log('deviceStatus update query is: ', updateQ);

        } else if (id && requiredStatus == Constants.DEVICE_SUSPENDED) {
            updateQ = `UPDATE devices SET account_status= 'suspended' WHERE id = ${id}`;
            console.log('deviceStatus update query is: ', updateQ);

        } else {
            res.send({
                status: false,
                msg: "No data found"
            })
        }
        if (updateQ != '') {
            sql.query(updateQ, async function (err, rslts) {
                if (err) {
                    console.log(err);
                    res.send({
                        status: false,
                        msg: "Error occur"
                    });
                } else {
                    res.send({
                        status: true,
                        msg: "update account_status successfully"
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
        data = {
            status: false,
            msg: "exception for deviceStatus",
        };
        res.send(data);
        return;
    }

}
exports.updateDeviceStatus = async function (req, res) {

    // console.log("Update Device", req.body);
    let linkToWL = req.body.linkToWL
    let SN = req.body.SN
    let mac = req.body.mac
    if (linkToWL) {
        let query = `UPDATE devices set status= 'deleted' where serial_number = '${SN}' AND mac_address = '${mac}'`
        console.log(query);
        sql.query(query);

    } else {
        let start_date = moment();
        let expiry_date = moment(start_date).add(1, 'M');
        start_date = moment(start_date).format()
        expiry_date = moment(expiry_date).format();
        let query = `UPDATE devices set status= 'active', start_date = '${start_date}' , expiry_date = '${expiry_date}' , remaining_days = '30' where serial_number = '${SN}' AND mac_address = '${mac}'`
        // console.log(query);
        sql.query(query)
    }

    res.send();



    

}


exports.saveIdPrices = async function (req, res) {
    // console.log('data is', req.body)

    let data = req.body.data;
    if (data) {
        // console.log(data, 'data')
        let whitelabel_id = req.body.whitelabel_id;
        if (whitelabel_id) {
            // console.log(whitelabel_id, 'whitelableid');
            let error = 0;

            let month = ''
            for (var key in data) {
                if (data.hasOwnProperty(key)) {
                    // console.log(key + " -> " + data[key]);
                    let outerKey = key;

                    let innerObject = data[key];
                    // console.log('iner object is', innerObject)
                    for (var innerKey in innerObject) {
                        if (innerObject.hasOwnProperty(innerKey)) {
                            let days = 0;
                            // console.log(innerKey + " -> " + innerObject[innerKey]);
                            if (innerObject[innerKey]) {

                                // console.log('is string', string)
                                let stringarray = [];

                                stringarray = innerKey.split(/(\s+)/).filter(function (e) { return e.trim().length > 0; });
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
                            // console.log(days, 'days are')
                            let unit_price = innerKey;
                            let updateQuery = "UPDATE prices SET unit_price='" + innerObject[innerKey] + "', price_expiry='" + days + "', whitelabel_id='" + whitelabel_id + "' WHERE price_term='" + innerKey + "' AND price_for='" + key + "'";
                            // console.log(updateQuery, 'query')
                            sql.query(updateQuery, async function (err, result) {
                                if (err) throw err;
                                if (result) {
                                    // console.log('outerKey', outerKey)
                                    if (!result.affectedRows) {
                                        let insertQuery = "INSERT INTO prices (price_for, unit_price, price_term, price_expiry, whitelabel_id) VALUES('" + outerKey + "', '" + innerObject[innerKey] + "', '" + unit_price + "', '" + days + "', '" + whitelabel_id + "')";
                                        // console.log('insert query', insertQuery)
                                        let rslt = await sql.query(insertQuery);
                                        if (rslt) {
                                            if (rslt.affectedRows == 0) {
                                                error++;
                                            }
                                        }
                                        // console.log(rslt, 'inner rslt')
                                    }
                                }
                            })
                        }
                    }

                }
            }
            console.log('errors are ', error)

            if (error == 0) {
                res.send({
                    status: true,
                    msg: 'Prices Set Successfully'
                })
            } else {
                res.send({
                    status: false,
                    msg: 'Some Error Accured'
                })
            }

        } else {
            res.send({
                status: false,
                msg: 'Invalid WhiteLabel'
            })
        }

    } else {
        res.send({
            status: false,
            msg: 'Invalid Data'
        })
    }
}


exports.savePackage = async function (req, res) {
    console.log('data is', req.body)

    let data = req.body.data;
    if (data) {
        // console.log(data, 'data')
        let whitelabel_id = req.body.data.whitelabel_id;
        if (whitelabel_id) {
            // console.log(whitelabel_id, 'whitelableid');
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
            sql.query(insertQuery, (err, rslt) => {
                if (err) throw err;
                if (rslt) {
                    if (rslt.affectedRows) {
                        res.send({
                            status: true,
                            msg: 'Package Saved Successfully'
                        })
                    }
                }
            })

        } else {
            res.send({
                status: false,
                msg: 'Invalid Whitelabel'
            })
        }
    } else {
        res.send({
            status: false,
            msg: 'Invalid Data'
        })
    }
}



exports.getPrices = async function(req, res) {
    let whitelebel_id = req.params.whitelabel_id;
    let sim_id = {};
    let chat_id = {};
    let pgp_email = {};
    let vpn = {};
    if(whitelebel_id){
        let selectQuery = "SELECT * FROM prices WHERE whitelabel_id='"+whitelebel_id+"'";
        sql.query(selectQuery, async (err, reslt) => {
             if(err) throw err;
             if(reslt){
                //  console.log('result for get prices are is ', reslt);
               
                 if(reslt.length){
                     for(let item of reslt){
                         if(item.price_for == 'sim_id'){
                            sim_id[item.price_term] = item.unit_price
                         }else if(item.price_for == 'chat_id'){
                            chat_id[item.price_term] = item.unit_price
                        }else if(item.price_for == 'pgp_email'){
                            pgp_email[item.price_term] = item.unit_price
                        }else if(item.price_for == 'vpn'){
                            vpn[item.price_term] = item.unit_price
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
                 }
                
             }else{
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
    }else{

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