<template>
    <div class="system">
        <div class="system-header">
            <nav-header title="System message"></nav-header>
        </div>
        <div class="system-content">
            <ul class="details-list">
                <router-link to="/message/system-details">
                    <li class="details-item">
                        <div class="details-time">
                            9:02 AM
                        </div>
                        <div class="title">
                            <div class="name">System maintenance</div>
                            <div class="description">Please be informed that. System maintenance today. Due to server maintenance,from 11 to 12:00 between system maintenance.Please be informed that. System maintenance today. Due to server maintenance,from 11 to 12:00 between system maintenance.</div>
                        </div>
                        <div class="check">
                            <span class="text">Check the details</span>
                            <span class="icon-right"></span>
                        </div>
                    </li>
                </router-link>
                <router-link to="/message/system-details">
                    <li class="details-item">
                        <div class="details-time">
                            9:02 AM
                        </div>
                        <div class="title">
                            <div class="name">The system update</div>
                            <div class="description">System with the new version in 03-09</div>
                        </div>
                        <div class="check">
                            <span class="text">Check the details</span>
                            <span class="icon-right"></span>
                        </div>
                    </li>
                </router-link>
                <router-link to="/message/system-details">
                    <li class="details-item">
                        <div class="details-time">
                            9:02 AM
                        </div>
                        <div class="title">
                            <div class="name">Spending to remind</div>
                            <div class="description">Spending €20.00</div>
                        </div>
                        <div class="check">
                            <span class="text">Check the details</span>
                            <span class="icon-right"></span>
                        </div>
                    </li>
                </router-link>
            </ul>
        </div>
    </div>
</template>
<script>
import details from '../../components/details/details';
import NavHeader from '../../../../components/header/nav-header';
export default {
    components: {
        details,
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.system {
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
    .system-header {
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
    .system-content {
        padding-bottom: 1rem;
        overflow: auto;
        .details-list {
            .details-item {
                .details-time {
                    margin: 0.34rem auto 0.5rem;
                    padding: 0.02rem;
                    width: 1.2rem;
                    height: 0.32rem;
                    line-height: 0.36rem;
                    text-align: center;
                    font-size: 0.2rem;
                    color: @content-bg-color;
                    background-color: rgba(0, 0, 0, 0.1);
                    border-radius: 0.10rem;
                }
                .title {
                    padding: 0.28rem 0.26rem 0.3rem;
                    background-color: @content-bg-color;
                    .border-1px(@default-border-color);
                    .name {
                        font-size: 0.36rem;
                        line-height: 0.36rem;
                        color: @text-color;
                    }
                    .description {
                        padding-top: 0.14rem;
                        font-size: 0.24rem;
                        line-height: 0.24rem;
                        color: @tips-color;
                        // white-space: wrap;
                        // max-height: 0.72rem;
                        // overflow: hidden;
                        // text-overflow: ellipsis;
                    }
                }
                .check {
                    position: relative;
                    padding: 0.3rem 0.26rem;
                    font-size: 0.3rem;
                    line-height: 0.23rem;
                    color: #717171;
                    background-color: @content-bg-color;
                    .icon-right {
                        position: absolute;
                        top: 0.22rem;
                        right: 0.26rem;
                        width: 10px;
                        height: 18px;
                        background-size: 10px 18px;
                        background-repeat: no-repeat;
                        .bg-image('right_list_n');
                    }
                }
            }
        }
    }
}
</style>
