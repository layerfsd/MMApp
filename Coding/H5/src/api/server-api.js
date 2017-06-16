'use strict';

var axios = require('axios');
var API = require('./urls');

const CODE_INVALIDE_SESSION_TOKEN = 101;   //无效session的返回码

var ServerAPI = function (app) {
    this.app = app;
    this.appVersion = '1.0';        //App的版本号
    this.deviceModel = 'iOS';       //手机设备型号
    this.deviceVersion = '10.2';    //手机设备OS的版本
    this.appChannel = '10000';      //渠道号
    this.payloadKey = '';           //PayloadKey
    this.IMEIFactor = '';           //IMEIFactor
    this.debug = true;              //是否调试模式
    this.imei='iphone6s';				//设备号
	
	this.phoneModel='iOS'			//待确定参数
    this.phoneSystem= '苹果';		//待确定参数
    this.pushToken= 'xxx';			//待确定参数

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
        const SUCCESS_CODE = '10000'; //返回码：10000 表示成功
        //先核对签名
        //
        
        //再解密
        

        //再把dataEntity提取出来
        var error = null;
        if(resPackage.data){
            if(resPackage.data.ret_code !== SUCCESS_CODE){
                error = {
                    code: resPackage.data.ret_code,
                    message: resPackage.data.ret_msg
                }
                console.log(error)
            }
        }else {
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
            timeout: 15000,      /*超时时间15秒*/
        })
          .then(res =>
          {
            self.checkResPackage(res, function(error, data) {
                var wentLogin = false;
                if (error !== null) {
                    if (error.code === CODE_INVALIDE_SESSION_TOKEN) {
                        console.log("会话失效");
                        var store = self.app.$store;
                        store.dispatch('removeSession');  //移除session
                        if (option === null || option === undefined) {
                            option = {
                                toLoginIfInvalidSession: true
                            }
                        }
                        var toLoginIfInvalidSession = option.toLoginIfInvalidSession || true;

                        if (toLoginIfInvalidSession) {
                            var returnToPage = option.returnToPage || '/home';
                            // self.app.showToast("Invalid session, please login");
                            self.app.$router.push({path: '/login', query:{toPage:returnToPage}});
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
                callback({code: -1001, message: 'The server responded with a status code that falls out of the range of 2xx' });
            }
            else {
              // Something happened in setting up the request that triggered an Error
              console.log(error);
              callback({code: -1002, message: 'Something happened in setting up the request that triggered an Error' });
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
    var dataEntity = {
    };

    this.send(API.getAccountBalance, dataEntity, option, callback);
            
};

/**
 * 判断是否注册接口
 * @param  {String}   手机号phone
 *
 * @param  {Function} callback(error, dataEntity) 回调函数
 * @return  无         
 */
ServerAPI.prototype.registerStatus = function(phone, option, callback) {
    var dataEntity = {
        phone: phone
    };



    this.send(API.registerStatus, dataEntity, null, function(error, data){
        // 异常
        if(error){
            callback(error, data);
            return ;
        }

        let unRegister = false;
        if(data.registerStatus === '0'){
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



    this.send(API.getVerificationCode, dataEntity, null, callback);

};

/*校验验证码*/
ServerAPI.prototype.checkVerificationCode = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        verificationCodeType: data.verificationCodeType, //用户注册
        verificationCode: data.verificationCode
    };


    this.send(API.checkVerificationCode, dataEntity, null, function(error, data){
        var correctCode = '111111' //正确的验证码,用于测试
        // 失败
        if(error){
            callback(error);
            return;
        }

        if(correctCode != dataEntity.verificationCode){
            error = {
                code: '999999',
                message: '验证码错误'
            }
            return callback(error);
        }else {
            // 正确
            callback(null, data);
        }

    });

};

/*注册(设密保)*/
ServerAPI.prototype.register = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone,
        password: data.password,
        pushToken: data.pushToken,
        satefyProblemNo: data.satefyProblemNo,
        answer: data.answer,
        imei: this.imei,
        phoneModel: this.phoneModel,
        phoneSystem: this.phoneSystem
    };



    this.send(API.register, dataEntity, null, function(error, data){
        // 失败
        if(error){
            callback(error, data);
            return false;
        }
        let ret = {},
            unVerified = false,
            unActiviated = false,
            sessionToken = '';

        if(data.customerType === '0'){
            unVerified = true;
        }
        if(data.customerStatus === '0'){
            unActiviated = true;
        }

        // 异常情况
        if(unVerified && !unActiviated){
            error = {
                code: 'FAIL',
                message: '返回数据异常'
            }
            callback(error, data);
            return false;
        }

        //正常情况
        ret = {
            unVerified: unVerified,
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



    this.send(API.authentication, dataEntity, null, function(error, data){
        // 失败
        if(error){
            callback(error, data);
            return false;
        }

        let unActiviated= data.customerStatus === '0';
        // 正常
        callback(null, {
            unActiviated:unActiviated
        });
    });

};

/*激活()*/
ServerAPI.prototype.activation = function(data,option, callback) {
    var dataEntity = {
        phone: data.phone,
        intitialPIN: data.intitialPIN,
        newPIN: data.newPIN
    };



    this.send(API.activation, dataEntity, null, callback);

};

/*登录()
 * 
 * phone:手机号
 * password：密码
 * imei：
 * phoneModel：
 * phoneSystem：
 * pushToken：
 * 
 * */
ServerAPI.prototype.login = function(data, option, callback) {
    var dataEntity = {
        phone: data.phone.toString(),
        password: data.password,
        imei: this.imei,
        phoneModel:this.phoneModel,
        phoneSystem:this.phoneSystem,
        pushToken:this.pushToken
    };

    this.send(API.login, dataEntity, null, function(error, data){
        if (error !== null) {
            //失败
            return callback(error, data);
        }
//		let sessionToken='';
//		if(data.isActivate=='1'){//状态为激活时才有sesstionToken
//			sessionToken=data.sessionToken;
//		}
        callback(null,{
            bindingDeviceChanged: data.bindState=='1' ? true:false,//是否更换设备 0否1是
            unActiviated: data.isActivate =='1' ? true:false,//激活状态 0未激活1已激活
            sessionToken: data.sessionToken
        });
    });

};


/*发信息(设备绑定不一致)*/
ServerAPI.prototype.bindPhoneChange = function(data,option, callback) {
    var dataEntity = {
        phone: data.phone.toString(),
        imei: this.imei,//设备号
        phoneModel: this.deviceModel,
        phoneSystem: this.phoneSystem,
        pushToken: this.pushToken,

    };


    this.send(API.bindPhoneChange, dataEntity, null, function(error, data){
        // 失败
        if(error){
            callback(error, data);
            return false;
        }

        let ret,unVerified,unActiviated,sessionToken;
        if(data){
            unVerified = data.customerType === '0';
            unActiviated = data.customerStatus === '0';
            sessionToken = data.sessionToken;
        }

        // 异常情况(未认证，已激活)
        if(unVerified && !unActiviated){
            error = {
                code: 'FAIL',
                message: '返回数据异常'
            }
            callback(error, data);
        }

        // 正常
        ret = {
            unVerified: unVerified,
            unActiviated: unActiviated,
            sessionToken: sessionToken
        }

        callback(null, ret);

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
        answer: data.answer
    };



    this.send(API.securityRecord, dataEntity, null, callback);

};

/*模块me => 重置登录密码*/
ServerAPI.prototype.changeLoginPassword = function(data, option, callback) {
    var dataEntity = {
        sessionToken: data.sessionToken,
        initialPassword: data.initialPassword,
        newPassword: data.newPassword
    };



    this.send(API.changeLoginPassword, dataEntity, null, callback);

};

module.exports = ServerAPI;

