<template>
	<div class="stepWrapper">
		<div class="step1-top">
			<nav-header title="Pay Bill" :showRight="false" >
        	</nav-header>
		</div>
		<div class="example-step1-content">
			<ul>
				<li>
					<!--<img src="~assets/images/home/pay_bill/Pay bill-no history/Electric_2x.png"/>-->
					<img :src="imgShow1"/>
				</li>
				<li>
					Romania electric power company
				</li>
				<li>
					634 526 118
				</li>
				<li>
					str.*** NICOLE 32 loc.***
				</li>
			</ul>
		</div>
		<div class="set-amount-input">
			<p>Amount</p>
			<span>€</span>
			<input type="text" placeholder="0.00" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" />
		</div>
		<div class="example-blank"></div>
		<div class="example-footer">
			<mt-button size="normal" type="danger" class="next-btn" :disabled="this.isEmpty" @click="setAmount">Comfirm</mt-button>
		</div>
		<div class="example-footer-bottom">
			<span>Pay with balance</span>
			<span>€2,900.00</span>
		</div>
        <dialog-pwd :show="isShow" ></dialog-pwd>
	</div>
</template>
<script>
	import NavHeader from '../../../../../../components/header/nav-header';
	import DialogPwd from '../../../../components/message-box/dialog-pwd';
	import { Indicator } from 'mint-ui';
	import { MessageBox } from 'mint-ui';
	export default {
//		name:'step1',
		data() {
			return {
				isEmpty: true,
				amount:'',
            	isShow: false,
            	imgShow1:''
			}
		},
//		 beforeUpdate(){
//			this.$store.dispatch('pushKeepAlive',"step1");
//	    },
		methods:{
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			close() {
	            this.show = false;
	            this.$parent.$emit('listen-child-msg', this.show);
	        },
			setAmount(){
//				this.$router.replace({
//					path: '/example-step3'
//				});
				 this.isShow = true;
			},
//			toElectricity(){
// 				this.$router.push({
//					path:'/Electricity',
//					query: {bill_type:this.imgShow1 }
//				});
// 			}
		},
		activated: function () {
			this.amount='';
    		this.imgShow1=this.$route.query.bill_type;
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleBlack();
            }
        },
		mounted() {
	        this.$nextTick(() => {
	            this.$on('listen-child-msg', (msg) => {
	                this.show = msg;
	            })
	        });
	        this.$on('listen-password', (msg) => {
	                this.text = msg;
	                if(this.text === '1234'){
	                    this.$router.push('/example-step3');
	                }else{
	                    alert('密码错误')
	                    this.show = false;
	                }
	            });
	    },
		components: {
			NavHeader,
			DialogPwd
		}
	}
</script>
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
		overflow: auto;
	}
	.step1-top{
		position: fixed;
		width: 100%;
		z-index: 99;
	}
	.example-step1-content{
		/*margin-top: 2.2rem;*/
		margin-top: 110px;
		background: #FFFFFF;
		/*height: 2.56rem;*/
		height: 128px;
	}
	.example-step1-content li{
		text-align: center;
	}
	.example-step1-content li:nth-child(1){
		/*height: 0.75rem;*/
		height: 38px;
		position: relative;
	}
	.example-step1-content li:nth-child(1) img{
		position: absolute;
		width: 1.3rem;
		height: 1.3rem;
		left: 50%;
		top:-0.6rem;
		transform: translate3d(-50%,0,0);
	}
	.example-step1-content li:nth-child(2){
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color:@link-color-black;
		/*margin-top: 0.3rem;*/
		margin-top: 15px;
	}
	.example-step1-content li:nth-child(3){
		/*font-size: 0.24rem;*/
		font-size: @hm-font-size-sm;
		color:@link-color-lightgray;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.example-step1-content li:nth-child(4){
		/*font-size: 0.2rem;*/
		font-size: @font-12px;
		color:@link-color-black;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.set-amount-input{
		height: 1.6rem;
		background-color: #f9f9f9;
	}
	.set-amount-input p{
		font-size: .3rem;
		color: #333333;	
		padding-top: .3rem;
		margin-left: .3rem;
	}
	.set-amount-input span{
		font-size: .6rem;
		color: #333333;	
		padding-top: .2rem;
		margin-left: .3rem;
	}
	.example-blank{
		height: 0.28rem;
		background: #FFFFFF;
	}
	.set-amount-input input{
		font-size: .6rem;
		color: #333333;	
		padding-top: .2rem;
		width: 4rem;
		background-color: #F9F9F9;
	}
	.example-footer{
		/*width: 7.5rem;*/
		text-align: center;
		margin-top: 0.55rem;
	}
	/*.example-footer button{
		width: 6.5rem;
		height: 1.02rem;
		background: #C6C6C6;
		color: @link-color-white;
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
		    /*width: 6.5rem;*/
		    width: 90%;
		    /*height: 1rem;*/
		   height: 51px;
		    margin-top: .5rem;
		    /*margin-left: .5rem;*/
	        border-radius: 6px;
	}
	.example-footer-bottom{
		text-align: center;
		/*font-size: 0.24rem;*/
		font-size: @font-12px;
		color:@link-color-black;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
</style>