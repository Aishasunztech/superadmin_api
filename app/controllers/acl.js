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
            id: user[0].id,
            email: user[0].email,
            last_name: user[0].last_name,
            name: `${user[0].first_name} ${user[0].last_name}`,
            first_name: user[0].first_name,
            
            two_factor_auth: user[0].is_two_factor_auth,
            verified: user[0].verified
        }

        res.json({
            status: true,
            msg: '',
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
