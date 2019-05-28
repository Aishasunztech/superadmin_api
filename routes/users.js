var express = require('express');
var router = express.Router();
// import controller here


/* GET users listing. */
router.get('/', async function (req, res, next) {
    // let file = path.join(__dirname, "../uploads/gana.apk");
    // // let file = path.join(__dirname, "../uploads/apk-1541677256487.apk");
    // let packageName = await helpers.getAPKPackageName(file);
    // let versionName = await helpers.getAPKVersionName(file);
    // let versionCode = await helpers.getAPKVersionCode(file);
    // let label = await helpers.getAPKLabel(file);
    // res.send({
    //     packageName: packageName,
    //     versionName: versionName,
    //     versionCode: versionCode,
    //     label: label
    // });
    res.send("Express");

    // helpers.resetDB();
    // apk-ScreenLocker v3.31.apk

    // const unzip = zlib.createGunzip();
    // fileContents.pipe(unzip).pipe(writeStream);

    // const directoryFiles = fs.readdirSync(path.join(__dirname, "../"));

    // res.send(directoryFiles);
    // directoryFiles.forEach(filename => {
    // const fileContents = fs.createReadStream(`./data/${filename}`);
    // const writeStream = fs.createWriteStream(`./data/${filename.slice(0, -3)}`);
    // const unzip = zlib.createGunzip();
    // fileContents.pipe(unzip).pipe(writeStream);
    // });

    // var zip = new AdmZip(path.join(__dirname, "../uploads/apk-ScreenLocker v3.31.apk"));
    // var zipEntries = await zip.getEntries();
    // console.log(zipEntries.length)
    // res.send(zipEntries);
    // for (var i = 0; i < zipEntries.length; i++) {
    //   if (zipEntries[i].entryName.match(/readme/))
    //     console.log(zip.readAsText(zipEntries[i]));
    // }
});


// enable or disable two factor auth
router.post('/two_factor_auth', async function (req, res) {
    var verify = await verifyToken(req, res);
    if (verify['status'] !== undefined && verify.status === true) {
        let loggedDealerId = verify.user.id;
        isEnable = req.body.isEnable;
        let updateDealerQ = "UPDATE dealers SET is_two_factor_auth=" + isEnable + " WHERE dealer_id=" + loggedDealerId;
        let updatedDealer = await sql.query(updateDealerQ);
        if (updatedDealer.affectedRows) {
            if (isEnable) {
                res.send({
                    status: true,
                    msg: "Dual Authentication is Successfully enabled",
                    isEnable: isEnable
                })
            } else {
                res.send({
                    status: true,
                    msg: "Dual Authentication is Successfully disabled",
                    isEnable: isEnable
                })
            }
        } else {
            res.send({
                status: false,
                msg: "Dual Authentication could not be enabled"
            })
        }

    }
});


router.get('/get_allowed_components', async function (req, res) {
    res.setHeader('Content-Type', 'application/json');

    var verify = await verifyToken(req, res);
    if (verify['status'] !== undefined && verify.status == true) {

    }
});


router.post('/check_component', async function (req, res) {
    res.setHeader('Content-Type', 'application/json');

    var verify = await verifyToken(req, res);
    if (verify['status'] !== undefined && verify.status == true) {
        var componentUri = req.body.ComponentUri;
        var userId = verify.user.id;
        var result = await helpers.isAllowedComponentByUri(componentUri, userId);
        let getUser = "SELECT * from dealers where dealer_id =" + userId;
        let user = await sql.query(getUser);
        var get_connected_devices = await sql.query("SELECT count(*) as total from usr_acc where dealer_id='" + userId + "'");

        if (user.length) {

            const usr = {
                id: user[0].dealer_id,
                dealer_id: user[0].dealer_id,
                email: user[0].dealer_email,
                lastName: user[0].last_name,
                name: user[0].dealer_name,
                firstName: user[0].first_name,
                dealer_name: user[0].dealer_name,
                dealer_email: user[0].dealer_email,
                link_code: user[0].link_code,
                connected_dealer: user[0].connected_dealer,
                connected_devices: get_connected_devices,
                account_status: user[0].account_status,
                user_type: verify.user.user_type,
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
});

/** is_admin **/
router.get('/is_admin', async function (req, res) {

});

/** get_user_type **/
router.get('/user_type', async function (req, res) {

});




/** Cron for expiry date **/
// cron.schedule('0 0 0 * * *', async () => {
//     var tod_dat = datetime.create();
//     var formatted_dt = tod_dat.format('Y/m/d');
//     var userAccQ = "select * from usr_acc where device_status = 1";
//     var results = await sql.query(userAccQ);

//     for (var i = 0; i < results.length; i++) {

//         if (formatted_dt >= results[i].expiry_date) {
//             var updateUsrAcc = "update usr_acc set status = 'expired' where device_id ='" + results[i].device_id + "'";
//             var dvcID = await device_helpers.getDvcIDByDeviceID(results[i].device_id);
//             sql.query(updateUsrAcc, function (error, results) {
//                 if (error) throw error;
//                 if (results.affectedRows == 0) {
//                     console.log('not done');
//                 } else {
//                     try {
//                         console.log('expired');
//                         require("../bin/www").sendDeviceStatus(dvcID, "expired", true);
//                     } catch (error) {
//                         console.log(error);
//                     }
//                 }
//             });

//         }
//     }
// });


module.exports = router;