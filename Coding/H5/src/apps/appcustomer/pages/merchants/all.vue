<template>
    <div class="all layout">
        <div class="all-header com-mint-header">
            <mt-header title="All" fixed>
                <router-link to="/home" slot="left">
                    <mt-button icon="back"></mt-button>
                </router-link>
                <!-- <mt-button icon="more" slot="right"></mt-button> -->
            </mt-header>
        </div>
        <div class="all-search">
            <mt-search v-model="value" cancel-text="Cancel" placeholder="search" @click="isSearch=true">
            </mt-search>
        </div>
        <div class="all-title">
        	Cooperation with the Merchants
        </div>
        <ul class="merchants-list">
        	<li class="merchant-item" v-for="(item,index) in merchants">
        		<router-link :to="item.path">
	                <div class="avatar">
	                    <img :src="item.src" alt="" width="100%" height="100%" :id="item.title">
	                </div>
	                <label :for="item.title">
	                    <p class="title">{{item.title}}</p>
	                    <p class="desc"> {{item.desc}}</p>
	                </label>
        		</router-link>
            </li>
        </ul>
    </div>
</template>
<script>
export default {
	data() {
		return {
			merchants: [
				{
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Transfer',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Pay bill',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Pay bill',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Transfer',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Go Dutch',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_2x.png'),
                    title: 'Top Up',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }]
		}
	}
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.all {
    .all-search {
        .mint-search {
            height: auto;
            .mint-searchbar {
                padding: 0.14rem 0.25rem;
                background-color: @content-bg-color;
                .mint-searchbar-inner {
                    .mintui-search {
                        position: relative;
                        &::before {
                            position: absolute;
                            color: #A2A2A2;
                            left: 0.04rem;
                            top: -0.14rem;
                        }
                    }
                }
                .mint-searchbar-core {
                    display: inline-block;
                    width: 100%;
                    height: 100%;
                    line-height: 1;
                    background-color: #F2EFF0;
                    border-radius: 0.06rem;
                    font-size: 0.22rem;
                    color: #A2A2A2;
                    text-indent: 0.30rem;
                }
            }
        }
    }
	.all-title{
		padding: 0.26rem 0.24rem;
		font-size: 0.3rem;
		line-height: 0.28rem;
		color: @tips-color;
	}
	.merchants-list {
        // display: flex;
        // flex-wrap: wrap;
        padding: 0.16rem 0 0.58rem 0;
        background-color: @content-bg-color;
        li {
            // flex: 1;
            // flex-basis: 25%;
            display: inline-block;
            text-align: center;
            padding-top: 0.31rem;
            .avatar {
                display: inline-block;
                width: 0.9rem;
                height: 0.9rem;
                padding: 0 0.4675rem;
            }
            img {
                display: inline-block;
                border-radius: 50%;
                border: none;
            }
            .title {
                padding: 0.17rem 0 0.09rem 0;
                font-size: 0.28rem;
                line-height: 0.21rem;
                color: @text-color;
            }
            .desc {
                font-size: 0.22rem;
                line-height: 0.21rem;
                color: @tips-color;
            }
        }
    }
}
</style>
