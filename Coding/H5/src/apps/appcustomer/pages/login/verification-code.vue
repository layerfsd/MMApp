/* * 登录 verfication-code * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */
<template>
    <div class="verfication-code layout" ref="verificationCode" v-if="show">
        <nav-header title="Login" :isKeepAlive="false" :leftFunc="leftFunc"></nav-header>
        <div class="initial-info">
            <span class="text">Enter OTP</span>
        </div>
        <div class="input-wrapper">
            <input-verfication class="input-padding" type="text" :text="verificationCode" @getChange.once="compare"></input-verfication>
        </div>
        <div class="tips">
            <span class="tip">Verfication Code has been send to</span><span class="tel">****0070</span>
            <count-down ref="count"></count-down>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import inputVerfication from '../../components/input/input-verfication';
import CountDown from '../../components/count-down/count-down';

const ATTESTATION = '0'; //待认征
const ACTIVATION = '0'; //待激活
export default {
    name: 'verificationCode',
    data() {
        return {
            verificationCode: '',
            rightCode: '',
            show: false
        }
    },
    // beforeCreate() {
    //     this.$store.dispatch('pushKeepAlive');
    // },
    mounted() {
        this.$nextTick(() => {
            console.log(this.show)
            this.show = true;
        });
    },
    // beforeDestory() {
    //     this.$store.dispatch('popKeepAlive');
    // },
    computed: {},
    methods: {
        leftFunc() {
            //删除缓存
            this.$store.dispatch('popKeepAlive');
            this.$router.replace('/login');
        },
        compare(value) {
            const SUCCESS = '1'; //验证通过
            this.showIndicator();
            console.log(this.$store.state.signUp.user.phone)
            this.serverApi.checkVerificationCode({
                phone: this.$store.state.signUp.user.phone,
                verificationCodeType: 2,
                verificationCode: value
            }, (error, data) => {
                //调用更换设备的接口
                this.hideIndicator();
                this.bindPhoneChange();
            })
        },
        bindPhoneChange() {
            this.showIndicator();
            this.serverApi.bindPhoneChange({
                phone: this.$store.state.signUp.user.phone,
                imei: 'abc124',
                phoneModel: 'iOS',
                phoneSystem: '10.2',
                pushToken: '123'
            }, (error, data) => {
                this.hideIndicator();
                if (error) {
                    this.showToast(error.message);
                    return;
                }
                console.log(data);
                if (data.unVerified && data.unActivated) {
                    //待认证，待激活
                    this.$router.push({
                        path: '/signUp/personalInformation'
                    });
                } else if (!data.unVerified && data.unActivated) {
                    //已认证，待激活
                    this.$router.push({
                        path: '/login/changeInitialPIN'
                    });
                } else if (!data.unVerified && !data.unActivated) {
                    //已认证，已激活
                    this.$store.dispatch('newSession', {
                        token: data.sessionToken
                    });
                    this.$router.replace({
                        path: this.$route.query.toPage ? this.$route.query.toPage : '/home'
                    });
                }
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
