/**
 * AA付款-待支付-选择 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="choose">
        <nav-header title="Go Dutch" :showRight="false"></nav-header>
		
		<div class="scroll" >
		<div class="items" @click="received">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		<div class="items">
			<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
			<p class="money">€10.00 to be paid</p><p class="date">18-04-2017 14:36</p>
		</div>
		
		</div>
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
	export default {
		name:'choose',
		components: {
			transferHeader,
			NavHeader
		},
		data() {
			return {
				isEmpty: true,
				amount:'',
				seen:false,
				scan:false,
				title:"Go Dutch"
			}
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'choose');
    	},
		methods:{
			received(){
				this.$router.push({
					path: '/go-dutch/choose-received'
				});
			}
			
		}
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.choose{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
	
		.scroll{
			overflow: auto;
			padding-bottom: 50px;
			/*模拟原生弹性滚动效果*/
			-webkit-overflow-scrolling: touch;
		}
		.items{
			/*height: 1.3rem;*/
			padding: 12px;	
			font-size: @hm-font-size-sm;
			background-color: @content-bg-color;
			margin-top: 10px;
			position: relative;
			.cor-name{
				display: inline-flex;
	    		width: 3.5rem;
	    		text-align: right;
	    		color: #8E8E8E;
			}
			.user-name{
		        display: inline-block;
	    		width: 3.2rem;
	    		text-align: right;
	    		color: #2d2d2d;
			    /*position: absolute;
			    right: 0;
			    margin-right: .5rem;*/
			}
			.money{
				display: inline-flex;
	    		width: 3.5rem;
	    		text-align: right;
			    margin-top: 10px;
			    color: #2d2d2d;
			}
			.date{
				display: inline-block;
	    		width: 3.2rem;
	    		text-align: right;
			    margin-top: 10px;
				color: #8E8E8E;
				font-size: @hm-font-size-xs;
			    position: absolute;
			    right: 0;
			    margin-right: .5rem;
			}
		}
	}
	
</style>




