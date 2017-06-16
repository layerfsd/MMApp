'use strict';
var device = require("./device.js");
var finger = require("./finger.js");
var gesture = require("./gesture.js");
var keyboard = require("./keyboard.js");
var encrypt = require("./encrypt.js");
var qrcode = require("./qrcode.js");

function setupWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'https://__bridge_loaded__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0);
    //兼容Android端
    document.addEventListener(
       'WebViewJavascriptBridgeReady'
       , function() {
           callback(WebViewJavascriptBridge)
       },
       false
   );
    
}

//设置初始值
window.supportTranslucentStatus = true;
window.workingInApp = true; //是否在App内运行

var NativePlugin  = module.exports = function(){
    
};

NativePlugin.prototype = {

    onReady: function(callback) {
      //如果是在浏览器里运行，直接返回
      //是否生产版本，
      let pluginTimer;
      if (process.env.NODE_ENV !== 'production') {
          pluginTimer = setTimeout(()=>{
              console.log("no supported native plugin");
              window.workingInApp = false;  //不在App内运行
              callback();
          }, 200);
      }

      setupWebViewJavascriptBridge(function(bridge) {
        if (process.env.NODE_ENV !== 'production') {
            window.clearTimeout(pluginTimer)
        }
        //初始化,Android用到
        if(bridge.init && typeof(bridge.init)=="function") { 
            bridge.init(function(message, responseCallback) {
               var data = {
                 'Javascript Responds': 'Wee!'   
               };
               responseCallback(data);
            });
        }
        console.log("setupWebViewJavascriptBridge bridge = " + bridge);    
        window.device = new device(bridge); 
        window.finger = new finger(bridge);  
        window.gesture = new gesture(bridge);
        window.keyboard = new keyboard(bridge);
        window.encrypt = new encrypt(bridge);
        window.qrcode = new qrcode(bridge);
        window.device.supportTranslucentStatus(function(supported){
            window.supportTranslucentStatus = supported;
            callback();
        });
      });
    }
      
}
