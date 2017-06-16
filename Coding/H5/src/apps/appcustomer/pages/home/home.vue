/**
 * home 主页
 * @author 王亮
 *
 *
 */
<template>
    <div class="home">
        <div class="home-header" v-bind:class="{ 'top-status': this.$root.supportTranslucentStatus}">
            <div class="home-header-wrapper">
                <div class="avatar">
                    <router-link to="me/profile">
                        <img src="~assets/images/common/home_tx_3x.png" alt="" width="100%" height="100%">
                    </router-link>
                </div>
                <div class="cash-wallet">
                    <h3 class="title">
                    	<router-link to='/cash-wallet/cash' slot="right">
                            Cash Wallet
                        </router-link>
                    </h3>
                    <div class="wallet-wrapper">
                        <span class="text" >{{money}}</span>
                        <i class="icon-eyes" @click="toggleEye" :class="{open:isOpen,close:!isOpen}"></i>
                    </div>
                </div>
                <router-link to="/message">
                    <div class="alarm"></div>
                </router-link>
            </div>
        </div>
        <div class="home-content">
            <div class="QR-pay-scan">
                <div class="QR-pay">
                    <router-link to="/my-qr-code">
                        <div class="avatar" id="QR-pay">
                            <img src="~assets/images/common/QR_n_3x.png" alt="" width="100%" height="100%" id="QR-pay">
                        </div>
                        <label for="QR-pay">
                            <p class="desc">QR Pay</p>
                        </label>
                    </router-link>
                </div>
                <div class="scan">
                    <div class="avatar">
                        <img src="~assets/images/common/scan_3x.png" alt="" width="100%" height="100%" id="scan">
                    </div>
                    <label for="scan">
                        <p class="desc">Scan</p>
                    </label>
                </div>
            </div>
            <ul class="menubar">
                <li :id="item.desc" v-for="item in menuList">
                    <router-link :to="item.path" tag="div">
                        <div class="avatar">
                            <img :src="item.src" alt="" width="100%" height="100%" :id="item.desc">
                        </div>
                        <label :for="item.desc">
                            <p class="desc">{{item.desc}}</p>
                        </label>
                    </router-link>
                </li>
                <!-- <li>
    				<div class="avatar" id="go-doutch">
    					<img :src="item.src" alt="" width="100%" height="100%" :id="item.desc">
    				</div>
    				<label for="go-doutch">
    					<p class="desc">Go Dutch</p>
    				</label>
    			</li>
    			<li>
    				<div class="avatar" id="top-up">
    					<img :src="item.src" alt="" width="100%" height="100%" :id="item.desc">
    				</div>
    				<label for="top-up">
    					<p class="desc">Top Up</p>
    				</label>
    			</li>
    			<li>
    				<div class="avatar" id="pay-bill">
    					<img :src="item.src" alt="" width="100%" height="100%" :id="item.desc">
    				</div>
    				<label for="pay-bill">
    					<p class="desc">Pay bill</p>
    				</label>
    			</li> -->
            </ul>
            <p class="merchants-desc">Cooperation with Merchants</p>
            <ul class="merchants-list">
                <li class="item" v-for="(item,index) in filterMerchants">
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
    </div>
</template>
<script>
export default {
    name: 'home',
    data() {
            return {
            	money: '€ 2,900.00',
                isOpen: true,
                menuList: [{
                    src: require('../../../../assets/images/common/Transfer_h_3x.png'),
                    desc: 'Transfer',
                    path: '/transfer/transfer'
                }, {
                    src: require('../../../../assets/images/common/Go-Dutch_h_3x.png'),
                    desc: 'Go Dutch',
                    path: '/go-dutch/go-dutch'

                }, {
                    src: require('../../../../assets/images/common/Top-Up_h_3x.png'),
                    desc: 'Top Up',
                    path: '/top-up'
                }, {
                    src: require('../../../../assets/images/common/Pay-bill_h_3x.png'),
                    desc: 'Pay bill',
                    path: '/pay-bill-no-history'
                }],
               merchants: [
                {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Transfer',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Pay bill',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Pay bill',
                    desc: '',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Transfer',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }, {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Go Dutch',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                },
                {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Go Dutch',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                },
                 {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Go Dutch',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                },
                 {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Go Dutch',
                    desc: '',
                    path: '/merchants/id=7'
                },
                {
                    src: require('../../../../assets/images/common/7-Eleven_3x.png'),
                    title: 'Top Up',
                    desc: 'xxxxxx',
                    path: '/merchants/id=7'
                }]
            }
        },
        computed: {
            filterMerchants() {
                let result = [];
                if (this.merchants.length >= 8) {
                    result = this.merchants.slice(0, 7)
                    result.push({
                        src: require('../../../../assets/images/common/all_h_3x.png'),
                        title: 'All',
                        desc: '',
                        path: '/merchants/all'
                    });
                } else {
                    result = this.merchants;
                }
                return result;
            }
        },
        //创建之前
        beforeCreate(){
            //添加到缓冲机制中
            this.$store.dispatch('pushKeepAlive', 'home');
        },
        activated: function () {
            //设置沉浸式状态栏
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleLight();
            }
        },
        methods: {
            toggleEye() {
            	let tempValue = '€ 2,900.00';
                this.isOpen = !this.isOpen;
                if(!this.isOpen){
                	this.money = '******';
                }else{
                	this.money = tempValue;
                }
            }
        }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.home {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    overflow: scroll;
    padding-bottom: 1rem;
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
    .top-status {
        padding-top: 40px !important;
    }
    .home-header {
        padding: 20px 20px 20px 20px;
        background: -webkit-linear-gradient(top, @theme-bg-begin-color 0, @theme-bg-end-color 100%);
        font-size: 0;
        .home-header-wrapper{
            position: relative;
            // padding: 0.35rem 0.34rem 0.32rem 0.33rem;
            .avatar {
                display: inline-block;
                width: 0.82rem;
                height: 0.82rem;
                vertical-align: top;
                border-radius: 50%;
            }
            .cash-wallet {
                margin-top: 0.35rem;
                color: #fff;
                .title {
                    font-size: 0.30rem;
                    line-height: 0.23rem;
                    a{
                        color: @theme-font-color;
                    }
                }
                .wallet-wrapper {
                    padding-top: 0.21rem;
                    position: relative;
                    .text {
                        font-size: 0.6rem;
                        line-height: 0.55rem;
                    }
                    .icon-eyes {
                        position: absolute;
                        right: 0;
                        top: 0.29rem;
                        width: 24px;
                        height: 15px;
                        background-size: 24px 15px;
                        background-repeat: no-repeat;
                        &.open {
                            .bg-image('open_eyes');
                        }
                        &.close {
                            .bg-image('close_eyes');
                        }
                    }
                }
            }
            .alarm {
                position: absolute;
                top: 0.41rem;
                right: 0;
                width: 15px;
                height: 18px;
                background-size: 15px 18px;
                background-repeat: no-repeat;
                transform: translate3d(0,-50%,0);
                .bg-image('message_h');
            }
        }
    }
    .home-content{
        overflow: scroll;
        .QR-pay-scan {
            display: flex;
            text-align: center;
            padding-top: 0.19rem;
            background-color: @content-bg-color;
            font-size: 0;
            .QR-pay {
                flex: 1;
                .avatar {
                    display: inline-block;
                    width: 1.46rem;
                    height: 1.46rem;
                }
                .desc {
                    font-size: 0.3rem;
                    line-height: 0.28rem;
                    padding: 0 0 0.24rem 0;
                    color: #39BBD2;
                }
            }
            .scan {
                flex: 1;
                .avatar {
                    display: inline-block;
                    width: 1.46rem;
                    height: 1.46rem;
                }
                .desc {
                    font-size: 0.3rem;
                    line-height: 0.28rem;
                    padding: 0 0 0.24rem 0;
                    color: #8265EB;
                }
            }
        }
        .menubar {
            display: flex;
            flex-wrap: wrap;
            margin-top: 0.28rem;
            background-color: @content-bg-color;
            li {
                flex: 1 0 25%;
                font-size: 0;
                display: inline-block;
                text-align: center;
                padding-top: 0.28rem;
                .avatar {
                    display: inline-block;
                    width: 0.79rem;
                    height: 0.79rem;
                    border-radius: 50%;
                }
                .desc {
                    font-size: 0.3rem;
                    line-height: 0.23rem;
                    padding: 0.20rem 0 0.3rem 0;
                    color: @text-color;
                }
            }
        }
        .merchants-desc {
            font-size: 0.3rem;
            line-height: 0.28rem;
            padding: 0.26rem 0.2rem 0.26rem 0.2rem;
            color: @tips-color;
        }
        .merchants-list {
            display: flex;
            flex-wrap: wrap;
            padding: 0.18rem 0 0 0;
            margin-bottom: 0.32rem;
            background-color: @content-bg-color;
            li {
                flex: 1 0 25%;
                display: inline-block;
                text-align: center;
                padding: 0.3rem 0 0.18rem;
                vertical-align: top;
                font-size: 0;
                .avatar {
                    display: inline-block;
                    width: 0.9rem;
                    height: 0.9rem;
                }
                img {
                    display: inline-block;
                    border-radius: 50%;
                    border: none;
                }
                .title {
                    padding: 0.16rem 0 0.08rem 0;
                    font-size: 0.28rem;
                    line-height: 0.21rem;
                    color: @text-color;
                }
                .desc {
                    font-size: 0.22rem;
                    line-height: 0.2rem;
                    color: @tips-color;
                }
            }
        }
    }
}
</style>
