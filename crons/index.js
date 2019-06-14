var cron = require('node-cron');
var { sql } = require('../config/database');
var mysqldump = require('mysqldump')
var empty = require('is-empty');
var XLSX = require('xlsx');

const device_helpers = require('../helpers/device_helpers');
const general_helpers = require('../helpers/general_helpers');

cron.schedule('0 0 * * * *', async () => {
    let whiteLabelQ = `SELECT * FROM white_labels`;
    let whiteLabels = await sql.query(whiteLabelQ);
    for (let index = 0; index < whiteLabels.length; index++) {
        let host = whiteLabels[index].ip_address;
        let dbUser = whiteLabels[index].db_user;
        let dbPass = whiteLabels[index].db_pass;
        let dbName = whiteLabels[index].db_name;
        if(!empty(host) && !empty(dbUser) && !empty(dbPass) && !empty(dbName)){

            let host_db_conn = await general_helpers.getDBCon(host, dbUser, dbPass, dbName);
            if(host_db_conn){
                // console.log(host_db_conn);
                
                // let result = await mysqldump({
                //     connection: {
                //         host: host,
                //         user: dbUser,
                //         password: dbPass,
                //         database: dbName,
                //     },
                // });
                
                // let allTables = await host_db_conn.query(`SELECT TABLE_NAME AS _table FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '${dbName}'`)
                // let tables = allTables.map(function (item) {
                //     return item._table
                // })
                // let ws;
                // let wb = XLSX.utils.book_new();
        
                // for (let i = 0; i < tables.length; i++) {
                //     let tableDate = await host_db_conn.query("SELECT * from " + tables[i])
                //     if (tableDate.length) {
                //         /* make the worksheet */
                //         ws = XLSX.utils.json_to_sheet(tableDate);
        
                //         /* add to workbook */
                //         XLSX.utils.book_append_sheet(wb, ws, tables[i]);
                //     }
                // }
                // let fileNameCSV = 'testDBBackup' + '_' + Date.now() + ".xlsx";
                // await XLSX.writeFile(wb, path.join(__dirname, "../db_backup/" + fileNameCSV));
                // console.log(result);
            }

        }
    }
});