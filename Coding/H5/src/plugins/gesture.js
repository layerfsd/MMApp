'use strict';

var Gestrue  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    
};

Gestrue.prototype = {
    //设置手势密码
    //传入参数: {}
    //传出参数: {ret: device_id: guesture_pwd: }
    //
    setGesturePassword : function(data, callback) {
        this.bridge.callHandler('setGesturePassword', data, function(response) {
            callback(response);
        });
    },

    //检查手势密码
    //传入参数: {}
    //传出参数: {ret: message : guesture_pwd: }
    //
    checkGesturePassword : function(callback) {
        this.bridge.callHandler('checkGesturePassword', {}, function(response) {
            callback(response);
        });
    },
}