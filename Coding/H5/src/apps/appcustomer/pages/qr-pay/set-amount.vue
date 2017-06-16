/**
 * 扫码支付-收款-设置收款金额页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="set-amount">
		<div>
        	<nav-header title="Set Amount" :showRight="false"></nav-header>
        </div>
        
		<div class="set-amount-content">
			
			<div class="set-amount-tx"><img src="~assets/images/common/tx_2x.png" /></div>
			<p class="set-amount-name">KFC</p>
			<div class="set-amount-input">
				<p>Amount</p>
				<span>€</span>
				<input type="text" placeholder="0.00" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" />
			</div>
		</div>
		<div class="set-amount-btn">
			<mt-button type="danger" class="next-btn" :disabled="this.isEmpty" @click="setAmount">Next</mt-button>
		</div>
	</div>
	
	
	
</template>
<script>
import { Indicator } from 'mint-ui';
import { MessageBox } from 'mint-ui';
import NavHeader from '../../../../components/header/nav-header';
	export default {
		name:'set-amount',
		data() {
			return {
				isEmpty: true,
				amount:''
			}
		},
		components: {
			NavHeader
		},
		
		methods:{
			//返回动画问题
//			goBack(){
//				
//			//判断页面是否被缓存，有则清除
//			if(this.isKeepAlive){
//                  this.$store.dispatch('popKeepAlive');
//              }
//			//如果不知道回退多少级，就用这条语句
//			this.$router.replace({path:'/receive-money'});
//			//如果知道回退多少级，就用这条语句
//			//this.$router.go(-2);
//
//          //设置返回标志，在动画里面处理
//          this.$store.dispatch('setPageAnimationBack', true);
//				
//		       
//			},
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			setAmount(){
				this.$router.push({
					path: '/receive-money',
					query:{amount:this.amount}
				});
			},
			beforeCreate(){
		        //添加到缓冲机制中
		        this.$store.dispatch('pushKeepAlive', 'set-amount');
	    	},
			activated:function(){
//	        	this.amount='';
	        }
			
		}
		
	};
	
	
	
		
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');

	.set-amount{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #F3F3F3;
		.mint-header {
		    background-color: #fff;
		    color: @text-color;
		    font-size: @hm-font-size-base;
		    height: 45px;
		}
		.set-amount-content{
			height: 180px;
			background: @content-bg-color;
			margin:50px 0;
			border-radius: 3px;
		}
		.set-amount-tx{
			text-align: center;
			img{
			    width: 65px;
			    height: 65px;
			    /*position: absolute;
			    margin: -.7rem 3.1rem;*/
	        	margin-top: -35px;
        	}
		}
		.set-amount-name{
			font-size: @hm-font-size-base;
			color: @text-color;
			text-align: center;
			padding-top: 25px;
		}
		.set-amount-input{
			height: 80px;
			background-color: #f9f9f9;
			    margin-top: 20px;
		}
		.set-amount-input p{
			font-size: @hm-font-size-sm;
			color: @text-color;	
			padding-top: .3rem;
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
			width: 6rem;
			background-color: #F9F9F9;
		}
		
		.set-amount-btn{
		    text-align: center;
			.mint-button--danger{
			    width: 6.5rem;
			    height: 50px;
			    /*padding: .5rem 0;*/
		        border-radius: 6px;
	        }
		}
		.set-amount-btn .mint-button.is-disabled{
			background-color: #c6c6c6;
		}
		.mint-header-title{
			flex:inherit;
		}
	}
</style>

