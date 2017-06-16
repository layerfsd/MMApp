<template>
	<div class="cell-no-pic">
		<div class="cell-no-pic-wrapper border-1px">
			<div class="label" :style="labelStyle">{{label}}</div>
            <div class="text" :style="textStyle">{{text}}</div>
		</div>
	</div>
</template>
<script>
	export default {
		props: {
			label: {
				type: String
			},
			text: {
				type: String
			},
			labelStyle: {
				type: {
					Object
				}
			},
			textStyle:{
				type:{
					Object
				}
			}
		}
	};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
	.cell-no-pic{
		.cell-no-pic-wrapper{
			display: flex;
			height: 50px;
	        line-height: 50px;
	        padding: 0 0.24rem;
	        background-color: @content-bg-color;
	        font-size: @hm-font-size-base;
	        color: @text-color;
	        .border-1px(@default-border-color);
	        .label{
	        	flex: 1;
	        	color: @text-color;
	        }
	        .text {
	            color: @tips-color;
	        }
		}
	}
</style>