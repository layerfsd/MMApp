<template>
    <div class="logo layout">
        <div class="logo-header">
            <nav-header :title="$t('label_标题_protrait')">
                <div slot="right" @click="showSet=true" class="rightPart">
                    <span class="icon-more" ></span>
                </div>
            </nav-header>
        </div>
        <div class="logo-background">
            <img :src="headPortrait" alt="" width="100%" height="100%">
        </div>
        <div class="logo-avatar">
            <img :src="headPortrait" alt="" width="100%" height="100%">
        </div>
        <overlay v-if="showSet"></overlay>
        <div class="detail-set" v-if="showSet">
            <div class="choose set-item" @click="choosePic">{{$t('action_从照片中选择')}}</div>
            <div class="take set-item">{{$t('action_拍照')}}</div>
            <div class="cancel set-item" @click="showSet=false">{{$t('action_取消')}}</div>
        </div>
    </div>
</template>
<script>
import overlay from '../../../../components/overlay/overlay';
import navHeader from '../../../../components/header/nav-header';
import {mapState} from 'vuex';
export default {
    data() {
        return {
            showSet: false
        }
    },
    created() {
        console.log("headPortrait" + this.headPortrait);
    },
    computed: mapState({
        headPortrait: state => state.user.headPortrait
    }),
    methods: {
        choosePic() {
            console.log('choosePic')

            // 从相册选择一张图片，暂时用本地图片替代
            this.$store.dispatch('saveUser', {headPortrait: '/static/assets/images/amy_3x.png'});
            // 隐藏遮罩
            this.showSet = false;
            console.log(this.headPortrait)

            // 上传图片至给服务端
        }
    },
    components: {
        overlay,
        navHeader
    }
}
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.logo {
    .logo-header {
        position: absolute;
        width: 100%;
        z-index: 1;
        .rightPart{
            height: 100%;
            .icon-more{
                display: inline-block;
                width: 17px;
                height: 3px;
                background-size: 17px 3px;
                vertical-align: middle;
                .bg-image('btn_more_black');
            }
        }
    }
    .logo-background {
        position: fixed;
        top: 74px;
        left: 0;
        bottom: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        img{
            filter: blur(5px);
            -webkit-filter: blur(5px);
        }
    }
    .logo-avatar {
        img {
            width: 100%;
            height: 50%;
            overflow: auto;
            margin: auto;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
        }
    }
    .detail-set {
        position: absolute;
        left: 0;
        bottom: 0;
        right: 0;
        z-index: 1;
        .set-item {
            width: 100%;
            height: 50px;
            line-height: 50px;
            background-color: @content-bg-color;
            text-align: center;
            .border-1px(@default-border-color);
            &:last-child {
                .border-none();
                margin-top: 5px;
            }
        }
    }
}
</style>
