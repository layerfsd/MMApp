<template>
    <div class="message">
        <div class="message-header">
            <nav-header title="Message"></nav-header>
        </div>
        <ul class="message-list">
            <router-link to="/message/speeding">
    			<li class="message-item">
    				<div class="avatar">
    					<img src="~assets/images/common/icon_list_right_2x.png" alt="" width="100%" height="100%">
    				</div>
    				<div class="content">
    					<div class="title">Trading reminders</div>
    					<div class="description">Spending €20.00</div>
    					<div class="time">
    						<span class="text">14:20</span>
    						<span class="icon"></span>
    					</div>
    				</div>
    			</li>
            </router-link>
            <router-link to="/message/system">
    			<li class="message-item">
    				<div class="avatar">
    					<img src="~assets/images/common/icon_list_right_2x.png" alt="" width="100%" height="100%">
    				</div>
    				<div class="content">
    					<div class="title">Trading reminders</div>
    					<div class="description">Spending €20.00</div>
    					<div class="time">
    						<span class="text">14:20</span>
    						<span class="icon" v-show="unread"></span>
    					</div>
    				</div>
    			</li>
            </router-link>
        </ul>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header'
export default {
	data() {
		return {
			unread: true
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
.message {
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
    .message-header {
        .mint-header {
            .border-1px(@default-border-color);
            height: 0.89rem;
            background-color: @content-bg-color;
            color: @text-color;
            .mintui-back{
                font-size: 0.5rem;
                // font-weight: bold;
            }
            .mint-header-title {
                flex: 5;
                font-size: 0.36rem;
                line-height: 0.9rem;
            }
        }
    }
    .message-list {
        margin-top: 0.2rem;
        background-color: @content-bg-color;
        .message-item{
    		position: relative;
        	padding: 0.3rem 0.24rem;
        	.border-1px(@default-border-color);
        	.avatar{
        		display: inline-block;
        		width: 0.5rem;
        		height: 0.48rem;
        		vertical-align: top;
        	}
        	.content{
        		display: inline-block;
        		margin-left: 0.4rem;
        		.title{
        			font-size: 0.32rem;
        			line-height: 0.32rem;
        			color: @text-color;
        		}
        		.description{
        			padding-top: 0.16rem;
        			font-size: 0.24rem;
        			line-height: 0.24rem;
        			color: @tips-color;
        		}
        		.time{
        			position: absolute;
        			right: 0.62rem;
        			top: 0.3rem;
        			font-size: 0.24rem;
        			line-height: 0.24rem;
        			color: @tips-color;
        			.text{
        				display: inline-block;
        				padding: 0.06rem 0.12rem 0 0;
        			}
        			.icon{
        				position: absolute;
        				top: -0.16rem;
        				right: -0.28rem;
        				width: 0.16rem;
        				height: 0.16rem;
        				background-color: #f00;
        				border-radius: 50%;

        			}
        		}

        	}
        }
    }
}
</style>
