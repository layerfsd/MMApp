<template>
	<div class="example-wrapper">
		<div class="example-title">
        	<nav-header title="Add Account" :showRight="false" :leftFunc='ExampleToPaybill'>
        		<div slot="right">
        			<span class="account-right-text">Bucharest</span>
           	 	</div>
        	</nav-header>
		</div>
		<div class="example-content">
			<ul>
				<li>
					<img :src="imgShow"/>
				</li>
				<li>
					<div class="examplt-address-select" @click="handleClick">
						<mt-button>{{payAdd}}</mt-button>
						<span><img src="~assets/images/common/right_list_3x.png"/></span>
					</div>
					<overlay v-if="listShow"></overlay>
					<transition name="fold">
						<div v-show="listShow" class="selectList">
							<div class="list-header">
								<a class="cancel" @click="cancel">Cancel</a>
								<a class="done" @click="done">Done</a>
							</div>
							<!-- <div class="list-content" ref="list-content">
								<ul>
									<li v-for="(item, index) in selectLists" class="list-item" :class="{'checked':currentIndex==index}" @click="currentIndex=index">
										<span class="pre-no">{{item.preNo}}</span>
										<img class="national-flag" :src="item.image"></img>
										<span class="country">{{item.country}}</span>
									</li>
								</ul>
								<div class="picker-center-highlight" :style="{ height: itemHeight + 'px', marginTop: -itemHeight / 2 + 'px' }"></div>
							</div> -->
							<mt-picker :slots="slots" @change="onValuesChange" value-key="preNo"
							 :visibleItemCount="visibleItemCount" class="list-content" show-tool-bar="true">
							</mt-picker>
						</div>
					</transition>
				</li>
				<li>
					<input type="" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" placeholder="Enter bill reference number"/>
				</li>
			</ul>
		</div>
		<div class="example-footer">
			<mt-button size="normal" type="danger" class="next-btn" :disabled="this.isEmpty" @click="setAmount">Next</mt-button>
		</div>
	</div>
</template>

<script>
	import Vue from 'vue';
	import { Picker, Popup,Indicator,MessageBox } from 'mint-ui';
	import Overlay from '../../../../../../components/overlay/overlay';
	import NavHeader from '../../../../../../components/header/nav-header';
	Vue.component(Picker.name, Picker);
	Vue.component(Popup.name, Popup);
	export default {
			name:"Electricity",
			data(){
			return{
				modal:true,
				closeOnClickModal:true,
				popupVisible:false,
				listShow:false,
				payAdd:'',
				isEmpty: true,
				visibleItemCount: 3,
				amount:'',
				imgShow:'',
				slots: [
			        {
			          flex: 1,
			          values: ['Romania electric power company', 
			          'Romania electric power company111', 
			          'Romania electric power company222', 
			          'Romania electric power company333', 
			          'Romania electric power company444', 
			          'Romania electric power company555'],
			          className: 'slot1',
			          textAlign: 'center'
			        },
			      ],
			      originalPreNo: 'Romania electric power company',
			      cancelText:"Cancel",
			      confirmText:"Confirm"
			}
		},
		 //创建之前
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'Electricity');
	    },
		methods: {
			handleClick() {
//				this.popupVisible = true
				this.listShow = true;
			},
			cancel() {
				this.payAdd = this.originalPreNo;
				this.listShow = false;
			},
			done() {
				this.listShow = false;
				this.originalPreNo = this.payAdd;
			},
			 onValuesChange(picker, values) {
			 	this.payAdd = values[0]
//		      if (values[0] > values[1]) {
//		        picker.setSlotValue(1, values[0]);
//		      }
		   	},
		    openPicker() {
	        this.$refs.picker.open();
	     	},
	     	handleConfirm() {
	     		alert(this.values)
	     	},
	     	checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			setAmount(){
				this.$router.push({
					path:'/example-step1',
					query: {bill_type:this.imgShow }
				});
			},
			ExampleToPaybill(){
	   			this.$router.push('/pay-bill-no-history');
	   			 //返回时删除缓存
                this.$store.dispatch('popKeepAlive');
	   		}
		},
		created: function(){
    		this.imgShow=this.$route.query.bill_type;
		},
//		activated: function () {
//  		this.imgShow=this.$route.query.bill_type;
//          if (this.$root.supportTranslucentStatus) {
//              this.$root.setStatusStyleBlack();
//          }
//          alert(this.imgShow)
//      },
		components: {
			Overlay,
			NavHeader
		},
//		activated:function(){
//			this.payAdd = originalPreNo;	
//		}
	}
</script>
<style lang="less">
	@import url('../../../../assets/css/mixin.less');
	@import url('../../../../assets/css/base.less');
	/*html{
		height: 100%;
		background: #f8f8f8;
	}*/
	.example-wrapper{
		overflow: hidden;
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
	}
	.account-right-text{
		font-size: 0.26rem;
		color: #1249DE;
	}
	.address-content .picker-slot{
		width: 7.5rem;
	}
	.list-header{
		display: flex;
		justify-content:space-between;
		height: 0.9rem;
		line-height: 0.9rem;
		padding: 0 0.16rem;
		background-color: #f6f6f6;
		.cancel,.done{
			display: inline-block;
			height: 100%;
			color: #1249DE;
			font-size: 0.3rem;
		}
	}
	.example-content{
		/*margin-top: 0.88rem;*/
		margin-top: 44px;
		background: #FFFFFF;
	}
	.example-content li:nth-child(1){
		/*height: 0.75rem;*/
		height: 35px;
		position: relative;
	}
	.example-content li:nth-child(1) img{
		position: absolute;
		width: 1.3rem;
		height: 1.3rem;
		left: 41.6%;
		top: -0.6rem;
		z-index: 99;
	}
	.example-content li:nth-child(2){
		/*height: 0.99rem;
		line-height: 0.99rem;*/
		height: 50px;
		line-height: 50px;
		border-bottom: 1px solid lightgrey;
	}
	.example-content li:nth-child(2) button{
		border: none;
		background: @content-bg-color;
		outline: none;
		box-shadow: none;
		float: left;
		/*height: 0.99rem;*/
		height: 50px;
		width: 6.7rem;
		color: @text-color;
		-webkit-tap-highlight-color:rgba(255,255,255,0);
		text-align: left;
	}
	.example-content .mint-button--normal{
		padding-left: 0 14px;
	}
	.example-content li:nth-child(2) .mint-button:after{
		background: none;
	}
	.example-content li:nth-child(2) span{
		/*height: 0.99rem;*/
		height: 50px;
		margin-right: 0.26rem;
		float: right;
	}
	.example-content li:nth-child(2) span img{
		width:0.24rem;
		/*height: 0.42rem;*/
		height: 21px;
		/*margin-top: 0.3rem;*/		
		margin-top: 15px;
	}
	.example-content li:nth-child(3){
		/*height: 1rem;*/
		height: 50px;
	}
	.example-content li:nth-child(3) input{
		/*height: 1rem;*/
		height: 50px;
		width: 100%;
		padding-left: 0.3rem;
		font-size: 0.26rem;
		color: #999999;
	}
	.example-footer{
		/*width: 7.5rem;*/
		text-align: center;
		/*margin-top: 1.36rem;*/
		margin-top: 68px;
	}
	/*.example-footer button{
		width: 6.5rem;
		height: 1.02rem;
		background: #C6C6C6;
	}*/
	.example-footer .mint-button.is-disabled{
		background-color: #c6c6c6;
		/*width: 6.5rem;*/
		width: 90%;
		/*height: 1.02rem;*/
		height: 51px;
		color: @link-color-white;
        border-radius: 6px;
	}
	.example-footer .mint-button--danger{
	    width: 6.5rem;
	    /*height: 1rem;*/
	    height: 50px;
        border-radius: 6px;
	}
	.example-content .selectList{
		position: absolute;
		bottom: 0;
		left: 0;
		width: 100%;
		z-index: 1;
		&.fold-enter-active,&.fold-leave-active{
		  	transition: all .5s;
			transform: translate3d(0,0,0);
		}
		&.fold-enter,&.fold-leave-active{
		  	transform: translate3d(0,100%,0);
		}
		.list-header{
			display: flex;
			justify-content:space-between;
			height: 0.9rem;
			line-height: 0.9rem;
			padding: 0 0.16rem;
			background-color: #f6f6f6;
			.cancel,.done{
				display: inline-block;
				height: 100%;
				color: #1249DE;
				font-size: 0.3rem;
			}
		}
		.list-content{
			position: relative;
			max-height:2.56rem;
			overflow: hidden;
			background-color: #fff;
			color: #333;
			cursor: pointer;
			.list-item{
				box-sizing: border-box;
				padding: 0.24rem 0 0.24rem 2.12rem;
				.pre-no,.national-flag,.country{
					line-height: 0.32rem;
					font-size: 0.34rem;
					vertical-align: top;
				}
				.national-flag{
					display: inline-block;
					width: 0.48rem;
					height: 0.36rem;
					margin: 0 0.24rem 0 0.4rem;
				}
			}
			// .checked{
			// 	background-color: #f6f6f6;
			// 	border-top: 1px solid #c6c6c6;
			// 	border-bottom: 1px solid #c6c6c6;
			// }
			.picker-center-highlight {
			    box-sizing: border-box;
			    position: absolute;
			    left: 0;
			    width: 100%;
			    height: 0.8rem;
			    top: 50%;
			    margin-top: -0.36rem;
			    pointer-events: none
			  }

			  .picker-center-highlight:before,
			  .picker-center-highlight:after {
			    content: '';
			    position: absolute;
			    height: 1px;
			    width: 100%;
			    background-color: #c6c6c6;
			    display: block;
			    z-index: 15;
			    transform: scaleY(0.5);
			  }

			  .picker-center-highlight:before {
			    left: 0;
			    top: 0;
			    bottom: auto;
			    right: auto;
			  }

			  .picker-center-highlight:after {
			    left: 0;
			    bottom: 0;
			    right: auto;
			    top: auto;
			  }
		}
	}
</style>
