/**
 * AA付款-历史页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="history">
		<nav-header class="history-header" :showLeft="false" :showRight="false">
        	<div slot="left">
	            <img src="~assets/images/common/nav_left_n_2x.png" alt='' /> 
            </div>
            <div slot="center" class="history-tit">
	            <div class="me" :class="{selectme:isselectMe}" @click="selectMe">From me</div>
	            <div class="friend" :class="{selectf:isselectF}" @click="selectF">From My friend</div>
            </div>
        </nav-header>
        
		<div class="history-me" v-if="historyMe">
			<div class="items" @click="details">
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
		
		<div class="history-friend" v-if="historyFriend">
			<div class="items">
				<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
				<p class="money">€10.00 to be paid</p><p class="date">xx</p>
			</div>
			<div class="items">
				<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
				<p class="money">€10.00 to be paid</p><p class="date">xx</p>
			</div>
			<div class="items">
				<p class="cor-name">Lunch in KFC</p><p class="user-name">From Candy</p>
				<p class="money">€10.00 to be paid</p><p class="date">xx</p>
			</div>
		</div>
		
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'history',
		components:{
			NavHeader
		},
		
		data() {
			return {
				isselectMe:true,
				isselectF:false,
				historyMe:true,
				historyFriend:false
			}
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'history');
    	},
		methods:{
			details(){
				this.$router.push({
					path: '/go-dutch/history-details'
				});
			},
			
			selectMe(){
				if(this.isselectMe==false){
					this.isselectMe=true;
					this.isselectF=false;
					this.historyMe=true;
					this.historyFriend=false;
				}
			},
			selectF(){
				if(this.isselectF==false){
					this.isselectF=true;
					this.isselectMe=false;
					this.historyMe=false;
					this.historyFriend=true;
				}
			}
		}
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.history{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color:@layout-bg-color;
	
	.history-me{
		overflow: auto;
		padding-bottom: 50px;
		/*模拟原生弹性滚动效果*/
		-webkit-overflow-scrolling: touch;
	}
	.history-friend{
		overflow: auto;
		padding-bottom: 50px;
		/*模拟原生弹性滚动效果*/
		-webkit-overflow-scrolling: touch;
	}
	
	.history-tit{
		height:30px;
		display: inline-block;
		.me{
		    width: 2rem;
		    height: 25px;
		    margin-top: 6px;
		    line-height: 25px;
		    float: left;
		    font-size: @hm-font-size-xxs;
		    border-top-left-radius: 8px;
		    border-bottom-left-radius: 8px;
		    border: 1px solid #DB1B43;
		    color: #DB1B43;
		    background-size: cover;
			&.selectme{
				background-image: url(~assets/images/common/nav_title_left1.png);
				color: @active-font-btn-color; 
			}
		}
		.friend{
			width: 2rem;
		    height: 25px;
		    margin-top: 6px;
		    line-height: 25px;
		    float: left;
		    font-size: @hm-font-size-xxs;
			border-top-right-radius: 8px;
			border-bottom-right-radius: 8px;
			border: 1px solid #DB1B43;
			color: #DB1B43;
			background-size: cover;
			&.selectf{
				background-image: url(~assets/images/common/nav_title_right1.png);
				color: @active-font-btn-color;
			}
		}
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




