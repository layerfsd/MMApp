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
            }
        },
        /*登录login*/
        {
            path: '/login',
            name: 'login',
            component: (resolve) => {
                require(['../pages/login/login'], resolve)
            }
        },
        /*发短信(绑定不一致)*/
        {
            path: '/login/verificationCode',
            name: 'verificationCode',
            component: (resolve) => {
                require(['../pages/login/verification-code'], resolve)
            }
        },
        /*发原始pin*/
         {
            path: '/login/changeInitialPIN',
            component: (resolve) => {
                require(['../pages/login/change-initial-PIN'], resolve)
            }
        },
        /*忘记密码forgotPassword*/
        {
            path: '/forgotPassword',
            name: 'forgotPassword',
            component: (resolve) => {
                require(['../pages/forgotPassword/forgot-password'], resolve)
            }
        },
        /*验证码(忘记密码)*/
        {
            path: '/forgotPassword/verficationCode',
            component: (resolve) => {
                require(['../pages/forgotPassword/verfication-code'], resolve)
            }
        },
        /*密保*/
        {
            path: '/forgotPassword/security',
            component: (resolve) => {
                require(['../pages/forgotPassword/security'], resolve)
            }
        },
        /*设置新密码*/
        {
            path: '/setNewPassword',
            component: (resolve) => {
                require(['../pages/forgotPassword/set-new-password'], resolve)
            }
        },
        /*注册*/
        {
            path: '/signUp',
            component: (resolve) => {
                require(['../pages/signup/signup'], resolve)
            }
        },
        /*验证码(注册)*/
        {
            path: '/signUp/verficationCode',
            component: (resolve) => {
                require(['../pages/signup/verfication-code'], resolve)
            }
        },
        /*设置密码*/
        {
            path: '/signUp/setPassword',
            component: (resolve) => {
                require(['../pages/signup/set-password'], resolve)
            }
        },
        /*设置密保*/
        {
            path: '/signUp/setSecurity',
            component: (resolve) => {
                require(['../pages/signup/security'], resolve)
            }
        },
        /*键入初始PIN*/
        {
            path: '/signUp/changeInitialPIN',
            component: (resolve) => {
                require(['../pages/signup/change-initial-PIN'], resolve)
            }
        },
        /*激活PIN*/
        {
            path: '/signUp/setNewPIN',
            component: (resolve) => {
                require(['../pages/signup/set-new-PIN'], resolve)
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
         /*扫卡支付*/
        {
            path: '/scanCard',
            name: 'scanCard',
            component: (resolve) => {
                require(['../pages/cardPay/scan-card'], resolve)
            }
        },
          /*扫卡支付*/
        {
            path: '/enterAccount',
            name: 'enterAccount',
            component: (resolve) => {
                require(['../pages/cardPay/enter-account'], resolve)
            }
        },
            /*支付社保费*/
        {
            path: '/chargeSocialSecurityFee',
            name: 'chargeSocialSecurityFee',
            component: (resolve) => {
                require(['../pages/cardPay/charge-social-security-fee'], resolve)
            }
        },
            /*社保卡输入PIN码*/
        {
            path: '/socialCardEnterPin',
            name: 'socialCardEnterPin',
            component: (resolve) => {
                require(['../pages/cardPay/social-card-enter-pin'], resolve)
            }
        },
        /*社保卡细节*/
         {
            path: '/cardPayDetails',
            name: 'cardPayDetails',
            component: (resolve) => {
                require(['../pages/cardPay/card-pay-details'], resolve)
            }
        },
        /*设置settings*/
        {
            path: '/settings',
            name: 'settings',
            component: (resolve) => {
                require(['../pages/settings/settings'], resolve)
            }
        },
        /*我的账户*/
         {
            path: '/myAccount',
            name: 'myAccount',
            component: (resolve) => {
                require(['../pages/myAccount/myAccount'], resolve)
            },
            children: [
                /*收入()*/
                {
                    path: '/myAccount',
                    component: (resolve) => {
                        require(['../pages/myAccount/income'], resolve)
                    },
                    redirect: '/myAccount/income'
                },
                /*收入()*/
                {
                    path: '/myAccount/income',
                    component: (resolve) => {
                        require(['../pages/myAccount/income'], resolve)
                    }
                },
                /*超额()*/
                {
                    path: '/myAccount/speeding',
                    component: (resolve) => {
                        require(['../pages/myAccount/speeding'], resolve)
                    }
                },
                /*固定资产()*/
                {
                    path: '/myAccount/fixed',
                    component: (resolve) => {
                        require(['../pages/myAccount/fixed'], resolve)
                    }
                },
            ]
        },
         /*设置settings-----密码(password)*/
        {
            path: '/password',
            name: 'password',
            component: (resolve) => {
                require(['../pages/settings/password'], resolve)
            }
        },
         /*密码password-----输入原始密码*/
        {
            path: '/resetLoginPassword',
            name: 'resetLoginPassword',
            component: (resolve) => {
                require(['../pages/resetLoginPassword/reset-login-password'], resolve)
            }
        },
          /*密码password-----重置新密码*/
        {
            path: '/setNewLoginPassword',
            name: 'setNewLoginPassword',
            component: (resolve) => {
                require(['../pages/resetLoginPassword/set-new-login-password'], resolve)
            }
        },
         /*设置settings-----反馈(feedback)*/
        {
            path: '/feedback',
            name: 'feedback',
            component: (resolve) => {
                require(['../pages/settings/feedback'], resolve)
            }
        },
         /*设置settings-----关于(about)*/
        {
            path: '/about',
            name: 'about',
            component: (resolve) => {
                require(['../pages/settings/about'], resolve)
            }
        },
         /*设置settings-----语言(languages)*/
         {
            path: '/languages',
            name: 'languages',
            component: (resolve) => {
                require(['../pages/settings/languages'], resolve)
            }
        },
        /*上传商家logo-----(logo)*/
         {
            path: '/uploadLogo',
            name: 'uploadLogo',
            component: (resolve) => {
                require(['../pages/uploadLogo/upload-logo'], resolve)
            }
        },
        /*profile-----*/
         {
            path: '/profile',
            name: 'profile',
            component: (resolve) => {
                require(['../pages/profile/profile'], resolve)
            }
        },
        /*protrait-----*/
         {
            path: '/protrait',
            name: 'protrait',
            component: (resolve) => {
                require(['../pages/profile/protrait'], resolve)
            }
        },
        /*重置密保问题-----重置密保*/
         {
            path: '/resetSecurity',
            name: 'resetSecurity',
            component: (resolve) => {
                require(['../pages/resetSecurity/reset-security'], resolve)
            }
        },
        /*设置settings-----密码(password)-----重置支付密码--输入原始PIN（reset-pin-pwd）*/
         {
            path: '/resetPin/reset-pin-pwd',
            component: (resolve) => {
                require(['../pages/resetPin/reset-pin-pwd'], resolve)
            }
        },
        /*设置settings-----密码(password)-----重置支付密码--输入新PIN（reset-pin-pwd）*/
         {
            path: '/resetPin/setNewPin',
            component: (resolve) => {
                require(['../pages/resetPin/set-new-pin'], resolve)
            }
        },
        /*提现（withdraw）*/
         {
            path: '/withdraw',
            component: (resolve) => {
                require(['../pages/withdraw/withdraw'], resolve)
            }
        },
        /*提现--输入PIN*/
         {
            path: '/withdraw/enterPin',
            component: (resolve) => {
                require(['../pages/withdraw/enter-pin'], resolve)
            }
        },
        /*提现--输入PIN--提现成功*/
         {
            path: '/withdraw/withdrawSuccess',
            component: (resolve) => {
                require(['../pages/withdraw/withdraw-success'], resolve)
            }
        },
        /*人员管理(operatorManagement)*/
         {
            path: '/operatorManagement',
            component: (resolve) => {
                require(['../pages/registered/operator-management'], resolve)
            }
        },
        /*创建角色(createOperator)*/
         {
            path: '/createOperator',
            component: (resolve) => {
                require(['../pages/registered/create-operator'], resolve)
            }
        },
        /*发验证码()*/
        {
            path: '/registered/verification',
            component: (resolve) => {
                require(['../pages/registered/verification-code'], resolve)
            }
        },
        /*认征()*/
        {
            path: '/registered',
            component: (resolve) => {
                require(['../pages/registered/personal-information'], resolve)
            }
        },

        /*Home/修改PIN*/
        {
            path: '/changePin/change-pin',
            component: (resolve) => {
                require(['../pages/changePin/change-pin'], resolve)
            }
        },
        /*Home/修改PIN--输入新PIN*/
         {
            path: '/changePin/set-new-pin',
            component: (resolve) => {
                require(['../pages/changePin/set-new-pin'], resolve)
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
            to.path == '/myAccount/income' ||
            to.path == '/myAccount/speeding' ||
            to.path == '/myAccount/fixed' ||
            to.path == '/settings')
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
                to.path == '/myAccount/income' ||
                to.path == '/myAccount/speeding' ||
                to.path == '/myAccount/fixed' ||
                to.path == '/settings'){
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
    if( to.path == '/login') {
        // "不需要登录的页面"
        next();
        return;
    }
    console.log("go to login page");
    next({path:'/login', query:{toPage:to.path}});
});
export default router
