import Vue from 'vue'
import App from './App'
import router from './router'
import Store from './store/store'
import MintUI from 'mint-ui'
//国际化语言文件
import * as LocalesEn from './translations/locales-en';
import * as LocalesZh from './translations/locales-zh';
import VueI18n from 'vue-i18n';

// 导入样式
import statusMixin from './mixins/status-mixin'

// 加入过滤器
import './filters/filter.js';
// 导入样式
import './assets/css/index'

Vue.use(MintUI);

import Func from '../../api/func.js'
Vue.use(Func);

Vue.use(VueI18n);

// 默认语言
import config from './config/index.js';

var lang = config.lang;

console.log('默认语言：'+ lang);

// 设置默认语言
Vue.config.lang = lang;

Vue.locale('en', LocalesEn.locales);
Vue.locale('zh', LocalesZh.locales);

import NativePlugin from '../../plugins';

var nativePlugin = new NativePlugin();

//注意：如果是在App里运行，要改一下plugins/index.js，把onReady里的return callback()注释掉
nativePlugin.onReady(function(error){
  //导入服务接口
  var ServerAPI = require('../../api/merchant-server-api')
  var app = new Vue({
      el: '#app',
      router,
      mixins: [statusMixin],
      store: Store,
      template: '<App/>',
      components: { App }
  })

  var serverApi = new ServerAPI(Vue, app);
  Vue.prototype.serverApi = serverApi;
});
