<template>
	<div class="reset-password">
		<nav-header title="Password"></nav-header>
		<input-text :openEye="openEye" text1="Reset PIN Password" text2="Reset Login Password"></input-text>
		<div class="gesture-password">
			<span class="name">Gesture Password</span>
			<mt-switch v-model="value" class="switch" @click="!value"></mt-switch>
		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputText from '../../components/input/input-text';
	export default {
		data() {
			return {
				openEye: false,
				value: true
			}
		},
		components: {
			NavHeader,
			inputText
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.reset-password{
		.gesture-password{
			position: relative;
			margin-top: 0.2rem;
			.name{
				display: inline-block;
				padding: 0 0.24rem;
				width: 100%;
				height: 1rem;
				line-height: 1rem;
				background-color: @content-bg-color;
				color: #3a3a3a;
				font-size: 0.32rem;
			}
			.switch{
				position: absolute;
				right: 0.24rem;
				top: 0.18rem;
			}
			.mint-switch-core{
				border-color: #e6e6e6;
			}
			.mint-switch-core::before {
			    background-color: #e6e6e6;
			}
		}
		.input-text .input-wrapper .name{
			font-size: 0.32rem;
		}
	}
</style>
