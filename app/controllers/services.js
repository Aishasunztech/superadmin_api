const axios = require('axios');
const moment = require('moment');
const { sql } = require('../../config/database');
const Constants = require('../../constants/application');
const general_helper = require('../../helpers/general_helpers');
const accountSid = 'AC2383c4b776efb51c86cc6f9a5cdb4e89';
const authToken = '8f09f2ebc98338bff27e0ac73ea71a23';
const twilioClient = require('twilio')(accountSid, authToken);

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

                    general_helper.createPGPEmailAccountToServer(pgp_email, (response) => {
                        if (response.data) {
                            sql.query(`INSERT INTO pgp_emails (pgp_email , whitelabel_id , uploaded_by, uploaded_by_id) VALUES ('${pgp_email}' , '${whitelabel_id}' ,'${req.body.uploaded_by}' , '${req.body.uploaded_by_id}')`, function (err, results) {
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
                                        msg: "Pgp Email has been generated Successfully.",
                                        product: pgp_email
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
                        }
                    }, (error) => {
                        // console.log("error:", error);
                        if (error.response.data && error.response.data.username[0] == 'user with this username already exists.') {
                            res.send({
                                status: false,
                                msg: 'User with this username already exists.'
                            })
                            return
                        }
                        else {
                            res.send({
                                status: false,
                                msg: "ERROR: Internal PGP Server Error."
                            })
                            return
                        }

                    });
                } else {
                    res.send({
                        status: false,
                        msg: "Invalid Pgp Email."
                    })
                    return
                }
            }
            else if (type === 'chat_id') {
                let chat_id = await general_helper.generateChatID()
                if (chat_id) {
                    sql.query(`INSERT INTO chat_ids (chat_id , whitelabel_id , uploaded_by, uploaded_by_id) VALUES ('${chat_id}' , '${whitelabel_id}' ,'${req.body.uploaded_by}' , '${req.body.uploaded_by_id}')`, function (err, results) {
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
                                msg: "Chat Id has been generated Successfully.",
                                product: chat_id
                            })
                            return
                        }
                        else {
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
                        msg: "ERROR: Superadmin Server Error.",
                    });
                    return
                }
            }
            else if (type === 'sim_id') {
                let sim_id = product_data.sim_id;
                let selectSimQ = `SELECT * FROM sim_ids WHERE sim_id = '${product_data.sim_id}' AND activated = 1 AND delete_status = 0`
                let simFound = await sql.query(selectSimQ)
                if (simFound && simFound.length) {
                    res.send({
                        status: false,
                        msg: "ERROR: THIS ICCID IS IN USE, PLEASE TRY ANOTHER ONE"
                    })
                    return
                }
                let valid = await general_helper.validateSimID()
                if (sim_id) {
                    sql.query(`INSERT INTO sim_ids (sim_id , whitelabel_id , uploaded_by, uploaded_by_id) VALUES ('${sim_id}' , '${whitelabel_id}' ,'${req.body.uploaded_by}' , '${req.body.uploaded_by_id}')`, function (err, results) {
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
                                msg: "Sim Id has been generated Successfully.",
                                product: sim_id
                            })
                            return
                        }
                        else {
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
                        msg: "ERROR: Superadmin Server Error.",
                    });
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
                msg: "Invalid WhiteLabel.",
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

exports.generateRandomUsername = async function (req, res) {
    try {
        let username = await general_helper.generateUsername();
        res.send({
            status: true,
            msg: "Username Created.",
            username: username
        });
        return
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

exports.checkUniquePgp = async function (req, res) {
    try {
        let available = await general_helper.checkUniquePgp(req.body.pgp_email);
        res.send({
            status: true,
            available: available
        });
        return
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

exports.validateSimID = async function (req, res) {
    try {
        let sim_id = req.body.sim_id;
        let validation = await general_helper.validateSimID(sim_id)
        if (validation.valid) {
            twilioClient.wireless.sims.list({ iccid: sim_id }).then(response => {
                if (response && response.length) {
                    if (response.status !== 'active') {
                        return res.send({
                            status: true,
                            msg: "ICCID VALIDATED SUCCESSFULLY.",
                            valid: true,
                        })
                    }
                    else {
                        return res.send({
                            status: true,
                            msg: "ERROR: THIS ICCID IS IN USE, PLEASE TRY ANOTHER ONE",
                            valid: false,
                        })
                    }
                } else {
                    return res.send({
                        status: true,
                        msg: "ERROR: INVALID ICCID PLEASE MAKE SURE YOU ENTER VALID ICCID",
                        valid: false,
                    })
                }
            })
        } else {
            res.send(validation)
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

