

function nativeFunc(bridge) {
    this.bridge = bridge;
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


nativeFunc.prototype.currentLanguageCode = function(data, callback) {
    this.bridge.callHandler('currentLanguageCode', data, function(response) {
        callback(response);
    });
};

nativeFunc.prototype.getIMEIFactor = function(data,callback){
    this.bridge.callHandler('getIMEIFactor',data,function(response){
        callback(response);
    });
};

nativeFunc.prototype.getTransportKey = function(data,callback){
    this.bridge.callHandler('getTransportKey',data,function(response){
        callback(response);
    });
};

nativeFunc.prototype.getPayloadKey = function(data,callback){
    this.bridge.callHandler('getPayloadKey',data,function(response){
        callback(response);
    });
};


nativeFunc.prototype.appVersion = function(data,callback){
    this.bridge.callHandler('appVersion',data,function(response){
        callback(response);
    });
};

nativeFunc.prototype.encryptWithPayloadKey = function(data,callback){
    this.bridge.callHandler('encryptWithPayloadKey',data,function(response){
        callback(response);
    });
};



