<template>
    <div class="protrait layout">
        <div class="protrait-header">
            <nav-header title="Protrait">
                <div slot="right" @click="showSet=true" class="rightPart">
                    <span class="icon-more" ></span>
                </div>
            </nav-header>
        </div>
        <div class="protrait-background">
        </div>
        <div class="protrait-avatar">
            <img src="~assets/images/common/pic_2x.png" alt="" width="100%" height="100%">
        </div>
        <overlay v-if="showSet"></overlay>
        <div class="detail-set" v-if="showSet">
            <div class="choose set-item">Choose From Photos</div>
            <div class="take set-item">Take A Photo</div>
            <div class="cancel set-item" @click="showSet=false">Cancel</div>
        </div>
    </div>
</template>
<script>
import Overlay from '../../../../components/overlay/overlay';
import NavHeader from '../../../../components/header/nav-header';
export default {
    data() {
            return {
                showSet: false
            }
        },
        components: {
            Overlay,
            NavHeader
        }
}
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.protrait {
    .protrait-header {
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
    .protrait-background {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        filter: blur(0.1rem);
        -webkit-filter: blur(0.1rem);
        background-color: rgba(0, 0, 0, 0.3);
        .bg-image('pic');
    }
    .protrait-avatar {
        img {
            width: 100%;
            height: 50%;
            background: #000;
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
            height: 1rem;
            line-height: 1rem;
            background-color: @content-bg-color;
            text-align: center;
            .border-1px(@default-border-color);
            &:last-child {
                .border-none();
                margin-top: 0.1rem;
            }
        }
    }
}
</style>
