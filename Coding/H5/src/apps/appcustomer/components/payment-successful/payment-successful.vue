<template>
	<div class="details-content">
			<img src="~assets/images/common/Payment-successful_2x.png" />
			<p class="details-content-label1">{{message}}</p>
			<p class="details-content-transfer" v-if="showTransfer">{{transfer}}</p>
			<p class="details-content-label2">-€{{amount}}</p>
		</div>
</template>
<script>
	export default {
		data(){
			return {
			}
		},
		props: {
			message: {
				type: String,
				default:"Payment successful"
			},
			amount: {
				type: String,
				default: ''
			},
			transfer:{
				type: String,
				default: 'MIke(134****3470)has received your transfer'
			},
			showTransfer:{
				type: Boolean,
				default:false
			}
		}
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.details-content{
		background-color: #FFFFFF;
		margin-top: .18rem;
		text-align: center;
		padding-bottom: .3rem; 
	}
	.details-content img{
		height: 1.32rem;
		width: 1.32rem;
		margin-top:.43rem;
		margin-bottom: .25rem;
	}
	.details-content-label1{
		font-size:.3rem ;
		color: #20A859;
	}
	.details-content-label2{
		font-size:.6rem ;
		color: #333333;
		margin-top: .28rem;
	    margin-bottom: .3rem;
	}
	.details-content-transfer{
		font-size:.24rem ;
		color: #999;
		margin-top: .16rem;
	}
</style>