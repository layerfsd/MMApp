<template>
    <div class="details">
        <div class="details-content">
            <ul class="details-list">
                <li class="details-item">
                    <div class="details-time">
                        9:02 AM
                    </div>
                    <div class="title">
                        <div class="name">details maintenance</div>
                        <div class="description">Please be informed that. details maintenance today. Due to server maintenance,from 11 to 12:00 between details maintenance.</div>
                    </div>
                    <div class="check">
                        <span class="text">Check the details</span>
                        <span class="icon-right"></span>
                    </div>
                </li>
                <li class="details-item">
                    <div class="details-time">
                        9:02 AM
                    </div>
                    <div class="title">
                        <div class="name">The details update</div>
                        <div class="description">details with the new version in 03-09</div>
                    </div>
                    <div class="check">
                        <span class="text">Check the details</span>
                        <span class="icon-right"></span>
                    </div>
                </li>
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
            </ul>
        </div>
    </div>
</template>
<script>
export default {};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.details {
    .details-content {
        .details-list {
            .details-item {
                .details-time {
                    margin: 0.34rem auto 0.5rem;
                    width: 1.1rem;
                    height: 0.32rem;
                    line-height: 0.32rem;
                    text-align: center;
                    font-size: 0.2rem;
                    color: #fff;
                    background-color: rgba(0, 0, 0, 0.1);
                    border-radius: 0.10rem;
                }
                .title {
                    padding: 0.28rem 0.26rem 0.3rem;
                    background-color: #fff;
                    .border-1px(#eee);
                    .name {
                        font-size: 0.36rem;
                        line-height: 0.36rem;
                        color: #3A3A3A;
                    }
                    .description {
                        padding-top: 0.14rem;
                        font-size: 0.24rem;
                        line-height: 0.24rem;
                        color: #999;
                    }
                }
                .check {
                    position: relative;
                    padding: 0.3rem 0.26rem;
                    font-size: 0.3rem;
                    line-height: 0.23rem;
                    color: #717171;
                    background-color: #fff;
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
