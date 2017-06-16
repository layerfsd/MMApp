/**
 * 提现 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="withdraw">
		<nav-header :title="title" :showLeft="true" :showRight="false"></nav-header>
		<div class="set-amount-content">
			<div class="turn-out">
				<label>{{$t('info_提现账户')}}</label><label class="bank" @click="payment">{{payTheWay}}</label>
			</div>
			<input-sum @isEnter="checkFiled"></input-sum>
			
			<div v-if="isFee">
				<label class="remark">{{$t('label_余额')}}:€ {{balance}}，</label><label class="withdraw-all" @click="withdrawAll">{{$t('action_全部提现')}}</label>
			</div>
			<div v-else class="fee">{{$t('info_手续费')}}:€ {{fee}}</div>
		</div>
		
		<div class="set-amount-btn">
			<button type="button" class="btn" :class="{'active': !isEmpty}" :disabled="this.isEmpty" @click="withdraw">{{$t('action_提现')}}</button>
		</div>
		<div class="tips" v-if="tips">{{$t('info_到账提示')}}</div>
		
			<div class="payment">
				<overlay  v-show="isShowPay"></overlay>
				
				<transition name="fade" >
					<div class="payment-content" v-show="isShowPay">
						<div class="head">
							<img @click="close" src="../../../../assets/images/common/close_n_2x.png" />
							<p>{{$t('label_切换用户')}}</p>
						</div>
		     			<mt-radio @change="close" align="right" v-model="value" :options="options"></mt-radio>
					</div>
				</transition>
			</div>
		
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputSum from '../../../../components/input/input-sum';
	import overlay from '../../../../components/overlay/overlay';
	
	
	
	export default {
		name:'withdraw',
		components: {
			NavHeader,
			inputSum,
			overlay
		},
		data() {
			return {
				title:this.$t('label_提现标题'),
				isFee:true,//是否显示手续费，true不显示，false显示
				tips:false,
				amount:'',
				isEmpty: true,
				balance:'100.00',
				fee:'4.00',
				payTheWay:'SPDB Debit Card（7666）',
				isShowPay:true,
				value:'',
				options:[
				{
					label:'ICBC Debit (7666)',
					value:'ICBC Debit (7666)'
				},{
					label:'ABC Debit (5330)',
					value:'ABC Debit (5330)'
				},{
					label:'CMB Debit (9045)',
					value:'CMB Debit (9045)'
				}],
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'withdraw');
    	},
    	beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
	    activated() {
	    	this.amount='';
        	this.isEmpty=true;
			this.tips=false;
			this.isFee=true;
        	
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
		methods:{
			//获取组件输入的值
			checkFiled(msg) {
				this.isEmpty=msg.isEmpty;
				this.amount=msg.value;
				if(this.amount!=''){
					this.tips=true;
					this.isFee=false;
				}else{
					this.tips=false;
					this.isFee=true;
				}
			},
			//选择支付方式
			payment(){
				this.isShowPay=true;
				this.isShowContent=true;
				this.payTheWay=this.value;
			},
			withdraw(){
				this.$router.push({
                    path: '/withdraw/enterPin',
                });
			},
			//关闭方法
			close(){
				this.isShowContent=false;
				this.isShowPay=false;
				this.payTheWay=this.value;
			},
			//提取全部方法
			withdrawAll(){
				
			}
			
		},
		mounted() {
	        
	        
	    },
	    
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.withdraw{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		
		.set-amount-content{
			background: #FFFFFF;
			margin-top:10px;
			border-radius: 3px;
		}
		.turn-out{
			font-size: @hm-font-size-base;
			color:@text-color ;
			margin-left:.28rem;
			/*适配iPhone5*/
			@media only screen and (max-device-width : 320px) and (min-device-height : 568px) and (-webkit-min-device-pixel-ratio: 2) and (orientation : portrait){
				font-size: @hm-font-size-sm;
			}
			label{
				line-height: 50px;
			}
			.bank{
				margin-left: 1rem;
				color:@theme-text-color;
			}
		}
		.set-amount-btn{
			text-align: center;
			margin-top: 35px;
			/*.mint-button--danger{
			    width: 6.5rem;
		        border-radius: 6px;
			}*/
		}
		.set-amount-btn .mint-button.is-disabled{
			/*background-color: #c6c6c6;*/
		}
		.remark{
			font-size: @hm-font-size-xs;
			color: @text-color;
			margin-left: .23rem;
			line-height: 40px;
		}
		.withdraw-all{
			font-size: @hm-font-size-xs;
			color: @theme-text-color;
			line-height: 40px;
		}
		.fee{
			font-size: @hm-font-size-xs;
			color: @text-color;
			margin-left: .23rem;
			line-height: 40px;
		}
		.tips{
			margin-top: 10px;
			text-align: center;
			font-size: @hm-font-size-xs;
			color: @tips-color;
		}
		.payment{
			.payment-content{
				overflow:hidden;
				position: absolute;
				left: 0;
				right: 0;
				bottom: 0;
				z-index: 2;
				max-height: 300px;
				overflow:　auto;
				color: @text-color;
				padding-bottom: 30px;
				background-color: #fff;
				&.fade-enter-active,
		        &.fade-leave-active {
		            transition: all .3s;
		            transform: translate3d(0, 0, 0);
		        }
		        &.fade-enter,
		        &.fade-leave-active {
		            transform: translate3d(0, 100%, 0);
		        }
		        /*.fade-enter-active {
				  transition: all .3s ease;
				}
				.fade-leave-active {
				  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
				}
				.fade-enter, .fade-leave-active {
				  transform: translateY(10px);
				  opacity: 0;
				}*/
		        
		        
			}
			.head{
				height: 40px;
				img{
				    width: 13px;
    				margin: 14px 17px;
				    vertical-align: middle;
				    position: absolute;
				}
				p{
				    font-size: @hm-font-size-sm;
					color:@text-color;
					text-align: center;
					padding: 12px;
				}
			}
			.mint-radiolist-title{
				margin:0;
			}
			.mint-cell-wrapper{
				font-size:@hm-font-size-base ;
			}
			.mint-radiolist-label{
				text-align: center;
			}
			
			.mint-radio-input {
			     display: none; 
			}
			.mint-radio-core{
				background: none;
				border:none;
    			border-color: green;
			}
			.mint-radio-input{
				background: url(~assets/images/common/icon_choose_2x.png);
			}
			.mint-radio-core:after{
				background: url(~assets/images/common/icon_choose_2x.png);
				background-size: 21px 21px;
				background-position: center center;
				border-radius: 100%;
				/*border:1px solid green;*/
				left: 0;
				top: 0;
				width: 21px;
				height: 21px;
			}
			
		}
		
	}

	
	
</style>