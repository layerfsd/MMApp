<template>
	<div class="scanCardWrapper">
		<nav-header :title="title" ></nav-header>
		<div class="scanBottom" @click="enterAccount">
			<img src="~assets/images/common/Electric1_3x.png"/>
		</div>
		<p class="scanBottomP">Enter social security card number</p>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	export default{
		data(){
			return{
				title:"Social security card"
			}
		},
		methods:{
			enterAccount(){
				this.$router.push("enterAccount");
			}
		},
		components:{
			navHeader
		}
	}
	
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.scanCardWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
	}
	.scanBottom{
		position: absolute;
		bottom: 50px;
		left: 44%;
	}
	.scanBottomP{
		text-align: center;
		position: absolute;
		bottom: 0;
	}
</style>