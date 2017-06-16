<template>
    <span class="count-down">
        <span class="count" v-show="countDown>0">({{countDown}})</span>
        <span class="resend" v-show="countDown<=0" @click="resend">{{$t('action_重新发送验证码')}}</span>
    </span>
</template>
<script>
export default {
    data() {
            return {
                countDown: 60,
            }
        },
    mounted() {
		this.resend();
    },
    // activated() {
    //     this.resend();
    // },
    methods: {
        setTime() {
            this.countDown--;
            let timer = setTimeout(() => {
            	this.setTime();
            }, 1000);
        	if(this.countDown <=0){
        		clearTimeout(timer)
        	}
        },
        resend() {
            this.countDown = 60;
            this.setTime();
            this.serverApi.getVerificationCode({
                phone: this.$store.state.signUp.user.phone,
                verificationCodeType: 1
            }, null, (error, data) => {
                if(error){
                    this.showToast(error.message);
                    return;
                }else{
                    console.log('验证码已发出，请注意查收!')
                }
            })
        }
    }
};
</script>

<style lang="less">
@import url('../../assets/css/base.less');
	.count-down{
		padding-left: 0.04rem;
		font-size: 0.3rem;
		color: @theme-text-color;
	}
</style>
