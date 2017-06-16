/**
 * 朋友 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="friend">
		<!--header问题暂无法解决-->
		<div class="friend-header-back">
			<img @click="back" src="~assets/images/common/nav_left_h_2x.png"/>
		</div>
		<div class="friend-head">
			

		</div>
		
		<div class="friend-content">
			<div class="tx">
				<img src="~assets/images/common/tx_2x.png"/>
			</div>
			<p>Mary</p>
			<div class="btn">
				<mt-button type="danger">Transfer</mt-button>
				<mt-button type="danger" plain>Top Up</mt-button>
			</div>
			<mt-cell class="cell1" title="Alipay account" value="13163281031"></mt-cell>
			<mt-cell title="Real name" value="Mary Berong"></mt-cell>
		</div>

			  
		
	</div>
	
</template>
<script>
	export default {
		components: {
			transferHeader
		},
		data() {
			return {
				isEmpty: true,
				imgs:"~assets/images/common/tx1_2x.png"
			}
		},
		methods:{
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			},
			back(){
				this.$router.back();

					
                //设置返回标志，在动画里面处理
                this.$store.dispatch('setPageAnimationBack', true);
			}
			
		}

	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.friend{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #F8F8F8;
	
		.friend-head{
			height: 4rem;
			background: url(~assets/images/common/merchant-7-Eleven.png);
			-webkit-filter: blur(.05rem);
		    z-index: 1;
		}
		.friend-header-back{
			height: .9rem;
			background-color: #333;
			img{
			    margin-top: .1rem;
    			margin-left: .2rem;
			}
		}
		.friend-content{
			background-color: #FFF;
			z-index: 2;
		    text-align: center;
			.tx img{
				width: 1.8rem;
			    height: 1.8rem;
			    /*position: absolute;
		        margin: -.9rem 2.85rem;*/
		        margin-top: -1rem;
			}
			p{
			    font-size: .36rem;
			    margin-top: 1.05rem;
			    color: #333;
			    text-align: center;	
			}
			.btn button{
			    margin: .64rem .3rem .92rem;
			}
		}
		.mint-button--danger{
			height: .7rem;
			width: 2.8rem;
			
		}
		.cell1 .mint-cell-wrapper{
			background-image: none;
		}
		.mint-cell-wrapper{
			background-origin: initial;
			
			padding-left: .28rem;
		}
		.mint-cell{
			display: inline;
		}
		.mint-cell-text {
		    vertical-align: middle;
		    font-size: .32rem;
		    color: #999;
		}
		.mint-cell-value {
	    	color: #333;
	    	font-size: .32rem;
		    width: 4rem;
	    }
    }
</style>