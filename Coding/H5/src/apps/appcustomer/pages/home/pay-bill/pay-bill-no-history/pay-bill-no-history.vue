<template>
	<div id="payBill-wrapper" class="payBillWrapper">
		<div class="paybillTop">
			<div>
				<nav-header title="Pay Bill" leftText="Home" :rightFunc="toBillRecord" :leftFunc='toHome'>
		    		<div class="paybill-right-btn" slot="right">
		    			<span name="right">Records</span>
		       	 	</div>
	    		</nav-header>
			</div>
			<div class="payBill-content">
				<ul>
					<li>
						<img src="~assets/images/common/list_tx_3x.png"/>
					</li>
					<li>
						<span>Build Family Bills</span>
						<span>to know how much you spend on</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="payBill-bottom">
			<ul v-for="(item,index) in items" >
				<li @click.stop.prevent="toElectricity(item)">
					<div>
						<span>
							<b><img :src="item.pic"/></b>
							<b>{{item.options}}</b>
						</span>
						<span>
							<b>Add new</b>
							<b><img src="~assets/images/common/right_list_2x.png"/></b>
						</span>
					</div>
				</li>
				<li class="newPayAdd" @click.stop.prevent="toStep(item)">
					<span>str.*** NICOLE 32 loc.***</span>
					<span>Pay</span>
				</li>
			</ul>
		</div>
	</div>
</template>
<script>
import NavHeader from '../../../../../../components/header/nav-header';
	export default{
		name:"pay-bill-no-history",
		data() {
			return{
				leftText:{
					default:"Home"
				},
//				index:'',
				items:[
				{ pic: '../../../../static/images/home/pay_bill/Pay bill-no history/water_2x.png',
				  pic2: '../../../../static/images/home/pay_bill/Pay bill-no history/water1_2x.png',
				  options:'Water' 
				},
			    { pic: '../../../../static/images/home/pay_bill/Pay bill-no history/Electric1_2x.png',
				  pic2: '../../../../static/images/home/pay_bill/Pay bill-no history/Electric_2x.png',
			      options:"Electric" 
			    },
			    { pic: '../../../../static/images/home/pay_bill/Pay bill-no history/Fuel-gas_2x.png',
				  pic2: '../../../../static/images/home/pay_bill/Pay bill-no history/Fuel-gas1_2x.png',
			      options:"Fuel gas" 
			    },
			    { pic: '../../../../static/images/home/pay_bill/Pay bill-no history/insurance_2x.png',
				  pic2: '../../../../static/images/home/pay_bill/Pay bill-no history/Insurance1_2x.png',
			      options:"Insurance" 
			    },
			    { pic: '../../../../static/images/home/pay_bill/Pay bill-no history/Property_2x.png',
				  pic2: '../../../../static/images/home/pay_bill/Pay bill-no history/Property1_2x.png',
			      options:"Property" 
			    }
				]
			}
		},
	components: {
   		NavHeader
   	},
//  beforeUpdate(){
//		this.$store.dispatch('refreshPageMe');
//  },
   	methods: {
   		toBillRecord () {
   			this.$router.replace('/bill-record');
   		},
   		toHome () {
   			this.$router.replace('/home');
   		},
   		toElectricity(item){
   			this.$router.push({
				path:'/Electricity',
				query: {bill_type: item.pic2}
			});
   		},
   		toStep(item){
   			this.$router.push({
				path:'/example-step1',
				query: {bill_type:item.pic2 }
			});
   		}
   	},
    props:{
		 rightFunc:{ //右边触发函数，默认返回首页
                type: Function,
            }
        }
		
	}
</script>
<style lang="less">
	@import url('../../../../assets/css/mixin.less');
	@import url('../../../../assets/css/base.less');
	.payBillWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
		/*font-size: 0.36rem;*/
	}
	.paybillTop{
		position: fixed;
		width: 100%;
	}
	/*.payBillWrapper .header{
		position: fixed;
		width: 100%;
	}*/
	#payBill-wrapper .nav-left-text{
		font-size: 0.26rem;
	}
	#payBill-wrapper .header-wrapper{
		padding: 0px 9px;
	}
	.paybill-right-btn{
		color: @link-color;
		font-size: @hm-font-size-sm;
	}
	.payBill-content{
		/*height:2rem;*/
		height: 100px;
		background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#D90647), to(#EB402C)); 
		/*margin-top: 64px;
		position: fixed;*/
		width: 100%;
	}
	.payBill-content li{
		float: left;
	}
	.payBill-content li:nth-child(1){
		height: 100px;
		line-height: 165px;
		/*height: 2rem;
		line-height: 2.7rem;*/
	}
	.payBill-content li:nth-child(1) img{
		/*width: 1rem;
		height: 1rem;*/
		width: 75px;
		height: 75px;
		margin-left: 0.24rem;
	}
	.payBill-content li:nth-child(2){
		margin-left: 0.34rem;
	}
	.payBill-content li:nth-child(2) span{
		display: block;
	}
	.payBill-content li:nth-child(2) span:nth-child(1){
		margin-top: 33px;
		/*margin-top: 0.66rem;*/
		/*font-size: 0.34rem;*/
		font-size: @hm-font-size-lg;
		color: @theme-font-color;
	}
	.payBill-content li:nth-child(2) span:nth-child(2){
		/*margin-top: 0.1rem;*/
		margin-top: 5px;
		font-size: @font-12px;
		color: #f6f2f3;
	}
	.payBill-bottom{
		background: @content-bg-color;
		/*margin-top: 3.5rem;*/
		margin-top: 175px;
		overflow: auto;
        -webkit-overflow-scrolling: touch;
	}
	.payBill-bottom ul{
		/*padding-bottom: 0.2rem;*/
	}
	.payBill-bottom li{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		border-bottom: 1px solid lightgrey;
	}
	.payBill-bottom li:nth-child(5){
		border: none;
	}
	.payBill-bottom li span{
		display: block;
	}
	.payBill-bottom li span:nth-child(1){
		float: left;
		margin-left: 0.26rem;
	}
	.payBill-bottom li span:nth-child(2){
		float: right;
		margin-right: 0.25rem;
	}
	.payBill-bottom li span b{
		display: table-cell;
		float: left;
		/*height: 1rem;*/
		height: 50px;
	}
	.payBill-bottom li span:nth-child(1) b{
		/*font-size: 0.26rem;*/
		font-size: @font-16px;
		margin-left: 0.25rem;
		/*color: #333333;*/
		color: @text-color;
	}
	.payBill-bottom li span:nth-child(1) b:nth-child(2){
		/*height: 1rem;
		line-height: 1.1rem;*/
		height: 50px;
		line-height: 55px;
	}
	.payBill-bottom li span b img{
		vertical-align: middle;
	}
	.payBill-bottom li:nth-child(1) span:nth-child(1) b:nth-child(1) img{
		width: 0.3rem;
		height: 0.41rem;
	}
	.payBill-bottom li:nth-child(2) span:nth-child(1) b:nth-child(1) img{
		width: 0.31rem;
		height: 0.4rem;
	}
	.payBill-bottom li:nth-child(3) span:nth-child(1) b:nth-child(1) img{
		width: 0.33rem;
		height: 0.38rem;
	}
	.payBill-bottom li:nth-child(4) span:nth-child(1) b:nth-child(1) img{
		width: 0.33rem;
		height: 0.39rem;
	}
	.payBill-bottom li:nth-child(5) span:nth-child(1) b:nth-child(1) img{
		width: 0.38rem;
		height: 0.36rem;
	}
	.payBill-bottom li span:nth-child(2) b:nth-child(1){
		font-size: @font-16px;
		color: @tips-color;
		margin-right: 0.12rem;
		/*line-height: 1.09rem;*/
	}
	.payBill-bottom li span:nth-child(2) b:nth-child(2) img{
		width: 0.16rem;
		height: 0.28rem;
	}
	.payBill-bottom .newPayAdd span:nth-child(1){
		font-size: 0.26rem;
		margin-left: 0.5rem;
	}
	.payBill-bottom .newPayAdd span:nth-child(2){
		font-size: 0.3rem;
		color: #1349dd;
		margin-right: 0.28rem;
	}
</style>