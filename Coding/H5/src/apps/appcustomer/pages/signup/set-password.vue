/* * 注册 set-password
 * @Date : 2017-03-15
 * @Author : wangliang
 * @Version : V1.0
 *
 */
<template>
    <div class="set-password layout">
        <nav-header :title="title" :leftFunc="linkPath" :isKeepAlive="false"></nav-header>
        <input-text @input-completed="getChecked" :text1="text1" :text2="text2"></input-text>
        <mt-button type="default" :class="{'active':checked}" class="btn" :disabled="false" @click="submit">{{$t('action_提交')}} </mt-button>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import inputText from '../../components/input/input-text';
const ATTESTATION = '0'; //待认征
const ACTIVATION = '0'; //待激活
export default {
    name: 'setPassword',
    data() {
        return {
        	text1:this.$t('label_登录_密码'),
        	text2:this.$t('label_确认_密码'),
        	title:this.$t('label_注册标题'),
            checked: false,
            password: ''
        }
    },
    // beforeCreate() {
    //     this.$store.dispatch('pushKeepAlive');
    // },
    methods: {
        linkPath() {
            this.$router.replace('/signUp');
        },
        getChecked(msg) {
            this.checked = msg.checked;
            this.password = msg.password;
        },
        submit() {
            this.$router.replace('/signUp/setSecurity');
            // this.showIndicator();
            // this.serverApi.register({
            //     phone: this.$store.state.signUp.user.phone,
            //     password: this.password,
            //     imei: this.$store.state.signUp.user.imei,
            //     phoneModel: this.$store.state.signUp.user.phoneModel,
            //     phoneSystem: this.$store.state.signUp.user.phoneSystem,
            //     pushToken: this.$store.state.signUp.user.pushToken
            // },(error, data) => {
            //     this.hideIndicator();
            //     if(data.customerType === ATTESTATION && data.customerStatus === ACTIVATION){
            //         //待认征，待激活
            //         this.$router.push({
            //              path: '/signUp/personalInformation'
            //         });
            //     }else if(data.customerType !== ATTESTATION && data.customerStatus === ACTIVATION){
            //         //已认证，待激活
            //          this.$router.push({
            //              path: '/signUp/changeInitialPIN'
            //         });
            //     }else if(data.customerType !== ATTESTATION && data.customerStatus !== ACTIVATION){
            //         //已认征激活
            //         this.$router.replace('/home');
            //     }else {
            //         //异常情况
            //         this.showToast('Network Abnormal');
            //     }
            // })
        }
    },
    components: {
        NavHeader,
        inputText
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.set-password {
    .btn {
        width: 90%;
        height: 1rem;
        line-height: 1rem;
        background-color: @default-bg-btn-color;
        color: @default-font-btn-color;
        margin: 0.86rem 5% 0 5%;
        &.active {
            background-color: @active-bg-btn-color;
        }
    }
}
</style>
