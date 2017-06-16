/* * 登录 change-initial-pin * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="change-initial-pin layout">
        <nav-header title="Verification" :isKeepAlive="false" :leftFunc="leftFunc"></nav-header>
        <div class="initial-info">
            <span class="text">Enter Initial PIN</span>
        </div>
        <div class="input-wrapper">
            <input-control class="input-padding" name="changeInitialPIN" @getChange.once="compare"></input-control>
        </div>
        <div class="tips">
            <span class="tip">Verfication Code has been send to</span><span class="tel">****0070</span>
            <count-down></count-down>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import inputControl from '../../components/input/input-control';
import countDown from '../../components/count-down/count-down'
export default {
    methods: {
        leftFunc() {
            //清除缓存
            this.$store.dispatch('popKeepAlive');
            this.$router.replace('/login');
        },
        compare(value) {
            const SUCCESS = '1'; //验证通过
            this.showIndicator();
            this.serverApi.checkVerificationCode({
                phone: this.$store.state.signUp.user.phone,
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
