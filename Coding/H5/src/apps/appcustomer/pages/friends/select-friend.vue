<template>
    <div class="select-friend">
        <div class="select-friend-header">
            <mt-header title="Select Friend" class="friend-header">
                <router-link to="/" slot="left">
                    <mt-button icon="back"></mt-button>
                </router-link>
                <mt-button icon="scan" slot="right"></mt-button>
            </mt-header>
        </div>
        <div class="select-friend-content">
            <select-friend></select-friend>
        </div>
    </div>
</template>
<script>
import SelectFriend from '../../components/friends/select-friend';
export default {
    data() {
        return {
            isSearch: false
        }
    },
    components: {
    	SelectFriend
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.select-friend{
    background-color: @layout-bg-color;
    .friend-header {
        height: 0.9rem;
        line-height: 0.9rem;
        background-color: @content-bg-color;
        .mint-header-title {
            font-size: 0.36rem;
            color: @text-color;
        }
        .mintui-scan {
            display: inline-block;
            width: 24px;
            height: 21px;
            background-size: 24px 21px;
            background-repeat: no-repeat;
            .bg-image('nav_sys_n');
        }
    }
    .select-friend-content{
        padding-bottom: 1rem;
        overflow: auto;
    }
}
</style>
