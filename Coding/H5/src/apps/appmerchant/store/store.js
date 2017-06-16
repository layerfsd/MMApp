import Vuex from 'vuex';
import Vue from 'vue';
import session from './modules/session';
import keepAlive from './modules/keepalive';
import tabbar from './modules/tabbar';
import refreshPage from './modules/refresh-page';
import pageAnimation from './modules/page-animation';
import user from './modules/user';
import language from './modules/language';
Vue.use(Vuex);

const store = new Vuex.Store({
	modules: {
		session,
		keepAlive,
		tabbar,
		refreshPage,
		pageAnimation,
		user,
		language
	}
	// strict: process.env.NODE_ENV !== 'production' //严格模式
});

export default store
