'use strict';

var Keyboard  = module.exports = function(bridge){
    console.log("bridge = " + bridge);
    this.bridge = bridge;
    //函数说明 提供密码输入后反显文本
    this.bridge.registerHandler('setJsInputFieldValue', function(data, responseCallback) {
        var jsonData = JSON.parse(data);
        console.log("setJsInputFieldValue data = " + data);
        document.getElementById(jsonData.id).value = jsonData.text;

        //回调返回处理
        // responseCallback("数据");
    });
    
};

Keyboard.prototype = {
    //弹出键盘
    //传入参数{id:输入框id, length:输入长度, type: 0为字母键盘；1为数字键盘；2为字符键盘。默认为1}
    //传出参数 {}
    popSafeKeyboard : function(data, callback) {
        this.bridge.callHandler('popSafeKeyboard', data, function(response) {
            callback(response);
        });
    },

    //获取密码密文数据
    //传入参数 {id:输入框id}
    //传出参数 {ret:'', value:''}
    getEncryptedInput : function(data, callback) {
        this.bridge.callHandler('getEncryptedInput', data, function(response) {
            callback(response);
        });
    },

    //传入参数 {}
    //传出参数 {}

    //获取密码hash值
    //传入参数 {}
    //传出参数 {ret:'', text:''}
    getPWHash : function(data, callback) {
        this.bridge.callHandler('getPWHash', data, function(response) {
            callback(response);
        });
    },

    //比较密码hash值是否相同
    //传入参数 {str1:'', str2:''}
    //传出参数 {ret:'', result:''}
    comparePWInput : function(data, callback) {
        this.bridge.callHandler('comparePWInput', data, function(response) {
            callback(response);
        });
    },
}