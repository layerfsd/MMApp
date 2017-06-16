<template>
    <div class="friends">
        <div class="friends-header">
            <nav-header title="Friends" :showLeft="false"></nav-header>
        </div>
        <div class="friends-content">
            <select-friend></select-friend>
        </div>
    </div>
</template>
<script>
import SelectFriend from '../../components/friends/select-friend';
import NavHeader from '../../../../components/header/nav-header';
export default {
    data() {
        return {
            isSearch: false
        }
    },
    components: {
    	SelectFriend,
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.friends{
    position: absolute;
    left: 0;
    bottom: 1rem;
    overflow: hidden;
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
            .bg-image('nav_sys_n');
        }
    }
    .friends-content{
        position: fixed;
        top: 1.4rem;
        bottom: 1rem;
        width:100%;
    }
}
</style>
