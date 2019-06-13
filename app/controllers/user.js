const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');
const { sql } = require('../../config/database');
const multer = require('multer');
var path = require('path');
var fs = require("fs");
var XLSX = require('xlsx');
var empty = require('is-empty');
const constant = require('../../constants/application');

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
    } else if (fieldName === "sc_apk") {
        file = req.files.sc_apk;
    } else {
        res.send({
            status: false,
            msg: "Error while uploading"
        })
        return;
    }

    filePath = file.path;
    mimeType = file.type;

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
                    status: true,
                    fileName: fileName
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

                                sql.query(`UPDATE whitelabel_apks SET apk_file='${apk}', apk_size='${formatByte}', version_name='${versionName}', version_code='${versionCode}' WHERE whitelabel_id = '${whiteLabelId}' AND package_name = '${packageName}' AND label = '${label}'`, (error, sResult) => {
                                    if (error) {
                                        data = {
                                            status: false,
                                            msg: "Error While Uploading"
                                        };
                                        res.send(data);
                                        return;
                                    }

                                    if (sResult && !sResult.affectedRows) {
                                        sql.query(`INSERT INTO whitelabel_apks (apk_file, whitelabel_id, package_name, apk_size, label, version_name, version_code) VALUES ('${apk}', ${whiteLabelId}, '${packageName}', '${formatByte}', '${label}', '${versionName}', '${versionCode}')`);
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

    let fileName = "";
    let mimeType = "";
    let fieldName = req.params.fieldName;
    let filePath = "";
    let file = null;

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
                    let slctQ = "SELECT sim_id, start_date, expiry_date from sim_ids WHERE sim_id IN (" + sim + ")";
                    let dataof = await sql.query(slctQ);
                    if (dataof.length) {
                        // console.log(parsedData, 'daata of', dataof);

                        for (let row of parsedData) {

                            let index = dataof.findIndex((item) => item.sim_id == row.sim_id);

                            if (index >= 0) {
                                duplicatedSimIds.push(row)
                            } else {
                                InsertableSimIds.push(row)
                            }
                        }
                    }

                    if (duplicatedSimIds.length == 0) {
                        for (let row of parsedData) {
                            if (row.sim_id && row.start_date && row.expiry_date) {
                                let result = await sql.query("INSERT sim_ids (sim_id, start_date, expiry_date) value ('" + row.sim_id + "', '" + row.start_date + "', '" + row.expiry_date + "')");
                            } else {
                                error = true;
                            }
                        }
                    }

                    // console.log('duplicate data is', duplicatedSimIds)

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
                    let slctQ = "SELECT chat_id from chat_ids WHERE chat_id IN (" + chat_ids + ")";
                    let dataof = await sql.query(slctQ);
                    if (dataof.length) {
                        // console.log(parsedData, 'daata of', dataof);

                        for (let row of parsedData) {

                            let index = dataof.findIndex((item) => item.chat_id == row.chat_id);

                            if (index >= 0) {
                                duplicatedChat_ids.push(row)
                            } else {
                                InsertableChat_ids.push(row)
                            }
                        }
                    }

                    if (duplicatedChat_ids.length == 0) {
                        for (let row of parsedData) {
                            if (row.chat_id) {
                                let result = await sql.query("INSERT chat_ids (chat_id) value ('" + row.chat_id + "')");
                            } else {
                                error = true;
                            }
                        }
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
                    let slctQ = "SELECT pgp_email from pgp_emails WHERE pgp_email IN (" + pgp_emails.map(item => { return "'" + item + "'" }) + ")";
                    // console.log('pgp query', slctQ)
                    let dataof = await sql.query(slctQ);
                    if (dataof.length) {
                        // console.log(parsedData, 'daata of', dataof);

                        for (let row of parsedData) {

                            let index = dataof.findIndex((item) => item.pgp_email == row.pgp_email);

                            if (index >= 0) {
                                duplicatedPgp_emails.push(row)
                            } else {
                                InsertablePgp_emails.push(row)
                            }
                        }
                    }

                    if (duplicatedPgp_emails.length == 0) {
                        for (let row of parsedData) {
                            if (row.pgp_email) {
                                let result = await sql.query("INSERT pgp_emails (pgp_email) value ('" + row.pgp_email + "')");
                            } else {
                                error = true;
                            }
                        }
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

                    return;
                }

            });
        } else {
            res.send({
                status: false,
                msg: "Incorrect file data",
                "duplicateData": [],
            })
        }
    } else {
        res.send({
            status: false,
            msg: "Incorrect file data",
            "duplicateData": [],
        })
    }


    // }
}

exports.getSimIds = async function (req, res) {
    let query = "select * from sim_ids where used=0";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}

exports.getChatIds = async function (req, res) {
    let query = "select * from chat_ids where used=0";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}

exports.getPgpEmails = async function (req, res) {
    let query = "select * from pgp_emails where used=0";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}



exports.getUsedSimIds = async function (req, res) {
    let query = "select * from sim_ids where used=1";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}

exports.getUsedChatIds = async function (req, res) {
    let query = "select * from chat_ids where used=1";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}

exports.getUsedPgpEmails = async function (req, res) {
    let query = "select * from pgp_emails where used=1";
    sql.query(query, (error, resp) => {
        console.log(resp, 'is response')
        res.send({
            status: false,
            msg: "data success",
            data: resp
        });
    });
}