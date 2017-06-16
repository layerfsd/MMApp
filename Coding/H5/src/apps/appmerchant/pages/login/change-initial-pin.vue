/* * 登录 change-initial-pin 
 * @Date : 2017-03-15 
 * @Author : wangliang  沈飞
 * @Version : V1.0 
 * 
 */
<template>
    <div class="change-initial-pin layout">
        <nav-header :title="title"></nav-header>
        <div class="initial-info">
            <span class="text">{{$t('info_输入初始PIN')}}</span>
        </div>
        <div class="input-wrapper">
            <password-control class="input-padding" name="changeInitialPIN" @getChange="compare"></password-control>
        </div>
        <div class="tips">
            <span class="tip">{{$t('info_验证码发送提示')}}</span><span class="tel">{{phone|filterPhone}}</span>
            <count-down></count-down>
        </div>
    </div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import passwordControl from '../../../../components/input/password-control';
import countDown from '../../components/count-down/count-down'
export default {
	name:'change-initial-pin',
	data(){
		return{
			title:this.$t('label_验证'),
			phone:this.$store.state.user.phone,
			verificationCodeType:'2',//暂无校验PIN接口，验证码接口替代
		}
	},
    methods: {
        compare(value) {
            this.showIndicator();
            this.serverApi.checkVerificationCode({
                phone: this.$store.state.user.phone,
                verificationCodeType: this.verificationCodeType,
                verificationCode: value
            },null, (error, data) => {
                this.hideIndicator();
                if(error){
                    this.showToast(error.message);
                    return;
                }
                this.$router.push('/signUp/setNewPIN');
            })
        }
    },
    filters: {
        filterPhone(value) {
            let markedPhone = '' + value;
            console.log("markedPhone="+markedPhone);
            markedPhone = '****' + markedPhone.slice(-4);
            return markedPhone;
        }
    },
    beforeCreate() {
		//添加到缓冲机制中
		this.$store.dispatch('pushKeepAlive', 'change-initial-pin');
	},
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
    components: {
        navHeader,
        passwordControl,
        countDown
    }
};
</script>
<style lang="less" scoped>
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
