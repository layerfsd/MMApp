/* * 注册sign-up * @Date : 2017-03-15 * @Author : wangliang * @Version : V1.0 * */ /** * 注册sign-up各组件的先后顺序 * signup.vue => verfication-code.vue => set-password.vue => personal-information.vue => change-initial-pin.vue => set-new-pin.vue */
<template>
    <div class="sign-up layout">
        <div class="sign-up-header">
            <nav-header :title="title" class="header border-1px"></nav-header>
        </div>
        <div class="content-wrapper">
            <!-- 账号输入框 -->
            <div class="content-div account-content">
                <div class="account">
                    <label for="account" class="account-name">
                        {{$t("label_账号")}}
                    </label>
                </div>
                <div class="input-wrapper">
                    <span class="plus">＋</span><span class="pre-no" ref="preno" @click="showList">{{preNo}}</span><i class="icon-down" @click="showList"></i>
                    <input type="number" id="account" class="content-input account-input" :placeholder="placeholder" @focus="isFoucs=true" v-model="telphone" @keyup="checkFiled($event)">
                </div>
            </div>
            <div class="content-div cornet-content">
                <div class="cornet">
                    <label for="cornet" class="cornet-name">
                        Cornet
                    </label>
                </div>
                <div class="input-wrapper">
                    <input type="number" id="cornet" class="content-input cornet-input" placeholder="" @focus="isFoucs=true" v-model="cornet" @keyup="checkFiled($event)">
                </div>
            </div>
            <!-- 用户（取消） -->
            <!--  <div class="content-div user-content">
                <div class="user">
                    <label for="user" class="user-name">
                        User
                    </label>
                </div>
                <div class="input-wrapper" id="user">
                    <span class="icon-right"></span>
                    <div type="number" class="content-input user-input" v-text="user"></div>
                </div>
                <ul>
                    <li class="user-item">shop owner</li>
                    <li class="user-item"></li>
                </ul>
            </div> -->
            <!-- <router-link to="/signUp/verficationCode"> -->
            <button type="button" :class="{active: !isEmpty}" class="btn" :disabled="this.isEmpty" @click="sendMessage">{{$t("action_下一步")}}</button>
            <!-- </router-link> -->
        </div>
        <overlay v-if="listShow"></overlay>
        <transition name="fold">
            <div v-show="listShow" class="selectList">
                <div class="list-header">
                    <button href="#" class="cancel" @click="cancel">Cancel</button>
                    <button href="#" class="done" @click="done">Done</button>
                </div>
                <!-- <div class="list-content" ref="list-content">
                        <ul>
                            <li v-for="(item, index) in selectLists" class="list-item" :class="{'checked':currentIndex==index}" @click="currentIndex=index">
                                <span class="pre-no">{{item.preNo}}</span>
                                <img class="national-flag" :src="item.image"></img>
                                <span class="country">{{item.country}}</span>
                            </li>
                        </ul>
                        <div class="picker-center-highlight" :style="{ height: itemHeight + 'px', marginTop: -itemHeight / 2 + 'px' }"></div>
                    </div> -->
                <mt-picker :slots="slots" @change="onValuesChange" value-key="preNo" :visibleItemCount="visibleItemCount" class="list-content">
                </mt-picker>
            </div>
        </transition>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import Overlay from '../../../../components/overlay/overlay';
import areaCodeList from '../../config/area-code-list';

export default {
    name: 'signUp',
    data() {
        return {
        	title:this.$t('label_注册标题'),
        	placeholder:this.$t('label_手机号码'),
            telphone: '',
            cornet: '',
            shortcode: '',
            // user: 'shop assistant',
            listShow: false,
            preNo: '',
            originalPreNo: '',
            visibleItemCount: 3,
            slots: [{
                flex: 1,
                name: 'picker',
                values: areaCodeList,
                className: 'slot1',
                textAlign: 'center',
                defaultIndex: 1
            }]
        }
    },
    computed: {
        isEmpty() {
            if(this.telphone && this.cornet){
                return false;
            }
            return true;
        }
    },
    methods: {
        onValuesChange(picker, values) {
            console.log(picker)
            this.preNo = values[0].preNo;
        },

        showList() {
            this.listShow = true;

        },
        cancel() {
            this.preNo = this.originalPreNo;
            this.listShow = false;
        },
        done() {
            this.listShow = false;
            this.originalPreNo = this.preNo;
        },
        checkFiled(event) {
            let val = event.target.value;
            if (val === '') {
                this.isEmpty = true;
            } else if (this.telphone !== '') {
                this.isEmpty = false;
            }
        },
        sendMessage() {
            //发送短信验证码
            this.showIndicator();
            this.serverApi.registerStatus(this.telphone, null,
                (error, data) => {
                    this.hideIndicator();
                    console.log("接口数据：" + JSON.stringify(data));
                    if (error) {
                        this.showToast(error.message);
                        return;
                    } else {
                        //成功
                        this.$store.dispatch('saveUser', {
                            phone: this.telphone
                        });
                        console.log(this.$store.state.signUp.user.phone)
                        if (data.unRegister) {
                            //未注册
                            this.$router.push('/signUp/verficationCode');
                        } else {
                            // 已注册
                            this.showToast('用户已注册')
                            this.$router.replace('/login')
                        }
                    }



                });
            let sendData = {};

        },
        showList() {
            //显示遮罩
            this.listShow = true;

        }
    },
    components: {
        NavHeader,
        Overlay
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.sign-up {
    .sign-up-header {
        .header {
            .border-1px(@border-1px-color);
        }
    }
    .content-wrapper {
        margin-top: 10px;
        overflow: hidden;
        .content-div {
            position: relative;
            display: flex;
            height: 44px;
            border-radius: 0.1rem;
            background-color: @content-bg-color;
            color: @text-color;
            &:last-child {
                .border-none();
            }
            .border-1px(@default-border-color);
            .account,
            .cornet,
            .user {
                flex: 0 0 2.4rem;
                width: 2.4rem;
                line-height: 44px;
            }
            .account-name,
            .cornet-name,
            .user {
                box-sizing: border-box;
                display: inline-block;
                width: 100%;
                padding-left: 0.4rem;
                font-size: @hm-font-size-lg;
            }
            .input-wrapper {
                display: flex;
                flex: 1;
                width: 100%;
                line-height: 44px;
                border: none;
                outline: none;
                background-color: transparent;
                font-size: @hm-font-size-sm;
                .plus {
                    flex: 0 0 0.4rem;
                    width: 0.4rem;
                    padding-right: 0.04rem;
                    font-size: @hm-font-size-lg;
                    vertical-align: top;
                }
                .pre-no {
                    display: inline-block;
                    padding-right: 6px;
                    flex: 0 0 0.4rem;
                    width: 0.4rem;
                    font-size: @hm-font-size-lg;
                    vertical-align: top;
                }
                .icon-down {
                    display: inline-block;
                    margin-top: 18px;
                    flex: 0 0 16px;
                    width: 16px;
                    height: 9px;
                    line-height: 44px;
                    vertical-align: top;
                    background-size: 16px 9px;
                    background-repeat: no-repeat;
                    .bg-image('xiala_n');
                }
            }
            .content-input {
                flex: 1;
                width: 100%;
                border: none;
                outline: none;
                background-color: transparent;
                font-size: @hm-font-size-sm;
                color: @text-color;
            }
            &.account-content {
                .content-input {
                    text-indent: 0.36rem;
                }
            }
            &.user-content {
                .border-none();
                .input-wrapper {
                    position: relative;
                    .icon-right {
                        display: inline-block;
                        position: absolute;
                        top: 13px;
                        right: 12px;
                        width: 10px;
                        height: 18px;
                        background-size: 10px 18px;
                        background-repeat: no-repeat;
                        .bg-image('right_list_n');
                    }
                }
            }
        }
        .btn {
            width: 90%;
            height: 1rem;
            line-height: 1rem;
            background-color: @default-bg-btn-color;
            border: none;
            outline: none;
            border-radius: 0.06rem;
            color: @default-font-btn-color;
            margin: 16px 5% 0;
            font-size: @hm-font-size-base;
            &.active {
                background-color: @active-bg-btn-color;
            }
        }
    }
    .signup-cotent-top {
        margin-top: 20px;
        border-bottom: 1px solid lightgrey;
    }
    .signup-cotent-bottom {
        margin-bottom: 58px;
    }
    .selectList {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        z-index: 1;
        &.fold-enter-active,
        &.fold-leave-active {
            transition: all .5s;
            transform: translate3d(0, 0, 0);
        }
        &.fold-enter,
        &.fold-leave-active {
            transform: translate3d(0, 100%, 0);
        }
        .list-header {
            display: flex;
            justify-content: space-between;
            height: 0.9rem;
            line-height: 0.9rem;
            padding: 0 0.16rem;
            background-color: @layout-bg-color;
            .cancel,
            .done {
                display: inline-block;
                height: 100%;
                color: @link-color;
                font-size: @hm-font-size-sm;
                border: none;
                background: none;
                outline: none;
            }
        }
        .list-content {
            position: relative;
            top: -0.04rem;
            max-height: 2.56rem;
            overflow: hidden;
            background-color: @content-bg-color;
            color: @text-color;
            cursor: pointer;
            .list-item {
                box-sizing: border-box;
                padding: 0.24rem 0 0.24rem 2.12rem;
                .pre-no,
                .national-flag,
                .country {
                    line-height: 0.32rem;
                    font-size: @hm-font-size-base;
                    vertical-align: top;
                }
                .national-flag {
                    display: inline-block;
                    width: 0.48rem;
                    height: 0.36rem;
                    margin: 0 0.24rem 0 0.4rem;
                }
            }
            // .checked{
            //  background-color: #f6f6f6;
            //  border-top: 1px solid #c6c6c6;
            //  border-bottom: 1px solid #c6c6c6;
            // }
            .picker-center-highlight {
                box-sizing: border-box;
                position: absolute;
                left: 0;
                width: 100%;
                height: 0.8rem;
                top: 50%;
                margin-top: -0.36rem;
                pointer-events: none
            }
            .picker-center-highlight:before,
            .picker-center-highlight:after {
                content: '';
                position: absolute;
                height: 1px;
                width: 100%;
                background-color: #c6c6c6;
                display: block;
                z-index: 15;
                transform: scaleY(0.5);
            }
            .picker-center-highlight:before {
                left: 0;
                top: 0;
                bottom: auto;
                right: auto;
            }
            .picker-center-highlight:after {
                left: 0;
                bottom: 0;
                right: auto;
                top: auto;
            }
        }
    }
}
</style>
