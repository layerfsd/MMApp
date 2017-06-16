<template>
	<div class="about-me">
		<div class="about-me-header">
			<mt-header title="Me" class="background"></mt-header>
			<div class="header-content-wrapper">
				<div class="avatar">
					<img src="../../assets/images/logo.png" alt="" width="52" height="52">
				</div>
				<div class="header-content">
					<div class="name">Lara Korvik</div>
					<div class="tel">134****2392</div>
				</div>
				<div class="QR-code">
					<span class="code"></span>
					<i class="icon-right"></i>
				</div>
			</div>
		</div>
		<div class="about-me-content">
			<div class="content-BT">
				<div class="balance">
					<div class="icon"></div>
					<div class="balance-content">
						<div class="title">Balance</div>
						<div class="para">$29000.00</div>
					</div>
				</div>
				<div class="transactions">
					<div class="icon"></div>
					<div class="transactions-content">
						<div class="title">Transactions</div>
					</div>
				</div>
			</div>
			<p class="desc">Acount and Security</p>
			<div class="content-password content-item">
				<span class="icon"></span>
				<span class="title">Password</span>
				<i class="icon-right"></i>
			</div>
			<div class="content-payment content-item">
				<span class="icon"></span>
				<span class="title">1-Step-Payment</span>
				<i class="icon-right"></i>
			</div>
			<div class="content-limit content-item last">
				<span class="title">Limit</span>
				<span class="content">$500789796.00/pay</span>
				<i class="icon-right"></i>
			</div>
			<div class="content-settings content-item">
				<span class="icon"></span>
				<span class="title">Settings</span>
				<i class="icon-right"></i>
			</div>
		</div>
	</div>
</template>
<script>
	export default {};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.css');
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
			.background{
				background-color: #db0f42;
			}
			.header-content-wrapper{
					position: relative;
					padding: 8px 12px 12px 12px;
				    background: -webkit-linear-gradient(top,@theme-bg-begin-color 0,@theme-bg-end-color 100%);
					.avatar{
						display: inline-block;
						width: 52px;
						height: 52px;
						vertical-align: top;
						img{
							border-radius: 50%;
						}
					}
					.header-content{
						display: inline-block;
						margin: 10px 0 11px 0;
						.name,.tel{
							padding-left: 18px;
						}
						.name{
							margin-bottom: 10px;
						}

					}
					.QR-code{
						position: absolute;
						right: 12px;
						top: 18px;
						.code{
							display: inline-block;
							width: 22px;
							height: 22px;
							margin-right: 12px;
							vertical-align: top;
							background-size: 22px 22px;
							background-repeat: no-repeat;
							// background-image: url();
						}
						.icon-right{
							display: inline-block;
							margin-top: 4px;
						}
					}

			}

		}
		.about-me-content{
			margin-top: 10px;
			.content-BT{
				display: flex;
				padding: 18px 12px;
				background-color: @content-bg-color;
				.balance{
					flex: 1;
					.icon{
						display: inline-block;
						width: 24px;
						height: 24px;
						vertical-align: top;
						margin: 4px 10px 4px 2px;
					}
					.balance-content{
						display: inline-block;
						.title{
							margin-bottom: 8px;
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
						margin: 4px 10px 4px 2px;
					}
					.transactions-content{
						display: inline-block;
						.title{
							margin-top: 9px;
						}
					}

				}
			}
			.desc{
				height: 40px;
				line-height: 40px;
				padding: 0 12px;
			}
			.content-item{
				position: relative;
				height: 50px;
				line-height: 50px;
				padding: 0 12px;
				background-color: @content-bg-color;
				.border-1px(@default-border-color);
				.icon{
					display: inline-block;
					width: 24px;
					height: 24px;
					vertical-align: top;
					margin: 13px 10px 4px 2px;
				}
				.icon-right,.content{
					position: absolute;
					right: 12px;
					top: 18px;
					color: @text-color;
				}
				.content{
					right: 45px;
					top: 0;
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