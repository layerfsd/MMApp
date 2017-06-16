<template>
    <div class="profile layout">
        <div class="profile-header">
            <nav-header :title="$t('label_介绍')">
                <!-- <div slot="right">
                    <span class="rightText">{{$t('action_保存')}}</span>
                </div> -->
            </nav-header>
        </div>
        <div class="profile-wrapper">
            <cell :title="$t('label_头像')" :to="'/protrait'" :src="headPortrait" :rightStyle="{width: '45px', height: '45px', right: '36px', top: '10px',border:'1px solid #eee', 'border-radius': '50%'}" :rootStyle="{height: '65px','line-height': '65px'}" :linkStyle="{top:'24px'}" :titleStyle="{position: 'relative', top: '8px'}"></cell>
            <cell-no-pic :label="$t('label_账户')" :text="phone"></cell-no-pic>
            <cell-no-pic :label="$t('label_姓名')" :text="operatorName"></cell-no-pic>
            <div class="cell-no-pic-wrapper" v-show="idType && idCardNo">
                <cell-no-pic :label="idType" :text="idCardNo"></cell-no-pic>
            </div>
        </div>
    </div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import cell from '../../../../components/cell/cell';
import cellNoPic from '../../../../components/cell/cell-no-pic';
import {mapState} from 'vuex';
export default {
    name: 'profile',
    //创建之前
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'profile');
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
    methods: {
        // 取消此功能
        // save() {
        //     this.showToast('已保存')
        //     console.log('已保存...');
        // }
    },
    computed: mapState({
        headPortrait: state => state.user.headPortrait,
        operatorName: state => state.user.operatorName,
        idType: state => state.user.idType,
        idCardNo: state => state.user.idCardNo,
        phone: state => state.user.phone
    }),
    components: {
        navHeader,
        cell,
        cellNoPic
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
            color: @link-color;
        }
    }
    .profile-wrapper{
        margin-top: 10px;
    }
}
</style>
