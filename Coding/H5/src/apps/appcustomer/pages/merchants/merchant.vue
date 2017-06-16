<template>
    <div class="merchant layout">
    	<div class="merchant-header com-mint-header">
            <!-- <mt-header title="" fixed>
                <router-link to="" slot="left">
                    <mt-button icon="back" @click="back"></mt-button>
                </router-link>
            </mt-header> -->
            <nav-header title=""></nav-header>
        </div>
        <div class="merchant-content">
            <div class="avatar">
                <img src="~assets/images/common/merchant-7-Eleven.png" alt="" width="100%" height="100%">
            </div>
            <div class="merchant-name">
                <div class="name">7-Eleven</div>
                <div class="description">The convenience store</div>
                <div class="score">
                	<star :score="score"></star>
                </div>
            </div>
            <div class="item near-store">
                <span class="icon-left"></span>
                <span class="name">Nearly Store</span>
                <span class="icon-right"></span>
            </div>
            <div class="item tel">
                <span class="icon-left"></span>
                <span class="name">040-87563422</span>
            </div>
            <div class="information">
                <div class="icon-left"></div>
                <div class="name">Preferential information</div>
                <div class="desc">Using mobile money to
                    <span class="pay"> pay the full 100 minus 8</span>
                </div>
            </div>
            <div class="submit">
                <button class="btn" @click="pay">QR Pay</button>
            </div>
        </div>
    </div>
</template>
<script>
import star from '../../components/star/star';
import NavHeader from '../../../../components/header/nav-header';
export default {
	data() {
		return {
			score: 3
		}
	},
	methods: {
		back() {
			this.$router.back();
		},
        pay() {
            this.$router.push({
                path: '/my-qr-code'
            });
        }
	},
	components: {
		star,
        NavHeader
	}
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.merchant {
	.mint-header{
		background-color: rgba(0, 0, 0, 0.8);
		color: @theme-font-color;
	}
    .merchant-content {
        padding-bottom: 1rem;
        overflow: auto;
    	background-color: @content-bg-color;
        .avatar{
            width: 100%;
            height: 5rem;
        }
    	.merchant-name{
    		position: relative;
    		padding: 0.4rem 0.24rem 0.34rem;
    		.border-1px(@default-border-color);
    		.name{
    			font-size: 0.36rem;
    			line-height: 0.28rem;
    			color: @text-color;
    		}
    		.description{
    			padding-top: 0.18rem;
    			font-size: 0.24rem;
    			line-height: 0.2rem;
    			color: @text-color;
    		}
    		.score{
    			position: absolute;
    			right: 0.36rem;
    			top: 0.3rem;
    		}
    	}
    }
    .item{
    	padding: 0.3rem 0.36rem;
    	.border-1px(@default-border-color);
    }
    .near-store{
    	position: relative;
    	.icon-left{
    		margin-right: 0.48rem;
	    	display: inline-block;
	    	width: 14px;
	    	height: 21px;
            background-size: 14px 21px;
            background-repeat: no-repeat;
	    	vertical-align: middle;
	    	.bg-image('map');
    	}
    	.name{
    		font-size: 0.32rem;
    		line-height: 0.32rem;
    		color: @text-color;
    	}
    	.icon-right{
    		position: absolute;
			top: 0.32rem;
			right: 0.24rem;
			width: 10px;
			height: 18px;
            background-size: 10px;
            background-repeat: 18px;
			.bg-image('right_list_n');
    	}
    }
    .tel{
    	.icon-left{
    		margin-right: 0.48rem;
    		display: inline-block;
    		width: 15px;
    		height: 19px;
            background-size: 15px 19px;
            background-repeat: no-repeat;
    		vertical-align: middle;
    		.bg-image('phone');
    	}
    	.name{
    		font-size: 0.32rem;
    		line-height: 0.32rem;
    		color: @text-color;
    	}
    }
    .information{
    	position: relative;
    	padding: 0.3rem 0.36rem;
    	.icon-left{
    		position: absolute;
    		left: 0.36rem;
    		top: 0.3rem;
    		width: 20px;
	    	height: 18px;
            background-size: 20px 18px;
            background-repeat: no-repeat;
	    	vertical-align: middle;
	    	.bg-image('sale');
    	}
    	.name,.desc{
    		padding-left: 0.80rem;
    		font-size: 0.32rem;
    		line-height: 0.32rem;
    		color: @text-color;
    	}
    	.desc{
    		padding-top: 0.42rem;
    		.pay{
    			font-size: 0.36rem;
    			line-height: 0.36rem;
    			color: #DB1B43;
    		}
    	}

    }
    .submit{
    	margin: 0.55rem auto 0;
    	width: 6.5rem;
    	height: 1.02rem;
    	.btn{
    		width: 100%;
    		height: 100%;
    		border: none;
    		background-color: #DD153F;
    		border-radius: 0.06rem;
    		font-size: 0.32rem;
    		line-height: 1;
    		color: @theme-font-color;
    	}
    }
}
</style>
