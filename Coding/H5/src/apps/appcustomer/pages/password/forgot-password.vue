/* * 忘记密码 forgot-password
* @Date : 2017-03-18
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
	<div class="forgot-password layout">
		<nav-header title="Forgot Password" path="/login"></nav-header>
		<div class="content-wrapper">
			<div for="account" class="content-div content-div-account">
				<div class="content-info">
					<label for="account"><span class="name">Account</span></label><span class="plus">+</span><span class="pre-no" ref="preno">40</span><i class="icon-down" @click="showList"></i>
				</div>
				<input type="number" id="account" class="content-input account-input" placeholder="Phone No" @keyup="checkFiled($event)" v-model="telphone">
			</div>
			<div for="cardNo" class="content-div content-div-card">
				<div class="content-info">
					<label for="cardNo">
						<span class="name">ID Card No.</span>
					</label>
				</div>
				<input type="number" id="cardNo" class="content-input card-input" placeholder="" @keyup="checkFiled($event)" v-model="cardNo">
			</div>
			<mt-button type="default"   :class="{active: !isEmpty}" class="btn" :disabled="this.isEmpty" @click="sendMessage">Next</mt-button>
		</div>
		<overlay v-if="listShow"></overlay>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import Overlay from '../../../../components/overlay/overlay';
	export default {
		data() {
			return {
				isEmpty: true,
				telphone: '',
				cardNo: '',
				listShow: false
			}
		},
		methods: {
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.telphone !== '' && this.cardNo !== ''){
					this.isEmpty = false;
				}
			},
			sendMessage() {
				//发送短信验证码(待开发...)
				let sendData = {};
				this.$router.push({
					path: '/forgotPassword/verficationCode'
				})

			},
			showList() {
				//显示遮罩
				this.listShow = true;
				// 显示选择列表（待开发...）

			}
		},
		components:{
			NavHeader,
			Overlay
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.forgot-password{
		.content-wrapper{
			margin-top: 0.2rem;
			overflow: hidden;
			.content-div{
				display: flex;
				background-color: @content-bg-color;
				.content-info{
					padding: 0.36rem 0.24rem 0.36rem;
					font-size: 0.36rem;
					.name,.plus,.pre-no,.icon-down{
						display: inline-block;
						height: 0.28rem;
						line-height: 0.28rem;
						vertical-align: top;
					}
					.plus{
						font-size: 0.44rem;
					}
					.pre-no{
						padding: 0 0.04rem 0 0.04rem;
					}
					.icon-down{
						display: inline-block;
						vertical-align: top;
						margin: 0.06rem 0 0 0.1rem;
						width: 16px;
						height: 9px;
						background-size: 16px 9px;
						background-repeat: no-repeat;
						.bg-image('xiala_n');
					}
				}
				.content-input{
					flex: 1;
				}
			}
			.btn{
				width: 90%;
				height: 1rem;
				line-height: 1rem;
				color: @default-font-btn-color;
				background-color: @default-bg-btn-color;
				margin: 0 5%;
				font-size: @font-16px;
				margin-top: 0.77rem;
				&.active{
					background-color: rgb(248, 0, 65);
				}
			}

		}
		.content-div-account{
			.border-1px(@default-border-color);
			.content-info{
				flex: 0 0 3.84rem;
				.name{
						padding-right: 0.96rem;
						vertical-align: top
					}
			}
		}
		.content-div-card{
			.content-info{
				flex: 0 0 2.38rem;
			}
		}

	}

</style>
