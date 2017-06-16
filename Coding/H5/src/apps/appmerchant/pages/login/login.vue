/**
 * 流程：
 *  1.点击login按钮，调用login接口，返回四个字段
 *      customerType: '1', //0未认证 1已认证
 *      customerStatus: '1', //0未激活 1已激活
 *      bindState: '1', //0 不一致 1 一致
 *      sessionToken: ''
 *  2.如果绑定状态(bindState)不一致，调用短信接口并跳转至短信验证码页面
 *  3.如果绑定状态(bindState)一致，并且未认证，未激活，跳转至认征页面
 *  4.如果绑定状态(bindState)一致，并且已认征，未激活，跳转至激活页面(输入原始pin)
 *  5.如果绑定状态(bindState)一致，并且已认征，已激活，跳转至首页(home),并记入sesstionToken
 * 登录login
 * @Date : 2017-03-15
 * @Author : wangliang 沈飞
 * @Version : V1.0
 *
 */
<template>
    <div class="login">
        <div class="login-wrapper">
            <div class="login-main">
                <!-- logo图 -->
                <div class="logo">
                    <img src="~assets/images/common/mm_logo_3x.png" alt="">
                </div>
                <!-- 账号输入框 -->
                <div class="content-div account-content">
                    <div class="account">
                        <label for="account" class="account-name">
                            {{ $t("label_账号") }}
                        </label>
                    </div>
                    <div class="input-wrapper">
                        <span class="plus">＋</span><span class="pre-no" ref="preno" @click="">{{preNo}}</span><!--<i class="icon-down" @click="showList"></i>-->
                        <!--<input type="tel" id="account" class="content-input account-input" :placeholder="placeholder[0]" @focus="isFoucs=true" v-model="telphone" @keyup="checkField($event)" maxlength="16">-->
                        <input-primary class="account-input" :isRequired="true" :placeholder="placeholder[0]" @getValue="getValue" @focus="isFoucs=true" v-model="telphone" @keyup="checkField($event)" ></input-primary>
                    </div>
                </div>
                <!-- 密码输入框 -->
                <div class="content-div" @click="popSafeKeyboard()">
                    <div class="password">
                        <label for="password">
                            <span class="pwd-name">{{$t("label_密码")}}</span>
                        </label>
                    </div>
                    <input type="password" id="password" class="content-input pwd-input" :placeholder="placeholder[1]" @focus="isFoucs=true" v-model="password" @keyup="checkField($event)" ref="input" maxlength="20">
                    <i class="icon-eye" :class="{'open-eye':isOpenEye,'close-eye':!isOpenEye}" @click="toggle"></i>
                </div>
                <div class="forgot">
                    <router-link to="/forgotPassword">{{$t("action_忘记密码")}} ?</router-link>
                </div>
                <div class="login_button">
                    <button class="login_loginBtn" @click="login" :class="{ disabled: isDisabled }" :disabled="!active">{{$t("action_登录")}}</button>
                </div>
            </div>
        </div>
        <div class="sign-up">
            <router-link class="signUp" to="/signUp">{{$t("action_注册")}}</router-link>
        </div>
        <overlay v-if="listShow"></overlay>
        <transition name="fold">
            <div v-show="listShow" class="selectList">
                <div class="list-header">
                    <button href="#" class="cancel" @click="cancel">Cancel</button>
                    <button href="#" class="done" @click="done">Done</button>
                </div>
                <!-- <div class="list-content" ref="list-content">
                        <ul>
                            <li v-for="(item, index) in selectLists" class="list-item" :class="{'checked':currentIndex==index}" @click="currentIndex=index">
                                <span class="pre-no">{{item.preNo}}</span>
                                <img class="national-flag" :src="item.image"></img>
                                <span class="country">{{item.country}}</span>
                            </li>
                        </ul>
                        <div class="picker-center-highlight" :style="{ height: itemHeight + 'px', marginTop: -itemHeight / 2 + 'px' }"></div>
                    </div> -->
                    
                <!--设计修改，暂未使用-->
                <!--<mt-picker :slots="slots" @change="onValuesChange" value-key="preNo" :visibleItemCount="visibleItemCount" class="list-content">
                </mt-picker>-->

            </div>
        </transition>
    </div>
</template>
<script>
import Vue from 'vue';
import { Picker,Toast,MessageBox } from 'mint-ui';
import validator from '../../validator/validation';
import overlay from '../../../../components/overlay/overlay';
import configInfo from '../../config/index';
import inputPrimary from '../../../../components/input/input-primary';
// Vue.component(Picker.name, Picker);

export default {
    name: 'login',
    data() {
        return {
        	placeholder: [this.$t('label_手机号码'),this.$t('label_登录密码')],
            isEmpty: true,
            preNo: '58',
            originalPreNo: '',
            telphone: '',
            password: '',
            isOpenEye: true,
            isDisabled:true,
            visibleItemCount: 3,
            currentIndex: 1,
            isFoucs: false,
            listShow: false,
            verificationCodeType:'1',
            slots: [{
                flex: 1,
                name: 'picker',
                values: configInfo.phoneCountryCodes,
                className: 'slot1',
                textAlign: 'center',
                defaultIndex: 1
            }]
        }
    },
//  beforeCreate() {
//      this.$store.dispatch('pushKeepAlive');
//  },
    mounted() {
        this.$nextTick(() => {
        	
        })
    },
    activated:function(){
       	//设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    beforeMount: function () {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    computed: {
        active() {
            if(this.telphone && this.password){
            	this.isDisabled=false;
                return true;
            }else{
            	this.isDisabled=true;
            }
            return false;
        }
    },
    deactivated: function() {
        this.password = '';
    },
    methods: {
//      onValuesChange(picker, values) {
//          console.log(picker)
//          this.preNo = values[0].preNo;
//      },

		getValue(value) {
            this.telphone = value;
        },

        showList() {
            this.listShow = true;

        },
        cancel() {
            this.preNo = this.originalPreNo;
            this.listShow = false;
        },
        done() {
            this.listShow = false;
            this.originalPreNo = this.preNo;
        },
        login() {
            this.showIndicator();
            this.serverApi.login({
                phone: this.telphone,
                password: this.password,
            },null, (error, data) => {
                console.log(data);
                this.hideIndicator();
                if (error) {
                    Toast(error.message);
                    return;
                }
                this.$store.dispatch('saveUser',{phone:this.telphone});
                console.log('手机号：' + this.$store.state.user.phone);
                if (data.bindingDeviceChanged) {
                    //设备不一致
                    let message = this.$t('info_绑定设备弹窗提示');
                    let okTitle = this.$t('action_弹窗按钮_确定');
                    const COMFIRM = 1;//确认
                    this.showConfirm(message,(index) => {
                        if(index === COMFIRM){
                            this.$router.push('/login/verificationCode');
                        }
                    },okTitle);
                }else if (!data.bindingDeviceChanged && !data.unActiviated) {
                    //设备一致，待激活
                    this.$router.push({
                    	//激活页面
                        path: '/login/changeInitialPIN'
                    });
                }else if(!data.bindingDeviceChanged && data.unActiviated){
                    //设备一致，已激活
                    this.$store.dispatch('newSession', {
                        token: data.sessionToken
                    });
                    //回到登录前的页面，若直接登录，进入home页面
                    this.$router.push({
                        path: this.$route.query.toPage ? this.$route.query.toPage : '/home'
                    });
                }

            });
        },
        checkField(event) {
            let val = event.target.value;
            if (val === '') {
                this.isEmpty = true;
            } else if (this.telphone !== '' && this.password !== '') {
                this.isEmpty = false;
            }
            // if (window.workingInApp) {
            //     var self = this;
            //     window.keyboard.getEncryptedInput({'id':'password'}, function(data){
            //         if (data.ret==0) {
            //             console.log("data.value="+data.value+", salt="+data.salt+", rounds="+data.rounds);
            //             this.isEmpty = false;
            //         }
            //     });
            // }
        },
        popSafeKeyboard () {
          var self = this;
          console.log("popSafeKeyboard");
          if (window.workingInApp) {
              //弹出密码键盘
              window.keyboard.popSafeKeyboard({'id':'password', 'length':'6', type:'digit'}, function(data){
              });
          }
        },
        toggle() {
            this.isOpenEye = !this.isOpenEye;
            this.$refs.input.type = (this.$refs.input.type === 'text') ? 'password' : 'text';
        }
    },
    components: {
        overlay,
        inputPrimary
    }
}
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.login {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    overflow:auto;
    background-size: cover;
    background-repeat: no-repeat;
    background: linear-gradient(to bottom, @theme-bg-begin-color 0%, @theme-bg-end-color 100%);
    
    .account-input{
    	.input-primary-wrapper .input-wrapper{
    		height: 44px !important;
    	}
    	.input-primary-wrapper .input-wrapper .input{
    		background-color: transparent !important;
		    color: @theme-font-color !important;
    	}
		.input-primary-wrapper .input-wrapper .icon-close{
    		top: 7px !important;
    		color: #fff !important;
		}
    }
    
    .login-wrapper {
        width: 100%;
        min-height: 100%;
        .login-main {
            margin: 0 5%;
            width: 90%;
            overflow: hidden;
            font-size: 0;
            .logo {
                margin: 38.4% auto 18.1%;
                width: 100px;
                height: 100px;
                @media screen and (max-height: 480px) {
                    margin: 20% auto 10%;
                }
                img {
                    width: 100%;
                    height: 100%;
                    border-radius: 50%;
                }
            }
            .content-div {
                position: relative;
                display: flex;
                height: 44px;
                border-radius: 0.1rem;
                background-color: rgba(0, 0, 0, 0.3);
                color: @theme-font-color;
                &.account-content {
                    margin-bottom: 16px;
                }
                .account {
                    flex: 0 0 2.4rem;
                    width: 2.4rem;
                    line-height: 44px;
                    .account-name {
                        box-sizing: border-box;
                        display: inline-block;
                        width: 100%;
                        padding-left: 0.4rem;
                        font-size: @hm-font-size-lg;
                        vertical-align: middle;
                    }
                }
                .input-wrapper{
                    display: flex;
                    flex: 1;
                    width: 100%;
                    line-height: 44px;
                    border: none;
                    outline: none;
                    background-color: transparent;
                    font-size: @hm-font-size-sm;
                    .plus {
                        flex: 0 0 0.4rem;
                        width: 0.4rem;
                        padding-right: 0.04rem;
                        font-size: @hm-font-size-lg;
                        vertical-align: top;
                    }
                    .pre-no {
                        display: inline-block;
                        padding-right: 6px;
                        flex: 0 0 0.4rem;
                        width: 0.4rem;
                        font-size: @hm-font-size-lg;
                        vertical-align: top;
                    }
                    .icon-down {
                        display: inline-block;
                        margin-top: 18px;
                        flex: 0 0 16px;
                        width: 16px;
                        height: 9px;
                        line-height: 44px;
                        vertical-align: top;
                        background-size: 16px 9px;
                        background-repeat: no-repeat;
                        .bg-image('xiala');
                    }
                }
                .password {
                    flex: 0 0 2.4rem;
                    width: 2.4rem;
                    line-height: 44px;
                    .pwd-name {
                        display: inline-block;
                        padding-left: 0.4rem;
                        width: 100%;
                        box-sizing: border-box;
                        font-size: @hm-font-size-lg;
                        vertical-align: top;
                    }
                }
                .content-input {
                    flex: 1;
                    width: 100%;
                    border: none;
                    outline: none;
                    background-color: transparent;
                    font-size: @hm-font-size-sm;
                    color: rgba(255, 255, 255, 0.6);
                    vertical-align: middle;
                    text-indent: 0.12rem;
                    padding-left: 5px;
                }
                .pwd-input{
                	padding-right: 1rem;
                }
                .icon-eye {
                    position: absolute;
                    right: 10px;
                    top: 15px;
                    line-height: 44px;
                    width: 30px;
                    height: 20px;
                    background-position: 50% 0;
                    background-repeat: no-repeat;
                    background-size: 20px 14px;
                    &.open-eye {
                        .bg-image('open_eyes');
                    }
                    &.close-eye {
                    	top: 11px;
                    	height: 14px;
                        margin-top: 6px;
                        .bg-image('close_eyes');
                    }
                }
            }
            .forgot {
                text-align: right;
                padding-right: 0.08rem;
                a {
                    display: inline-block;
                    padding: 13px 0 18px 0;
                    font-size: @hm-font-size-sm;
                    text-decoration: none;
                    color: @theme-font-color;
                }
            }
            
        }
    }
    .sign-up {
        position: relative;
        margin: -40px auto 0;
        width: 80%;
        height: 0.36rem;
        line-height: 0.36rem;
        font-size: @hm-font-size-lg;
        text-align: center;
        @media screen and (min-height: 1024px) {
            margin: -100px auto 0;
        }
        .signUp {
            color: @theme-font-color;
        }
    }
    .selectList {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: #fff;
        z-index: 1;
        &.fold-enter-active,
        &.fold-leave-active {
            transition: all .5s;
            transform: translate3d(0, 0, 0);
        }
        &.fold-enter,
        &.fold-leave-active {
            transform: translate3d(0, 100%, 0);
        }
        .list-header {
            display: flex;
            justify-content: space-between;
            height: 45px;
            line-height: 45px;
            padding: 0 0.16rem;
            background-color: @layout-bg-color;
            .cancel,
            .done {
                display: inline-block;
                height: 100%;
                color: @link-color;
                font-size: @hm-font-size-sm;
                background:none;
                border: none;
                outline: none;
            }
        }
        .list-content {
            position: relative;
            top: -0.04rem;
            max-height: 180px;
            overflow: hidden;
            background-color: @content-bg-color;
            color: @text-color;
            cursor: pointer;
            .list-item {
                box-sizing: border-box;
                padding: 0.24rem 0 0.24rem 2.12rem;
                .pre-no,
                .national-flag,
                .country {
                    line-height: 16px;
                    font-size: @hm-font-size-base;
                    vertical-align: top;
                }
                .national-flag {
                    display: inline-block;
                    width: 0.48rem;
                    height: 18px;
                    margin: 0 0.24rem 0 0.4rem;
                }
            }
            .picker-center-highlight {
                box-sizing: border-box;
                position: absolute;
                left: 0;
                width: 100%;
                height: 40px;
                top: 50%;
                margin-top: -18px;
                pointer-events: none
            }
            .picker-center-highlight:before,
            .picker-center-highlight:after {
                content: '';
                position: absolute;
                height: 1px;
                width: 100%;
                background-color: #c6c6c6;
                display: block;
                z-index: 15;
                transform: scaleY(0.5);
            }
            .picker-center-highlight:before {
                left: 0;
                top: 0;
                bottom: auto;
                right: auto;
            }
            .picker-center-highlight:after {
                left: 0;
                bottom: 0;
                right: auto;
                top: auto;
            }
        }
    }
    .login_button {
	    .login_loginBtn {
	        line-height: 44px;
	        margin: 0;
	        padding: 0;
	        width: 100%;
	        height: 44px;
	        color: #28A7E1;
	        background-color: #fff;
	        border-radius: 0.1rem;
	        font-size: @hm-font-size-lg;
	        border: none;
	        outline: none;
	        &.disabled{
	            background-color: #e4e4e4 !important;
	        }
	    }
	    .login_loginBtn:active {                
	        opacity:0.7;                 
	    }
	}
}
</style>
