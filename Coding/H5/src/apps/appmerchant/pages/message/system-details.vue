<template>
    <div class="system-details">
        <div class="system-details-header">
            <nav-header title="Details"></nav-header>
        </div>
        <div class="system-details-content">
            <div class="title">System maintenance</div>
            <div class="time">14:20</div>
            <p class="description">Please be informed that. System maintenance today. Due to server maintenance,from 11 to 12:00 between system maintenance.</p>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
    components: {
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.system-details {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    font-size: 0.36rem;
    background-color: @layout-bg-color;
    &:before {
        content: "";
        position: fixed;
        z-index: -1;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background-color: @content-bg-color;
        background-repeat: no-repeat;
        background-size: cover;
    }
    .system-details-header {
        .mint-header {
            .border-1px(@default-border-color);
            height: 0.89rem;
            background-color: @content-bg-color;
            color: @text-color;
            .mintui-back{
                font-size: 0.44rem;
            }
            .mint-header-title {
                flex: 5;
                font-size: 0.36rem;
                line-height: 0.9rem;
            }
        }
    }
    .system-details-content{
        margin: 0.9rem auto 0.26rem;
        .title{
            font-size: 0.36rem;
            line-height: 0.36rem;
            color: @text-color;
            text-align: center;
        }
        .time{
            margin: 0.14rem 0.24rem 0 0.24rem;
            padding-bottom: 0.26rem;
            box-sizing: content-box;
            font-size: 0.24rem;
            line-height: 0.24rem;
            color: @tips-color;
            text-align: center;
            .border-1px(@default-border-color);
        }
        .description{
            margin: 0.3rem auto;
            width: 5.92rem;
            font-size: 0.24rem;
            line-height: 0.32rem;
            color: @tips-color;

        }
    }
}
</style>
