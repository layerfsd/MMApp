/**
 * 钱包-过滤筛选页面
 * @author 徐伟辉(1506487526@qq.com)
 * 
 * 
 */
<template>
	<div class="fliters-wrapper">
		<nav-header title="Fliters" :leftFunc='fToTransactions'>
        </nav-header>
        <div class="fliter-content-top">
        	<ul>
        		<li>Type</li>
        		<li>
        			<span>Inflow</span>
					<router-link to='/outflow' slot="right">
        				<span>Outflow</span>
        			</router-link>
        		</li>
        	</ul>
        </div>
        <div class="fliter-content-bottom">
        	<ul>
        		<li>Time</li>
        		<li>
        			<span>This week</span>
        			<span>This month</span>
        			<span>Nearly three months</span>
        		</li>
        		<li>
        			<span @click="open('picker')">{{message}}</span>
        			<span><img src="~assets/images/common/line_3x.png"/></span>
        			<span @click="open('picker2')">{{message2}}</span>
        		</li>
        	</ul>
        </div>
         <mt-datetime-picker
	      ref="picker"
	      type="date"
	      cancelText="Cancel"
	      confirmText="Confirm"
	      v-model="value"
	      @confirm="handleChange">
	    </mt-datetime-picker>
	    <mt-datetime-picker
	      ref="picker2"
	      type="date"
	      cancelText="Cancel"
	      confirmText="Confirm"
	      v-model="value2"
	      @confirm="handleChange2">
	    </mt-datetime-picker>
        <div class="fliters-footer">
        	<mt-button type="danger">Next</mt-button>
        </div>
	</div>
</template>
<script>
	import Vue from 'vue';
	import NavHeader from '../../../../components/header/nav-header';
	import { DatetimePicker,Toast } from 'mint-ui';
	Vue.component(DatetimePicker.name, DatetimePicker);
	
	export default{
		 name:"fliters",
		 data() {
	      return {
	      	message:'Start',
	      	message2:'Finish',
	        value: '',
	        value2: '',
	        visible: false,
	        visible2: false
	      }
	    },
		components: {
	   		NavHeader
	   	},
	   	beforeCreate(){
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'fliters');
	    },
	    beforeMount: function () {
	        console.log("fliters, beforeMount");
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleLight();
	        }
	    },
	    activated: function () {
	        console.log("fliters, activated");
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleLight();
	        }
	    },
	    deactivated: function () {
	        console.log("fliters, deactivated");
	    },
	    beforeUpdate: function () {
	        console.log("fliters, beforeUpdate");
	    },
	   	methods:{
	   		fToTransactions(){
	   			this.$router.push('/transactions');
   			},
   			open(picker) {
	        	this.$refs[picker].open();
	      	},
	      	handleChange(value) {
	      		var that = this.value;
	      		var a = that.toString();
	      		var thatValue = a.substring(0,15);
	      		this.message = thatValue;
		    },
		    handleChange2(value2) {
	      		var that = this.value2;
	      		var b = that.toString();
	      		var thatValue = b.substring(0,15);
	      		this.message2 = thatValue;
		    }
	   	}
	}
	
</script>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
	.fliters-wrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background: #f8f8f8;
		/*font-size: 0.36rem;*/
	}
	.fliter-content-top{
		/*height: 1.72rem;*/
		height: 86px;
		border-top: 1px solid lightgrey;
		border-bottom: 1px solid lightgrey;
	}
	.fliter-content-top li:nth-child(1){
		/*height: 0.6rem;
		line-height: 0.6rem;*/
		height: 30px;
		line-height: 30px;
		color: @tips-color;
		/*font-size: 0.3rem;*/	
		font-size: @hm-font-size-sm;
		margin-left: 0.24rem;
	}
	.fliter-content-top li:nth-child(2) span{
		display: block;
		float: left;
		width: 2rem;
		/*height: 0.76rem;
		line-height: 0.76rem;*/
		height: 38px;
		line-height: 38px;
		text-align: center;
		background: @theme-font-color;
		font-size: 16px;
		color: @text-color;
		border: 1px solid lightgrey;
		border-radius: 4px;
	}
	.fliter-content-top li:nth-child(2) span:nth-child(1){
		margin-left: 0.24rem;
	}
	.fliter-content-top li:nth-child(2) span:nth-child(2){
		margin-left: 0.1rem;
	}
	.fliter-content-bottom{
		/*height: 2.7rem;*/
		height: 135px;
	}
	.fliter-content-bottom li:nth-child(1){
		/*height: 0.6rem;
		line-height: 0.6rem;*/
		height: 30px;
		line-height: 30px;
		color: @tips-color;
		/*font-size: 0.3rem;*/	
		font-size: @hm-font-size-sm;
		margin-left: 0.24rem;
	}
	.fliter-content-bottom li:nth-child(2){
		/*height: 0.8rem;*/
		height: 40px;
	}
	.fliter-content-bottom li:nth-child(3){
		/*margin-top: 0.35rem;
		height: 0.74rem;*/
		margin-top: 17.5px;
		height: 37px;
		display: flex;
	}
	.fliter-content-bottom li:nth-child(2) span{
		display: block;
		/*height: 0.76rem;
		line-height: 0.76rem;*/
		height: 38px;
		line-height: 38px;
		text-align: center;
		background: @theme-font-color;
		/*font-size: 0.24rem;*/
		font-size: @hm-font-size-sm;
		color: @text-color;
		border: 1px solid lightgrey;
		border-radius: 4px;
		float: left;
	}
	.fliter-content-bottom li:nth-child(2) span:nth-child(1){
		width: 1.78rem;
		margin-left: 0.24rem;
	}
	.fliter-content-bottom li:nth-child(2) span:nth-child(2){
		width: 1.78rem;
		margin-left: 0.18rem;
	}
	.fliter-content-bottom li:nth-child(2) span:nth-child(3){
		width: 3.02rem;
		margin-left: 0.18rem;
	}
	.fliter-content-bottom li:nth-child(3) span:nth-child(1),span:nth-child(3){
		display: block;
		width: 2.96rem;
		/*height: 0.72rem;
		line-height: 0.72rem;*/
		height: 36px;
		line-height: 36px;
		text-align: center;
		background: @theme-font-color;
		font-size: @hm-font-size-sm;
		color: @tips-color;
		border: 1px solid lightgrey;
		border-radius: 4px;
	}
	.fliter-content-bottom li:nth-child(3) span:nth-child(1){
		float: left;
		margin-left: 0.24rem;
		flex: 1;
	}
	.fliter-content-bottom li:nth-child(3) span:nth-child(2){
		float: left;
		width: 1rem;
		/*height: 0.74rem;
		line-height: 0.74rem;*/
		height: 37px;
		line-height: 37px;
		text-align: center;
	}
	.fliter-content-bottom li:nth-child(3) span:nth-child(2) img{
		vertical-align: middle;
		/*width: 0.4rem;
		height: 0.04rem;*/
		width: 20px;
		height: 2px;
	}
	/*.fliter-content-bottom li:nth-child(3) span:nth-child(2) i{
		width:0.4rem;
		height: 0.04rem;
		background: #999999;
	}*/
	.fliter-content-bottom li:nth-child(3) span:nth-child(3){
		float: right;
		margin-right: 0.24rem;
		flex: 1;
	}
	.fliters-footer{
		text-align: center;
	}
	.fliters-footer .mint-button--normal, .mint-button--small{
		/*padding: 0 2.9rem;*/
		width: 90%;
		/*margin-top: 0.83rem;*/
		margin-top: 42px;
	}
</style>
