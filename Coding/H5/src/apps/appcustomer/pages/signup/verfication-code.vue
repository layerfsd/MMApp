/* * 注册 verfication-code * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="verfication-code layout">
        <nav-header :title="title" :isKeepAlive="false"></nav-header>
        <div class="initial-info">
			<span class="text">{{$t('info_输入OTP')}}</span>
		</div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" @getChange="compare"></input-verfication>
        </div>
        <div class="tips">
			<span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">****0070</span><count-down></count-down>
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
        	title:this.$t('label_注册标题'),
            verificationCode: '',
            rightCode: ''
        }
    },
    created() {

    },
    computed: {
    },
    methods: {
    	compare(value) {
            // 验证码正确
            if(value === '111111'){
        		this.showIndicator();
        		this.serverApi.checkVerificationCode({
        			phone: this.$store.state.signUp.user.phone,
        			verificationCodeType: 1,
        			verificationCode: value
        		}, null, (error, data) => {
        			this.hideIndicator();
    				this.$router.push('/signUp/setPassword');
        		})
            }else {
                // 验证码错误
                this.showToast('验证码错误');
            }
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
