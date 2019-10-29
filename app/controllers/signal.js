
const { sql } = require('../../config/database');
const axios = require('axios');

exports.checkChatID = async function (req, res) {
    let device_id = req.body.device_id;
    let chat_id = req.body.chat_id;
    let ts = req.body.ts;

    if (!device_id || !chat_id || !ts) {
        res.status(422).send({
            status: false,
            msg: "missing required data"
        });
        return false;
    }

    let chat_detail = `SELECT wl.api_url , cid.chat_id , cid.used , cid.whitelabel_id 
    FROM chat_ids AS cid JOIN white_labels AS wl ON cid.whitelabel_id = wl.id 
    WHERE cid.chat_id = '${chat_id}'`;
    let chat_detail_row = await sql.query(chat_detail);

    if (!chat_detail_row || chat_detail_row.length <= 0) {
        res.status(400).send({
            status: false,
            msg: "Chat id not found"
        });
        return false;
    }
    if (chat_detail_row[0].used == 1) {
        res.status(400).send({
            status: false,
            msg: "Bad Request: not used"
        });
        return false;
    }

    await axios.post(chat_detail_row[0].api_url + '/signal/validate_chat_id', { ...req.body })
        .then(function (response) {
            console.log(response);
            // chat id is assigned to same device id
            if (response.header.status == 200) {
                res.status(200).send({
                    status: true,
                    msg: "success"
                });
                return false;
            }

            res.status(422).send({
                status: false,
                msg: "Bad Data"
            });
            return false;
        })
        .catch((error) => {
            console.log(error);
            res.status(500).send({
                status: false,
                msg: "White Label server not responding.",
                error: error
            });
            return false;
        });
}