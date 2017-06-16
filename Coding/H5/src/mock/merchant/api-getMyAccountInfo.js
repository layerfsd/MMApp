'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/getMyAccountInfo',
    response: function(req, res) {
        setTimeout(function() {
            res.json({
                "ret_code": "000000",
                "ret_msg": "请求成功",
                "data_entity": {
                    "balanceCurrencys": [{
                        "balance": "2900.00", //余额
                        "currency": "1" //币种
                    }, {
                        "balance": "1000.00",
                        "currency": "1"
                    }, {
                        "balance": "800.00",
                        "currency": "1"
                    }, {
                        "balance": "999.00",
                        "currency": "1"
                    }],
                    "transactionRecords": [{
                        "transationType": "1", //交易类型  //1：账户交易   2：银行卡交易 3：社保卡交易
                        "transationAmount": "34.00", //交易金额
                        "currency": "1", //币种
                        "transactionDate": "17-05-2017 11:12:36", //交易时间
                        "transactionId": "", //交易流水号
                        "tax": "0.00", //税
                        "commission": "0.00", //佣金
                        "brokerage": "0.00" //手续费
                    }, {
                        "transationType": "2", //交易类型
                        "transationAmount": "18.00", //交易金额
                        "currency": "1", //币种
                        "transactionDate": "17-05-2017 11:19:36", //交易时间
                        "transactionId": "", //交易流水号
                        "tax": "0.00", //税
                        "commission": "0.00", //佣金
                        "brokerage": "0.00" //手续费
                    }, {
                        "transationType": "3", //交易类型
                        "transationAmount": "26.00", //交易金额
                        "currency": "1", //币种
                        "transactionDate": "19-05-2017 11:18:36", //交易时间
                        "transactionId": "", //交易流水号
                        "tax": "0.00", //税
                        "commission": "0.00", //佣金
                        "brokerage": "0.00" //手续费
                    }, {
                        "transationType": "1", //交易类型
                        "transationAmount": "18.00", //交易金额
                        "currency": "1", //币种
                        "transactionDate": "29-05-2017 14:18:36", //交易时间
                        "transactionId": "", //交易流水号
                        "tax": "0.00", //税
                        "commission": "0.00", //佣金
                        "brokerage": "0.00" //手续费
                    }, {
                        "transationType": "1", //交易类型
                        "transationAmount": "20.00", //交易金额
                        "currency": "1", //币种
                        "transactionDate": "20-05-2017 10:18:36", //交易时间
                        "transactionId": "", //交易流水号
                        "tax": "0.00", //税
                        "commission": "0.00", //佣金
                        "brokerage": "0.00" //手续费
                    }]
                }
            });
        }, WAIT_MS);
    }
};
