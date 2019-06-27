
const { sql } = require('../../config/database');

const Constants = require('../../constants/application');
const device_helpers = require('../../helpers/device_helpers');
const general_helpers = require('../../helpers/general_helpers');

exports.exchangeCurrency = async function (req, res){
    let toCr = req.params.toCr;
    let getCurrency = 'SELECT * FROM currencies ORDER BY updated_at DESC';
    let currenciesRes = await sql.query(getCurrency);
    if(currenciesRes.lenght){
        let currencies = JSON.parse(currenciesRes[0].data);
        console.log(currencies[toCr]);
        
    } else {
        res.send({
            status: false,
            msg: "Currency Not Found"
        })
    }
}