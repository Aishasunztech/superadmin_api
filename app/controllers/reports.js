const { sql } = require('../../config/database');
const axios = require('axios');
const Constants = require('../../constants/application');
const general_helper = require('../../helpers/general_helpers');
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
        // let reportType = req.body.reportType;

        // if (reportType === 'products') {

        // } else if (reportType === 'hardware') {

        // }

        let WHITE_LABEL_BASE_URL = '';
        let getWhiteLabel = await sql.query(`SELECT * from white_labels WHERE id= ${labelId} LIMIT 1`);

        if (getWhiteLabel.length && getWhiteLabel[0].api_url) {


            WHITE_LABEL_BASE_URL = getWhiteLabel[0].api_url;

            general_helper.sendRequestToWhiteLabel(WHITE_LABEL_BASE_URL, '/users/reports/product', req.body, defaultData, res, (response) => {

                if (response.data.status) {

                    return res.send({
                        status: true,
                        msg: "DATA FOUND",
                        data: response.data.data
                    });

                } else {
                    return res.send({
                        status: true,
                        msg: "DATA FOUND",
                        data: defaultData
                    });
                }
            })

            // axios.post(WHITE_LABEL_BASE_URL + '/users/super_admin_login', Constants.SUPERADMIN_CREDENTIALS, { headers: {} }).then(async (response) => {
            //     if (response.data.status) {

            //         loginResponse = response.data;
            //         axios.post(WHITE_LABEL_BASE_URL + '/users/reports/product', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

            //             if (response.data.status) {

            //                 res.send({
            //                     status: true,
            //                     msg: "DATA FOUND",
            //                     data: response.data.data
            //                 });
            //                 return
            //             } else {
            //                 res.send({
            //                     status: true,
            //                     msg: "DATA FOUND",
            //                     data: defaultData
            //                 });
            //                 return
            //             }
            //         }).catch((error) => {
            //             console.log("White Label server not responding. PLease try again later");
            //         });
            //     }
            // }).catch((error) => {
            //     console.log(error);
            //     console.log("White Label server not responding. PLease try again later");
            //     res.send({
            //         status: false,
            //         msg: "error",
            //         data: defaultData
            //     });
            //     return
            // });

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
        let getWhiteLabel = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getWhiteLabel.length && getWhiteLabel[0].api_url) {


            WHITE_LABEL_BASE_URL = getWhiteLabel[0].api_url;
            console.log("white label api url: ", WHITE_LABEL_BASE_URL);
            general_helper.sendRequestToWhiteLabel(WHITE_LABEL_BASE_URL, '/users/reports/hardware', req.body, defaultData, res, (response) => {

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
            })

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
        let getWhiteLabel = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getWhiteLabel.length && getWhiteLabel[0].api_url) {

            WHITE_LABEL_BASE_URL = getWhiteLabel[0].api_url;
            // /users/reports/invoice

            general_helper.sendRequestToWhiteLabel(WHITE_LABEL_BASE_URL, '/users/reports/invoice', req.body, defaultData, res, (response) => {

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
            });


        } else {
            res.send({
                status: false,
                msg: "error",
                data: defaultData
            });
            return
        }
    } catch (err) {
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
        let getWhiteLabel = await sql.query(`SELECT * from white_labels WHERE id= ${labelId}`)

        if (getWhiteLabel.length && getWhiteLabel[0].api_url) {


            WHITE_LABEL_BASE_URL = getWhiteLabel[0].api_url;
            // '/users/reports/payment-history'
            general_helper.sendRequestToWhiteLabel(WHITE_LABEL_BASE_URL, '/users/reports/payment-history',req.body, defaultData, res, (response) => {

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
            });

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

exports.generateSalesReport = async function (req, res) {
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
                        axios.post(WHITE_LABEL_BASE_URL + '/users/reports/sales', req.body, { headers: { 'authorization': loginResponse.token } }).then((response) => {

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

// exports.generateSalesReport = async function (req, res) {

//     let verify = req.decoded;

//     if (verify) {

//         let user_type       = verify.user.user_type;
//         let dealer          = req.body.dealer;
//         let from            = req.body.from;
//         let to              = req.body.to;
//         let productType     = req.body.product_type;
//         let condition       = '';
//         let packages        = [];
//         let packagesData    = [];
//         let products        = [];
//         let productsData    = [];
//         let hardwares       = [];
//         let hardwaresData   = [];
//         let totalCost       = 0;
//         let totalSale       = 0;
//         let totalProfitLoss = 0;
//         let response        = {};

//         if(productType === 'PACKAGES' || productType === 'ALL'){

//             if (dealer === '' && user_type === Constants.DEALER) {

//                 let sDealerIds = await generalHelper.getSdealersByDealerId(verify.user.id);
//                 if (sDealerIds.length > 0){
//                     condition += ' AND ua.dealer_id IN (' + verify.user.id + ',' + sDealerIds.join(',') + ')'
//                 }else{
//                     condition += ' AND ua.dealer_id = ' + verify.user.id
//                 }

//             } else if (dealer) {
//                 condition += ' AND ua.dealer_id = ' + dealer
//             }

//             if (from) {
//                 condition += ' AND DATE(ss.created_at) >= "' + moment(from).format('YYYY-MM-DD') + '"'
//             }

//             if (to) {
//                 condition += ' AND DATE(ss.created_at) <= "' + moment(to).format('YYYY-MM-DD') + '"'
//             }

//             packages = await sql.query(`SELECT ss.*, d.device_id as device_id, ua.link_code as dealer_pin FROM services_sale as ss
//             JOIN usr_acc as ua on ua.id = ss.user_acc_id 
//             JOIN devices as d on ua.device_id = d.id
//             WHERE ss.status != 'cancelled' AND ss.item_type LIKE 'package'  ${condition} ORDER BY ss.id DESC`);

//             packages.map(function (value, index) {

//                 let name        = JSON.parse(value.item_data).pkg_name;
//                 let cost_price  = 0;
//                 let sale_price  = 0;
//                 let profit_loss = 0;

//                 if (value.item_dealer_cost == 0 && user_type === Constants.ADMIN) {

//                     cost_price  = parseInt(value.item_admin_cost);
//                     sale_price  = parseInt(value.item_sale_price);
//                     profit_loss = sale_price - cost_price;

//                     totalCost       += cost_price;
//                     totalSale       += sale_price;

//                     packagesData.push({
//                         'type': 'Package',
//                         'name': name.replace(/_/g, ' '),
//                         'dealer_pin': value.dealer_pin,
//                         'device_id': value.device_id,
//                         'cost_price': cost_price,
//                         'sale_price': sale_price,
//                         'profit_loss': profit_loss,
//                         'created_at': value.created_at,
//                     })

//                 } else {

//                     if (value.item_dealer_cost != 0 && user_type === Constants.DEALER) {
//                         cost_price = parseInt(value.item_dealer_cost);
//                         sale_price = parseInt(value.item_sale_price);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += sale_price;

//                         packagesData.push({
//                             'type': 'Package',
//                             'name': name.replace(/_/g, ' '),
//                             'dealer_pin': value.dealer_pin,
//                             'device_id': value.device_id,
//                             'cost_price': cost_price,
//                             'sale_price': sale_price,
//                             'profit_loss': profit_loss,
//                             'created_at': value.created_at,
//                         })

//                     } else if (user_type === Constants.ADMIN){
//                         cost_price = parseInt(value.item_admin_cost);
//                         sale_price = parseInt(value.item_dealer_cost);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += sale_price;

//                         packagesData.push({
//                             'type': 'Package',
//                             'name': name.replace(/_/g, ' '),
//                             'dealer_pin': value.dealer_pin,
//                             'device_id': value.device_id,
//                             'cost_price': cost_price,
//                             'sale_price': sale_price,
//                             'profit_loss': profit_loss,
//                             'created_at': value.created_at,
//                         })
//                     }
//                 }

//             });

//         }

//         if (productType === 'PRODUCTS' || productType === 'ALL') {

//             if (dealer === '' && user_type === Constants.DEALER) {

//                 let sDealerIds = await generalHelper.getSdealersByDealerId(verify.user.id);
//                 if (sDealerIds.length > 0){
//                     condition += ' AND ua.dealer_id IN (' + verify.user.id + ',' + sDealerIds.join(',') + ')'
//                 }else{
//                     condition += ' AND ua.dealer_id = ' + verify.user.id
//                 }


//             } else if (dealer) {
//                 condition += ' AND ua.dealer_id = ' + dealer
//             }

//             if (from) {
//                 condition += ' AND DATE(ss.created_at) >= "' + moment(from).format('YYYY-MM-DD') + '"'
//             }

//             if (to) {
//                 condition += ' AND DATE(ss.created_at) <= "' + moment(to).format('YYYY-MM-DD') + '"'
//             }

//             products = await sql.query(`SELECT ss.*, d.device_id as device_id, ua.dealer_id as dealer_id, ua.link_code as dealer_pin FROM services_sale as ss
//             JOIN usr_acc as ua on ua.id = ss.user_acc_id 
//             JOIN devices as d on ua.device_id = d.id
//             WHERE ss.status != 'cancelled' AND ss.item_type LIKE 'product'  ${condition} ORDER BY ss.id DESC`);

//             products.map(function (value, index) {

//                 let cost_price = 0;
//                 let sale_price = 0;
//                 let profit_loss = 0;

//                 if (value.item_dealer_cost == 0 && user_type === Constants.ADMIN) {

//                     cost_price = parseInt(value.item_admin_cost);
//                     sale_price = parseInt(value.item_sale_price);
//                     profit_loss = sale_price - cost_price;

//                     totalCost       += cost_price;
//                     totalSale       += profit_loss;

//                 } else {

//                     if (user_type === Constants.DEALER) {
//                         cost_price = parseInt(value.item_dealer_cost);
//                         sale_price = parseInt(value.total_credits);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += profit_loss;
//                     } else {
//                         cost_price = parseInt(value.item_admin_cost);
//                         sale_price = parseInt(value.item_dealer_cost);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += profit_loss;
//                     }

//                 }

//                 let name = JSON.parse(value.item_data).price_for;
//                 productsData.push({
//                     'type': 'Product',
//                     'name': name.replace(/_/g, ' '),
//                     'dealer_pin': value.dealer_pin,
//                     'device_id': value.device_id,
//                     'cost_price': cost_price,
//                     'sale_price': sale_price,
//                     'profit_loss': profit_loss,
//                     'created_at': value.created_at,
//                 })
//             });

//         }

//         if (productType === 'HARDWARES' || productType === 'ALL') {

//             if (dealer === '' && user_type === Constants.DEALER) {

//                 let sDealerIds = await generalHelper.getSdealersByDealerId(verify.user.id);
//                 if (sDealerIds.length > 0){
//                     condition += ' AND hd.dealer_id IN (' + verify.user.id + ',' + sDealerIds.join(',') + ')'
//                 }else{
//                     condition += ' AND hd.dealer_id = ' + verify.user.id
//                 }

//             } else if (dealer) {
//                 condition += ' AND hd.dealer_id = ' + dealer
//             }

//             if (from) {
//                 condition += ' AND DATE(hd.created_at) >= "' + moment(from).format('YYYY-MM-DD') + '"'
//             }

//             if (to) {
//                 condition += ' AND DATE(hd.created_at) <= "' + moment(to).format('YYYY-MM-DD') + '"'
//             }

//             hardwares = await sql.query(`SELECT hd.*, d.device_id as device_id, ua.link_code as dealer_pin FROM hardwares_data as hd
//                 JOIN usr_acc as ua 
//                     on ua.id = hd.user_acc_id 
//                 JOIN devices as d 
//                     on ua.device_id = d.id
//                 WHERE hd.id IS NOT NULL ${condition} ORDER BY hd.id DESC`);

//             hardwares.map(function (value, index) {
//                 let cost_price = 0;
//                 let sale_price = 0;
//                 let profit_loss = 0;

//                 if (value.dealer_cost_credits === 0 && user_type === Constants.ADMIN) {

//                     cost_price = parseInt(value.admin_cost_credits);
//                     sale_price = parseInt(value.total_credits);
//                     profit_loss = sale_price - cost_price;

//                     totalCost       += cost_price;
//                     totalSale       += sale_price;

//                     hardwaresData.push({
//                         'type': 'Hardware',
//                         'name': value.hardware_name,
//                         'dealer_pin': value.dealer_pin,
//                         'device_id': value.device_id,
//                         'cost_price': cost_price,
//                         'sale_price': sale_price,
//                         'profit_loss': profit_loss,
//                         'created_at': value.created_at,
//                     })

//                 } else {

//                     if (value.item_dealer_cost != 0 && user_type === Constants.DEALER) {
//                         cost_price  = parseInt(value.dealer_cost_credits);
//                         sale_price  = parseInt(value.total_credits);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += sale_price;

//                         hardwaresData.push({
//                             'type': 'Hardware',
//                             'name': value.hardware_name,
//                             'dealer_pin': value.dealer_pin,
//                             'device_id': value.device_id,
//                             'cost_price': cost_price,
//                             'sale_price': sale_price,
//                             'profit_loss': profit_loss,
//                             'created_at': value.created_at,
//                         })

//                     } else if (user_type === Constants.ADMIN){
//                         cost_price = parseInt(value.admin_cost_credits);
//                         sale_price = parseInt(value.dealer_cost_credits);
//                         profit_loss = sale_price - cost_price;

//                         totalCost       += cost_price;
//                         totalSale       += sale_price;

//                         hardwaresData.push({
//                             'type': 'Hardware',
//                             'name': value.hardware_name,
//                             'dealer_pin': value.dealer_pin,
//                             'device_id': value.device_id,
//                             'cost_price': cost_price,
//                             'sale_price': sale_price,
//                             'profit_loss': profit_loss,
//                             'created_at': value.created_at,
//                         })
//                     }

//                 }

//             });

//         }

//         let saleInfo = {
//             'totalCost'  : totalCost,
//             'totalSale'   : totalSale,
//             'totalProfitLoss': totalSale - totalCost,
//         };

//         response = {
//             data: [...packagesData, ...productsData, ...hardwaresData],
//             saleInfo,
//         };
//         return res.send(response);
//     }

// };
