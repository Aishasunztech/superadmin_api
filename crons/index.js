var cron = require('node-cron');
var { sql } = require('../config/database');
var mysqldump = require('mysqldump')
var empty = require('is-empty');
var XLSX = require('xlsx');
var path = require('path');
var archiver = require('archiver');
var fs = require("fs");
var moment = require('moment-strftime');
const fixer = require('../lib/fixer-api');

const constants = require('../config/constants');
const device_helpers = require('../helpers/device_helpers');
const general_helpers = require('../helpers/general_helpers');

cron.schedule('0 0 0 * * *', async () => {
    let whiteLabelQ = `SELECT * FROM white_labels`;
    let whiteLabels = await sql.query(whiteLabelQ);
    for (let index = 0; index < whiteLabels.length; index++) {
        let host = whiteLabels[index].ip_address;
        let dbUser = whiteLabels[index].db_user;
        let dbPass = whiteLabels[index].db_pass;
        let dbName = whiteLabels[index].db_name;
        if (!empty(host) && !empty(dbUser) && !empty(dbPass) && !empty(dbName)) {

            let host_db_conn = await general_helpers.getDBCon(host, dbUser, dbPass, dbName);
            if (host_db_conn) {
                // console.log(host_db_conn);
                // console.log("Working");
                let miliSeconds = Date.now();
                let fileName = 'dump_' + dbName + '_' + miliSeconds
                // let filePath = path.join(__dirname, "../db_backup/"  + file_name);
                let dumpFileName = fileName + '.sql';

                let result = await mysqldump({
                    connection: {
                        host: host,
                        user: dbUser,
                        password: dbPass,
                        database: dbName,
                    },
                    dumpToFile: './db_backup/' + dumpFileName,
                });

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
                await XLSX.writeFile(wb, path.join(__dirname, "../db_backup/" + fileNameCSV));

                var archive = archiver('zip', {
                    gzip: true,
                    zlib: { level: 9 },
                    forceLocalTime: true,
                    // password: 'test'
                });

                let zipFileName = fileName + ".zip"
                var output = fs.createWriteStream("./db_backup/" + zipFileName);


                archive.on('error', function (err) {
                    throw err;
                });

                // pipe archive data to the output file
                archive.pipe(output);

                // append files
                archive.file(path.join(__dirname, "../db_backup/" + fileNameCSV), { name: 'DataBase_Backup_excel.xlsx' });
                archive.file(path.join(__dirname, "../db_backup/" + dumpFileName), { name: 'DataBase_Backup_sql.sql' });

                //
                archive.finalize();

                output.on('close', async function () {
                    let saveHistory = `INSERT into db_backups (whitelabel_id, backup_name, db_file) VALUES (${whiteLabels[index].id}, '${fileName}', '${zipFileName}')`
                    await sql.query(saveHistory);
            
                });
            }

        }
    }
});


cron.schedule('0 0 0 * * *', async () => {
    let today = moment().format('DD-MM-YY');
    console.log("today", today);
    var deviceQ = "select * from devices";
    var devices = await sql.query(deviceQ);
    for (var i = 0; i < devices.length; i++) {
        let dvcDate = moment(devices[i].expiry_date).format('DD-MM-YY')
        console.log("dvcDate", dvcDate)
        if (today >= dvcDate) {
            let updateDvcQ = `UPDATE devices SET status='expired' WHERE id='${devices[i].id}'`

            sql.query(updateDvcQ, function (error, results) {
                if (error) throw error;
                if (results.affectedRows == 0) {
                    console.log('not done');
                } else {

                }
            });

        }
    }
});

cron.schedule("0 0 * * * *", async () => {
    try {
        const data = await fixer.latest({ base: constants.BASE_CURRENCY });
        if(data && data.success){

            let updateCurrencyQ = `UPDATE currencies SET base='${constants.BASE_CURRENCY}', data='${JSON.stringify(data.rates)}'`;
            sql.query(updateCurrencyQ, async function(error, updateResult){
                if(error){
                    console.log("error occured", error);
                }

                if(updateResult && updateResult.affectedRows){
                    console.log("succesfully updated record");
                } else {
                    let insertCurrencyQ = `INSERT INTO currencies (base, data) VALUES ('${constants.BASE_CURRENCY}', '${JSON.stringify(data.rates)}')`;
                    sql.query(insertCurrencyQ, await function(error, insertResult){
                        if(error){
                            console.log("error occured", error);
                        }

                        if(insertResult){
                            console.log("inserted successfully", insertResult);
                        }
                    })
                }
            })

        } else {
            console.log("data not fetched by api");
        }

    } catch (error) {
        console.log("some error occured", error);
    }
})