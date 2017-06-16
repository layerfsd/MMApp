/*
* 注册sign-up
* @Date : 2017-03-15
* @Author : wangliang
* @Version : V1.0
*
*/
/** * 注册sign-up各组件的先后顺序 * signup.vue => verfication-code.vue => set-password.vue => personal-information.vue => change-initial-pin.vue => set-new-pin.vue */
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
                    <span class="plus">＋</span><span class="pre-no" ref="preno" @click="">58</span>
                    <!-- <i class="icon-down" @click=""></i> -->
                    <input-primary :isRequired="true" :placeholder="placeholder" @getValue="getValue" :label="'account'"></input-primary>
                </div>
            </div>
            <input-label :label="$t('label_短号')" @getMessage="getMessage"  :isRequired="true"></input-label>
            <button type="button" :class="{'active': !isEmpty}" class="btn" :disabled="this.isEmpty" @click="sendMessage">{{$t("action_下一步")}}</button>
        </div>
        <overlay v-if="listShow"></overlay>
        <transition name="fold">
            <div v-show="listShow" class="selectList">
                <div class="list-header">
                    <button href="#" class="cancel" @click="cancel">Cancel</button>
                    <button href="#" class="done" @click="done">Done</button>
                </div>
                <mt-picker :slots="slots" @change="onValuesChange" value-key="preNo" :visibleItemCount="visibleItemCount" class="list-content">
                </mt-picker>
            </div>
        </transition>
    </div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import overlay from '../../../../components/overlay/overlay';
import inputPrimary from '../../../../components/input/input-primary';
import inputLabel from '../../../../components/input/input-label';
import configInfo from '../../config/index';
export default {
    name: 'signUp',
    data() {
        return {
        	title:this.$t('label_注册标题'), //注册标题
        	placeholder:this.$t('label_手机号码'), //提示语
            phone: '', //手机号
            cornet: '', //短号
            listShow: false, //是否显示区号列表
            preNo: '', //区号
            originalPreNo: '', //原始号
            visibleItemCount: 3, //picker组件显示条目数
            slots: [{
                flex: 1,
                name: 'picker',
                values: configInfo.phoneCountryCodes,
                className: 'slot1',
                textAlign: 'center',
                defaultIndex: 1
            }]//picker组件所需数据
        }
    },
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'signUp');

    },
    created(){

    },
    beforeMount() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    activated() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    deactivated() {

    },
    computed: {
        isEmpty() {
            if(this.phone && this.cornet){
                return false;
            }
            return true;
        }
    },
    methods: {
        // picker组件提供方法
        onValuesChange(picker, values) {
            this.preNo = values[0].preNo;
        },
        // 显示区号列表
        showList() {
            this.listShow = true;
        },
        // 取消
        cancel() {
            this.preNo = this.originalPreNo;
            this.listShow = false;
        },
        // 完成
        done() {
            this.listShow = false;
            this.originalPreNo = this.preNo;
        },
        // 接收子组件消息
        getMessage(msg) {
            this.cornet = msg;
        },
        getValue(value) {
            this.phone = value;
        },
        // 下一步
        sendMessage() {
            //发送短信验证码
            this.showIndicator();
            this.serverApi.registerStatus({
                phone: this.phone,
                shortCode: this.cornet
            }, null,
                (error, data) => {
                    this.hideIndicator();
                    if (error) {
                        this.showToast(error.message);
                        return;
                    } else {
                        //成功
                        this.$store.dispatch('saveUser', {phone:this.phone,shortCode: this.cornet});
                        console.log('存入手机号：' + this.$store.state.user.phone);
                        if (data.unRegister) {
                            console.log("this.phone="+this.phone);
                            //未注册
                            this.$router.push({
                                path: '/signUp/verficationCode',
                                query: {
                                    phone: this.phone
                                }
                            });
                        } else {
                            // 已注册
                            this.showToast('用户已注册')
                            setTimeout(() => {
                                this.$router.replace('/login')
                            }, 2000);
                        }
                    }

            });

        }
    },
    components: {
        navHeader,
        overlay,
        inputLabel,
        inputPrimary
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
            height: 50px;
            border-radius: 0.1rem;
            background-color: @content-bg-color;
            color: @text-color;
            &:last-child {
                .border-none();
            }
            .border-1px(@default-border-color);
            .account {
                flex: 0 0 2.4rem;
                width: 2.4rem;
                line-height: 50px;
            }
            .account-name{
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
                line-height: 50px;
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
                    line-height: 50px;
                    vertical-align: top;
                    background-size: 16px 9px;
                    background-repeat: no-repeat;
                    .bg-image('xiala_n');
                }
            }
        }
        .btn {
           margin-top: 0.86rem;
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
