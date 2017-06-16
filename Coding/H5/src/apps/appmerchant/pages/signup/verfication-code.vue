/**
* 注册 verfication-code
* @Date : 2017-03-15
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
    <div class="verfication-code layout">
        <nav-header :title="title"></nav-header>
        <div class="initial-info">
			<span class="text">{{$t('info_输入OTP')}}</span>
		</div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" @getChange="compare" ref="inputVerification"></input-verfication>
        </div>
        <div class="tips">
			<span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">{{phone | filterPhone}}</span>
            <count-down :startFrom="countDownStartFrom" :max="countDownMax"></count-down>
		</div>
    </div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import inputVerfication from '../../components/input/input-verfication';
import countDown from '../../components/count-down/count-down';
export default {
	name: 'verificationCode',
    data() {
        return {
        	title: this.$t('label_注册标题'),
            verificationCode: '',
            rightCode: '',
            phone: this.$route.query.phone,
            countDownStartFrom: 60,    //60秒倒计时
            countDownMax: 60           //倒计时最大值
        }
    },
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'verificationCode');
        console.log('beforeCreate phone: ' + this.phone);

    },
    created() {
        console.log('created: ' + this.phone);
    },
    beforeMount() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    activated() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    deactivated() {

        this.verificationCode = '';
        this.filterPhone = '';
    },
    filters: {
        filterPhone(value) {
            let markedPhone = '' + value;
            console.log("markedPhone="+markedPhone);
            markedPhone = '****' + markedPhone.slice(-4);
            return markedPhone;
        }
    },
    computed: {

    },
    methods: {
    	compare(value) {
            // 校验验证码
            let register = 1;//验证类型： 1：注册  2：登录
    		this.showIndicator();
    		this.serverApi.checkVerificationCode({
    			phone: this.$route.query.phone,
    			verificationCodeType: register,
    			verificationCode: value
    		}, null, (error, data) => {
                this.hideIndicator();
                if(error){
                    this.showToast(error.message);
                    this.$refs.inputVerification.text = '';
                    return;
                }
                this.$router.replace({
                    path: '/signUp/setPassword',
                    query: {
                        phone: this.phone
                    }
                });
    		})
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
.verfication-code{
		color: @text-color;
		.initial-info{
            padding: 0 0.24rem;
			height:35px;
			font-size: @hm-font-size-sm;
			line-height: 35px;
		}
		.input-wrapper{
			padding: 0 0.24rem;
			background-color: @content-bg-color;
			.input-padding{
				padding: 0.2rem 0;
			}
		}
		.tips{
			padding: 0.16rem 0.24rem;
			font-size: @hm-font-size-xs;
			text-align: right;

			.tel{
				padding-left: 0.08rem;
			}
			.time{
				padding-left: 0.08rem;
			}
		}
	}
</style>
