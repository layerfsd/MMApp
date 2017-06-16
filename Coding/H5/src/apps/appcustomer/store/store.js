import Vuex from 'vuex';
import Vue from 'vue';
import session from './modules/session';
import keepAlive from './modules/keepalive';
import tabbar from './modules/tabbar';
import refreshPage from './modules/refresh-page';
import pageAnimation from './modules/page-animation';
import signUp from './modules/signup';
Vue.use(Vuex);

const store = new Vuex.Store({
	modules: {
		session,
		keepAlive,
		tabbar,
		refreshPage,
		pageAnimation,
		signUp
	}
	// strict: process.env.NODE_ENV !== 'production' //严格模式
});

export default store
