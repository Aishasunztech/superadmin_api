// Libraries
var cron = require('node-cron');
var { sql } = require('../config/database');
var mysqldump = require('mysqldump')
var XLSX = require('xlsx');
var path = require('path');
var archiver = require('archiver');
var fs = require("fs");
var moment = require('moment-strftime');

// constants
const fixer = require('../lib/fixer-api');
const constants = require('../config/constants');
const device_helpers = require('../helpers/device_helpers');
const general_helpers = require('../helpers/general_helpers');

cron.schedule('0 0 0 * * Sunday', async () => {
    let whiteLabelQ = `SELECT * FROM white_labels WHERE status=1`;
    let whiteLabels = await sql.query(whiteLabelQ);
    for (let index = 0; index < whiteLabels.length; index++) {
        let host = whiteLabels[index].ip_address;
        let dbUser = whiteLabels[index].db_user;
        let dbPass = whiteLabels[index].db_pass;
        let dbName = whiteLabels[index].db_name;
        if (host && dbUser && dbPass && dbName) {

            let host_db_conn = await general_helpers.getDBCon(host, dbUser, dbPass, dbName);
            if (host_db_conn) {
                // console.log(host_db_conn);
                // console.log("Working");
                let milliSeconds = Date.now();
                let fileName = 'dump_' + dbName + '_' + milliSeconds
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

// cron.schedule("0 0 * * * *", async () => {
/**
 * @author Usman Hafeez
 * @description run fixer cron twice in a day
 */
cron.schedule("0 0 */12 * * *", async () => {
    try {
        fixer.latest({ base: constants.BASE_CURRENCY }).then((data) => {
            if (data && data.success) {

                let updateCurrencyQ = `UPDATE currencies SET base='${constants.BASE_CURRENCY}', data='${JSON.stringify(data.rates)}'`;
                sql.query(updateCurrencyQ, async function (error, updateResult) {
                    if (error) {
                        console.log("query error occurred:", error);
                        return;
                    }

                    if (updateResult && updateResult.affectedRows) {
                        console.log("successfully updated record");
                    } else {

                        let insertCurrencyQ = `INSERT INTO currencies (base, data) VALUES ('${constants.BASE_CURRENCY}', '${JSON.stringify(data.rates)}')`;
                        sql.query(insertCurrencyQ, await function (error, insertResult) {
                            if (error) {
                                console.log("query error occurred", error);
                                return;
                            }

                            if (insertResult) {
                                console.log("inserted successfully", insertResult);
                            }
                        })
                    }
                })

            } else {
                console.log("data not fetched by api");
            }
        }).catch((error) => {
            console.log("api error:", error.message);
        });

    } catch (error) {
        console.log("api key error:", error.message);
    }
})

cron.schedule('0 0 0 * * *', async () => {



    // =========== get usage records for accounts on daily basis
    // constants.twilioClient.wireless.sims.list({
    //     pageSize: 1
    // }).then((sims) => {
    //     if (sims && sims.length) {

    //         console.log('sim data => ', sims)
    //         // sims.forEach(sim => {
    //         //     // sim.usageRecords.then((simUsageRecords)=>{
    //         //     //     console.log('simUsageRecords => ', simUsageRecords)
    //         //     // })
    //         //     // sim.usageRecords().then((simUsage) => {
    //         //     //     console.log(simUsage)
    //         //     // }).catch(error=>{
    //         //     //     console.log('error while getting usage record of sim: ', error)
    //         //     // })
    //         // })
    //     }
    // }).catch(error => {
    //     console.log('error occurred while getting sims: ', error)
    // })

    //get each record... slower
    constants.twilioClient.wireless.sims.each({
        pageSize: 1
    }, sim => {
        try {
            console.log(sim.sid);
            sim.usageRecords().each(({
                start: new Date()
            }), (simUsageRecords) => {
                // console.log(simUsageRecords)
                // {
                //     simSid: 'DE119ed7cbd13555e1371e8dfb3b1d2c9a',
                //     accountSid: 'AC2383c4b776efb51c86cc6f9a5cdb4e89',
                //     period: { start: '2020-02-25T00:00:00Z', end: '2020-02-26T00:00:00Z' },
                //     commands: {
                //         billing_units: 'USD',
                //         from_sim: null,
                //         to_sim: null,
                //         national_roaming: {
                //             billing_units: 'USD',
                //             billed: 0,
                //             total: 0,
                //             from_sim: 0,
                //             to_sim: 0
                //         },
                //         home: {
                //             billing_units: 'USD',
                //             billed: 0,
                //             total: 0,
                //             from_sim: 0,
                //             to_sim: 0
                //         },
                //         international_roaming: [],
                //         billed: 0,
                //         total: null
                //     },
                //     data: {
                //         billing_units: 'USD',
                //         upload: 490053,
                //         download: 766389,
                //         national_roaming: {
                //             billing_units: 'USD',
                //             upload: 0,
                //             download: 0,
                //             units: 'bytes',
                //             billed: 0,
                //             total: 0
                //         },
                //         home: {
                //             billing_units: 'USD',
                //             upload: 0,
                //             download: 0,
                //             units: 'bytes',
                //             billed: 0,
                //             total: 0
                //         },
                //         units: 'bytes',
                //         international_roaming: [[Object]],
                //         billed: 0.0585,
                //         total: 1256442
                //     }
                // }
            })
        } catch (error) {
            console.log(error)
        }
    })

    // constants.twilioClient.usage
    //     .records
    //     .daily
    //     // .loadPage({category: 'wireless'})
    //     // // .get
    //     .page({
    //         category:'wireless',
    //         pageSize: 2
    //     })
    //     // .each((usageRecords) => {
    //     //     console.log(usageRecords)
    //     // })
    //     .then((usageRecords) => {
    //         // console.log("hello: ", h)
    //         if(!usageRecords){

    //         }

    //     })

})