/**
 * 扫码支付-支付完成页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="transfer-success-contailer">
		
		<nav-header title="Details" :showLeft="false" :showRight="true" >
        	<div slot="right">
	            <!--<img src="~assets/images/nav_left_h_2x.png" alt='' />--> 
	            <lable class="nav-right" @click="done">Done</lable>
            </div>
        </nav-header>
		<details-content :showTransfer="showTransfer" :message="message" :amount="amount"></details-content>
		
		
	</div>
</template>
<script>
	import detailsContent from '../../components/payment-successful/payment-successful';
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'transfer-success',
		components: {
			detailsContent,
			NavHeader
		},
		data() {
			return {
				message:'Payment successful',
				amount:'202.2',
				showTransfer:true
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'transfer-success');
    	},
		methods:{
			successDone(){
				this.$router.push({
					path: '/transfer/transfer'
				});
			},
			done(){
				this.$router.push({
					path: '/Home'
				});
			}
		}
		
	}
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.transfer-success-contailer{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #F8F8F8;
		.nav-right{
			font-size:.3rem;
			color:#1352E2;
		}
		
	}
</style>




