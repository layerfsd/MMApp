'use strict';

var Encrpty  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    
};

Encrpty.prototype = {
    //加密
    //传入参数: {text:''}
    //传出参数: {ret: '', text:''}
    getIMEIFactor : function(callback) {
        this.bridge.callHandler('getIMEIFactor', {}, function(response) {
            callback(response);
        });
    },
    getTransportKey : function(callback) {
        this.bridge.callHandler('getTransportKey', {}, function(response) {
            callback(response);
        });
    },
    getPayloadKey : function(callback) {
        this.bridge.callHandler('getPayloadKey', {}, function(response) {
            callback(response);
        });
    },
    encryptWithPayloadKey : function(data, callback) {
        this.bridge.callHandler('encryptWithPayloadKey', data, function(response) {
            callback(response);
        });
    },
}