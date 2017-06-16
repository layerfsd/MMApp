/** * home 主页 * @author 王亮 * * */
<template>
    <div class="home">
        <div class="home-header" :class="{ 'top-status': this.$root.supportTranslucentStatus}">
            <div class="home-header-wrapper">
                <div class="avatar">
                    <router-link to="">
                        <img :src="merchantLogo" alt="" width="100%" height="100%">
                    </router-link>
                </div>
                <div class="cash-wallet">
                    <h3 class="title">
                        <router-link to="" slot="right">
                            {{$t('info_收入')}}
                        </router-link>
                    </h3>
                    <div class="wallet-wrapper">
                        <span class="currency">{{currency | formatCurrency}} </span>
                        <span class="text">{{income | formatMoney}}</span>
                        <span class="date">{{currentDate}}</span>
                    </div>
                </div>
                <router-link to="">
                    <div class="alarm">
                        <span class="newMessage" v-show="haveNewMessage"></span>
                    </div>
                </router-link>
            </div>
        </div>
        <div class="home-content">
            <ul class="menubar">
                <li :id="item.desc" v-for="item in menuList" v-show="item.isShow">
                    <router-link :to="item.path" tag="div">
                        <div class="avatar">
                            <img :src="item.src" alt="" width="100%" height="100%" :id="item.desc">
                        </div>
                        <label :for="item.desc">
                            <p class="desc">{{item.desc}}</p>
                        </label>
                    </router-link>
                </li>
            </ul>
        </div>
    </div>
</template>
<script>
import {getCurrentDate} from '../../assets/js/common/util';
import {mapState} from 'vuex';
export default {
    name: 'home',
    data() {
        return {
            // merchantLogo: '', //商户logo头像
            income: '0',
            currency: '', //币种
            cardPayFlag: false,
            withdrawFlag: false,
            activationFlag: false,
            newsFlag: false,
            changePINFlag: false,
            registeredFlag: false,
            myAccountFlag: false,
            settingsFlag: false,
            isCardPay: false,
            isActivation: false,
            currentDate: '',
            haveNewMessage: false,
            menuList: [{
                src: require('../../../../assets/images/merchant/card_pay_3x.png'),
                desc: this.$t('action_卡支付'),
                path: '/scanCard'
            }, {
                src: require('../../../../assets/images/merchant/withdraw_3x.png'),
                desc: this.$t('action_取现'),
                path: '/withdraw'

            }, {
                src: require('../../../../assets/images/merchant/activation_3x.png'),
                desc: this.$t('action_激活'),
                path: '/activation'
            }, {
                src: require('../../../../assets/images/merchant/change_pin_3x.png'),
                desc: this.$t('action_修改支付密码'),
                path: '/changePin/change-pin'
            }, {
                src: require('../../../../assets/images/merchant/registered_3x.png'),
                desc: this.$t('action_认征'),
                path: '/operatorManagement'
            }]
        }
    },
    computed: mapState({
        merchantLogo: state => state.user.merchantLogo
    }),
    //创建之前
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'home');
    },
    created() {
        // 获取系统当前时间
        this.currentDate = getCurrentDate();
        // 为menuList添加isShow属性
        this.menuList.forEach((item, index) => {
            if (typeof item.isShow === 'undefined') {
                this.$set(item, 'isShow', false);
            }
        });

    },
    beforeMount() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    // 请求数据
    mounted() {
        this.showIndicator();
        this.serverApi.homeInfo(null, {
            returnToPage: '/home'
        }, (error, data, wentLogin) => {
            this.hideIndicator();
            if (wentLogin) {
                return;
            }
            if (error) {
                this.showToast(error.message);
                return;
            }
            // this.merchantLogo = data.headPortrait;
            // 将头像存在store
            this.$store.dispatch('saveUser', {merchantLogo: data.headPortrait})
            this.income = data.income;
            this.currency = data.currency;
            this.cardPayFlag = data.cardPayFlag;
            this.withdrawFlag = data.withdrawFlag;
            this.activationFlag = data.activationFlag;
            this.newsFlag = data.newsFlag;
            this.changePINFlag = data.changePINFlag;
            this.registeredFlag = data.registeredFlag;
            this.myAccountFlag = data.myAccountFlag;
            this.settingsFlag = data.settingsFlag;
            this.isCardPay = data.isCardPay;
            this.isActivation = data.isActivation;
            this.haveNewMessage = data.haveNewMessage;

            let ret = [this.cardPayFlag, this.withdrawFlag, this.activationFlag, this.changePINFlag, this.registeredFlag];
            this.menuList.forEach((item, index) => {
                item.isShow = ret[index];
            });

        });
    },
    activated() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleLight();
        }
    },
    methods: {}
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
        .home-header-wrapper {
            position: relative;
            // padding: 0.35rem 0.34rem 0.32rem 0.33rem;
            .avatar {
                display: inline-block;
                width: 0.82rem;
                height: 0.82rem;
                vertical-align: top;
                border-radius: 50%;
                img{
                    border: 1px solid transparent;
                    border-radius: 50%;
                }
            }
            .cash-wallet {
                margin-top: 0.35rem;
                color: #fff;
                .title {
                    font-size: 0.30rem;
                    line-height: 0.23rem;
                    a {
                        color: @theme-font-color;
                    }
                }
                .wallet-wrapper {
                    padding-top: 10px;
                    position: relative;
                    .currency{
                        font-size: @hm-font-size-base;
                    }
                    .text {
                        font-size: 0.6rem;
                        line-height: 0.55rem;
                    }
                    .date {
                        position: absolute;
                        right: 0;
                        top: 16px;
                        height: 15px;
                        line-height: 15px;
                        font-size: @hm-font-size-xxs;
                        letter-spacing: 1px;
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
                transform: translate3d(0, -50%, 0);
                .bg-image('message_h');
                .newMessage{
                    position: absolute;
                    top: 0;
                    right: 0;
                    width: 5px;
                    height: 5px;
                    border: 1px solid transparent;
                    border-radius: 50%;
                    background-color: #f00;
                }
            }
        }
    }
    .home-content {
        overflow: auto;
        .menubar {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin-top: 10px;
            padding: 29px 0 4px;
            background-color: @content-bg-color;
            font-size: 0;
            li {
                flex: 0 0 33.33%;
                width: 33.33%;
                font-size: 0;
                display: inline-block;
                text-align: center;
                padding-bottom: 21px;
                .avatar {
                    display: inline-block;
                    width: 50px;
                    height: 50px;
                    border: 1px solid #eee;
                    border-radius: 50%;
                }
                .desc {
                    font-size: @hm-font-size-sm;
                    line-height: 1;
                    padding-top: 10px;
                    color: @text-color;
                }
            }
        }
    }
}
</style>
