<template>
    <div class="my-QR-code layout">
        <div class="code-header">
            <nav-header title="My QR Code"></nav-header>
        </div>
        <div class="code-content">
            <div class="code-wrapper">
            	<div class="avatar">
            		<img src="~assets/images/common/home_tx_2x.png" alt="" width="100%" height="100%">
            	</div>
            	<div class="name">Lara Korvik</div>
            	<div class="description">Scan and Add friends to me</div>
            	<div class="QR-code">
            		<img src="~assets/images/common/erweima_tit_n_2x.png" alt="" width="100%" height="100%">
            	</div>
            </div>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
	methods: {
		back() {
			this.$router.back();
		}
	},
    components: {
        NavHeader
    }

};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.my-QR-code {
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
    .code-header {
        .mint-header {
            .border-1px(#eee);
            height: 0.89rem;
            color: @text-color;
            background-color: @content-bg-color;
            .mint-header-title {
            	flex: 5;
                font-size: 0.36rem;
                line-height: 0.9rem;
                color: @text-color;
            }
            .mint-button-text{
            	font-size: 0.3rem;
            	color: #1249DE;
            }
        }
    }
    .code-content{
        overflow: auto;
        .code-wrapper{
        	position: relative;
        	width: 6.3rem;
        	margin: 1.48rem auto 0;
        	background-color: @content-bg-color;
        	border: 1px solid @default-border-color;
    		.avatar{
    			position: absolute;
    			left: 50%;
    			top: -0.65rem;
    			// margin-left: -0.65rem;
                transform: translate3d(-50%, 0 ,0);
    			width: 1.3rem;
    			height: 1.3rem;
    			border-radius: 50%;
    		}
    		.name{
    			margin: 1rem auto 0.32rem;
    			text-align: center;
    			font-size: 0.3rem;
    			line-height: 0.23rem;
    			color: @text-color;
    		}
    		.description{
    			margin: 0 auto;
    			text-align: center;
    			font-size: 0.36rem;
    			line-height: 0.28rem;
    			color: @text-color;
    		}
    		.QR-code{
    			margin: 1.25rem auto 1.32rem;
    			width: 3.6rem;
    			height: 3.6rem;
    		}
        }
    }
}
</style>
