/*
* 注册 change-initial-pin
* @Date : 2017-03-15
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
    <div class="change-initial-pin layout">
        <div class="initial-pin-header">
            <nav-header :title="title"></nav-header>
        </div>
        <div class="initial-info">
            <span class="text">{{$t('info_输入初始PIN')}}</span>
        </div>
        <div class="input-wrapper">
            <password-control class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
        </div>
        <div class="tips">
            <span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">{{phone|filterPhone}}</span>
            <count-down></count-down>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import passwordControl from '../../../../components/input/password-control';
import countDown from '../../components/count-down/count-down'
export default {
    name: 'changeInitialPin',
	data(){
		return{
			title:this.$t('label_注册标题'),
            phone: this.$route.query.phone
		}
	},
    beforeCreate() {
        // 加入缓存
        this.$store.dispatch('pushKeepAlive', 'changeInitialPin');
    },
    created() {
        console.log('phone: ' + this.$route.query.phone);
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
                    this.$refs.passwordControl.text = '';
                    return;
                }
                this.$router.push({
                    path: '/signUp/setNewPIN',
                    query: {
                        initialPIN: value
                    }
                });
            })
    	}
    },
    components: {
        NavHeader,
        passwordControl,
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
