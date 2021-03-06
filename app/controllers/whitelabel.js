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
var mysqldump = require('mysqldump')
var archiver = require('archiver');

var node_ssh = require('node-ssh')
ssh = new node_ssh()

exports.getWhiteLabels = async function (req, res) {
    let whiteLabelsQ = ''
    if (req.params.type === 'all') {
        console.log("hello all servers");
        whiteLabelsQ = "SELECT id, name, route_uri, api_url FROM white_labels";
    }
    // else if (req.params.type === 'whitelabels') {

    //     whiteLabelsQ = "SELECT id, name, route_uri, api_url FROM white_labels WHERE status=1";
    // } 
    else {
        whiteLabelsQ = "SELECT id, name, route_uri, api_url FROM white_labels WHERE status=1";
    }
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

exports.updateWhiteLabelInfo = async function (req, res) {
    try {
        // console.log(req.body, 'body data is')
        let model_id = req.body.model_id;
        let command_name = req.body.command_name;
        let apk_files = req.body.apk_files;
        // let apk_type = req.body.apk_type ? req.body.apk_type : '';
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
                        for (let item of apk_files) {
                            let apk = item.apk;
                            let apk_type = item.apk_type;
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
                                // if (is_byod == 1) {

                                query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND apk_type='${apk_type}'`
                                // } else {
                                // query = `UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}' , version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND package_name = '${packageName}' AND label = '${label}'`
                                // } 
                                // console.log(query)
                                console.log(apk_type, 'sdfsdfsdfsdf')
                                if (apk_type == 'LAUNCHER' || apk_type == 'SCS' || apk_type == 'BYOD' || apk_type == 'BYOD7') {
                                    sql.query(query, (error, sResult) => {
                                        if (error) {
                                            data = {
                                                status: false,
                                                msg: "Error While Uploading"
                                            };
                                            res.send(data);
                                            return;
                                        }
                                        // console.log(sResult.affectedRows)

                                        if (sResult && !sResult.affectedRows) {
                                            sql.query(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code , apk_type) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}' , '${apk_type}')`);
                                        }
                                    });
                                } else {
                                    data = {
                                        status: false,
                                        msg: "Invalid Apk"
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
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/sim_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later"
                                            };
                                            res.send(data);
                                            return
                                        });;
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
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/chat_ids', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later"
                                            };
                                            res.send(data);
                                            return
                                        });;
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
                                        await axios.post(WHITE_LABEL_BASE_URL + '/users/import/pgp_emails', { parsedData }, { headers: { 'authorization': loginResponse.token } }).catch((error) => {
                                            data = {
                                                "status": false,
                                                "msg": "White Label server not responding. PLease try again later"
                                            };
                                            res.send(data);
                                            return
                                        });;
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

// get ids with label
exports.getLabelSimIds = async function (req, res) {
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

exports.getLabelChatIds = async function (req, res) {
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

exports.getLabelPgpEmails = async function (req, res) {
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
            // console.log('errors are ', error)

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
    // console.log('data is', req.body)

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



exports.getPrices = async function (req, res) {
    let whitelebel_id = req.params.whitelabel_id;
    let sim_id = {};
    let chat_id = {};
    let pgp_email = {};
    let vpn = {};
    if (whitelebel_id) {
        let selectQuery = "SELECT * FROM prices WHERE whitelabel_id='" + whitelebel_id + "'";
        sql.query(selectQuery, async (err, reslt) => {
            if (err) throw err;
            if (reslt) {
                //  console.log('result for get prices are is ', reslt);

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

exports.restartWhitelabel = async function (req, res) {

    let wlID = req.body.wlID;
    if (!empty(wlID)) {

        let whitelabelQ = `SELECT * FROM white_labels WHERE id =${wlID}`;

        let whitelabel = await sql.query(whitelabelQ);
        if (whitelabel.length) {
            let sshUser = whitelabel[0].ssh_user;
            let sshPort = whitelabel[0].ssh_port;
            let sshPass = whitelabel[0].ssh_pass;

            if (whitelabel[0].status) {
                // database
                let host = whitelabel[0].ip_address;
                let dbUser = whitelabel[0].db_user;
                let dbPass = whitelabel[0].db_pass;
                let dbName = whitelabel[0].db_name;


                if (!empty(host) && !empty(dbUser) && !empty(dbPass) && !empty(dbName)) {

                    let host_db_conn = await general_helpers.getDBCon(host, dbUser, dbPass, dbName);
                    if (host_db_conn) {
                        console.log("db connection established");

                        let deletePushPoliciesQ = "DELETE FROM policy_queue_jobs";
                        await host_db_conn.query(deletePushPoliciesQ);
                        try {
                            await rebootServer(host, sshUser, sshPort, sshPass, whitelabel, res);
                        } catch (error) {
                            console.log(error);
                            res.send({
                                status: true,
                                msg: "Server Rebooted"
                            });
                        }

                    } else {
                        res.send({
                            status: false,
                            msg: "Invalid Credentials"
                        })
                    }

                } else {
                    res.send({
                        status: false,
                        msg: "Invalid Credentials"
                    })
                }
            } else {
                try {
                    await rebootServer(host, sshUser, sshPort, sshPass, whitelabel, res);
                } catch (error) {
                    console.log(error);
                    res.send({
                        status: true,
                        msg: "Server Rebooted"
                    });
                }
            }

        } else {
            res.send({
                status: false,
                msg: "Invalid Credentials"
            })
        }

    } else {
        res.send({
            status: false,
            msg: "whitelabel not defined"
        })
    }
}


exports.saveBackup = async function (req, res) {

    let id = req.body.id;
    if (!empty(id)) {

        let whitelabelQ = `SELECT * FROM white_labels WHERE id =${id}`;

        let whiteLabels = await sql.query(whitelabelQ);
        if (whiteLabels.length) {
            let host = whiteLabels[0].ip_address;
            let dbUser = whiteLabels[0].db_user;
            let dbPass = whiteLabels[0].db_pass;
            let dbName = whiteLabels[0].db_name;
            if (!empty(host) && !empty(dbUser) && !empty(dbPass) && !empty(dbName)) {

                let host_db_conn = await general_helpers.getDBCon(host, dbUser, dbPass, dbName);
                if (host_db_conn) {
                    // console.log(host_db_conn);
                    // console.log("Working");
                    let miliSeconds = Date.now();
                    let fileName = 'dump_' + dbName + '_' + miliSeconds
                    // let filePath = path.join(__dirname, "../db_backup/"  + file_name);
                    let dumpFileName = fileName + '.sql';
                    let file = path.join(__dirname, "../../db_backup/" + dumpFileName)
                    console.log(file);
                    await mysqldump({
                        connection: {
                            host: host,
                            user: dbUser,
                            password: dbPass,
                            database: dbName,
                        },
                        dumpToFile: file,
                    });
                    console.log("CHECKing");

                    let allTables = await host_db_conn.query(`SELECT TABLE_NAME AS _table FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '${dbName}'`)
                    let tables = allTables.map(function (item) {
                        return item._table
                    })
                    let ws;
                    let wb = XLSX.utils.book_new();

                    for (let i = 0; i < tables.length; i++) {
                        let tableDate = await host_db_conn.query(`SELECT * from ${tables[i]}`)
                        if (tableDate.length) {
                            /* make the worksheet */
                            ws = XLSX.utils.json_to_sheet(tableDate);

                            /* add to workbook */
                            XLSX.utils.book_append_sheet(wb, ws, tables[i]);
                        }
                    }
                    let fileNameCSV = fileName + '.xlsx';
                    console.log(path.join(__dirname, "../../db_backup/" + fileNameCSV));
                    await XLSX.writeFile(wb, path.join(__dirname, "../../db_backup/" + fileNameCSV));
                    var archive = archiver('zip', {
                        gzip: true,
                        zlib: { level: 9 },
                        forceLocalTime: true,
                        // password: 'test'
                    });

                    let zipFileName = fileName + ".zip"

                    var output = fs.createWriteStream(path.join(__dirname, "../../db_backup/" + zipFileName));


                    archive.on('error', function (err) {
                        throw err;
                    });

                    // pipe archive data to the output file
                    archive.pipe(output);

                    // append files
                    archive.file(path.join(__dirname, "../../db_backup/" + fileNameCSV), { name: 'DataBase_Backup_excel.xlsx' });
                    archive.file(path.join(__dirname, "../../db_backup/" + dumpFileName), { name: 'DataBase_Backup_sql.sql' });

                    //
                    archive.finalize();

                    output.on('close', async function () {
                        console.log("archive closed");
                        let saveHistory = `INSERT into db_backups (whitelabel_id, backup_name, db_file) VALUES (${whiteLabels[0].id}, '${fileName}', '${zipFileName}')`
                        let result = await sql.query(saveHistory);
                        if (result.affectedRows > 0) {
                            console.log(result.insertId)
                            let data = await sql.query("SELECT * from db_backups where id = " + result.insertId)
                            res.send({
                                status: true,
                                msg: "Database backup created successfullly.",
                                data: data[0]
                            })
                        }
                    });

                }
            }
        } else {
            res.send({
                status: false,
                msg: "Invalid Credentials"
            })
        }

    } else {
        res.send({
            status: false,
            msg: "whitelabel not defined"
        })
    }
}

exports.getDomains = async function (req, res) {
    let whitelebel_id = req.params.whitelabel_id;
    if (whitelebel_id) {
        let selectQuery = `SELECT * FROM domains WHERE whitelabel_id='${whitelebel_id}' AND delete_status = 0`;
        sql.query(selectQuery, async (err, reslt) => {
            if (err) {
                console.log(err);
                res.send({
                    status: false,
                    data: []
                })
                return
            };
            if (reslt) {
                // console.log('result for get packages are is ', reslt);

                if (reslt.length) {
                    // console.log(reslt, 'reslt data of prices')
                    res.send({
                        status: true,
                        msg: "Data found",
                        data: reslt

                    })
                    return
                } else {
                    res.send({
                        status: true,
                        msg: "Data not found",
                        data: []

                    })
                    return
                }

            } else {

                res.send({
                    status: true,
                    msg: "Domain not Found ",
                    data: []
                })
                return
            }
        })
    } else {

        res.send({
            status: false,
            msg: 'Invalid Whitelabel_id',
            data: []

        })
        return
    }
}


exports.addDomain = async function (req, res) {
    let whitelabel_id = req.body.whitelabel_id;
    let domain = req.body.domain_name;
    let WHITE_LABEL_BASE_URL = '';
    let getApiURL = await sql.query(`SELECT * from white_labels where id = ${whitelabel_id}`)
    if (getApiURL.length) {
        let alreadyAdded = await sql.query(`SELECT * FROM domains WHERE whitelabel_id = ${whitelabel_id} AND domain_name = '${domain}' AND delete_status = 0`)
        if (alreadyAdded && alreadyAdded.length) {
            res.send({
                status: false,
                msg: 'Domain already added on whitelabel.Please Choose another domain.'
            })
            return
        }
        if (getApiURL[0].api_url) {
            WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
            axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                if (response.data.status) {
                    loginResponse = response.data;
                    let data = {
                        domain: domain
                    }
                    axios.post(WHITE_LABEL_BASE_URL + '/users/add-domain', { data }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                        if (response.data.status) {
                            let insertQuery = "INSERT INTO domains (whitelabel_id , domain_name) VALUES('" + whitelabel_id + "','" + domain + "')";
                            sql.query(insertQuery, async (err, rslt) => {
                                if (err) {
                                    res.send({
                                        status: false,
                                        msg: 'Domain has been saved on Whitelabel But Superadmin server encountered by some internal error.',
                                    })
                                    return
                                };
                                if (rslt.affectedRows) {
                                    insertedRecord = await sql.query("SELECT * FROM domains WHERE id='" + rslt.insertId + "'")
                                    res.send({
                                        status: true,
                                        msg: 'Domain Saved Successfully.',
                                        data: insertedRecord[0]
                                    })
                                    return
                                } else {
                                    res.send({
                                        status: false,
                                        msg: 'Domain has been saved on Whitelabel But Superadmin server encountered by some internal error.',
                                    })
                                    return
                                }

                            })
                        } else {
                            res.send({
                                status: false,
                                msg: response.data.msg
                            })
                            return

                        }
                    }).catch((error) => {
                        data = {
                            "status": false,
                            "msg": "White Label server not responding. PLease try again later",
                        };
                        res.send(data);
                        return
                    });;

                }
                else {
                    res.send({
                        status: false,
                        msg: "you are not allowed to perform this action.",
                    })
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

}


exports.editDomain = async function (req, res) {
    let whitelabel_id = req.body.whitelabel_id;
    let id = req.body.id;
    let domain = req.body.domain_name;
    let WHITE_LABEL_BASE_URL = '';
    let checkDomain = await sql.query(`SELECT * FROM domains WHERE whitelabel_id = ${whitelabel_id} AND id = ${id} AND delete_status = 0`)

    if (checkDomain.length == 0) {
        res.send({
            status: false,
            msg: 'ERROR: Domain not found on server.'
        })
        return
    }

    let getApiURL = await sql.query(`SELECT * from white_labels where id = ${whitelabel_id}`)
    if (getApiURL.length) {
        let alreadyAdded = await sql.query(`SELECT * FROM domains WHERE whitelabel_id = ${whitelabel_id} AND domain_name = '${domain}' AND id != ${id}`)
        if (alreadyAdded && alreadyAdded.length) {
            res.send({
                status: false,
                msg: 'Domain already added on whitelabel.Please Choose another domain.'
            })
            return
        }
        if (getApiURL[0].api_url) {
            WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
            axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                if (response.data.status) {
                    loginResponse = response.data;
                    let data = {
                        domain: domain,
                        oldDomain: checkDomain[0].domain_name
                    }
                    axios.put(WHITE_LABEL_BASE_URL + '/users/edit-domain', { data }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                        if (response.data.status) {
                            let insertQuery = `UPDATE domains SET domain_name = '${domain}' WHERE id = ${id}`;
                            sql.query(insertQuery, async (err, rslt) => {
                                if (err) {
                                    res.send({
                                        status: false,
                                        msg: 'Domain has been updated on Whitelabel But Superadmin server encountered by some internal error.',
                                    })
                                    return
                                };
                                if (rslt.affectedRows) {
                                    res.send({
                                        status: true,
                                        msg: 'Domain has been updated Successfully.',
                                    })
                                    return
                                } else {
                                    res.send({
                                        status: false,
                                        msg: 'Domain has been updated on Whitelabel But Superadmin server encountered by some internal error.',
                                    })
                                    return
                                }

                            })
                        } else {
                            res.send({
                                status: false,
                                msg: response.data.msg
                            })
                            return

                        }
                    }).catch((error) => {
                        data = {
                            "status": false,
                            "msg": "White Label server not responding. PLease try again later",
                        };
                        res.send(data);
                        return
                    });;

                }
                else {
                    res.send({
                        status: false,
                        msg: "you are not allowed to perform this action.",
                    })
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

}


exports.deleteDomains = async function (req, res) {
    let whitelabel_id = req.params.whitelabel_id;
    let domain_id = req.params.domain_id
    // console.log(domain_id);
    if (whitelabel_id) {
        let selectQuery = `SELECT * FROM domains WHERE whitelabel_id='${whitelabel_id}' AND id = ${domain_id} AND delete_status = 0`;
        sql.query(selectQuery, async (err, reslt) => {
            if (err) {
                console.log(err);
                res.send({
                    status: false,
                    data: []
                })
                return
            };
            if (reslt.length) {

                let getApiURL = await sql.query(`SELECT * from white_labels where id = ${whitelabel_id}`)
                if (getApiURL.length) {
                    if (getApiURL[0].api_url) {
                        WHITE_LABEL_BASE_URL = getApiURL[0].api_url;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                            if (response.data.status) {
                                loginResponse = response.data;
                                let data = {
                                    domain_name: reslt[0].domain_name,
                                }
                                axios.put(WHITE_LABEL_BASE_URL + '/users/delete-domain', { data }, { headers: { 'authorization': loginResponse.token } }).then((response) => {
                                    if (response.data.status) {
                                        let deleteQ = `UPDATE domains SET delete_status = 1 WHERE id = ${domain_id}`
                                        sql.query(deleteQ, function (err, result) {
                                            if (err) {
                                                console.log(err);
                                                res.send({
                                                    status: false,
                                                    msg: "ERROR:  Domain not deleted.Please Try again.",
                                                })
                                                return
                                            }
                                            if (result.affectedRows) {
                                                res.send({
                                                    status: true,
                                                    msg: "Domain Has been Deleted SuccessFully.",
                                                })
                                                return

                                            } else {
                                                res.send({
                                                    status: false,
                                                    msg: "ERROR: Domain not deleted. Please try again later.",
                                                })
                                                return
                                            }
                                        })
                                    } else {
                                        res.send({
                                            status: false,
                                            msg: response.data.msg
                                        })
                                        return

                                    }
                                }).catch((error) => {
                                    data = {
                                        "status": false,
                                        "msg": "White Label server not responding. PLease try again later",
                                    };
                                    res.send(data);
                                    return
                                });;

                            }
                            else {
                                res.send({
                                    status: false,
                                    msg: "you are not allowed to perform this action.",
                                })
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
                    msg: "ERROR: Domain not Found.",
                })
                return
            }
        })
    } else {
        res.send({
            status: false,
            msg: 'ERROR: Invalid Whitelabel'
        })
        return
    }
}

async function rebootServer(host, sshUser, sshPort, sshPass, whitelabel, res) {
    if (!empty(whitelabel[0].api_cmd)) {
        ssh.connect({
            host: host,
            username: sshUser,
            port: sshPort,
            password: sshPass
            // privateKey: '/home/steel/.ssh/id_rsa'
        }).then(function () {
            console.log("executing system command");
            ssh.execCommand(`sudo ${whitelabel[0].api_cmd}`, { cwd: '/var/www/html/' }).then(function (result) {
                console.log(result);
                if (result.stderr) {
                    res.send({
                        status: false,
                        msg: "Invalid Credentials"
                    });
                }
                // if (result.stdout) {    
                res.send({
                    status: true,
                    msg: "Server Rebooted"
                });
                return;
            });
        }).catch(function (error) {
            res.send({
                status: false,
                msg: "Invalid Credentials"
            });
            return;
        });
    } else {
        res.send({
            status: false,
            msg: "Invalid Credentials"
        });
        return;
    }
}
