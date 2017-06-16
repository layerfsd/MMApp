/* 
 * 登录 verfication-code 
 * @Date : 2017-03-15 
 * @Author : wangliang 沈飞
 * @Version : V1.0 
 * 
 */
<template>
    <div class="verfication-code layout" ref="verificationCode">
        <nav-header :title="title"></nav-header>
        <div class="initial-info">
            <span class="text">{{$t('info_输入OTP')}}</span>
        </div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" :text="verificationCode" @getChange="compare"></input-verfication>
        </div>
        <div class="tips">
            <span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">{{phone|filterPhone}}</span>
            <count-down></count-down>
        </div>
    </div>
</template>
<script>
import {Toast,MessageBox } from 'mint-ui';
import navHeader from '../../../../components/header/nav-header';
import inputVerfication from '../../components/input/input-verfication';
import countDown from '../../components/count-down/count-down';
export default {
    name: 'verificationCode',
    data() {
        return {
        	title:this.$t('label_登录'),
        	phone:'',
            verificationCode: '',
            rightCode: '',
            verificationCodeType:'2',
        }
    },
    beforeCreate() {
   		this.$store.dispatch('pushKeepAlive','verificationCode');
   	},
    mounted() {

    },
    computed: {},
    activated:function(){
    	//获取手机号
       	this.phone=this.$store.state.user.phone;
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

    methods: {
        compare(value) {
            this.showIndicator();
            console.log(this.$store.state.user.phone);
            this.serverApi.checkVerificationCode({
                phone: this.$store.state.user.phone,
                verificationCodeType: this.verificationCodeType,
                verificationCode: value
            },null, (error, data) => {
            	this.hideIndicator();
//          	if (error) {
//                  this.showToast(error.message);
//                  return;
//              }
                this.bindPhoneChange();
            })
        },
        bindPhoneChange() {
            this.showIndicator();
            this.serverApi.bindPhoneChange({
                phone: this.$store.state.user.phone,
            },null, (error, data) => {
                this.hideIndicator();
//              if (error) {
//                  this.showToast(error.message);
//                  return;
//              }
                console.log(data);
                if(data.adminStatus){
                	this.$store.dispatch('newSession', {
                        token: data.sessionToken
                    });
                    this.$router.push({
                        path: this.$route.query.toPage ? this.$route.query.toPage : '/home'
                    });
                }
//              if (data.unVerified && data.unActivated) {
//                  //待认证，待激活
//                  this.$router.push({
//                      path: '/signUp/personalInformation'
//                  });
//              } else if (!data.unVerified && data.unActivated) {
//                  //已认证，待激活
//                  this.$router.push({
//                      path: '/login/changeInitialPIN'
//                  });
//              } else if (!data.unVerified && !data.unActivated) {
//                  //已认证，已激活
//                  this.$store.dispatch('newSession', {
//                      token: data.sessionToken
//                  });
//                  this.$router.replace({
//                      path: this.$route.query.toPage ? this.$route.query.toPage : '/home'
//                  });
//              }
            })
       },
       

    },
    filters: {
        filterPhone(value) {
            let markedPhone = '' + value;
            console.log("markedPhone="+markedPhone);
            markedPhone = '****' + markedPhone.slice(-4);
            return markedPhone;
        }
    },
    components: {
        navHeader,
        inputVerfication,
        countDown
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.verfication-code {
    color: @text-color;
    .initial-info {
        padding: 0.24rem 0.24rem 0.2rem;
        font-size: @hm-font-size-sm;
        line-height: 0.23rem;
    }
    .input-wrapper {
        padding: 0 0.24rem;
        background-color: @content-bg-color;
        .input-padding {
            padding: 0.2rem 0;
        }
    }
    .tips {
        padding: 0.16rem 0.24rem;
        font-size: @hm-font-size-xs;
        text-align: right;
        .tel {
            padding-left: 0.08rem;
        }
        .time {
            padding-left: 0.08rem;
        }
    }
}
</style>
