'use strict';

var Device  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    
};

Device.prototype = {
    deviceModel : function(callback) {
        this.bridge.callHandler('deviceModel', {}, function(response) {
            callback(response);
        });
    },

    //设备Id
    deviceId : function(callback) {
        this.bridge.callHandler('deviceId', {}, function(response) {
            callback(response);
        });
    },

    //设备IP
    deviceIP : function(callback) {
        this.bridge.callHandler('deviceIP', {}, function(response) {
            callback(response);
        });
    },

    //设备OS版本号
    deviceOSVersion : function(callback) {
        this.bridge.callHandler('deviceOSVersion', {}, function(response) {
            callback(response);
        });
    },

    //App版本号
    appVersion : function(callback) {
        this.bridge.callHandler('appVersion', {}, function(response) {
            callback(response);
        });
    },

    //当前语言代码
    currentLanguageCode : function(callback) {
        this.bridge.callHandler('currentLanguageCode', {}, function(response) {
            callback(response);
        });
    },

    getLocation : function(callback) {
        this.bridge.callHandler('getLocation', {}, function(response) {
            callback(response);
        });
    },

    //是否支持沉浸式状态栏
    supportTranslucentStatus : function(callback) {
        this.bridge.callHandler('supportTranslucentStatus', {}, function(response) {
            if (response==='true' || response==='True' || response==='yes' || response==='Yes')
                callback(true);
            else 
                callback(false);
        });
    },
    //取状态栏高度(px)
    getStatusHeight : function(callback) {
        this.bridge.callHandler('getStatusHeight', {}, function(response) {
            callback(response);
        });
    },
    //设置沉浸式状态栏字体颜色为深色
    setStatusStyleBlack : function(callback) {
        this.bridge.callHandler('setStatusStyleBlack', {}, function(response) {
            callback(response);
        });
    },
    //设置沉浸式状态栏字体颜色为浅色
    setStatusStyleLight : function(callback) {
        this.bridge.callHandler('setStatusStyleLight', {}, function(response) {
            callback(response);
        });
    },
    //从照片库选取照片
    //传入参数{imageType:png或jpg compressionQuality:jpg的压缩比，默认是0.7}
    //传出参数: {ret: base64Encoded:}  base64Encoded为图片的base64码
    pickPhotoFromLibrary : function(data, callback) {
        this.bridge.callHandler('pickPhotoFromLibrary', data, function(response) {
            callback(response);
        });
    },
    //拍照
    //传入参数{imageType:png或jpg compressionQuality:jpg的压缩比，默认是0.7}
    //传出参数: {ret: base64Encoded:}  base64Encoded为图片的base64码
    takePhoto : function(data, callback) {
        this.bridge.callHandler('takePhoto', data, function(response) {
            callback(response);
        });
    },
}
