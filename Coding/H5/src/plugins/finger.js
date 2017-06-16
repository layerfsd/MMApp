'use strict';

var Finger  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    
};

Finger.prototype = {
    //设置指纹
    //传入参数: {}
    //传出参数: {ret: message : device_id: }
    //
    setFingerprintPassword : function(data, callback) {
        this.bridge.callHandler('setFingerprintPassword', data, function(response) {
            callback(response);
        });
    },

    //验证指纹
    //传入参数: {}
    //传出参数: {ret: message : device_id: }
    //
    checkFingerprintPassword : function(data, callback) {
        this.bridge.callHandler('checkFingerprintPassword', data, function(response) {
            callback(response);
        });
    },
}