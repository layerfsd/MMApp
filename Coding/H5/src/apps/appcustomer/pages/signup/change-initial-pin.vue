/* * 注册 change-initial-pin * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="change-initial-pin layout">
        <nav-header :title="title" :isKeepAlive="false"></nav-header>
        <div class="initial-info">
            <span class="text">{{$t('info_输入初始PIN')}}</span>
        </div>
        <div class="input-wrapper">
            <input-control class="input-padding" name="changeInitialPIN" @getChange="compare"></input-control>
        </div>
        <div class="tips">
            <span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">****0070</span>
            <count-down></count-down>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import inputControl from '../../components/input/input-control';
import countDown from '../../components/count-down/count-down'
export default {
	data(){
		return{
			title:this.$t('label_注册标题')
		}
	},
    methods: {
    	compare(value) {
            const SUCCESS = '1'; //验证通过
            this.showIndicator();
            this.serverApi.checkVerificationCode({
                phone: 123,
                verificationCodeType: 2,
                verificationCode: value
            }, (error, data) => {
                this.hideIndicator();
                this.$router.push('/signUp/setNewPIN');
            })
    	}
    },
    components: {
        NavHeader,
        inputControl,
        countDown
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
.change-initial-pin {
    .initial-info {
        padding: 0.24rem 0.24rem 0.2rem;
        color: @text-color;
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
        padding: 0.16rem 0.24rem 0.2rem;
        text-align: right;
        color: @text-color;
        font-size: @hm-font-size-xs;
        line-height: 0.24rem;
        .tel {
            padding-left: 0.08rem;
        }
        .time {
            padding-left: 0.08rem;
        }
    }
}
</style>
