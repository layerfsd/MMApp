<template>
	<div class="detailsWrapper">
		<div class="details-top">
        	<nav-header title="Details" :showLeft="true" :showRight="false">
        	</nav-header>
		</div>
		<div class="details-content">
			<img src="~assets/images/common/Electric_3x.png" />
			<p class="details-content-label1">{{message}}</p>
			<p class="details-content-label2">- €{{amount}}</p>
			<p class="details-content-label3">success</p>
		</div>
		<div class="details-content-bottom">
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
<script>
import NavHeader from '../../../../../../components/header/nav-header';
	export default {
		components: {
   			NavHeader
   		},
		props: {
			message: {
				type: String,
				default:"Romania electric power company"
			},
			amount: {
				type: String,
				default: '21.2'
			}
		}
	}
</script>
<style lang="less">
	@import url('../../../../assets/css/base.less');
	@import url('../../../../assets/css/mixin.less');
	.detailsWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
	}
	.details-top{
		position: fixed;
		width: 100%;
	}
	.details-content{
		background-color: #FFFFFF;
		/*margin-top: 1.5rem;*/
		margin-top: 75px;
		text-align: center;
		/*padding-bottom: .3rem;*/ 
	}
	.details-content img{
		height: 1.35rem;
		width: 1.35rem;
		margin-top:.45rem;
		margin-bottom: .4rem;
	}
	.details-content .details-content-label1{
		font-size:@hm-font-size-sm;
		color: @link-color-black;
	}
	.details-content .details-content-label2{
		font-size:30px;
		color: @text-color;
		margin-top: 23px;
	    margin-bottom: 10px;
	}
	.details-content .details-content-label3{
		font-size: 12px;
		color:@link-color-lightgray;
		margin-bottom: 20px;
	}
	.details-content-bottom{
		background: @link-color-white;
	}
	.details-content-bottom li{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		border-top: 1px solid lightgrey;
	}
	.details-content-bottom li span{
		display: block;
		/*height: 1rem;*/
		height: 50px;
	}
	.details-content-bottom li span:nth-child(1){
		text-align: center;
		color: #b8b8b8;
		margin-left: .24rem;
		/*font-size: .3rem;*/
		font-size: @hm-font-size-sm;
		float: left;
	}
	.details-content-bottom li span:nth-child(2){
		/*font-size: .3rem;*/
		font-size: @hm-font-size-sm;
		color: @link-color-black;
		float: right;
		margin-right: .25rem;
	}
</style>
