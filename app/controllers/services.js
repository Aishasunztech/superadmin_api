const axios = require('axios');
const moment = require('moment');
const { sql } = require('../../config/database');
const Constants = require('../../constants/application');
const general_helper = require('../../helpers/general_helpers');

exports.createServiceProduct = async function (req, res) {
    try {
        console.log(req.body);
        let type = req.body.type;
        let auto_generated = req.body.auto_generated;
        let product_data = req.body.product_data
        let label = req.body.label
        let whitelabel_id = await general_helper.getlabelIdByName(label)
        if (whitelabel_id) {
            if (type === 'pgp_email' && product_data.domain) {
                let pgp_email = ''
                if (auto_generated) {
                    pgp_email = await general_helper.generatePgpEmail(product_data.domain)
                } else {
                    pgp_email = product_data.pgp_email;
                    if (general_helper.validateEmail(pgp_email)) {
                        if (! await general_helper.checkUniquePgp(pgp_email)) {
                            res.send({
                                status: false,
                                msg: "Username not available. Please choose another username."
                            })
                            return
                        }
                    } else {
                        res.send({
                            status: false,
                            msg: "Invalid username or domain."
                        })
                        return
                    }
                }
                if (pgp_email) {
                    sql.query(`INSERT INTO pgp_emails (pgp_email , whitelabel_id) VALUES ('${pgp_email}' , '${whitelabel_id}')`, function (err, results) {
                        if (err) {
                            res.send({
                                status: false,
                                msg: "ERROR: Internal Server Error."
                            })
                            return
                        }
                        if (results && results.insertId) {
                            res.send({
                                status: true,
                                msg: "Pgp Email has been generated Successfully."
                            })
                            return
                        } else {
                            res.send({
                                status: false,
                                msg: "ERROR: Internal Server Error."
                            })
                            return
                        }
                    })
                } else {
                    res.send({
                        status: false,
                        msg: "Invalid Pgp Email."
                    })
                    return
                }
            }
            else {
                res.send({
                    status: false,
                    msg: "Invalid request.",
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "Invalid Whitelabel.",
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "Super Admin Server Error.",
        });
        return
    }
}

