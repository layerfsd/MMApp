/*
 * 导航条
 * @Date    : 2017-03-15
 * @Author  : wangliang
 * @Version : V1.0
 *
 */
import Vue from 'vue'
import Router from 'vue-router'
import store from '../store/store'

Vue.use(Router)
/*创建一个路由对象*/
const router =  new Router({
    // mode: 'history',
    base: __dirname,
    routes: [
        {
            path: '/',
            name: 'login',
            component: (resolve) => {
                require(['../pages/login/login'], resolve)
            },
            meta: {
                keepAlive: true //需要被缓存
            }
        },
        /*登录login*/
        {
            path: '/login',
            name: 'login',
            component: (resolve) => {
                require(['../pages/login/login'], resolve)
            },
            meta: {
                keepAlive: true //需要被缓存
            }
        },
        /*发短信(绑定不一致)*/
        {
            path: '/login/verificationCode',
            name: 'verificationCode',
            component: (resolve) => {
                require(['../pages/login/verification-code'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*发原始pin*/
         {
            path: '/login/changeInitialPIN',
            component: (resolve) => {
                require(['../pages/login/change-initial-PIN'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*忘记密码forgotPassword*/
        {
            path: '/forgotPassword',
            name: 'forgotPassword',
            component: (resolve) => {
                require(['../pages/password/forgot-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*验证码(忘记密码)*/
        {
            path: '/forgotPassword/verficationCode',
            component: (resolve) => {
                require(['../pages/password/verfication-code'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*密保*/
        {
            path: '/forgotPassword/security',
            component: (resolve) => {
                require(['../pages/password/security'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*设置新密码*/
        {
            path: '/forgotpassword/setNewPassword',
            component: (resolve) => {
                require(['../pages/password/set-new-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*重置密码*/
        {
            path: '/resetPassword',
            component: (resolve) => {
                require(['../pages/password/reset-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*重置PIN*/
        {
            path: '/resetPinPassword',
            component: (resolve) => {
                require(['../pages/password/reset-pin-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*重置新PIN*/
        {
            path: '/resetNewPin',
            component: (resolve) => {
                require(['../pages/password/reset-new-pin'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*重置登录密码*/
        {
            path: '/resetLoginPassword',
            component: (resolve) => {
                require(['../pages/password/reset-login-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*设置新密码*/
        {
            path: '/setNewPassword',
            component: (resolve) => {
                require(['../pages/password/set-new-login-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*注册*/
        {
            path: '/signUp',
            component: (resolve) => {
                require(['../pages/signup/signup'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*验证码(注册)*/
        {
            path: '/signUp/verficationCode',
            component: (resolve) => {
                require(['../pages/signup/verfication-code'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*设置密码*/
        {
            path: '/signUp/setPassword',
            component: (resolve) => {
                require(['../pages/signup/set-password'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*设置密保*/
        {
            path: '/signUp/setSecurity',
            component: (resolve) => {
                require(['../pages/signup/security'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*个人信息*/
        {
            path: '/signUp/personalInformation',
            component: (resolve) => {
                require(['../pages/signup/personal-information'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*键入初始PIN*/
        {
            path: '/signUp/changeInitialPIN',
            component: (resolve) => {
                require(['../pages/signup/change-initial-PIN'], resolve)
            },
            meta: {
                keepAlive: false //不需要被缓存
            }
        },
        /*激活PIN*/
        {
            path: '/signUp/setNewPIN',
            component: (resolve) => {
                require(['../pages/signup/set-new-PIN'], resolve)
            },meta: {
                keepAlive: false //不需要被缓存
            }
        },

        /*首页*/
        {
            path: '/home',
            name: 'home',
            component: (resolve) => {
                require(['../pages/home/home'], resolve)
            }
        },
        {
            path: '/friends',
            name: 'friends',
            component: (resolve) => {
                require(['../pages/friends/friends'], resolve)
            }
        },
        {
            path: '/me',
            name: 'me',
            component: (resolve) => {
                require(['../pages/me/me'], resolve)
            }
        },

        // {
        //     path: '/home',
        //     component: (resolve) => {
        //         require(['../pages/index/index'], resolve)
        //     },
        //     children: [
        //         {
        //             path: '/home',
        //             name: 'home',
        //             component: (resolve) => {
        //                 require(['../pages/home/home'], resolve)
        //             }
        //         },
        //         {
        //             path: '/friends',
        //             name: 'friends',
        //             component: (resolve) => {
        //                 require(['../pages/friends/friends'], resolve)
        //             }
        //         },
        //         {
        //             path: '/me',
        //             name: 'me',
        //             component: (resolve) => {
        //                 require(['../pages/me/me'], resolve)
        //             }
        //         }
        //     ]
        // },
        /**
         * me/settings
         */
        {
        	path: '/me/settings',
        	name: 'settings',
        	component: (resolve) => {
        		require(['../pages/me/settings/settings'], resolve);
        	}
        },
		//feedback
        {
        	path: '/feedback',
        	name: 'feedback',
        	component: (resolve) => {
        		require(['../pages/me/settings/feedback'], resolve);
        	}
        },
        //languages
        {
        	path: '/languages',
        	name: 'languages',
        	component: (resolve) => {
        		require(['../pages/me/settings/languages'], resolve);
        	}
        },
        //about
        {
        	path: '/about',
        	name: 'about',
        	component: (resolve) => {
        		require(['../pages/me/settings/about'], resolve);
        	}
        },
        /*扫码支付-付款码*/
        {
            path: '/my-qr-code',
            name: 'my-qr-code',
            component: (resolve) => {
                require(['../pages/qr-pay/my-qr-code'], resolve)
            }
        },
        /*扫码支付-扫码-输入密码*/
        {
            path: '/qr-pay/enter-password',
            name: 'enter-password',
            component: (resolve) => {
                require(['../pages/qr-pay/enter-password'], resolve)
            }
        },
        /*扫码支付-扫码-输入密码-支付完成*/
        {
            path: '/qr-pay/details',
            name: 'qr-pay-details',
            component: (resolve) => {
                require(['../pages/qr-pay/details'], resolve)
            }
        },
        /*扫码支付-收款*/
        {
            path: '/receive-money',
            name: 'receive-money',
            component: (resolve) => {
                require(['../pages/qr-pay/receive-money'], resolve)
            }
        },
        /*扫码支付-收款-设置金额*/
        {
            path: '/set-amount',
            name: 'set-amount',
            component: (resolve) => {
                require(['../pages/qr-pay/set-amount'], resolve)
            }
        },
        /*首页-消息*/
        {
            path: '/message',
            name: 'message',
            component: (resolve) => {
                require(['../pages/message/message'], resolve)
            }
        },
        /*首页-消息-详情(Message for details)*/
        {
            path: '/message/speeding',
            name: 'speeding',
            component: (resolve) => {
                require(['../pages/message/speeding'], resolve)
            }
        },
        /*首页-消息-详情(Details)*/
        {
            path: '/message/details',
            name: 'details',
            component: (resolve) => {
                require(['../pages/message/details'], resolve)
            }
        },
        // 首页-消息-系统
        {
            path: '/message/system',
            name: 'system',
            component: (resolve) => {
                require(['../pages/message/system'], resolve)
            }
        },
        // 首页-消息-系统详情
        {
            path: '/message/system-details',
            name: 'system-details',
            component: (resolve) => {
                require(['../pages/message/system-details'], resolve)
            }
        },
        /*我的钱包 cash-wallet*/
        {
            path: '/cash-wallet/cash',
            name: 'cash',
            component: (resolve) => {
                require(['../pages/cash-wallet/cash'], resolve);
            }
        },
		//我的钱包里点击checkall的细节
        {
            path: '/transactions',
            name: 'transactions',
            component: (resolve) => {
                require(['../pages/cash-wallet/transactions'], resolve);
            }
        },
        //transactions里的fliters
         {
            path: '/fliters',
            name: 'fliters',
            component: (resolve) => {
                require(['../pages/cash-wallet/fliters'], resolve);
            }
        },
        //fliters的outflow
        {
            path: '/outflow',
            name: 'outflow',
            component: (resolve) => {
                require(['../pages/cash-wallet/outflow'], resolve);
            }
        },
		// 付款,无记录
        {
            path: '/pay-bill-no-history',
            name: 'pay-bill-no-history',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/pay-bill-no-history'], resolve);
            }
        },
        //无历史记录的record
        {
            path: '/bill-record',
            name: 'bill-record',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/bill-record'], resolve);
            }
        },
        //record的详细细节
		{
            path: '/pay-bill/details',
            name: 'pay-bill/details',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/details'], resolve);
            }
		},
         //添加付款账户
        {
            path: '/Electricity',
            name: 'Electricity',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/Electricity(Example)-new'], resolve);
            }
        },
		//付款第一步
        {
            path: '/example-step1',
            name: 'example-step1',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/example-step1'], resolve);
            }
		},
		//付款第三步
		 {
            path: '/example-step3',
            name: 'example-step3',
            component: (resolve) => {
                require(['../pages/home/pay-bill/pay-bill-no-history/example-step3'], resolve);
            }
		},
        /*首页-头像*/
        {
            path: '/me/profile',
            name: 'profile',
            component: (resolve) => {
                require(['../pages/profile/profile'], resolve)
            }
        },
        /*我-设置头像*/
        {
            path: '/me/protrait',
            name: 'protrait',
            component: (resolve) => {
                require(['../pages/profile/protrait'], resolve)
            }
        },
        /*我-我的QR-code*/
        {
            path: '/me/my-QR-code',
            name: 'my-QR-code',
            component: (resolve) => {
                require(['../pages/profile/my-QR-code'], resolve)
            }
        },
        /*首页-充值 top-up*/
        {
            path: '/top-up',
            name: 'top-up',
            component: (resolve) => {
                require(['../pages/top-up/top-up'], resolve)
            }
        },
        /*首页-充值-结果 top-up/detail*/
        {
            path: '/top-up/detail',
            name: 'detail',
            component: (resolve) => {
                require(['../pages/top-up/detail'], resolve)
            }
        },
        /*首页-所有商家 all*/
        {
            path: '/merchants/all',
            name: 'all',
            component: (resolve) => {
                require(['../pages/merchants/all'], resolve)
            }
        },
        /*首页-商家 merchant*/
        {
            path: '/merchants/:id',
            name: 'merchant',
            component: (resolve) => {
                require(['../pages/merchants/merchant'], resolve)
            }
        },
        /*转账 transfer*/
        {
            path: '/transfer/transfer',
            name: 'transfer',
            component: (resolve) => {
                require(['../pages/transfer/transfer'], resolve)
            }
        },
        /*转账-朋友 friend*/
        {
            path: '/transfer/friend',
            name: 'friend',
            component: (resolve) => {
                require(['../pages/transfer/friend'], resolve)
            }
        },
        /*转账-选择朋友select-friend*/
        {
            path: '/transfer/select-friend',
            name: 'transfer-select-friend',
            component: (resolve) => {
                require(['../pages/transfer/select-friend'], resolve)
            }
        },
        /*转账-转账给朋友 transfer-to-friend*/
        {
            path: '/transfer/transfer-to-friend',
            name: 'transfer-to-friend',
            component: (resolve) => {
                require(['../pages/transfer/transfer-to-friend'], resolve)
            }
        },
        /*转账-转账给朋友-完成 transfer-success*/
        {
            path: '/transfer/transfer-success',
            name: 'transfer-success',
            component: (resolve) => {
                require(['../pages/transfer/transfer-success'], resolve)
            }
        },
        /*AA付款 go-dutch*/
        {
            path: '/go-dutch/go-dutch',
            name: 'go-dutch',
            component: (resolve) => {
                require(['../pages/go-dutch/go-dutch'], resolve)
            }
        },
        /*AA付款-我的收款码my-qr-code*/
        {
            path: '/go-dutch/my-qr-code',
            name: 'go-dutch-my-qr-code',
            component: (resolve) => {
                require(['../pages/go-dutch/my-qr-code'], resolve)
            }
        },
        /*AA付款-发起收款-详情received*/
        {
            path: '/go-dutch/received',
            name: 'received',
            component: (resolve) => {
                require(['../pages/go-dutch/received'], resolve)
            }
        },
        /*AA付款-选择付款*/
        {
            path: '/go-dutch/choose',
            name: 'choose',
            component: (resolve) => {
                require(['../pages/go-dutch/choose'], resolve)
            }
        },
        /*AA付款-选择付款-详细*/
        {
            path: '/go-dutch/choose-received',
            name: 'choose-received',
            component: (resolve) => {
                require(['../pages/go-dutch/choose-received'], resolve)
            }
        },
        /*AA付款-选择成员*/
        {
            path: '/friends/select-merbers',
            name: 'select-merbers',
            component: (resolve) => {
                require(['../pages/friends/select-merbers'], resolve)
            }
        },
        /*AA付款-历史记录*/
        {
            path: '/go-dutch/history',
            name: 'history',
            component: (resolve) => {
                require(['../pages/go-dutch/history'], resolve)
            }
        },
        /*AA付款-历史记录-详情*/
        {
            path: '/go-dutch/history-details',
            name: 'history-details',
            component: (resolve) => {
                require(['../pages/go-dutch/history-details'], resolve)
            }
        },

        
    ]
});

router.beforeEach((to, from, next) => {
    console.log("beforeEach");

    //处理tabbar是否显示
    function showTabbar(to, store) {

        console.log("to.path="+to.path);

        if( to.path == '/home' ||
            to.path == '/friends' ||
            to.path == '/me')
        {
            store.dispatch('showTabbar');
        } else{
            store.dispatch('hideTabbar');
        }
    }
    //处理动画
    function changedPageAnimation(to, store){
        if(store.state.pageAnimation.pageAnimationBack == true){
            store.dispatch("setPageAnimationClass", {
                enter:'page-animated fadeInLeft',
                leave:'page-animated fadeOutRight'
            });
            store.dispatch("setPageAnimationBack", false);
        }else{
            if( to.path == '/home' ||
                to.path == '/friends' ||
                to.path == '/me'){
                store.dispatch("setPageAnimationClass", {
                    enter:'',
                    leave:''
                });
            }else{
                store.dispatch("setPageAnimationClass", {
                    enter:'page-animated fadeInRight',
                    leave:'page-animated fadeOutLeft'
                });
            }
        }
    }

    //不要用router.app.$store, 有可能为空
    //var store = router.app.$store;

    if(typeof store === 'undefined'){
        console.log("store is undefined");
    }else{
        showTabbar(to, store);
        changedPageAnimation(to, store);
        if (store.getters.sessionIsValid) {
            console.log("已经登录，不需要跳转登录");
            next();
            return;
        }
        console.log("session is invalid");
    }
    if( to.path == '/login' || to.path == '/pay-bill-no-history') {
        // "不需要登录的页面"
        next();
        return;
    }
    console.log("go to login page");
    next({path:'/login', query:{toPage:to.path}});
});
export default router
