/* * 注册 verfication-code * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="verfication-code layout">
        <nav-header title="Forgot Password" :isKeepAlive="false"></nav-header>
        <div class="initial-info">
			<span class="text">Enter OTP</span>
		</div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" :text="verificationCode" @getChange.once="compare"></input-verfication>
        </div>
        <div class="tips">
			<span class="tip">Verfication Code has been send to</span><span class="tel">****0070</span><count-down></count-down>
		</div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import inputVerfication from '../../components/input/input-verfication';
import CountDown from '../../components/count-down/count-down';
export default {
	name: 'verificationCode',
    data() {
        return {
            verificationCode: '',
            rightCode: ''
        }
    },
    beforeCreate() {
    	this.$store.dispatch('pushKeepAlive');
    },
    created() {

    },
    computed: {
    },
    methods: {
    	compare(value) {
    		const SUCCESS = '1';//验证通过
    		this.showIndicator();
    		this.serverApi.checkVerificationCode({
    			phone: 123,
    			verificationCodeType: 1,
    			verificationCode: value
    		}, (error, data) => {
    			this.hideIndicator();
				this.$router.push('/forgotPassword/security');
    		})
    	}
    },
    components: {
        NavHeader,
        inputVerfication,
        CountDown
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.verfication-code{
		color: @text-color;
		.initial-info{
			padding: 0.24rem 0.24rem 0.2rem;
			font-size: @font-15px;
			line-height: 0.23rem;
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
