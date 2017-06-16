/** * 收入 * wangliang * 2017-05-16 */
<template>
    <div class="income">
        <div class="balance-wrapper">
            <balance :balanceList="balanceList"></balance>
        </div>
        <div class="income-wrapper" ref="incomeWrapper">
            <div class="menu">
                <span class="recent">Recent</span>
                <span class="checkall">Check all</span>
            </div>
            <div class="record-date border-1px">
                <span class="text">Today</span>
                <span class="date">{{transactionRecords[0].transactionDate | formatDate}}</span>
            </div>
            <div class="record-list-wrapper" v-infinite-scroll="loadMore"           
              infinite-scroll-disabled="loading"
              infinite-scroll-distance="10"
              infinite-scroll-immediate-check="true">
                <!-- 数据列表 -->
                <ul class="record-list">
                    <li class="record-item" v-for="record in transactionRecords" v-show="transactionRecords.length>0">
                        <cell-account :record="record"></cell-account>
                    </li>
                </ul>
                <!-- 加载更多 -->
                <p v-show="loading" class="page-infinite-loading">
                    <mt-spinner type="fading-circle" class="page-spinner"></mt-spinner>
                    Loading...
                </p>
                <!-- no more -->
                <p v-show="noMoreData">
                    <!-- <mt-spinner type="fading-circle" class="page-spinner"></mt-spinner> -->
                    No more data
                </p>
                <footer class="cash-footer" ref="footer" ></footer>
            </div>
        </div>
    </div>
</template>
<script>
import balance from '../../components/balance/balance';
import cellAccount from '../../components/cell/cell-account';
export default {
    data() {
            return {
                accountType: 1, //账户类型  1：收入
                balanceList: [{
						balance: '0',
						currency: '1'
					}],
                transactionRecords: [{
                    "transationType": "", //交易类型  //1：账户交易   2：银行卡交易 3：社保卡交易
                    "transationAmount": "", //交易金额
                    "currency": "", //币种
                    "transactionDate": "", //交易时间
                    "transactionId": "", //交易流水号
                    "tax": "", //税
                    "commission": "", //佣金
                    "brokerage": "" //手续费
                }],
                wrapperHeight: 0,
                loading: false,    //无限滚动加载中
                noMoreData: false  //无限滚动数据已经全部加载
            }
        },
        created() {
            console.log('是否触发无限滚动： ' + this.infiniteScrollDisabled)
        },
        filters: {
            formatDate(value){
                return String(value).substr(0, 10);
            }
        },
        computed: {
            infiniteScrollDisabled() {
                if (this.loading || this.noMoreData){
                    return true;
                }
                return false;
            }
        },
        mounted() {
            this.loadMore();
            this.$nextTick(() => {
                console.log('footer高度：' + this.$refs.footer.getBoundingClientRect().top)
                this.wrapperHeight = this.$refs.footer.getBoundingClientRect().top - this.$refs.incomeWrapper.getBoundingClientRect().top;
            });
        },
        methods: {
            getMyAccountInfo(accountType, start, limit, callback) {
                this.serverApi.getMyAccountInfo({
                    accountType: accountType,
                    start: start,
                    limit: limit
                }, {
                    returnToPage: '/myAccont/income'
                }, (error, data, wentlogin) => {

                    callback(error, data, wentlogin);

                })
            },
            loadMore() {
                if(this.noMoreData) return;

                // 触发加载中
                this.loading = true;
                setTimeout(() => {

                    let start = this.transactionRecords.length;

                    let limit = 5;//每次加载的记录的条数

                    this.getMyAccountInfo(this.accountType, start, limit, (error, data, wentlogin) => {

                        if(wentlogin){
                            return ;
                        }
                        if(error){
                            this.showToast(error.message);
                            return;
                        }
                        this.balanceList = data.balanceCurrencys;

                        this.transactionRecords = data.transactionRecords;

                        console.log(data)

                        if(data.transactionRecords.length < limit){
                            this.noMoreData = true;
                        }

                        this.transactionRecords = this.transactionRecords.concat(data.transactionRecords);
                        this.loading = false;
                    });
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
    top: 60px;
    bottom: 50px;
    .balance-wrapper {}
    .income-wrapper {
        padding-bottom: 30px;
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
        .page-infinite-loading{
            text-align: center;
            font-size: @hm-font-size-xs;
            color: @tips-color;
            .page-spinner{
                display: block;
                margin: 10px auto;
                width: 28px;
                height: 28px;

            }
        }
    }
}
</style>
