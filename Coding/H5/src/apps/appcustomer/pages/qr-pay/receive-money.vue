/**
 * 扫码支付-收款页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="receive-money">
		<div class="qr-code-wrapper">
			<div>
				<nav-header title="Receive money" :showLeft="false" :showRight="false" :leftFunc="goBack" :customClass="`customNavHeader`">
					<div slot="left">
						<img src="~assets/images/common/nav_left_h_2x.png" alt='' />
					</div>
				</nav-header>
			</div>
			
	  <div class="receive-scroll">
				
      <div class="receive-content">
			<div class="receive-qr-code-receive-tx"><img src="~assets/images/common/tx_2x.png" /></div>
			<p class="receive-qr-code-tip1">Scan to pay me</p>
			<p class="receive-qr-code-money" v-if="jineShow">€{{jine}}</p>
			<div style="text-align: center;">
				<img class="receive-qr-code" />
			</div>
			<div style="display: flex;">
				<p class="clear-amount" style="padding-left: 1.3rem;" @click="setAmount">{{set}} Amount</p>
				<p class="clear-amount" style="padding-left: .7rem;" @click="save">Save image</p>
			</div>
			
			<div class="scanned">
				<mt-cell class="payer" title="Blank" v-for="todo in todos" :key="todo.id">
					<span><label class="pay-state">Unable to pay{{todo.text}}</label></span>
					<img class="payer-tx" slot="icon" src="~assets/images/common/tx2_2x.png">
				</mt-cell>
			</div>
		</div>
		
		
		</div>
		</div>
			
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
	export default {
		name: 'receive-money',
		data() {
			return {
				todos: [
					{text: '111'}, 
					{text: '222'},
					{text: '222'},
					{text: '222'},
					{text: '222'},
					{text: '222'}
				],
				jine:'',
				set:'Set',
				jineShow:false
			}
		},
		components: {
	        NavHeader
	    },
	    //创建之前
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'receive-money');
	    },
	    methods: {
	    	//保存图片方法
	    	save(){
	    		this.showToast("Save successful","bottom");
	    	},
	    	goBack(){
				
			    if(this.isKeepAlive){
                    this.$store.dispatch('popKeepAlive');
                }

                this.$store.dispatch('setPageAnimationBack', true);
                this.$router.push({path:'/my-qr-code'});
			},
	    	setAmount(){
	    		if(this.set=='Set'){
	    			this.$router.push({path:'/set-amount'});
	    		}else{
	    			this.jineShow=false;
	    			this.set='Set';
	    		}
	    	}
        },
        activated:function(){
        	if(this.jineShow)
        		this.set='Set';
        	if(''!=this.$route.query.amount&&undefined!=this.$route.query.amount){
        		this.jine=this.$route.query.amount;
        		this.set='Clear';
				this.jineShow=true;
        	}else{
        		this.jineShow=false;
        	}
        	
        }
	};
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.customNavHeader {
		background-color: transparent !important; 
        color: @content-bg-color !important;

    }
	
	.receive-scroll{
		/*border: 1px solid;*/
		overflow: scroll;
		-webkit-overflow-scrolling: touch;
	    height: 541px;
		/*适配iPhone4*/
		@media only screen and (max-device-width : 320px) and (min-device-height: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait) {
			height: 390px;
		}
		/*适配iPhone5*/
		@media only screen and (max-device-width : 320px) and (min-device-height : 568px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait){
			height: 450px;
		}
	}
	.receive-money {
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		font-family: Arial;
		/*background-image: url(../../assets/images/home/QR_pay/QR-code_blue_bg_2x.png);*/
		background-color: #1B82D1 ;
		.qr-code-wrapper{
			overflow: auto;
			position: relative;
			-webkit-overflow-scrolling: touch;
		}
		.header {
			font-size: @hm-font-size-lg;
			height: 45px;
			color: @content-bg-color;
			font-weight: 700;
			background-color: transparent !important;
		}
		.receive-content {
			width: 6.3rem;
			background: @content-bg-color;
			margin: 60px auto 0;
			border-radius: 3px;
			/*适配iPhone4*/
			@media only screen and (max-device-width : 320px) and (min-device-height: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait) {
				margin: 35px auto 0;
			}
			/*适配iPhone5*/
			@media only screen and (max-device-width : 320px) and (min-device-height : 568px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait){
				margin: 45px auto 0;
			}
		}
		
		.receive-qr-code {
			height: 170px;
			width: 170px;
			background: #ccc;
			margin: 20px 0;
		}
		
		.payment-code {
			width: 50%;
			float: left;
			text-align: center;
		}
		
		.receive-qr-code-receive-tx{
			text-align: center;
		 	img {
				width: 65px;
				height: 66px;
				/*position: absolute;
				margin: -.7rem 2.5rem;*/
			    margin-top: -35px;
			}
		}
		
		.receive-qr-code-tip1 {
			font-size: @hm-font-size-sm;
			color: @text-color;
			text-align: center;
			line-height: 25px;
			padding-top: 30px;
			/*适配iPhone4*/
			@media only screen and (max-device-width : 320px) and (min-device-height: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait) {
				padding-top: 0px;
			}
			/*适配iPhone5*/
			@media only screen and (max-device-width : 320px) and (min-device-height : 568px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait){
				padding-top: 10px;
			}
		}
		
		.receive-qr-code-money {
			font-size: @hm-font-size-xxl;
			color: @text-color;
			text-align: center;
		}
		
		.clear-amount {
			/*width: 3.15rem;*/
			font-size: @hm-font-size-xs;
			color: #6889A3;
			/*display: table-cell;*/
			padding-bottom: 25px;
			/*适配iPhone4*/
			@media only screen and (max-device-width : 320px) and (min-device-height: 480px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait) {
				padding-bottom: 10px;
			}
			/*适配iPhone5*/
			@media only screen and (max-device-width : 320px) and (min-device-height : 568px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait){
				padding-bottom: 15px;
			}
		}
		
		.payer {
			font-size: @hm-font-size-sm;
			color: @text-color;
		}
		
		.payer-tx {
			width: 35px;
			height: 35px;
			margin-right: .3rem;
		}
		
		.pay-state {
			font-size: @hm-font-size-xs;
			color: #DB1B43;
		}
	}
</style>