const { sql } = require('../../config/database');
const axios = require('axios');
const Constants = require('../../constants/application');

// exports.generateReport = async function (req, res) {
//     try {
//         let reportName = req.params.reportName;
//         console.log("reportName ", reportName);
//         let defaultData = [];
//         if (reportName === "product") {
//             defaultData = { CHAT: [], PGP: [], SIM: [], VPN: [] }
//         }
//         // return res.send({ status: true, data: defaultData })
//         let labelId = req.body.label;
//         let WHITE_LABEL_BASE_URL = '';
//         let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

//         if (getApiURL.length) {

//             if (getApiURL[0].api_url) {

//                 WHITE_LABEL_BASE_URL = getApiURL[0].api_url;

//                 axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
//                     if (response.data.status) {

//                         loginResponse = response.data;
//                         axios.post(WHITE_LABEL_BASE_URL + '/users/reports/' + reportName, req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

//                             if (response.data.status) {

//                                 res.send({
//                                     status: true,
//                                     msg: "DATA FOUND",
//                                     data: response.data.data
//                                 });
//                                 return
//                             } else {
//                                 res.send({
//                                     status: true,
//                                     msg: "DATA FOUND",
//                                     data: defaultData
//                                 });
//                                 return
//                             }
//                         }).catch((error) => {
//                             console.log("White Label server not responding. PLease try again later");
//                         });
//                     }
//                 }).catch((error) => {
//                     console.log(error);
//                     console.log("White Label server not responding. PLease try again later");
//                     res.send({
//                         status: false,
//                         msg: "error",
//                         data: defaultData
//                     });
//                     return
//                 });;
//             } else {
//                 res.send({
//                     status: false,
//                     msg: "error",
//                     data: defaultData
//                 });
//                 return
//             }
//         } else {
//             res.send({
//                 status: false,
//                 msg: "error",
//                 data: defaultData
//             });
//             return
//         }
//     }
//     catch (err) {
//         console.log(err);
//         res.send({
//             status: false,
//             msg: "error",
//             data: defaultData
//         });
//         return
//     }
// }

exports.generateProductReport = async function (req, res) {
    try {
        let defaultData = { CHAT: [], PGP: [], SIM: [], VPN: [] }
        let labelId = req.body.label;
        let WHITE_LABEL_BASE_URL = '';
        let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getApiURL.length) {

            if (getApiURL[0].api_url) {

                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;

                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {

                        loginResponse = response.data;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/reports/product', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

                            if (response.data.status) {

                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: response.data.data
                                });
                                return
                            } else {
                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: defaultData
                                });
                                return
                            }
                        }).catch((error) => {
                            console.log("White Label server not responding. PLease try again later");
                        });
                    }
                }).catch((error) => {
                    console.log(error);
                    console.log("White Label server not responding. PLease try again later");
                    res.send({
                        status: false,
                        msg: "error",
                        data: defaultData
                    });
                    return
                });;
            } else {
                res.send({
                    status: false,
                    msg: "error",
                    data: defaultData
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "error",
                data: defaultData
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "error",
            data: defaultData
        });
        return
    }
}

exports.generateHardwareReport = async function (req, res) {
    try {
        let defaultData = []
        let labelId = req.body.label;
        let WHITE_LABEL_BASE_URL = '';
        let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getApiURL.length) {

            if (getApiURL[0].api_url) {

                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;

                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {

                        loginResponse = response.data;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/reports/hardware', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

                            if (response.data.status) {

                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: response.data.data
                                });
                                return
                            } else {
                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: defaultData
                                });
                                return
                            }
                        }).catch((error) => {
                            console.log("White Label server not responding. PLease try again later");
                        });
                    }
                }).catch((error) => {
                    console.log(error);
                    console.log("White Label server not responding. PLease try again later");
                    res.send({
                        status: false,
                        msg: "error",
                        data: defaultData
                    });
                    return
                });;
            } else {
                res.send({
                    status: false,
                    msg: "error",
                    data: defaultData
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "error",
                data: defaultData
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "error",
            data: defaultData
        });
        return
    }
}

exports.generateInvoiceReport = async function (req, res) {
    try {
        let defaultData = []
        let labelId = req.body.label;
        let WHITE_LABEL_BASE_URL = '';
        let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getApiURL.length) {

            if (getApiURL[0].api_url) {

                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;

                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {

                        loginResponse = response.data;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/reports/invoice', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

                            if (response.data.status) {

                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: response.data.data
                                });
                                return
                            } else {
                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: defaultData
                                });
                                return
                            }
                        }).catch((error) => {
                            console.log("White Label server not responding. PLease try again later");
                        });
                    }
                }).catch((error) => {
                    console.log(error);
                    console.log("White Label server not responding. PLease try again later");
                    res.send({
                        status: false,
                        msg: "error",
                        data: defaultData
                    });
                    return
                });;
            } else {
                res.send({
                    status: false,
                    msg: "error",
                    data: defaultData
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "error",
                data: defaultData
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "error",
            data: defaultData
        });
        return
    }
}

exports.generatePaymentHistoryReport = async function (req, res) {
    try {
        let defaultData = []
        let labelId = req.body.label;
        let WHITE_LABEL_BASE_URL = '';
        let getApiURL = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getApiURL.length) {

            if (getApiURL[0].api_url) {

                WHITE_LABEL_BASE_URL = getApiURL[0].api_url;

                axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
                    if (response.data.status) {

                        loginResponse = response.data;
                        axios.post(WHITE_LABEL_BASE_URL + '/users/reports/payment-history', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

                            if (response.data.status) {

                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: response.data.data
                                });
                                return
                            } else {
                                res.send({
                                    status: true,
                                    msg: "DATA FOUND",
                                    data: defaultData
                                });
                                return
                            }
                        }).catch((error) => {
                            console.log("White Label server not responding. PLease try again later");
                        });
                    }
                }).catch((error) => {
                    console.log(error);
                    console.log("White Label server not responding. PLease try again later");
                    res.send({
                        status: false,
                        msg: "error",
                        data: defaultData
                    });
                    return
                });;
            } else {
                res.send({
                    status: false,
                    msg: "error",
                    data: defaultData
                });
                return
            }
        } else {
            res.send({
                status: false,
                msg: "error",
                data: defaultData
            });
            return
        }
    }
    catch (err) {
        console.log(err);
        res.send({
            status: false,
            msg: "error",
            data: defaultData
        });
        return
    }
}
