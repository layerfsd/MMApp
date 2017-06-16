<template>
	<div class="reset-new-pin">
		<nav-header title="Reset Pin Password"></nav-header>
		<input-text text1="New Pin" text2="Comfirm Pin" @input-completed="inputCompleted"></input-text>
		<mt-button type="default"  :class="{'active':active}" class="btn" :disabled="!active" @click="submit">Submit</mt-button>
		<p class="tips">PIN for your payment,please remenber!</p>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputText from '../../components/input/input-text';
	export default {
		data() {
			return {
				active: false,
				password: '',
				passwordConfirm: ''
			}
		},
		computed: {
		    active: function () {
		    	return this.password.length > 0 && this.passwordConfirm.length > 0;
		  	}
		},
		components: {
			NavHeader,
			inputText
		},
		methods: {
			inputCompleted(msg) {
				this.active = msg.checked;
				this.password =msg.password;
			},
			submit() {
				// this.showIndicator();
				this.$router.replace('/resetPassword')
			}
		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
	.reset-new-pin{
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
		.btn{
			width: 90%;
			height: 1rem;
			line-height: 1rem;
			background-color: @default-bg-btn-color;
			color: @default-font-btn-color;
			margin: 1.08rem 5% 0 5%;
			&.active{
				background-color: rgb(248, 0, 65);
			}
		}
		.tips{
			margin: 0.24rem 0.24rem 0;
			text-align: center;
			color: @tips-color;
			font-size: 0.24rem;
		}
	}
</style>