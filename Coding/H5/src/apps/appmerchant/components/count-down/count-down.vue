<template>
    <span class="count-down">
        <span class="count" v-show="countDown>0">({{countDown}})</span>
        <span class="resend" v-show="countDown<=0" @click="resend">{{$t('action_重新发送验证码')}}</span>
    </span>
</template>
<script>
export default {
    props:{
        startFrom:{  //从什么值开始倒计时 
            type:Number,
            default:60,
        },
        max:{ //最大值，按了重新发送后，从这个值开始倒计时
            type:Number,
            default:60,
        },
    },
    data() {
        return {
            countDown: 0,
        }
    },
    created() {
        console.log("count-down created");
        this.countDown = this.startFrom;
        this.startCountDown();

    },
    mounted() {
        console.log("count-down mounted");
		
    },
    activated() {
        console.log("count-down activated");
    },
    deactivated() {
        // this.countDown = 0;
        // this.setTime();
    },
    destroyed() {
    },
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
        //开始倒计时，如果是刚开始计时，要调用接口获取验证码
        startCountDown() {
            if (this.countDown===this.max) {
                this.showIndicator();
                this.serverApi.getVerificationCode({
                    phone: this.$store.state.user.phone,
                    verificationCodeType: 1
                }, null, (error, data) => {
                    this.hideIndicator();
                    if(error){
                        this.countDown = -1; //目的是让“resend”生效
                        this.showToast(error.message);
                        return;
                    }else{
                        this.setTime();
                        console.log('验证码已发出，请注意查收!')
                    }
                })
            }
            else {
                this.setTime();
            }
        },
        resend() {
            this.countDown = this.max;
            this.startCountDown();
        }
    }
};
</script>

<style lang="less">
@import url('../../assets/css/base.less');
	.count-down{
		padding-left: 0.04rem;
		font-size: @hm-font-size-sm;
		color: @theme-text-color;
	}
</style>
