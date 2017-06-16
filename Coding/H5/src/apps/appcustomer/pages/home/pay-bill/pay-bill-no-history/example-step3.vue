<template>
	<div class="stepWrapper">
		<div class="paybill-example3-title">
        	<nav-header title="Pay Bill"  :showRight="true" :rightFunc="toAddOne" :showLeft="false">
        		<div class="step3-right-btn" slot="right">
        			Done
           	 	</div>
        	</nav-header>
		</div>
		<paymentsuccessful :amount="amount"></paymentsuccessful>
		<div class="paybill-example3-content">
			<ul>
				<li>
					<span>Utility Unit</span>
					<span>Romania electric power company</span>
				</li>
				<li>
					<span>Bill reference number</span>
					<span>634 526 118</span>
				</li>
				<li>
					<span>Electricity address</span>
					<span>str.*** NICOLE 32 loc.***</span>
				</li>
			</ul>
		</div>
	</div>
</template>
<style lang="less">
	@import url('../../../../assets/css/mixin.less');
	@import url('../../../../assets/css/base.less');
	.stepWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
	}
	.paybill-example3-title .step3-right-btn{
		color: #1450e2;
		font-size: .26rem;
	}
	.paybill-example3-content{
		background: @link-color-white;
	}
	.paybill-example3-content li{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		border-top: 1px solid lightgrey;
	}
	.paybill-example3-content li span{
		display: block;
		/*height: 1rem;*/
		height: 50px;
	}
	.paybill-example3-content li span:nth-child(1){
		text-align: center;
		color: #b8b8b8;
		margin-left: .24rem;
		/*font-size: .3rem;*/
		font-size: @hm-font-size-sm;
		float: left;
	}
	.paybill-example3-content li span:nth-child(2){
		/*font-size: .3rem;*/
		font-size: @hm-font-size-sm;
		color: @link-color-black;
		float: right;
		margin-right: .25rem;
	}
</style>
<script>
import NavHeader from '../../../../../../components/header/nav-header';
import paymentsuccessful from '../../../../components/payment-successful/payment-successful';
	export default{
	components: {
   		NavHeader,
   		paymentsuccessful
   	},
	methods: {
	toAddOne () {
		this.$router.replace('/pay-bill-no-history');
   		}
   	},
    props:{     

       },
       data(){
       	return {
       		amount:'22'
       	}
       }
		
	}
</script>