/**
 * top-up 充值
 * @author 王亮
 *
 *
 */
<template>
    <div class="top-up">
        <!-- <sign-up-header title="Mobile Top Up"></sign-up-header> -->
        <!-- <nav-header title="Mobile Top Up"></nav-header> -->
        <div class="top-up-header com-mint-header">
            <mt-header title="Mobile Top Up" fixed>
                <router-link to="" slot="left">
                    <mt-button icon="back" @click="back"></mt-button>
                </router-link>
                <!-- <mt-button icon="more" slot="right"></mt-button> -->
            </mt-header>
        </div>
        <div class="content-wrapper">
            <div class="tel-wrapper border-1px">
                <div class="description">Linked mobile number(Paris Vodafone)</div>
                <div class="tel">
                    <input type="number" v-model="tel" class="text" :value="tel | formatTel(tel)">
                    <span class="icon"></span>
                </div>
            </div>
            <ul class="price-list">
                <li class="price-item" v-for="item in 4" @click="pay">
                    <div class="price">€30</div>
                    <div class="discount">Price€29.9</div>
                </li>
            </ul>
            <!-- handling charge 手续费 -->
            <div class="handling-charge">€2.00 fee</div>
        </div>
        <dialog-pwd :show="isShow" :name="'top-up'"></dialog-pwd>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import DialogPwd from '../../components/message-box/dialog-pwd';
export default {
    data() {
        return {
            tel: '13544284627',
            isShow: false,
            text: ''
        }
    },
    filters: {
        formatTel(value) {
            if (value && value.length === 11) {
                return value.substr(0, 3) + ' ' + value.substr(3, 4) + ' ' + value.substr(7, 4);
            }
        }
    },
    mounted() {
        this.$nextTick(() => {
            this.$on('listen-child-msg', (msg) => {
                this.isShow = msg;
            })
            this.$on('listen-password', (msg) => {
                this.text = msg;
                if(this.text === '1234'){
                    this.$router.push('/top-up/detail');
                }else{
                    alert('密码错误')
                    this.isShow = false;
                }
            })
        });
    },
    methods: {
        // formatTel(value) {
        //        if (value && value.length === 11) {
        //            return value.substr(0, 3) + ' ' + value.substr(3, 4) + ' ' + value.substr(7, 4);
        //        }
        //    }
        back() {
            this.$router.back();
        },
        pay() {
            this.isShow = true;
        },
     },
    components: {
        NavHeader,
        DialogPwd
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.top-up {
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
    .content-wrapper {
        padding: 0.44rem 0.3rem;
        background-color: @content-bg-color;
        overflow: hidden;
        .tel-wrapper {
            .border-1px(@default-border-color);
            .description {
                font-size: 0.24rem;
                line-height: 0.24rem;
                color: @text-color;
            }
            .tel {
                position: relative;
                padding: 0.44rem 0;
                .text {
                    font-size: 0.6rem;
                    line-height: 0.46rem;
                }
                .icon {
                    position: absolute;
                    right: 0.16rem;
                    bottom: 0.52rem;
                    display: inline-block;
                    width: 24px;
                    height: 26px;
                    background-size: 24px 26px;
                    background-repeat: no-repeat;
                    .bg-image('phone_h');
                }
            }
        }
        .price-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 0.6rem;
            // width: 7.50rem;
            // overflow: hidden;
            .price-item {
                display: inline-block;
                flex: 0 0 2rem;
                width: 2rem;
                height: 1.2rem;
                // border: 1px solid #DB1B43;
                .border(#DB1B43);
                border-radius: 0.04rem;
                margin-bottom:0.40rem;
                text-align: center;
                .price {
                    margin: 0.3rem auto 0.16rem;
                    font-size: 0.36rem;
                    line-height: 0.28rem;
                    color: #DB1B43;
                }
                .discount {
                    font-size: 0.24rem;
                    line-height: 0.19rem;
                    color: @text-color;
                }
            }
        }
        .handling-charge {
            margin-top: 0.05rem;
            font-size: 0.24rem;
            line-height: 0.19rem;
            color: #1B82D1;
            text-align: right
        }
    }
}
</style>
