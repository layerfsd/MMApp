/** * 收入 * wangliang * 2017-05-16 */
<template>
    <div class="income">
        <div class="balance-wrapper">
            <balance></balance>
        </div>
        <div class="income-wrapper" ref="incomeWrapper">
            <div class="menu">
                <span class="recent">Recent</span>
                <span class="checkall">Check all</span>
            </div>
            <div class="record-date border-1px">
                <span class="text">Today</span>
                <span class="date">20-01-2017</span>
            </div>
            <!--infinite-scroll-disabled: 若为真，则无限滚动不会被触发-->
            <!--infinite-scroll-distance: 触发加载方法的滚动距离阈值（像素）-->
            <!--infinite-scroll-immediate-check 若为真，则指令被绑定到元素上后会立即检查是否需要执行加载方法。 -->
            <ul class="record-list" v-infinite-scroll="loadMore" infinite-scroll-disabled="infiniteScrollDisabled" infinite-scroll-distance="10" infinite-scroll-immediate-check="false">
                <li class="record-item" v-for="i in 6">
                    <cell-account></cell-account>
                </li>
            </ul>
            <!-- 加载更多 -->
            <p v-show="loading" class="page-infinite-loading">
                <mt-spinner type="fading-circle"></mt-spinner>
                Loading...
            </p>
            <!-- 已经没有更多数据了 -->
            <p v-show="">no more</p>
        </div>
    </div>
</template>
<script>
import balance from '../../components/balance/balance';
import cellAccount from '../../components/cell/cell-account';
export default {
    data() {
            return {
                accountType: 1 //账户类型  1：收入
            }
        },
        created() {
            this.getMyAccountInfo(this.accountType);
        },
        methods: {
            getMyAccountInfo(accountType) {
                this.$nextTick(() => {
                    this.showIndicator();
                    this.serverApi.getMyAccountInfo({
                        sessionToken: this.$store.state.session.session.token,
                        accountType: accountType
                    }, {
                        returnToPage: '/myAccont/income'
                    }, (error, data, wentlogin) => {
                        this.hideIndicator();
                        if (wentlogin) {
                            return;
                        }
                        if (error) {
                            this.showToast(error.message);
                            return;
                        }
                        console.log(data);
                    })
                });
            }
        },
        components: {
            balance,
            cellAccount
        }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.income {
    position: fixed;
    padding-bottom: 30px;
    top: 60px;
    bottom: 50px;
    .balance-wrapper {}
    .income-wrapper {
        width: 100%;
        overflow: auto;
        background-color: @layout-bg-color;
        .menu {
            display: flex;
            padding: 0 14px;
            justify-content: space-between;
            height: 40px;
            line-height: 40px;
            font-size: @hm-font-size-xs;
            .checkall {
                color: @link-color;
            }
        }
        .record-date {
            padding: 0 14px;
            height: 40px;
            line-height: 40px;
            background-color: #fff;
            font-size: 0;
            .border-1px(@border-1px-color);
            .text,
            .date {
                font-size: @hm-font-size-xs;
            }
            .text {
                padding-right: 8px;
            }
        }
    }
}
</style>
