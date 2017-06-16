/**
 * 扫码支付-我的付款码页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
<div class="my-qr-code">
 <div class="qr-code-wrapper">
 	<div>
	 	<nav-header title="QR Code Pay" :showLeft="false" :showRight="false"  :leftFunc="goBack" :customClass="`customNavHeader`">
	    	<div slot="left">
	            <img src="~assets/images/common/nav_left_h_2x.png" alt='' /> 
	            <label style="vertical-align: middle;">Home</label>
	        </div>
	        <div slot="right">
	            <img @click="scan" src="~assets/images/common/nav_scan_b_3x.png" alt='' /> 
	        </div>
	    </nav-header>		
	</div>
		<div class="content">
			<img class="bar-code" />
			<p class="bar-code-no">1234 1234 1234</p>
			<div style="text-align: center;">
				<img class="qr-code" />
			</div>
			<div style="text-align: center;">
				<img class="wellet" src="~assets/images/common/wallet_3x.png" />
				<label class="wellet-text">From Cash Wallet</label>
			</div>
			<div style="text-align: center;padding-top: 8px;">
				<img class="auto-update" src="~assets/images/common/refresh_n_3x.png" />
				<label class="auto-update-text">Auto-update per min for facetoface transaction</label>
			</div>
			<mt-cell class="money-text" title="Receive money" to="/receive-money">
				<span><img class="card-right" src="~assets/images/common/card_right_3x.png" /></span>
			  <img class="money" slot="icon" src="~assets/images/common/money_3x.png">
			</mt-cell>	
		</div>
		
 </div>
		


	</div>
	
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';

export default {
    name: 'my-qr-code',
 //    data() {
 //        return {
 //            supportTranslucentStatus: true
 //        }
	// },        
	components: {
        NavHeader
    },
    //创建之前
    beforeCreate(){
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'my-qr-code');

    },
    beforeMount: function () {
        console.log("my-qr-code, beforeMount");
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleLight();
        }
    },
    activated: function () {
        console.log("my-qr-code, activated");
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleLight();
        }
    },
    deactivated: function () {
        console.log("my-qr-code, deactivated");
    },
    beforeUpdate: function () {
        console.log("my-qr-code, beforeUpdate");
    },
	methods:{
		scan(){
			this.$router.push("/qr-pay/enter-password");
		},
		//回退到首页
		goBack(){
            this.$store.dispatch('setPageAnimationBack', true);
			this.$router.push({path:'/Home'});
			}
		
	}
};
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.header{
		font-size: @hm-font-size-lg;
		height: 45px;
		color: @content-bg-color;
		font-weight: 700;
		background: transparent;
	}

	.customNavHeader {
		background-color: transparent !important; 
        color: @content-bg-color !important;

    }
	.my-qr-code{
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		/*background-image: url(../../assets/images/home/QR_pay/QR-code_bg_3x.png);*/
		background: linear-gradient(to bottom, #D90647 0%,#EB402C 100%);
		background-size: cover;
		.is-center{
			flex:6 !important;
		}
		.qr-code-wrapper{
			overflow: auto;
		}
		.header{
			font-size: .36rem;
			height: .9rem;
			color: #FFF;
			font-weight: 700;
			background: transparent !important;
		}
		.content{
			width: 6.3rem;
			background: @content-bg-color;
			margin:20px auto;
			border-radius: 3px;
			@media only screen and (max-device-height: 480px)and (-webkit-min-device-pixel-ratio: 2) {
				margin:0 auto;
			}
		}
		.bar-code{
			width: 4.64rem;
			height: 45px;
			/*背景色暂替代2维码*/
			background: #ccc;
			margin:20px .84rem;
			@media only screen and (max-device-height: 480px)and (-webkit-min-device-pixel-ratio: 2) {
				margin:10px .84rem;
			}
		}
		.bar-code-no{
			color:@text-color;
			font-size: @hm-font-size-lg;
			text-align: center;
		}
		.qr-code{
			height: 170px;
			width: 170px;
			/*背景色暂替代2维码*/
			background: #ccc;
			margin:25px 0;
			@media only screen and (max-device-height: 480px)and (-webkit-min-device-pixel-ratio: 2) {
				margin:15px .84rem;
			}
		}
		.wellet{
			height: 16px;
			width: 17px;
		}
		.wellet-text{
			font-size: @hm-font-size-xs;
			line-height: 20px;
			color: @text-color;
		}
		.auto-update{
			height: 17px;
			width: 18px;
			vertical-align: middle;
			margin-right: .3rem;
		}
		.auto-update-text{
			font-size: @hm-font-size-xxs;
			color: @text-color;
			vertical-align: middle;
		}
		.money{
			width: 16px;
			height: 17px;
			vertical-align: middle;
		}
		.money-text{
			font-size: @hm-font-size-base;
			color: @link-color;
			vertical-align: middle;
			margin-top: 18px;
			@media only screen and (max-device-height: 480px)and (-webkit-min-device-pixel-ratio: 2) {
				margin-top: 10px;
			}
			
		}
		.card-right{
			width: .2rem;
			height: 18px;
		}
		.mint-cell:last-child {
			background-position: inherit;
		}
		.mint-cell-text {
	    	margin-left: .4rem;
		}
		.mint-cell img {
	    	margin-left: .32rem;
		}
	}
</style>




