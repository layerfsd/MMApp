<template>
	<div class="socialCardEnterPinWrapper">
		<div class="cardEnterPinHead">
			<nav-header :title="title"></nav-header>
		</div>
		<div class="cardEnterPinMiddle">
			<div class="cardEnterPinTop">
				<ul>
					<li>
						<span>
							<img class="enter-account-pic" src="~assets/images/common/Social_security_card_2x.png"/>
						</span>
						<span>{{cardOwner}}</span>
					</li>
					<li>Tail number ({{tailNumber}})</li>
					<li><b>-</b><b>€{{balance}}</b></li>
				</ul>
			</div>
			<div class="enter-input">
				<p class="tip-enter">{{$t('label_输入PIN')}}</p>
        		<password-control :count="count" class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
			</div>
		</div>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import passwordControl from '../../../../components/input/password-control';
	
	export default{
		name:'socialCardEnterPin',
		data(){
			return{
				title:this.$t('label_社保卡'),
				cardOwner:'William',
				tailNumber:'0625',
				balance:'26.25',
				count:4,
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'socialCardEnterPin');
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
		methods:{
			//获取密码框值
			compare(value) {
				
				this.$router.push('/cardPayDetails');
//	            this.showIndicator();
//	            this.serverApi.checkVerificationCode({//无接口，暂用验证码接口替代
//	                phone: this.$store.state.user.phone,
//	                verificationCodeType: this.verificationCodeType,
//	                verificationCode: value
//	            },null, (error, data) => {
//	                this.hideIndicator();
//	                if(error){
//	                    this.showToast(error.message);
//	                    return;
//	                }
//	                this.$router.push('/signUp/setNewPIN');
//	            })
	        }
		},
		components:{
			navHeader,
			passwordControl
		}
	}
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.socialCardEnterPinWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
	}
	.cardEnterPinMiddle{
		margin: 10px;
		height: 270px;
		background: #FFFFFF;
	}
	.cardEnterPinTop li:nth-child(1){
		margin-top: 25px;
		height: 40px;
		line-height: 40px;
	}
	.cardEnterPinTop li:nth-child(2){
		margin-top: 15px;
		font-size: @hm-font-size-xs;
		color: #A3A3A3;
		text-align: center;
	}
	.cardEnterPinTop li:nth-child(3){
		font-size: @hm-font-size-xxl;
		color: @text-color;
		margin-top: 10px;
		text-align: center;
	}
	.cardEnterPinTop li:nth-child(1) span{
		display: block;
		float: left;
	}
	.cardEnterPinTop li:nth-child(1) span:nth-child(1){
		margin-left: 2.35rem;
	}
	.cardEnterPinTop li:nth-child(1) span:nth-child(1) img{
		width: 40px;
		height: 40px;
	}
	.cardEnterPinTop li:nth-child(1) span:nth-child(2){
		font-size: @hm-font-size-base;
		color:@text-color;
		margin-left: 0.35rem;
	}
	.enter-input{
		margin-top: 30px;
		padding: 0 .4rem;
	}
	.tip-enter{
		text-align: left;
		color:@text-color;
		font-size: @hm-font-size-lg;
		margin-top: 24px;
		margin-bottom: 13px;
	}
</style>