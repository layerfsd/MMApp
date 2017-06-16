<template>
	<div class="socialFeeWrapper">
		<div class="socialFeeHead">
			<nav-header :title="title" :leftFunc='toEnterAccount'></nav-header>
		</div>
		<div class="socialFeeMiddle">
			<img class="socialFeeLogo" src="~assets/images/common/social_security_card_1_2x.png"/>
			<div class="socialFeeDetail">
				<ul>
					<li>{{cardOwner}}</li>
					<li>Tail number ({{tailNumber}})</li>
					<li><b>Balance</b><b>€{{balance}}</b></li>
				</ul>
			</div>
			<div class="set-amount-input">
				<p>{{$t('label_总数')}}</p>
				<span>€</span>
				<input type="text" placeholder="0.00" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" />
			</div>
			<div class="socialFeeBlank"></div>
		</div>
		<div class="set-amount-btn">
			<button type="button" class="btn" :class="{'active': !isEmpty}" :disabled="this.isEmpty" @click="submit">{{$t('action_下一步')}}</button>
		</div>
	</div>
	
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	
	export default{
		name:'chargeSocialFee',
		data(){
			return{
				title:this.$t('label_社保卡'),
				cardOwner:'William',
				tailNumber:'0625',
				balance:'26.25',
				amount:'',
				isEmpty: true,
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'chargeSocialFee');
    	},
    	beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
	    activated() {
	    	this.amount='';
        	this.isEmpty=true;
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
		methods:{
			toEnterAccount(){
				//返回时删除缓存
                 this.$store.dispatch('popKeepAlive');
                //设置返回标志，在动画里面处理
                this.$store.dispatch('setPageAnimationBack', true);
                this.$router.replace('/scanCard');
			},
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			submit(){
				this.$router.push('/socialCardEnterPin');
			}
		},
		components:{
			navHeader,
		}
	}
	
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.socialFeeWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
	}
	.socialFeeMiddle{
		background: #FFFFFF;
		margin-top: 50px;
		/*height: 135px;*/
	}
	.socialFeeLogo{
		position: absolute;
		top: 80px;
		left: 50%;
		margin-left: -32.5px;
		z-index: 99;
		width: 65px;
		height: 65px;
	}
	.socialFeeDetail{
		margin-top: 40px;
		text-align: center;
		height: 105px;
	}
	.socialFeeDetail ul li:nth-child(1){
		font-size: @hm-font-size-base;
		color: @text-color;
	}
	.socialFeeDetail ul li:nth-child(2){
		font-size: @hm-font-size-xs;
		color: #A3A3A3;
		margin-top: 22px;
	}
	.socialFeeDetail ul li:nth-child(3){
		font-size: @hm-font-size-base;
		margin-top: 8px;
	}
	.socialFeeDetail ul li:nth-child(3) b:nth-child(1){
		color: @text-color;
	}
	.socialFeeDetail ul li:nth-child(3) b:nth-child(2){
		color: #1B82D1;
		margin-left: 5px;
	}
	.socialFeeBlank{
		height: 15px;
	}
	.set-amount-input{
		height: 90px;
		background-color: #f9f9f9;
	}
	.set-amount-input p{
		font-size: @hm-font-size-sm;
		color: @text-color;	
		padding-top: 15px;
		margin-left: .3rem;
	}
	.set-amount-input span{
		font-size: @hm-font-size-xxl;
		color: @text-color;	
		padding-top: 10px;
		margin-left: .3rem;
	}
	.set-amount-input input{ 
		font-size: @hm-font-size-xxl;
		color: @text-color;	
		padding-top: 10px;
	    max-width: 85%;
		background-color: #F9F9F9;
	}
	.set-amount-btn{
		text-align: center;
		margin-top: 35px;
	}
</style>