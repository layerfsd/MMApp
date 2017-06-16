import Vue from 'vue'
import App from './App'
import router from './router'
import Store from './store/store'
import MintUI from 'mint-ui'
//国际化语言文件
import * as LocalesEn from './translations/locales-en';
import * as LocalesZh from './translations/locales-zh';
import VueI18n from 'vue-i18n';
//原生接口
// import NativePlugins from '../../plugins'

// 导入样式
import statusMixin from './mixins/status-mixin'

// 导入样式
import '../../assets/css/index'
import './assets/css/index'
// import 'mint-ui/lib/style.css'

//导入服务接口
// var ServerAPI = require('../../api/server-api')

// import ServerAPI from '../../serverAPI.js'
// let serverApi = new ServerAPI();
// Vue.portotype.serverApi = serverApi;
// import axios from 'axios'
// Vue.prototype.$http = axios
// Import F7
// import Framework7 from 'framework7'

// // Import F7 Vue Plugin
// import Framework7Vue from 'framework7-vue'
// import 'mint-ui/lib/style.css';
Vue.use(MintUI);
// // Init F7 Vue Plugin
// Vue.use(Framework7Vue)
Vue.use(VueI18n);


Vue.config.lang = 'en';
Vue.locale('en', LocalesEn.locales);
Vue.locale('zh', LocalesZh.locales);

import Func from '../../api/func.js'
Vue.use(Func);



import NativePlugin from '../../plugins';

var nativePlugin = new NativePlugin();

//注意：如果是在App里运行，要改一下plugins/index.js，把onReady里的return callback()注释掉
nativePlugin.onReady(function(error){
	//导入服务接口
	var ServerAPI = require('../../api/server-api')
	
	var app = new Vue({
	    el: '#app',
	    router,
	    mixins: [statusMixin],
	    store: Store,
	    template: '<App/>',
	    components: { App }
	})

	var serverApi = new ServerAPI(app);
	Vue.prototype.serverApi = serverApi;
});
