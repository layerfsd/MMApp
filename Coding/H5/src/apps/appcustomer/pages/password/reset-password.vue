<template>
    <div class="reset-password layout">
        <nav-header title="Password"></nav-header>
        <!-- 重置PIN -->
        <router-link to="/resetPinPassword">
            <div class="reset-pin-password">
                <span class="name">Reset PIN Password</span>
                <span class="icon-right"></span>
            </div>
        </router-link>
        <!-- 重置登录密码 -->
        <router-link to="/resetLoginPassword">
            <div class="reset-login-password">
                <span class="name">Reset Login Password</span>
                <span class="icon-right"></span>
            </div>
        </router-link>
        <!-- 重置密保问题 -->
        <router-link to="/resetLoginPassword">
            <div class="reset-login-password">
                <span class="name">Reset Security</span>
                <span class="icon-right"></span>
            </div>
        </router-link>
        <!-- 手势密码开关 -->
        <div class="gesture-password">
            <span class="name">Gesture Password</span>
            <span class="icon-switch" :class="{open:!value,close:value}" @click="value=!value"></span>
        </div>
        <!-- 更改手势密码 -->
        <div class="change-gesture-password" v-show="value">
            <span class="name">Gesture Password</span>
            <span class="icon-right"></span>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
    data() {
            return {
                openEye: false,
                value: false
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
.reset-password {
    .reset-pin-password,.reset-login-password,.change-gesture-password{
        position: relative;
        padding: 0 0.24rem;
        height: 1rem;
        line-height: 1rem;
        background-color: @content-bg-color;
        color: @text-color;
        font-size: @font-17px;
        .icon-right{
            position: absolute;
            display: inline-block;
            width: 0.16rem;
            height: 0.28rem;
            right: 0.24rem;
            top: 0.36rem;
            background-size: 0.16rem 0.28rem;
            background-repeat: no-repeat;
            .bg-image('right_list_n');
        }
    }
    .reset-pin-password{
        margin-top: 0.2rem;
        .border-1px(@default-border-color);
    }
    .reset-login-password{
        .border-1px(@default-border-color);
    }
    .change-gesture-password{
        .border-1px-top(@default-border-color);
    }
    .gesture-password {
        position: relative;
        margin-top: 0.2rem;
        padding: 0.38rem 0.24rem;
        background-color: @content-bg-color;
        box-sizing: border-box;
        .name {
            display: inline-block;
            width: 100%;
            height: 100%;
            color: @text-color;
            font-size: @font-17px;
        }
        .switch {
            position: absolute;
            right: 0.24rem;
            top: 0.18rem;
        }
        .icon-switch {
            position: absolute;
            right: 0.33rem;
            top: 0.32rem;
            width: 42px;
            height: 23px;
            background-size: 42px 23px;
            background-repeat: no-repeat;
            &.open {
                .bg-image('icon_close');
            }
            &.close {
                .bg-image('icon_open');
            }
        }
    }
    .input-text .input-wrapper .name {
        font-size: 0.32rem;
    }
}
</style>
