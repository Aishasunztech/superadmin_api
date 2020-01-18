var express = require('express');
var path = require('path');
var fs = require("fs");
var router = express.Router();
var pub = require('../app/controllers/pub');
var reports = require('../app/controllers/reports');

router.get('/exchange-currency/:toCr', pub.exchangeCurrency);
router.post('/show-pdf-file', reports.showPdfFile);


router.get("/getFileWithFolder/:folder/:file", async function (req, res) {
console.log('fsdfsdfsdfsdf')
    if (fs.existsSync(path.join(__dirname, "../uploads/"+ req.params.folder+'/' + req.params.file))) {
        let file = path.join(__dirname, "../uploads/"+ req.params.folder+'/'  + req.params.file);
        res.sendFile(path.join(__dirname, "../uploads/"+ req.params.folder+'/' + req.params.file));

    } else {
        data = {
            "status": false,
            "msg": "file not found",
        };
        res.send(data)
    }
});

module.exports = router;