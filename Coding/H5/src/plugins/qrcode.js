'use strict';

var QRCode  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    
};

QRCode.prototype = {
    //扫描二维码
    scan : function(data, callback) {
        this.bridge.callHandler('scanQRCode', data, function(response) {
            callback(response);
        });
    },
}
