/**
 * 转账给朋友 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div>
	<!--密码弹窗-->
	<dialog-pwd :show="show" :name="name"></dialog-pwd>
	<div class="transfer-to-friend">
		
		<nav-header title="Receive money" :showLeft="true" :showRight="false"></nav-header>
		<div class="set-amount-content">
			<div class="set-amount-tx"><img src="~assets/images/common/tx_2x.png" /></div>
			<p class="set-amount-name">KFC</p>
			<p class="set-amount-no">132****0000</p>
			<div class="set-amount-input">
				<p>Amount</p>
				<span>€</span>
				<input type="text" placeholder="0.00" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" />
			</div>
			<p class="remark"> Add remark(less than 20 characters)</p>
		</div>
		
		<div class="set-amount-btn">
			<mt-button type="danger" class="next-btn" :disabled="this.isEmpty" @click="enterpwd">Transfer</mt-button>
		</div>
		<p class="yue">Pay with balance €2,900.00</p>
		
		</div>
		</div>
	
</template>
<script>
	import dialogPwd from '../../components/message-box/dialog-pwd';
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'transfer-friend',
		components: {
			dialogPwd,
			NavHeader
		},
		data() {
			return {
				amount:'',
				isEmpty: true,
				seen:false,
				scan:false,
				show:false,
				name:"transfer-success"
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'transfer-friend');
    	},
		methods:{
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			//弹出密码弹窗
			enterpwd(){
				this.show=true;
			}
			
		},
		activated:function(){
	        	this.amount='';
	        	this.isEmpty=true;
	        	this.show=false;
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
	                    this.$router.push('/transfer/transfer-success');
	                }else{
	                    alert('密码错误')
	                    this.show = false;
	                }
	            });
	    },
	    
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.transfer-to-friend{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #F3F3F3;
		
		.mint-header {
		    background-color: #fff;
		    color: #333;
		    font-size: .36rem;
		    height: .9rem;
		}
		.set-amount-content{
		    padding-bottom: .26rem;
			background: #FFFFFF;
			margin:1rem auto 0;
			border-radius: 3px;
		}
		.set-amount-tx{
			text-align: center;
			img{
			    width: 1.3rem;
			    height: 1.3rem;
			    /*position: absolute;
			    margin: -.7rem 3.1rem;*/
			   margin-top: -.7rem;
		    }
		}
		.set-amount-name{
			font-size: .32rem;
			color: #333333;
			text-align: center;
			padding-top: .5rem;
		}
		.set-amount-no{
			font-size: .3rem;
			color: #999;
			text-align: center;
			margin-top: .24rem;
		}
		.set-amount-input{
			height: 1.6rem;
			background-color: #f9f9f9;
		    margin-top: .25rem;
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
		.set-amount-input input{ 
			font-size: .6rem;
			color: #333333;	
			padding-top: .2rem;
		    max-width: 85%;
			background-color: #F9F9F9;
		}
		
		.set-amount-btn .mint-button--danger{
			    width: 6.5rem;
			    height: 1rem;
			    margin-top: .5rem;
			    margin-left: .5rem;
		        border-radius: 6px;
		}
		.set-amount-btn .mint-button.is-disabled{
			background-color: #c6c6c6;
		}
		.remark{
			font-size: .24rem;
			color: #666;
			margin-left: .23rem;
			margin-top: .26rem;
		}
		.yue{
			font-size: .24rem;
			color: #333;
			text-align: center;
			margin-top: .2rem;
		}
	}

	
	
</style>