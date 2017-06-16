'use strict';

var axios = require('axios');
// var API = require('./merchant-urls');//联调
var API = require('./merchant-mock-urls'); //本地mock调试

const CODE_INVALIDE_SESSION_TOKEN = 101; //无效session的返回码

var sessionToken = JSON.parse(localStorage.getItem('MM_SESSION_KEY')).token;
console.log("缓存为：" + sessionToken);

var ServerAPI = function(Vue, app) {
    this.app = app;
    this.appVersion = '1.0'; //App的版本号
    this.deviceOS = 'iOS'; //手机设备操作系统
    this.deviceModel = 'iPhone 6s'; //手机设备型号
    this.deviceVersion = '10.2'; //手机设备OS的版本
    this.appChannel = '10000'; //渠道号
    this.payloadKey = ''; //PayloadKey
    this.IMEIFactor = ''; //IMEIFactor
    this.debug = true; //是否调试模式
    this.imei = 'iphone6s'; //设备号
    this.pushToken = 'xxx'; //推送消息需要用到
    this.sessionToken = sessionToken; //sessionToken
    //  this.phoneModel=this.deviceModel;       //手机设备型号
    //  this.phoneSystem= this.deviceOS;        //手机设备操作系统
    this.Vue = Vue;

    // console.log(this.Vue.t('label_账号'));

    this.setAppVersion = function(appVersion) {
            this.appVersion = appVersion;
        },

        this.setDeviceModel = function(deviceModel) {
            this.deviceModel = deviceModel;
        },

        this.setDeviceVersion = function(deviceVersion) {
            this.devciceVersion = deviceVersion;
        },

        this.setPayloadKey = function(payloadKey) {
            this.payloadKey = payloadKey;
        },

        this.setIMEIFactor = function(IMEIFactor) {
            this.IMEIFactor = IMEIFactor;
        },

        /**
         * 产生请求报文, appVersion, deviceModel, deviceVersion, IMEIFactor需要先设置好
         * @param  {JSON}       dataEntity  请求数据
         * @param  {Function}   callback(error, reqPackage) 回调函数, reqPackage是请求报文，如果处理失败，error不为null
         * @return  无
         */
        this.generateReqPackage = function(dataEntity, callback) {
            var timestamp = new Date();
            var sign = '';
            //调用原生获取payloadKey
            var payloadKey = '12345678';

            //对数据进行加密
            //

            //再计算签名


            //
            var reqPackage = {
                appVersion: this.appVersion,
                deviceModel: this.deviceModel,
                deviceVersion: this.deviceVersion,
                appChannel: this.appChannel,
                timestamp: timestamp,
                payloadKey: this.payloadKey,
                IMEIFactor: this.IMEIFactor,
                debug: this.debug,
                dataEntity: dataEntity,
                sign: sign
            }
            callback(null, reqPackage);
        },

        /**
         * 检查返回报文
         * @param  {JSON}       resPackage  返回的报文
         * @param  {Function}   callback(error, dataEntity) 回调函数, 返回响应数据
         * @return  无
         */
        this.checkResPackage = function(resPackage, callback) {
            const SUCCESS_CODE = '000000'; //返回码：000000 表示成功
            //先核对签名
            //

            //再解密


            //再把dataEntity提取出来
            var error = null;
            if (resPackage.data) {
                if (resPackage.data.ret_code !== SUCCESS_CODE) {
                    error = {
                        code: resPackage.data.ret_code,
                        message: resPackage.data.ret_msg
                    }
                    console.log(error)
                }
            } else {
                /*网络异常*/
                error = {
                    code: 'APP_999999',
                    message: '网络异常'
                }
            }
            // var error = !resPackage.data.ret_code? null: {code: resPackage.data.ret_code, message: resPackage.data.ret_msg};
            callback(error, resPackage.data.data_entity);

        }

}

/**
 * 发送报文
 * @param  {url}        url  URL地址
 * @param  {reqData}    reqData  请求报文，JSON格式
 * @param  {Function}   callback(error, rspData) 回调函数, 返回响应报文
 *                      error: { code:  错误码  message: 错误信息}
 *                      rspData: 响应报文，JSON格式
 *
 * @return  无
 */
ServerAPI.prototype.send = function(url, reqData, option, callback) {

    var self = this;
    this.generateReqPackage(reqData, function(error, req) {

        if (error) {
            callback(error);
            return;
        }

        axios.post(url, req, {
                timeout: 15000,
                /*超时时间15秒*/
            })
            .then(res => {
                self.checkResPackage(res, function(error, data) {
                    var wentLogin = false;
                    if (error !== null) {
                        if (error.code === CODE_INVALIDE_SESSION_TOKEN) {
                            console.log("会话失效");
                            var store = self.app.$store;
                            store.dispatch('removeSession'); //移除session
                            if (option === null || option === undefined) {
                                option = {
                                    toLoginIfInvalidSession: true
                                }
                            }
                            var toLoginIfInvalidSession = option.toLoginIfInvalidSession || true;

                            if (toLoginIfInvalidSession) {
                                var returnToPage = option.returnToPage || '/home';
                                // self.app.showToast("Invalid session, please login");
                                self.app.$router.push({ path: '/login', query: { toPage: returnToPage } });
                                wentLogin = true;
                            }
                        }
                    }
                    callback(error, data, wentLogin);
                });
            })
            .catch(function(error) {
                if (error.response) {
                    // The request was made, but the server responded with a status code
                    // that falls out of the range of 2xx
                    console.log(error.response.data);
                    console.log(error.response.status);
                    console.log(error.response.headers);
                    callback({ code: -1001, message: 'The server responded with a status code that falls out of the range of 2xx' });
                } else {
                    // Something happened in setting up the request that triggered an Error
                    console.log(error);
                    callback({ code: -1002, message: 'Something happened in setting up the request that triggered an Error' });
                }
            });

    });

};

/**
 * 登录接口
 * @param  {String}   msisdn 用户名
 * @param  {String}   LoginPassword 密文密码
 * @param  {Function} callback(error, dataEntity) 回调函数
 * @return  无
 */
// ServerAPI.prototype.login = function(username, password, callback) {
//     var dataEntity = {
//         username: username,
//         password: password
//     };

//     this.send(API.login, dataEntity, null, callback);

// };


/**
 * 获取CashWallet Transactions
 * @param  {Int}      start
 * @param  {Int}      limit
 * @param  {Object}   option
 *         toLoginIfInvalidSession: 如果session失效，是否要跳转要login, 默认值True,
 *         returnToPage: 如果session失效，要跳转要login, login成功后再跳转回的页面, 默认值/home
 * }
 * @param  {Function} callback(error, dataEntity, wentLogin) 回调函数
 *         error: {code:错误码  message:错误信息}
 *         dataEntity:  返回的数据
 *         wentLogin: 是否已经跳转到登录页面
 * @return  无
 */
ServerAPI.prototype.getCashWalletTrans = function(data, option, callback) {
    var dataEntity = {
        start: data.start,
        limit: data.limit
    };

    this.send(API.getCashWalletTrans, dataEntity, option, callback);

};

/**
 * 获取账户余额
 * @param  {Function} callback(error, dataEntity) 回调函数
 * @return  无
 */
ServerAPI.prototype.getAccountBalance = function(data, option, callback) {
    var dataEntity = {};

    this.send(API.getAccountBalance, dataEntity, option, callback);

};

/**
 * 判断是否注册接口
 * phone  手机号
 * shortCode    短号
 * @param  {Function} callback(error, dataEntity) 回调函数
 * @return  无
 */
ServerAPI.prototype.registerStatus = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        shortCode: data.shortCode
    };



    this.send(API.registerStatus, dataEntity, null, function(error, data) {
        // 异常
        if (error) {
            callback(error, data);
            return;
        }

        let unRegister = false;
        // 0未注册
        // 1已注册
        if (data.status === '0') {
            unRegister = true;
        }
        // 正常
        callback(null, {
            unRegister: unRegister
        });
    });

};

const SEND_VERIFICATION_TYPE_REGISTER = 1;

/*获取短信验证码*/
ServerAPI.prototype.getVerificationCode = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        verificationCodeType: data.verificationCodeType //用户注册
    };
    console.log(dataEntity);
    this.send(API.getVerificationCode, dataEntity, null, callback);

};

/*校验验证码*/
ServerAPI.prototype.checkVerificationCode = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        verificationCodeType: data.verificationCodeType, //2
        verificationCode: data.verificationCode
    };

    this.send(API.checkVerificationCode, dataEntity, null, function(error, data) {
        if (error != null) {
            //失败
            return callback(error, data);
        }
        callback(null, {
            //          successfulFlag:data.successfulFlag == '1' ? true:false
        });
    });

};

/**
 * { 注册(设密保) }
 *
 * phone      手机号
 * shortCode      短号
 * password      密码
 * imei     设备号
 * phoneModel   手机型号
 * phoneSystem  手机操作系统
 * pushToken
 * satefyProblemNo 密保问题
 * answer   密保答案
 */
ServerAPI.prototype.register = function(data, option, callback) {
    var randomQuestions = data.randomQuestions,
        satefyProblemNoList = [];
    for (var i = 0; i < randomQuestions.length; i++) {
        satefyProblemNoList.push(randomQuestions[i].id);
    }
    var dataEntity = {
        phone: data.phone,
        shortCode: data.shortCode,
        password: data.password,
        imei: this.imei, //设备号
        phoneModel: this.deviceModel, //手机型号
        phoneSystem: this.deviceOS, //手机操作系统
        pushToken: this.pushToken,
        satefyProblem: satefyProblemNoList.join(), //密保问题
        answer: data.answer.replace(/,/g, '|') //密保答案
    };



    this.send(API.register, dataEntity, null, function(error, data) {
        // 失败
        if (error) {
            callback(error, data);
            return false;
        }
        let ret = {},
            unActiviated = false,
            sessionToken = '';

        // 0未激活
        // 1已激活

        if (data.status === '0') {
            unActiviated = true;
        }


        //正常情况
        ret = {
            unActiviated: unActiviated,
            sessionToken: sessionToken
        }
        console.log(ret)
        callback(null, ret);

    });

};

/*认征(个人信息)*/
ServerAPI.prototype.authentication = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        customerName: data.customerName,
        birthday: data.birthday,
        idType: data.idType,
        idCardNo: data.idCardNo,
        email: data.email
    };



    this.send(API.authentication, dataEntity, null, function(error, data) {
        // 失败
        if (error) {
            callback(error, data);
            return false;
        }

        // let unActiviated= data.customerStatus === '0';
        // 正常
        callback(null, {});
    });

};


/**
 * { 激活 }
 *
 * @msisdn      {<String>}  //电话号码
 * @intitialPIN      {<String>} //初始PIN
 * @newPIN      {<String>}  //新PIN
 */
ServerAPI.prototype.activation = function(data, option, callback) {
    var dataEntity = {
        msisdn: data.phone,
        initialPIN: data.initialPIN,
        newPIN: data.newPIN
    };



    this.send(API.activation, dataEntity, null, callback);

};

/*登录()
 *
 * phone:手机号
 * password：密码
 * imei：
 * phoneModel：手机设备型号
 * phoneSystem：手机设备操作系统
 * pushToken：
 *
 * */
ServerAPI.prototype.login = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        password: data.password,
        imei: this.imei,
        phoneModel: this.deviceModel,
        phoneSystem: this.deviceOS,
        pushToken: this.pushToken
    };

    this.send(API.login, dataEntity, null, function(error, data) {
        if (error != null) {
            //失败
            return callback(error, data);
        }
        let sessionToken = '';
        if (data.isActivate == '1') { //状态为激活时才有sesstionToken
            sessionToken = data.sessionToken;
        }
        callback(null, {
            bindingDeviceChanged: data.bindState == '1' ? true : false, //是否更换设备 0否1是
            unActiviated: data.isActivate == '1' ? true : false, //激活状态 0未激活1已激活
            sessionToken: data.sessionToken || '',
        });
    });

};


/*发信息(设备绑定不一致)*/
ServerAPI.prototype.bindPhoneChange = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        imei: this.imei, //设备号
        phoneModel: this.deviceModel,
        phoneSystem: this.deviceOS,
        pushToken: this.pushToken,

    };


    this.send(API.bindPhoneChange, dataEntity, null, function(error, data) {
        if (error != null) {
            //失败
            return callback(error, data);
        };
        let sessionToken = '';
        if (data.adminStatus == '1') { //状态为激活时才有sesstionToken
            sessionToken = data.sessionToken;
        };

        callback(null, {
            adminStatus: data.adminStatus == '1' ? true : false, //绑定成功标识
            sessionToken: data.sessionToken
        });
    });

};

/*忘记密码*/
ServerAPI.prototype.forgotPassword = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        password: data.password,
    };



    this.send(API.forgotPassword, dataEntity, null, callback);

};

/*接收问题*/
ServerAPI.prototype.securityRecordRandom = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,

    };

    this.send(API.securityRecordRandom, dataEntity, null, callback);

};

/*验证密保*/
ServerAPI.prototype.securityRecord = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        satefyProblemNum: data.satefyProblemNum,
        answer: data.answer.join('|'),
    };

    this.send(API.securityRecord, dataEntity, null, callback);

};

/*重置登录密码*/
ServerAPI.prototype.changeLoginPassword = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        initialPassword: data.initialPassword,
        newPassword: data.newPassword
    };

    this.send(API.changeLoginPassword, dataEntity, null, callback);

};

/* => 提交反馈内容*/
ServerAPI.prototype.feedbackSubmit = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        feedbackContent: data.feedbackContent,
    };

    this.send(API.feedbackSubmit, dataEntity, null, callback);

};


/* => 判断原密码是否正确*/
ServerAPI.prototype.checkOriginalPassword = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        initialPassword: data.initialPassword,
    };

    this.send(API.checkOriginalPassword, dataEntity, null, callback);

};

/* => 修改登录密码*/
ServerAPI.prototype.modifyLoginPassword = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        newPassword: data.newPassword,
        initialPassword: data.initialPassword
    };

    this.send(API.modifyLoginPassword, dataEntity, null, callback);
};

/*修改PIN码*/
ServerAPI.prototype.updatePIN = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        initialPIN: data.intitialPIN, //intitialPIN 单词错误
        newPIN: data.newPIN
    };
    this.send(API.updatePIN, dataEntity, null, callback);



};

/*查询密保记录接口*/
ServerAPI.prototype.queryMarchantSecurity = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
    };

    this.send(API.queryMarchantSecurity, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常
        callback(null, data);
    });
};

/*修改密保记录接口*/
ServerAPI.prototype.modifySecurityRecord = function(data, option, callback) {
    
    var randomQuestions = data.randomQuestions,
        satefyProblemNoList = [];
    for (var i = 0; i < randomQuestions.length; i++) {
        satefyProblemNoList.push(randomQuestions[i].id);
    }
    var dataEntity = {
        sessionToken: this.sessionToken,
        satefyProblemNum: satefyProblemNoList.join(),
        answer: data.answer.replace(/,/g, '|')
    };

    this.send(API.modifySecurityRecord, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常
        callback(null, data);
    });

};

/* 获取账户信息接口*/
ServerAPI.prototype.getMyAccountInfo = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        accountType: data.accountType
    };

    this.send(API.getMyAccountInfo, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常
        callback(null, data);
    });

};

/* 查询商户信息接口*/
ServerAPI.prototype.queryMarchantInfo = function(data, option, callback) {
    var dataEntity = {
        sessionToken: this.sessionToken,
    };

    this.send(API.queryMarchantInfo, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常

        callback(null, {
            headPortrait: data.headPortrait,
            operatorName: data.operatorName,
            phone: data.phone,
            isModifyMerchantIcon: data.modifyMerchantIconFlag === '1',
            isResetSecurity: data.resetSecurityFlag === '1',
            isResetLoginPassword: data.resetLoginPasswordFlag === '1',
            isResetPIN: data.resetPINFlag === '1',
            isResetPassword: data.passwordFlag === '1',
            isResetFeedback: data.feedbackFlag === '1',
            ismodifyOperatorAvatar: data.modifyOperatorAvatarFlag === '1'
        });
    });

};

/* Home页信息接口*/
ServerAPI.prototype.homeInfo = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
    };

    this.send(API.homeInfo, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常

        callback(null, {
            headPortrait: data.headPortrait,
            income: data.income,
            currency: data.currency,
            cardPayFlag: data.cardPayFlag === '1',
            withdrawFlag: data.withdrawFlag === '1',
            activationFlag: data.activationFlag === '1',
            newsFlag: data.newsFlag === '1',
            changePINFlag: data.changePINFlag === '1',
            registeredFlag: data.registeredFlag === '1',
            myAccountFlag: data.myAccountFlag === '1',
            settingsFlag: data.settingsFlag === '1',
            isCardPay: data.cardPayStatus === '1',
            isActivation: data.activationStatus === '1',
            haveNewMessage: data.messagesFlag === '1'
        });
    });

};

/* 上传图标接口*/
ServerAPI.prototype.fileUpload = function(data, option, callback) {
    
    var dataEntity = {
        sessionToken: this.sessionToken,
        userType: data.userType
    };

    this.send(API.fileUpload, dataEntity, null, function(error, data) {
        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常
        callback(null, data);
    });

};

/* 社保卡号查询接口*/
ServerAPI.prototype.querySSCStatus = function(data, option, callback) {
    var sessionToken = JSON.parse(localStorage.getItem('MM_SESSION_KEY'));
    console.log(sessionToken.token);
    var dataEntity = {
        sessionToken: sessionToken.token,
        cardNo: data.cardNo
    };

    this.send(API.querySSCStatus, dataEntity, null, function(error, data) {

        if (error != null) {
            //失败
            return callback(error, data);
        };

        //正常
        callback(null, data);
    });

};

module.exports = ServerAPI;
