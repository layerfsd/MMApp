<template>
  <div class="native-func">
    <h3>Device functions {{ $t("你好_欢迎页") }}</h3>
    <p>{{ $t("hello_name", {name: 'sam'}) }}  {{ $tc('total_car', 2, {count:2}) }} </p>
    <p>{{ day }}</p>
    <div id='buttons'>
      <button @click="deviceId()">deviceId</button>
      <button @click="deviceModel()">deviceModel</button>
      <button @click="deviceIP()">deviceIP</button>
      <button @click="deviceOSVersion()">deviceOSVersion</button>
      <button @click="appVersion()">appVersion</button>
      <button @click="currentLanguageCode()">currentLanguageCode</button>
      <button @click="getLocation()">getLocation</button>
      <button @click="getIMEIFactor()">getIMEIFactor</button>
      <button @click="getTransportKey()">getTransportKey</button>
      <button @click="getPayloadKey()">getPayloadKey</button>
      <button @click="encryptWithPayloadKey()">encryptWithPayloadKey</button>
      <button @click="supportTranslucentStatus()">supportTranslucentStatus</button>
      <button @click="getStatusHeight()">getStatusHeight</button>
      <button @click="setStatusStyleBlack()">setStatusStyleBlack</button>
      <button @click="setStatusStyleLight()">setStatusStyleLight</button>
      <button @click="scanQRCode()">scanQRCode</button>
      <button @click="pickPhoto()">pickPhoto</button>
      <button @click="takePhoto()">takePhoto</button>
    </div>
    <h3>Gesture password functions</h3>
    <div id='buttons'>
      <button @click="setGesturePassword()">setGesturePassword</button>
      <button @click="checkGesturePassword()">checkGesturePassword</button>
    </div>
    <input id="username" />
    <div @click="popSafeKeyboard()">
      <input id="password" disabled="disabled" placeholder="请输入密码"/>
    </div>
    <div id='buttons'>
      <button @click="popSafeKeyboard()">popSafeKeyboard</button>
      <button @click="getEncryptedInput()">getEncryptedInput</button>
    </div>
    <div class='photo'>
        <img :src="imageBase64" alt="">
    </div>
    <ul class="log">
      <li v-for="log in logs">
        {{ log.message }} : {{ log.data}}
      </li>
    </ul>
  </div>
</template>

<script>

var moment = require('moment');
moment.locale('zh-cn');

export default {
  data () {
    return {
      payloadKey: '',
      logs: [],
      day: moment().format('LLLL'),
      imageBase64: ''
    }
  },

  methods: {
    deviceId () {
      var self = this;
      window.device.deviceId(function(deviceId){
        self.logs.push({
          message:'deviceId',
          data: JSON.stringify(deviceId)
        });
      });
    },

    deviceModel () {
      var self = this;
      window.device.deviceModel(function(deviceModel){
        self.logs.push({
          message:'deviceModel',
          data: JSON.stringify(deviceModel)
        });
      });
    },

    deviceIP () {
      var self = this;
      window.device.deviceIP(function(deviceIP){
        self.logs.push({
          message:'deviceIP',
          data: JSON.stringify(deviceIP)
        });
      });
    },

    deviceOSVersion () {
      var self = this;
      window.device.deviceOSVersion(function(deviceOSVersion){
        self.logs.push({
          message:'deviceOSVersion',
          data: JSON.stringify(deviceOSVersion)
        });
      });
    },

    appVersion () {
      var self = this;
      window.device.appVersion(function(appVersion){
        self.logs.push({
          message:'appVersion',
          data: JSON.stringify(appVersion)
        });
      });
    },

    currentLanguageCode () {
      var self = this;
      window.device.currentLanguageCode(function(currentLanguageCode){
        self.logs.push({
          message:'currentLanguageCode',
          data: JSON.stringify(currentLanguageCode)
        });
      });
    },

    getLocation () {
      var self = this;
      window.device.getLocation(function(data){
        self.logs.push({
          message:'getLocation',
          data: JSON.stringify(data)
        });
      });
    },

    setGesturePassword () {
      var self = this;
      window.gesture.setGesturePassword({retryLimit:3}, function(data){
        self.logs.push({
          message:'setGesturePassword',
          data: JSON.stringify(data)
        });
      });
    },

    checkGesturePassword () {
      var self = this;
      window.gesture.checkGesturePassword(function(data){
        self.logs.push({
          message:'checkGesturePassword',
          data: JSON.stringify(data)
        });
      });
    },

    getIMEIFactor () {
      var self = this;
      window.encrypt.getIMEIFactor(function(data){
        self.logs.push({
          message:'getIMEIFactor',
          data: JSON.stringify(data)
        });
      });
    },

    getTransportKey () {
      var self = this;
      window.encrypt.getTransportKey(function(data){
        self.logs.push({
          message:'getTransportKey',
          data: JSON.stringify(data)
        });
      });
    },

    getPayloadKey () {
      var self = this;
      window.encrypt.getPayloadKey(function(data){
        self.payloadKey = data;
        self.logs.push({
          message:'getPayloadKey',
          data: JSON.stringify(data)
        });
      });
    },

    encryptWithPayloadKey () {
      var self = this;
      window.encrypt.encryptWithPayloadKey({data:"123456", payloadKey:self.payloadKey}, function(data){
        self.logs.push({
          message:'encryptWithPayloadKey',
          data: JSON.stringify(data)
        });
      });
    },

    supportTranslucentStatus () {
      var self = this;
      window.device.supportTranslucentStatus(function(data){
        self.logs.push({
          message:'supportTranslucentStatus',
          data: JSON.stringify(data)
        });
      });
    },

    getStatusHeight () {
      var self = this;
      window.device.getStatusHeight(function(data){
        self.logs.push({
          message:'getStatusHeight',
          data: JSON.stringify(data)
        });
      });
    },

    setStatusStyleBlack () {
      var self = this;
      window.device.setStatusStyleBlack(function(data){
        self.logs.push({
          message:'setStatusStyleBlack',
          data: JSON.stringify(data)
        });
      });
    },

    setStatusStyleLight () {
      var self = this;
      window.device.setStatusStyleLight(function(data){
        self.logs.push({
          message:'setStatusStyleLight',
          data: JSON.stringify(data)
        });
      });
    },

    popSafeKeyboard () {
      var self = this;
      window.keyboard.popSafeKeyboard({'id':'password', 'length':'6', type:'digit'}, function(data){
        self.logs.push({
          message:'popSafeKeyboard',
          data: JSON.stringify(data)
        });
      });
    },

    getEncryptedInput () {
      var self = this;
      window.keyboard.getEncryptedInput({'id':'password'}, function(data){
        self.logs.push({
          message:'getEncryptedInput',
          data: JSON.stringify(data)
        });
      });
    },

    scanQRCode () {
      var self = this;
      window.qrcode.scan({'canScanPhoto':true}, function(data){
        self.logs.push({
          message:'scanQRCode',
          data: JSON.stringify(data)
        });
      });
    },

    pickPhoto () {
      var self = this;
      window.device.pickPhotoFromLibrary({'imageType':'jpg', compressionQuality:0.7}, function(data){
        self.imageBase64 = 'data:image/png;base64,'+data.base64Encoded;
        console.log(self.imageBase64);
        self.logs.push({
          message:'pickPhotoFromLibrary',
          data: JSON.stringify(data)
        });
      });
    },

    takePhoto () {
      var self = this;
      window.device.takePhoto({'imageType':'jpg', compressionQuality:0.7}, function(data){
        self.imageBase64 = 'data:image/png;base64,'+data.base64Encoded;
        console.log(self.imageBase64);

        self.logs.push({
          message:'takePhoto',
          data: JSON.stringify(data)
        });
      });
    },

  }
}
</script>
<style lang="less">
.photo {
    width: 100px;
    height: 100px;
    img {
        width: 100%;
        height: 100%;
    }
}
</style>
