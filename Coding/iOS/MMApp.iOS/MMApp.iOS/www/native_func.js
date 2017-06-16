

function nativeFunc(bridge) {
    this.bridge = bridge;

    //函数说明 提供密码输入后反显文本
    this.bridge.registerHandler('setInputValue', function(data, responseCallback) {
        var jsonData = JSON.parse(data);
        console.log("setPWInputValue data = " + data);
        document.getElementById(jsonData.id).value = jsonData.text;

        //回调返回处理
        // responseCallback("数据");
    });
}

//原生给JS调用的接口
//设备类型：返回iOS，Android
nativeFunc.prototype.deviceModel = function(callback) {
    this.bridge.callHandler('deviceModel', {}, function(response) {
        callback(response);
    });
};

//设备Id
nativeFunc.prototype.deviceId = function(callback) {
    this.bridge.callHandler('deviceId', {}, function(response) {
        callback(response);
    });
};

//设备IP
nativeFunc.prototype.deviceIP = function(callback) {
    this.bridge.callHandler('deviceIP', {}, function(response) {
        callback(response);
    });
};

//设备OS版本号
nativeFunc.prototype.deviceOSVersion = function(callback) {
    this.bridge.callHandler('deviceOSVersion', {}, function(response) {
        callback(response);
    });
};

//取当前地址
//返回： {ret: longitude: latitude: address: }
//ret: 0 成功，其它失败
//longitude: 经度
//latitude: 纬度
//address: 地址
nativeFunc.prototype.getLocation = function(callback) {
    this.bridge.callHandler('getLocation', {}, function(response) {
        callback(response);
    });
};

//设置手势密码
//传入参数: {}
//传出参数: {ret: device_id: guesture_pwd: }
//
nativeFunc.prototype.setGesturePassword = function(data, callback) {
    this.bridge.callHandler('setGesturePassword', data, function(response) {
        callback(response);
    });
};

//检查手势密码
//传入参数: {}
//传出参数: {ret: message : guesture_pwd: }
//
nativeFunc.prototype.checkGesturePassword = function(data, callback) {
    this.bridge.callHandler('checkGesturePassword', data, function(response) {
        callback(response);
    });
};

//在新页面打开url
//传入参数: {url: }
//传出参数: {ret: }
nativeFunc.prototype.newPageWithURL = function(data, callback) {
    this.bridge.callHandler('newPageWithURL', data, function(response) {
        callback(response);
    });
};

//关闭当前页面
//传入参数: {}
//传出参数: {ret: }
nativeFunc.prototype.closePage = function(data, callback) {
    this.bridge.callHandler('closePage', data, function(response) {
        callback(response);
    });
};

//加密
//传入参数: {text:''}
//传出参数: {ret: '', text:''}
nativeFunc.prototype.encrypt = function(data, callback) {
    this.bridge.callHandler('encrypt', data, function(response) {
        callback(response);
    });
};

//解密
//传入参数: {text:''}
//传出参数: {ret: '', text:''}
nativeFunc.prototype.innerEncrypt = function(data, callback) {
    this.bridge.callHandler('innerEncrypt', data, function(response) {
        callback(response);
    });
};

//弹出键盘
//传入参数{id:输入框id, length:输入长度, type: 0为字母键盘；1为数字键盘；2为字符键盘。默认为1}
//传出参数 {}
nativeFunc.prototype.popPWKeyboard = function(data, callback) {
    this.bridge.callHandler('popPWKeyboard', data, function(response) {
        callback(response);
    });
};

//获取密码密文数据
//传入参数 {id:输入框id}
//传出参数 {ret:'', text:''}
nativeFunc.prototype.getPWCiphertext = function(data, callback) {
    this.bridge.callHandler('getPWCiphertext', data, function(response) {
        callback(response);
    });
};

//传入参数 {}
//传出参数 {}

//获取密码hash值
//传入参数 {id:输入框id}
//传出参数 {ret:'', text:''}
nativeFunc.prototype.getPWHash = function(data, callback) {
    this.bridge.callHandler('getPWHash', data, function(response) {
        callback(response);
    });
};

//比较密码hash值是否相同
//传入参数 {str1:'', str2:''}
//传出参数 {ret:'', result:''}
nativeFunc.prototype.comparePWInput = function(data, callback) {
    this.bridge.callHandler('comparePWInput', data, function(response) {
        callback(response);
    });
};





