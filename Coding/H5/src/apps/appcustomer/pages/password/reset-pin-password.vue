<template>
	<div class="reset-pin-password">
		<nav-header title="Reset Pin Password"></nav-header>
		<div class="initial-info">
			<span class="text">Enter Original Pin</span>
		</div>
		<div class="input-wrapper">
			<input-control class="input-padding" :count="count" @getChange.once="compare"></input-control>
		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputControl from '../../components/input/input-control';
	export default {
		data() {
			return {
				count: 4
			}
		},
		methods: {
			compare(value) {
	            const SUCCESS = '1'; //验证通过
	            this.showIndicator();
	            this.serverApi.checkVerificationCode({
	                phone: 123,
	                verificationCodeType: 2,
	                verificationCode: value
	            }, (error, data) => {
	                this.hideIndicator();
	                this.$router.push('/resetNewPin');
	            })
	    	}
		},
		components: {
			NavHeader,
			inputControl
		}
	};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
	.reset-pin-password{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
		// margin-top: 0.2rem;
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
		.initial-info{
			height: 0.7rem;
			padding: 0 0.24rem;
			line-height: 0.7rem;
			font-size: @font-15px;
			color: @text-color;
		}
		.input-wrapper{
			padding: 0.2rem 0.24rem;
			background-color: @content-bg-color;
			.show-wrapper{
				.show-item{
					margin-right: 0.46rem;
					&:last-child{
						margin-right: none;
					}
				}
			}
		}
		.tips{
			height: 0.7rem;
			margin: 0 0.24rem;
			line-height: 0.7rem;
			text-align: right;
			.tel{
				padding-left: 0.08rem;
			}
			.time{
				color: #e04c64;
			}
		}
	}
</style>