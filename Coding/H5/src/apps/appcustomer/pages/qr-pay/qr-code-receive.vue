<!--/**
 * 扫码支付-我的收款码 页面
 * @author 沈飞(179920638@qq.com)
 * 
 *（暂未使用到此页面）
 */

<template>
	<div class="qr-code-receive">
		<mt-header title="QR Code Pay" class="header">
		  <router-link to="/" slot="left" class="return-home">
		  	<mt-button icon="back"></mt-button>
		  </router-link>
		</mt-header>
	
		<div class="content">
			<span class="qr-code-receive-tx"><img src="../../assets/images/home/QR_pay/tx_2x.png" /></span>
			<p class="qr-code-name">Lara Korvik</p>
			<p class="qr-code-tip1">Scan to pay me</p>
			<p class="qr-code-money">€22.00</p>
			
			<img class="qr-code" />
			<p class="clear-amount">Clear Amount</p>
		</div>
		<div class="payment-code">
			<img src="../../assets/images/home/QR_pay/Payment-code_blue_h_2x.png" />
			<p>Payment code</p>
		</div>
		<div class="payment-code">
			<img src="../../assets/images/home/QR_pay/Scan-code-to-pay_blue_n_2x.png" />
			<p>Scan code to pay</p>
		</div>

	</div>
	
</template>
<script>
	
	
	
	
	
	
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.qr-code-receive{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		font-family: Arial;
		background-image: url(../../assets/images/home/QR_pay/QR-code_blue_bg_2x.png);
		
		
		.mint-header-title{
			overflow: visible;
		}
		.return-home{
			font-size: 15px;
		}
		.return-home i{
		    color: #FFF;
		}
		.content{
			width: 6.3rem;
			height: 8rem;
			background: #FFFFFF;
			margin:1.2rem auto;
			border-radius: 3px;
		}
		.qr-code{
			height: 3.6rem;
			width: 3.6rem;
			background: #ccc;
			margin:.42rem 1.35rem;
		}
		.payment-code{
			width: 50%;
			float: left;
			    text-align: center;
		}
		.payment-code img{
			height:55px;
			width: 55px;
		}
		.payment-code p{
			margin-top: 10px;
			font-size: 12px;
			color: #FFFFFF;
		}
		.qr-code-receive-tx img{
		    width: 1.3rem;
		    height: 1.3rem;
		    position: absolute;
		    margin: -.7rem 2.5rem;
		}
		.qr-code-name{
			font-size: .3rem;
			color: #2D2D2D;
			text-align: center;
		    padding-top: 1rem;
		}
		.qr-code-tip1{
			font-size: .3rem;
			color: #999;
		    text-align: center;
	   		line-height: .5rem;
		}
		.qr-code-money{
			font-size: .6rem;
			color: #333;
		    text-align: center;
		    margin-top: .3rem;
		}
		.clear-amount{
			font-size: .32rem;
			color: #DB1B43;
			text-align: center;
		}
	}
</style>



-->
