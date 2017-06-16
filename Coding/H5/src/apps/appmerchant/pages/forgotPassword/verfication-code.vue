/* * 注册 verfication-code * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="verfication-code layout">
        <nav-header :title="title"></nav-header>
        <div class="initial-info">
			<span class="text">{{$t('info_输入OTP')}}</span>
		</div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" :text="verificationCode" @getChange="compare" ref="inputVerification"></input-verfication>
        </div>
        <div class="tips">
			<span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">{{phone | filterPhone}}</span><count-down></count-down>
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
            verificationCode: '',
            rightCode: '',
            phone:this.$route.query.phone,//获取手机号码
            title: this.$t('label_忘记密码标题'), //导航栏标题
        }
    },
    beforeCreate() {
		//添加到缓冲机制中
    	this.$store.dispatch('pushKeepAlive', 'verificationCode');
	},
    activated() {
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
    created: function () {
    },
    filters: {
        filterPhone(value) {
            let markedPhone = '' + value;
            console.log("markedPhone="+markedPhone);
            markedPhone = '****' + markedPhone.slice(-4);
            return markedPhone;
        }
    },
    methods: {
    	backToAcc() {
//			this.$router.push("/forgotPassword");
		},
    	compare(value) {
    		let forgotCode = 2;////验证类型： 1：注册  2：登录
    		this.showIndicator();
    		this.serverApi.checkVerificationCode({
    			phone: this.$route.query.phone,//电话号码
    			verificationCodeType: forgotCode,
    			verificationCode: value
    		}, null, (error, data) => {
    			this.hideIndicator();
    			if(error){
                    this.showToast(error.message);
                    this.$refs.inputVerification.text = '';
                    return;
                }
				this.$router.replace({
					path:'/forgotPassword/security',
					query: {phone:this.phone}
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
			padding: 12px 0.24rem 10px;
			font-size: @font-15px;
			line-height:12px;
		}
		.input-wrapper{
			padding: 0 0.24rem;
			background-color: @content-bg-color;
			.input-padding{
				padding: 10px 0;
			}
		}
		.tips{
			padding: 8px 0.24rem;
			font-size: @font-12px;
			text-align: right;

			.tel{
				padding-left: 0.08rem;
			}
			.time{
				padding-left: 0.08rem;
				color: #e04c64;
			}
		}
	}
</style>
