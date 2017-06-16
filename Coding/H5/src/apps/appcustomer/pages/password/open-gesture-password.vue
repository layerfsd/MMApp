<template>
	<div class="open-gesture-password">
		<nav-header title="Set Gesture Password"></nav-header>
		<div class="initial-info">
			<span class="text">Enter Login Password</span>
		</div>
		<div class="input-wrapper">
			<input-control class="input-padding" :count="6"></input-control>
		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputControl from '../../components/input/input-control';
	export default {
		components: {
			NavHeader,
			inputControl
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.open-gesture-password{
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
		.initial-info{
			height: 0.7rem;
			margin: 0 0.24rem;
			line-height: 0.7rem;
		}
		.input-wrapper{
			padding: 0 0.24rem;
			background-color: @content-bg-color;
			.input-padding{
				padding: 0.1rem; 0;
			}
		}
	}
</style>