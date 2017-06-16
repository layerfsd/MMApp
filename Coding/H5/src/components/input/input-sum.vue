/**
 * 金额输入组件
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="input-sum">
		<div class="set-amount-input">
			<p>{{$t('label_总数')}}</p>
			<span>€</span>
			<input type="text" :value="value" placeholder="0.00" @keyup="checkFiled($event)" @focus="isFoucs=true" />
		</div>
	</div>
</template>
<script>
	
	export default {
		data() {
			return {
				isEmpty: true,
				value:''
			}
		},
	    activated() {
        	this.isEmpty=true;
        	this.value='';
	    },
		methods:{
			checkFiled(event) {
				this.value = event.target.value;
				if(this.value === ''){
					this.isEmpty = true;
				}else{
					this.isEmpty = false;
				}
				this.$emit('isEnter',{
					isEmpty: this.isEmpty,
					value:this.value
				});
			},
			
		},
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.input-sum{
		.set-amount-input{
			height: 90px;
			background-color: #f9f9f9;
		}
		.set-amount-input p{
			font-size: @hm-font-size-sm;
			color: @text-color;	
			padding-top: 15px;
			margin-left: .3rem;
		}
		.set-amount-input span{
			font-size: @hm-font-size-xxl;
			color: @text-color;	
			padding-top: 10px;
			margin-left: .3rem;
		}
		.set-amount-input input{ 
			font-size: @hm-font-size-xxl;
			color: @text-color;	
			padding-top: 10px;
		    max-width: 85%;
			background-color: #F9F9F9;
		}
		
	}
</style>