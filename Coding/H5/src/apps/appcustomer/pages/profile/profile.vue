<template>
    <div class="profile layout">
        <div class="profile-header">
            <nav-header title="Profile" :rightFunc="rightFunc">
                <div slot="right">
                    <span class="rightText">Save</span>
                </div>
            </nav-header>
        </div>
        <div class="profile-wrapper">
            <div class="protrait item">
                <router-link to="/me/protrait">
                    <div class="label">Protrait</div>
                    <div class="text">
                        <span class="avatar"></span>
                        <i class="icon-right"></i>
                    </div>
                </router-link>
            </div>
            <div class="account item">
                <div class="label">Account</div>
                <div class="text">+40 634 567 923</div>
            </div>
            <div class="name item">
                <div class="label">Name</div>
                <div class="text">Lara Korvik</div>
            </div>
            <div class="QR-code item">
                <router-link to="/me/my-QR-code">
                    <div class="label">Protrait</div>
                    <div class="text">
                        <span class="avatar"></span>
                        <i class="icon-right"></i>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
    methods: {
        rightFunc() {
            console.log('已保存...');
        }
    },
    components: {
        NavHeader
    }
}
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.profile {
    .profile-header {
        .rightText{
            font-size: 0.3rem;
            color: #1249DE;
        }
    }
    .item {
        height: 1rem;
        line-height: 1rem;
        padding: 0 0.24rem;
        background-color: @content-bg-color;
        font-size: 0.34rem;
        color: @text-color;
        .border-1px(@default-border-color);
        &:last-child{
        	.border-none();
        }
        .label{
        	color: @text-color;
        }
        .text {
            color: @tips-color;
        }
    }
    .protrait {
        position: relative;
        margin-top: 0.2rem;
        height: 1.3rem;
        line-height: 1.3rem;

        .text {
            position: absolute;
            right: 0.24rem;
            top: 0.2rem;
            .avatar {
                display: inline-block;
                width: 45px;
                height: 45px;
                margin-right: 0.24rem;
                background-size: 45px 45px;
                background-repeat: no-repeat;
                .bg-image('tx');
            }
            .icon-right {
                display: inline-block;
                width: 10px;
                height: 18px;
                background-size: 10px 18px;
                background-repeat: no-repeat;
                margin-bottom: 0.26rem;
                .bg-image('right_list_n');
            }
        }
    }
    .account,
    .name {
        display: flex;
        .label {
            flex: 1;
        }
    }
    .QR-code {
        .text {
            position: absolute;
            // height: 0.44rem;
            line-height: 1rem;
            right: 0.24rem;
            top: 0;
            .avatar {
                display: inline-block;
                width: 22px;
                height: 22px;
                margin: 0.28rem 0.24rem 0 0;
                vertical-align: top;
                background-size: 22px 22px;
                background-repeat: no-repeat;
                .bg-image('erweima_list_right');
            }
            .icon-right {
                display: inline-block;
                width: 10px;
                height: 18px;
                margin-top: 0.32rem;
                vertical-align: top;
                background-size: 10px 18px;
                background-repeat: no-repeat;
                .bg-image('right_list_n');
            }
        }
    }
}
</style>
