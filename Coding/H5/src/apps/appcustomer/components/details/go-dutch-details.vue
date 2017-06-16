/**
 * AA付款-详细 页面组件
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="go-dutch-details">
		<div class="detail-content">
				<div class="details-tx"><img src="~assets/images/common/tx_2x.png" /></div>
				<div class="details-head">
					<p class="date">Today 14:36</p>
					<p class="tips1">Luch in KFC</p>
					<p class="tips2">3 people,€30.00 in total</p>
					
					<!--pay-go-dutch详情页面-->
					<p class="pay-go-dutch-tip" v-if="toPay">you need to pay</p>
					
					<p class="tips3" :class="{ stong: isStong,finished:isFinished}">€10 received</p>
					<router-link to="/go-dutch/my-qr-code">
						<p class="tips4" v-if="qrCode">My QR code</p>
					</router-link>
					<!--立即支付按钮-->
					<div class="pay-now" v-if="payNow">
						<mt-button type="danger" @click="click">Pay Now</mt-button>
					</div>
				</div>
		</div>
		<div class="members">
			<!--no pai未完成支付-->
			<div class="pay-state">
				<p class="not-paid">2 people not paid</p>
				<p class="remind" v-if="remind" @click="reminds">remind</p>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="money">€10.00 to be paid</label>
			</div>
			
			
			<!--paid 已完成支付-->
			<div class="pay-state">
				<p class="not-paid">1 people paid</p>
			</div>
			<div class="pay-state-not">
				<img slot="icon" src="~assets/images/common/amy_2x.png"  />
				<label class="name">Amy</label>
				<label class="paid-money">€10.00 to be paid</label>
				<label class="paydate">€10.00 to be paid</label>
			</div>
		
		
		</div>
		
	</div>
</template>
<script>
import { MessageBox } from 'mint-ui';
	export default {
		data() {
			return {
			}
		},
		props: {
			toPay: {
				type: Boolean,
				default:false
			},
			payNow: {
				type: Boolean,
				default:false
			},
			qrCode:{
				type: Boolean,
				default:true
			},
			isStong:{
				type: Boolean
			},
			isFinished:{
				type: Boolean
			},
			enterPwd:{    
                type: Function,
            },
            remind:{
            	type: Boolean,
				default:true
            }
		},
		methods:{
			click(){
				if(typeof this.enterPwd === 'function'){
                    this.enterPwd();
                }
			},
			//提醒付款方法
			reminds(){
				this.showToast("Remind successful","bottom");
			},
			
		}
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.go-dutch-details{
		position: relative;
	    background-color: #f8f8f8;
		.members{
		    position: relative;
		    background-color: #f8f8f8;
		    padding-bottom:1rem;
		}
		
		.detail-content{
			background-color: #F8F8F8;
		    padding: .25rem;
	    	padding-top: .8rem;
	    	padding-bottom: 0;
	    	margin-bottom: .25rem;
		}
		.details-tx{
			text-align: center;
		 	img{
			height: 1.3rem;
		    width: 1.3rem;
		    /*position: absolute;*/
		    margin: -.6rem auto;
		    }
		}
		    
		.details-head{
			background-color: #FFFFFF;
			border-radius: 6px;
		}
		.date{
		    font-size: .24rem;
		    color: #999;
		    padding-top: .4rem;
		    margin-left: 4rem;
		    text-align: right;
    		margin-right: .5rem;
		}
		.tips1{
		    font-size: .32rem;
		    color: #999;
		    margin-top: .4rem;
		    text-align: center;
		}
		.tips2{
		    font-size: .3rem;
		    color: #333;
		    margin-top: .24rem;
		    text-align: center;
		}
		.tips3{
		    font-size: .48rem;
		    color: #DD153F;
		    margin-top: .34rem;
		    text-align: center;
		    &.stong{
				font-size:.6rem;
			    padding-bottom: .4rem;
			}
			&.finished{
				font-size:.48rem;
				color: #20A859;
				padding-bottom: .2rem;
			}
		}
		.tips4{
		    font-size: .32rem;
		    color: #1B57DE;
		    margin-top: .24rem;
		    text-align: center;
		    padding-bottom: .2rem;
		}
		.pay-go-dutch-tip{
			font-size: .24rem;
		    color: #999;
		    margin-top: .1rem;
		    text-align: center;
	        margin-bottom: -.2rem;
		}
		.pay-now{
			text-align: center;
		 	.mint-button--danger{
			    width: 6.5rem;
	    		height: 1rem;
	    	    background-color: #DB1B43;	
	            margin: .3rem 0;
			}
		}
		.pay-state{
			padding-bottom: .25rem;
		}
		.not-paid{
		    font-size: .3rem;
		    color: #999;
		    margin-left: .3rem;
		    width: 4rem;
		    display: inline;
		}
		.remind{
		    color: #1B57DE;
		    display: inline;
		    position: relative;
		    margin-left: 3.5rem;
		    font-size: .3rem;
		    }
		.pay-state-not{
		    border-bottom: 1px solid #E4E4E4;
			background-color: #fff;
			height: 1.3rem;
			img{
			    width: .82rem;
			    height: .81rem;
			    position: absolute;
			    margin-top: .25rem;
			    margin-left: .25rem;
			}
			.name{
			    margin-left: 1.43rem;
			    line-height: 1.3rem;
			    font-size: .32rem;
			    color: #262626;
			    position: absolute;
			    width: 3rem;
			}
			.money{
			    line-height: 1.3rem;
			    font-size: .32rem;
			    color: #262626;
			    float: right;
			    margin-right: .5rem;				
			}
			.paid-money{
			    font-size: .32rem;
			    color: #20A859;
		        margin-top: .34rem;
	            float: right;
    			margin-right: .5rem;
			}
			.paydate{
			    font-size: .24rem;
			    color: #999;
			    margin-top: .8rem;
			    margin-right: .5rem;
			    position: absolute;
			    right: 0;
			}
			
		}
		
	}
	
	
	
</style>




