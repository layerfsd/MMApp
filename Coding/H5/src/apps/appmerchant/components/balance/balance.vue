/**
 * 显示余额
 * wangliang
 * 2017-05-16
 */
<template>
    <div class="balance">
        <div class="balance-wrapper">
            <div class="title">Balance</div>
            <div class="balance">
                <span class="dollar-sign">{{balanceList[0].currency | formatCurrency}}</span>
                <span class="text" v-show="balanceList.length>0"> {{balanceList[0].balance | formatMoney}}</span>
                <span :class="iconClass" @click="toggleList" v-show="filterBalanceList.length>0"></span>
            </div>
            <div class="detail-wrapper" v-show="!fold">
                <ul class="detail-list">
                    <li class="item" v-for="item in filterBalanceList">
                        <span class="dollar-sign">{{item.currency | formatCurrency}}</span>
                        <span class="text">{{item.balance | formatMoney}}</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: {
        balanceList: {
            type: Array
        }
    },
    data() {
        return {
            fold: true
        }
    },
    created() {

    },
    computed: {
        iconClass() {
            if (this.fold) {
                return 'icon-down';
            }
            return 'icon-up';
        },
        filterBalanceList() {
            return this.balanceList.slice(1);
        }
    },
    methods: {
        toggleList() {
            this.fold = !this.fold;
        }
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.balance {
    position: relative;
    top: -1px;
    .balance-wrapper {
        padding: 0 14px;
        background: @theme-bg-end-color;
        color: @theme-font-color;
        font-size: 0;
        .title {
            margin-bottom: 10px;
            line-height: 13px;
            font-size: @hm-font-size-xs;
        }
        .balance {
            padding-bottom: 20px;
            .dollar-sign {
                font-size: @hm-font-size-base;
            }
            .text {
                line-height: 1;
                font-size: @hm-font-size-xxl;
            }
            .icon-down,
            .icon-up {
                position: absolute;
                display: inline-block;
                padding: 5px;
                margin: 5px 0 0 10px;
                width: 18px;
                height: 10px;
                background-size: 18px 10px;
                background-repeat: no-repeat;
                background-position: 50% 50%;
            }
            .icon-down {
                .bg-image('down_n');
            }
            .icon-up {
                .bg-image('up_n');
            }
        }
        .detail-wrapper {
            padding: 0 15px;
            .detail-list {
                display: flex;
                flex-wrap: wrap;
                .item {
                    margin-bottom: 15px;
                    flex: 0 0 50%;
                    width: 50%;
                    height: 21px;
                    line-height: 21px;
                    border-right: 1px solid @theme-font-color;
                    box-sizing: border-box;
                    font-size: @hm-font-size-xs;
                    &:nth-child(even) {
                        padding-left: 0.8rem;
                        border-right: none;
                    }
                }
            }
        }
    }
}
</style>
