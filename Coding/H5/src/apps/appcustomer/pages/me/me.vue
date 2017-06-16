<template>
	<div class="about-me">
		<div class="about-me-header">
			<h1 class="title">Me</h1>
			<div class="header-content-wrapper">
				<router-link to="/me/profile">
					<div class="avatar">
						<img src="~assets/images/common/tx_2x.png" alt="" width="100%" height="100%">
					</div>
				</router-link>
				<div class="header-content">
					<div class="name">Lara Korvik</div>
					<div class="tel">134****2392</div>
				</div>
				<div class="QR-code">
					<router-link to="/me/my-QR-code">
 						<span class="code"></span>
						<i class="icon-right"></i>
					</router-link>
				</div>
			</div>
		</div>
		<div class="about-me-content">
			<div class="content-BT">
				<div class="balance">
					<div class="icon"></div>
					<div class="balance-content">
						<div class="title">Balance</div>
						<div class="para">${{balance}}</div>
					</div>
				</div>
				<div class="transactions">
					<div class="icon"></div>
					<div class="transactions-content">
						<div class="title">Transactions</div>
					</div>
				</div>
				<div class="devider"></div>
			</div>
			<p class="desc">Acount and Security</p>
			<div class="content-password" @click="linkPassword">
				<span class="icon"></span>
				<span class="title">Password</span>
				<i class="icon-right"></i>
			</div>
			<div class="content-payment" :class="{border: value}">
				<span class="icon"></span>
				<span class="title">Password free payment</span>
				<span class="icon-switch" :class="{open:!value,close:value}" @click="value=!value"></span>
			</div>
			<div class="content-limit last" v-if="value">
				<span class="title">Limit</span>
				<span class="content">€500.00/pay</span>
			</div>
			<div class="content-settings" @click="linkSettings">
				<span class="icon"></span>
				<span class="title">Settings</span>
				<i class="icon-right"></i>
			</div>
		</div>
	</div>
</template>
<script>
import { mapState } from 'vuex';
	export default {
		name: 'meHome',
		data() {
			return {
				value: false,
				balance: 0.00
			}
		},
		computed: mapState({
	        needRefreshPageMe: state => state.refreshPage.needRefreshPageMe
	    }),
		methods: {
			linkPassword() {
				this.$router.push({
					path: '/resetPassword'
				});
			},
			linkSettings(){
				this.$router.push({
					path: '/me/settings'
				});
			},
			refreshPage() {
				let self = this;
				self.showIndicator();

				this.serverApi.getAccountBalance(null, {returnToPage: '/me'},
					function(error, data, wentLogin){
						self.$store.dispatch('refreshPageMeDone');
						self.hideIndicator();
						if (wentLogin)
							return;
						if (error) {
							self.showToast(error.message);
							return;
						}
						self.balance = data.balance;
					});
			}
		},
		created() {
	      	console.log("created");
	    },
	    activated: function () {
	      	console.log("me, activated");
	      	if (this.needRefreshPageMe) {
	      		this.refreshPage();
	      	}
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleLight();
            }

	    },
	    deactivated: function () {
	      	console.log("deactivated");
	    },
		//创建之前
        beforeCreate(){
            //添加到缓冲机制中
	      	console.log("beforeCreate");
	      	console.log(this);
        	this.$store.dispatch('pushKeepAlive', 'meHome');
        },

		mounted() {
	      	console.log("mounted");
			this.refreshPage();
			
		},
	};
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.about-me{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
		&:before {
		  content: "";
		  position: fixed;
		  z-index: -1;
		  top: 0;
		  right: 0;
		  bottom: 0;
		  left: 0;
		  background-color: @content-bg-color;
		  background-repeat: no-repeat;
		  background-size: cover;
		}
		.about-me-header{
			color: @theme-font-color;
	        background: -webkit-linear-gradient(top,@theme-bg-begin-color 0,@theme-bg-end-color 100%);
			.background{
				background-color: @theme-bg-end-color;
			}
			.title{
				text-align: center;
				font-size: 0.36rem;
				line-height: 0.26rem;
				padding: 0.44rem 0 0.47rem 0;
			}
			.header-content-wrapper{
					position: relative;
					padding: 0 0.27rem 0.26rem 0.27rem;
					.avatar{
						display: inline-block;
						width: 1.02rem;
						height: 1.02rem;
						vertical-align: top;
						img{
							border-radius: 50%;
							border: none;
						}
					}
					.header-content{
						display: inline-block;
						padding-top: 0.2rem;
						.name,.tel{
							padding-left: 0.35rem;
						}
						.name{
							margin-bottom: 0.19rem;
							font-size: 0.3rem;
							line-height: 0.23rem;
						}
						.tel{
							font-size: 0.24rem;
							line-height: 0.19rem;
						}

					}
					.QR-code{
						position: absolute;
						right: 0.33rem;
						top: 0.28rem;
						.code{
							display: inline-block;
							margin-right: 0.25rem;
							vertical-align: top;
							width: 22px;
							height: 22px;
							background-size: 22px 22px;
							background-repeat: no-repeat;
							.bg-image('erweima_tit');
						}
						.icon-right{
							display: inline-block;
							margin-top: 0.04rem;
							vertical-align: top;
							width: 10px;
							height: 18px;
							background-size: 10px 18px;
							background-repeat: no-repeat;
							.bg-image('card_right');
						}
					}

			}

		}
		.about-me-content{
			margin-top: 0.2rem;
			color: @text-color;
			.content-BT{
				position: relative;
				display: flex;
				padding: 0.35rem 0.29rem;
				background-color: @content-bg-color;
				.balance{
					flex: 1;
					.icon{
						display: inline-block;
						margin: 0.07rem 0.34rem 0.08rem 0;
						vertical-align: top;
						width: 24px;
						height: 24px;
						background-size: 24px 24px;
						background-repeat: no-repeat;
						.bg-image('icon_list_left');
					}
					.balance-content{
						display: inline-block;
						.title{
							margin-bottom: 0.17rem;
							font-size: 0.32rem;
							line-height: 0.25rem;
							color: @text-color;
						}
						.para{
							font-size: 0.24rem;
							line-height: 0.19rem;
							color: @tips-color;
						}
					}
				}
				.transactions{
					flex: 1;
					.icon{
						display: inline-block;
						width: 24px;
						height: 24px;
						vertical-align: top;
						margin: 0.07rem 0.32rem 0.08rem 0.42rem;
						background-size: 24px 24px;
						background-repeat: no-repeat;
						.bg-image('icon_list_right');
					}
					.transactions-content{
						display: inline-block;
						.title{
							font-size: 0.32rem;
							line-height: 0.66rem;
							color: @text-color;
						}
					}

				}
				.devider{
					position: absolute;
					left: 50%;
					top: 0.14rem;
					width: 0;
					height: 1.02rem;
					border-right: 0.04rem solid @default-border-color;
				}
			}
			.desc{
				font-size: 0.3rem;
				line-height: 0.28rem;
				padding: 0.26rem 0.24rem;
			}
			.content-password{
				position: relative;
				padding: 0.28rem 0.3rem;
				background-color: @content-bg-color;
				line-height: 0.56rem;
				.border-1px(@default-border-color);
				.icon{
					display: inline-block;
					width: 19px;
					height: 22px;
					margin: 0 0.44rem 0 0;
					vertical-align: top;
					background-size: 19px 22px;
					background-repeat: no-repeat;
					.bg-image('password');
				}
				.title{
					// display: inline-block;
					font-size: 0.32rem;
				}
				.icon-right{
					position: absolute;
					right: 0.33rem;
					top: 0.36rem;
					width: 10px;
					height: 18px;
					background-size: 10px 18px;
					background-repeat: no-repeat;
					.bg-image('right_list_n');
				}
			}
			.content-payment {
				position: relative;
				padding: 0.28rem 0.3rem;
				background-color: @content-bg-color;
				line-height: 0.56rem;
				&.border{
					.border-1px(@default-border-color);
				}
				.icon{
					display: inline-block;
					width: 24px;
					height: 19px;
					vertical-align: top;
					margin:0.1rem 0.37rem 0 0;
					background-size: 24px 19px;
					background-repeat: no-repeat;
					.bg-image('1-step');
				}
				.title{
					// display: inline-block;
					font-size: 0.32rem;
				}
				.icon-switch{
					position: absolute;
					right: 0.33rem;
					top: 0.37rem;
					width: 42px;
					height: 23px;
					background-size: 42px 23px;
					background-repeat: no-repeat;
					&.open{
						.bg-image('icon_close');
					}
					&.close{
						.bg-image('icon_open');
					}
				}
			}
			.content-limit{
				position: relative;
				padding: 0.28rem 0.3rem;
				background-color: @content-bg-color;
				line-height: 0.56rem;
				.title{
					display: inline-block;
					font-size: 0.32rem;
				}
				.content{
					position: absolute;
					right: 0.92rem;
					top: 0.33rem;
					font-size: 0.32rem;
					// line-height: 0.56rem;
					color: #999;
				}
			}
			.content-settings{
				position: relative;
				padding: 0.28rem 0.3rem;
				background-color: @content-bg-color;
				margin-top: 0.2rem;
				.icon{
					display: inline-block;
					width: 22px;
					height: 22px;
					margin: 0.06rem 0.44rem 0 0;
					vertical-align: top;
					background-size: 22px 22px;
					background-repeat: no-repeat;
					.bg-image('settings');
				}
				.title{
					display: inline-block;
					font-size: 0.32rem;
					line-height: 0.56rem;
				}
				.icon-right{
					position: absolute;
					right: 0.33rem;
					top: 0.36rem;
					width: 10px;
					height: 18px;
					background-size: 10px 18px;
					background-repeat: no-repeat;
					.bg-image('right_list_n');
				}
			}
			.last{
				&:after{
					border: none;
				}
				margin-bottom: 10px;
			}
		}
	}
</style>