<template>
    <div class="my-account">
        <div class="my-account-header" :class="{ 'top-status': this.$root.supportTranslucentStatus}">
            <div class="my-account-header-top">
                <router-link to="/myAccount/income" class="item" active-class="active">Income</router-link>
                <router-link to="/myAccount/speeding" class="item" active-class="active">Spending</router-link>
                <router-link to="/myAccount/fixed" class="item" active-class="active">Fixed</router-link>
            </div>
        </div>
        <router-view class="router-view"></router-view>
    </div>
</template>
<script>
export default {
    name: 'myAccount',
    //创建之前
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'myAccount');
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
            this.$root.setStatusStyleLight();
        }
    },
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.my-account {
    .my-account-header {
        background: -webkit-linear-gradient(top, @theme-bg-begin-color 0, @theme-bg-end-color 100%);
        color: @theme-font-color;
        .my-account-header-top {
            display: flex;
            margin: 14px auto;
            width: 80%;
            height: 30px;
            line-height: 30px;
            border: 1px solid @bg-btn-color;
            border-radius: 3px;
            font-size: 0;
            .item {
                flex: 1;
                text-align: center;
                font-size: @hm-font-size-xs;
                border-right: 1px solid @bg-btn-color;
                color: @theme-font-color;
                &:last-child {
                    border-right: none;
                }
                &.active {
                    background-color: #fff;
                    color: @theme-text-color;
                }
            }
        }
    }
    .router-view {
        position: fixed;
        top: 60px;
        bottom: 50px;
        width: 100%;
    }
}
</style>
