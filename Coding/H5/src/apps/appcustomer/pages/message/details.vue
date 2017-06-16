<template>
    <div class="details">
        <div class="details-header">
            <nav-header title="Details"></nav-header>
        </div>
        <div class="details-content-wrapper">
            <div class="details-content">
                <div class="avatar">
                    <img src="~assets/images/common/7-Eleven_2x.png" alt="" width="100%" height="100%">
                </div>
                <div class="merchant-name">7-Eleven</div>
                <div class="amount">-€21.20</div>
                <div class="status">success</div>
            </div>
        </div>
        <ul class="details-list">
            <li class="details-item">
                <span class="name">Time</span>
                <span class="text">20-01-2017 12:33</span>
            </li>
            <li class="details-item">
                <span class="name">Receipt</span>
                <span class="text">2017012000056</span>
            </li>
            <li class="details-item">
                <span class="name">Transcation Type</span>
                <span class="text">Buy goods</span>
            </li>
        </ul>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
    components: {
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.details {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    font-size: 0.36rem;
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
    .details-header {
        .mint-header {
            .border-1px(@default-border-color);
            height: 0.89rem;
            background-color: @content-bg-color;
            color: @text-color;
            .mintui-back{
                font-size: 0.44rem;
            }
            .mint-header-title {
                flex: 5;
                font-size: 0.36rem;
                line-height: 0.9rem;
            }
        }
    }
    .details-content-wrapper {
        margin-top: 0.2rem;
        background-color: @content-bg-color;
        .details-content{
        	width: 4rem;
        	margin: 0.24rem auto 0;
        	padding-bottom: 0.24rem;
        	text-align: center;
        	.avatar{
        		margin: 0 auto;
        		width: 1.34rem;
        		height: 1.34rem;
        	}
        	.merchant-name{
        		padding-top: 0.26rem;
        		font-size: 0.3rem;
        		line-height: 0.23rem;
        		color: @text-color;
        	}
        	.amount{
        		padding-top: 0.32rem;
        		font-size: 0.6rem;
        		line-height: 0.45rem;
        		color: @text-color;
        	}
        	.status{
        		padding-top: 0.2rem;
        		font-size: 0.24rem;
        		line-height: 0.14rem;
        		color: @tips-color;
        	}
        }
    }
    .details-list {
        background-color: @content-bg-color;
        .details-item{
        	padding: 0.38rem 0.24rem;
        	display: flex;
        	justify-content: space-between;
        	.border-1px-top(@default-border-color);
        	.name{
				font-size: 0.3rem;
				line-height: 0.23rem;
				color: @tips-color;
        	}
        	.text{
				font-size: 0.3rem;
				line-height: 0.23rem;
				color: @text-color;
        	}
        }
    }
}
</style>
