/**
 * AA付款-我的付款码页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
<div class="my-qr-code2">
	<div class="qr-code-wrapper2">
 		<nav-header title="QR Code Pay" :showLeft="false" :showRight="false" :customClass="`customNavHeader`">
	    	<div slot="left">
	            <img src="~assets/images/common/nav_left_h_2x.png" alt='' /> 
	        </div>
    	</nav-header>	
	
		<div class="content">
			<p class="bar-code-no">Scan and pay to me</p>
			<p class="bar-code-tip1">3 people,€30.00 in total</p>
			<p class="bar-code-tip2">Each one should pay <span>€10.00</span></p>
			<img class="qr-code" />
			
		</div>


		</div>
 </div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		naem:'my-qr-code2',
		components:{
			NavHeader
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'my-qr-code2');
    	},
		
		
		
		
		
		
	}
	
	
	
	
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.my-qr-code2{
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		/*background-image: url(../../assets/images/home/QR_pay/QR-code_bg_3x.png);*/
		background: linear-gradient(to bottom, #D90647 0%,#EB402C 100%);
		background-size: cover;
		.qr-code-wrapper2{
			overflow: auto;
		}
		
		.header{
			font-size: @hm-font-size-base;
			height: 45px;
			color: #FFF;
			font-weight: 700;
			background: transparent !important;
		}
		.customNavHeader {
			background-color: transparent !important; 
	        color: #ffffff !important;

    	}
		/*.nav-left{
		    height: .35rem;
	    	width: .19rem;
		}
		.mint-header-title{
			overflow: visible;
		}
		.return-home{
			font-size: .3rem;
		}
		.return-home i{
		    color: #FFF;
		}*/
		.content{
		    width: 6.3rem;
		    height: 400px;
		    background: #FFFFFF;
		    margin: 40px auto;
		    border-radius: 3px;
		    text-align: center;
		}
		.bar-code{
			/*width: 4.64rem;
			height: 45px;
			background: #ccc;
			margin:.4rem .84rem;*/
		}
		.bar-code-no{
			color:@text-color;
			font-size: @hm-font-size-lg;
			padding-top: 40px;
		}
		.qr-code{
			height: 180px;
		    width: 180px;
		    background: #ccc;
		    margin: 40px auto;
		}
		.bar-code-tip1{
			color:@text-color;
			font-size: @hm-font-size-sm;
			margin-top: 25px;
		}
		.bar-code-tip2{
			color:@text-color;
			font-size: @hm-font-size-sm;
			margin-top: 5px;
			span{
				color: #20A859;
			}
		}
		
		}
</style>




