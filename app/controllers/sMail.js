
const { sql } = require('../../config/database');
const axios = require('axios');

exports.validatePgpEmail = async function (req, res) {
    let device_id = req.body.device_id;
    let pgp_email = req.body.pgp_email;
    // let ts = req.body.ts;

    console.log('checkEmail req.body', req.body);
    console.log('checkEmail: ', device_id, pgp_email);

    if (!device_id || !pgp_email) {
        return res.status(422).send({
            status: false,
            msg: "missing required data",
            data: req.body
        });
    }

    let pgpDetailsQ = `SELECT wl.api_url, cid.pgp_email, cid.used, cid.whitelabel_id FROM pgp_emails AS cid JOIN white_labels AS wl ON cid.whitelabel_id = wl.id WHERE cid.pgp_email = ?`;
    let pgpDetailRow = await sql.query(pgpDetailsQ, [pgp_email]);

    if (!pgpDetailRow || pgpDetailRow.length <= 0) {
        return res.status(400).send({
            status: false,
            msg: "email not found"
        });
    }
    // LM update SA about chat id has been used which some time miss to reach SA. 
    // And user could not use Signal app.
    /* if (chat_detail_row[0].used != 1) {
        res.status(400).send({
            status: false,
            msg: "Bad Request: not used"
        });
        return false;
    } */

    console.log('white label url:', pgpDetailRow[0].api_url);
    axios.post(pgpDetailRow[0].api_url + '/s-mail/validate', { device_id: device_id, pgp_email: pgp_email })
        .then(function (response) {
            console.log('white label response status: ', response.status);
            if (response.status == 200) {
                console.log('white label response data: ', response.data);
                return res.status(200).send({
                    status: response.data.status,
                    msg: "success"
                });
            }

            return res.status(422).send({
                status: false,
                msg: "Bad Data"
            });
        }).catch((error) => {
            console.log('whitelabel error: ');
            return res.status(500).send({
                status: false,
                msg: "White Label server not responding.",
                error: error
            });
        });
}

exports.disablePgpEmail = async function (req, res) {
    let email = req.body.email;
    if (!email) {
        return res.send({
            status: false,
            msg: 'Bad request'
        });
    }

    // get single record against email
    axios.get(`${app_constants.PGP_SERVER_URL}/accounts?search=${email}`, {
        headers: {
            'Authorization': app_constants.PGP_SERVER_KEY,
            'Content-Type': 'application/json',
        }
    }).then(function (emailData) {
        if (emailData && emailData.data && emailData.data.length) {
            let emailConfigData = emailData.data[0];
            console.log("email searched records: ", emailConfigData.pk);

            axios.patch(`${app_constants.PGP_SERVER_URL}/accounts/${emailConfigData.pk}/`, {
                'is_active': false,
            }, {
                headers: {
                    'Authorization': app_constants.PGP_SERVER_KEY,
                    'Content-Type': 'application/json',
                }
            }).then(function (updateEmailRes) {
                console.log("updating account info: ", updateEmailRes);
                console.log("updating user password data: ", updateEmailRes.data);

                return res.send({
                    status: true,
                    msg: 'Account is disabled successfully'
                })
            }).catch(function (error) {
                console.log("updating account error:");
                return res.status(200).send({
                    status: false,
                    msg: 'PGP server error'
                })
            })
        } else {
            console.log("email not found on pgp server");

            return res.status(200).send({
                status: false,
                msg: 'PGP server error while disabling'
            })
        }

    }).catch(function (error) {
        console.log("getting account error:");
        return res.status(200).send({
            status: false,
            msg: 'PGP server error'
        })
    })


}