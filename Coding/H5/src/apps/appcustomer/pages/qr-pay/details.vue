/**
 * 扫码支付-支付完成页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="qr-pay-contailer">
		
		<nav-header title="QR Code Pay" :showLeft="false" :showRight="true" >
        	<div slot="right">
	            <!--<img src="~assets/images/nav_left_h_2x.png" alt='' />--> 
	            <lable class="nav-right" @click="done">Done</lable>
            </div>
        </nav-header>
		
		<details-content :message="message" :amount="amount"></details-content>
		
		<div class="qr-pay-contailer-cell">
			<mt-cell title="Merchant" value="Victor Roads StarBucks"></mt-cell>
			<mt-cell title="Comments" class="cell-star"><star class="star"></star></mt-cell>
		</div>
		
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import detailsContent from '../../components/payment-successful/payment-successful';
	import star from '../../components/star/star';
	export default {
		name:'qr-pay-details',
		components: {
			star,
			detailsContent,
			NavHeader
		},
		data() {
			return {
				message:'x xx',
				amount:'202'
			}
		},
		methods:{
			done(){
				this.$router.push({
					path: '/Home'
				});
			}
		},
		//创建之前
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'qr-pay-details');
	
	    },
	    beforeMount: function () {
	        console.log("qr-pay-details, beforeMount");
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleLight();
	        }
	    },
	    activated: function () {
	        console.log("qr-pay-details, activated");
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleLight();
	        }
	    },
		
	}
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.qr-pay-contailer{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #F8F8F8;
		.nav-right{
			font-size:@hm-font-size-sm;
			color:@link-color;
		}
		
		.details-title{
			height: 45px;
		}
		.mint-cell{
			height: 25px;
		}
		.qr-pay-contailer-cell .mint-cell:last-child {
			background-position: inherit;
		}
		.qr-pay-contailer-cell .mint-cell-wrapper {
		    background-origin: inherit;
		}
		.qr-pay-contailer-cell .mint-cell-text {
		    font-size: @hm-font-size-xs;
		    color: @tips-color;
		}
		.qr-pay-contailer-cell .mint-cell-value {
		    font-size: @hm-font-size-xs;
		    color: @text-color;
		}
		.cell-star .mint-cell-value{
			margin-right: 1.8rem;
		    padding-top: 10px;
		}
		.qr-pay-contailer-cell .mint-cell-text{
			    margin-left: 0;
		}
		.star{
			display: -webkit-inline-box;
		}
	}
</style>




