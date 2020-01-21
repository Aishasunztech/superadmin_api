
const { sql } = require('../../config/database');
const axios = require('axios');

exports.validatePgpEmail = async function (req, res) {
    let device_id = req.body.device_id;
    let pgp_email = req.body.pgp_email;
    // let ts = req.body.ts;

    console.log('checkChatID: ', device_id, pgp_email);
    console.log('checkChatID req.body', req.body);

    if (!device_id || !pgp_email) {
        res.status(422).send({
            status: false,
            msg: "missing required data",
            data: req.body
        });
        return false;
    }

    let pgpDetailsQ = `SELECT wl.api_url, cid.pgp_email, cid.used, cid.whitelabel_id 
    FROM pgp_emails AS cid JOIN white_labels AS wl ON cid.whitelabel_id = wl.id 
    WHERE cid.pgp_email = '${pgp_email}'`;
    let pgpDetailRow = await sql.query(pgpDetailsQ);

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