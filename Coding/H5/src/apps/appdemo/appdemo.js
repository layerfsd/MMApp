// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import AppDemo from './components/appdemo'
import store from './store'
// import NativePlugins from '../../plugins'

import VueI18n from 'vue-i18n';

import * as LocalesEn from './translations/locales-en';
import * as LocalesZh from './translations/locales-zh';

// import LocalesEn from './translations/locales-en';
// import LocalesZh from './translations/locales-zh';

// const locales = {
//   hello: 'hello world',
// }

// install plugin
Vue.use(VueI18n);
Vue.use(require('vue-moment'));

// set lang
Vue.config.lang = 'en';


Vue.locale('en', LocalesEn.locales);
Vue.locale('zh', LocalesZh.locales);


import NativePlugin from '../../plugins';

var nativePlugin = new NativePlugin();

nativePlugin.onReady(function(error){
	//window.device.setStatusStyleBlack(function(){});
	/* eslint-disable no-new */
	new Vue({
	  el: '#appdemo',
	  store,
	  render: page => page(AppDemo)

	})
});
