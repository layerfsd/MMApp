/**
 * 支出
 * wangliang
 * 2017-05-16
 */
<template>
	<div class="speeding">
		<div class="balance-wrapper">
			<balance :balanceList="balanceList"></balance>
		</div>
		<div class="speeding-wrapper">
			<div class="menu">
				<span class="recent">Recent</span>
				<span class="checkall">Check all</span>
			</div>
			<div class="record-date border-1px">
				<span class="text">Today</span>
				<span class="date">20-01-2017</span>
			</div>
			<ul class="record-list">
				<li class="record-item" v-for="i in 6">
					<cell-account></cell-account>
				</li>
			</ul>
		</div>
	</div>
</template>
<script>
import balance from '../../components/balance/balance';
import cellAccount from '../../components/cell/cell-account';
	export default {
    data() {
            return {
                accountType: 2, //账户类型  1：收入
                balanceList: [{
						balance: '0',
						currency: '1'
					}]
            }
        },
        created() {
            this.getMyAccountInfo(this.accountType);
        },
        methods: {
            getMyAccountInfo(accountType) {
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
                    console.log(data.balanceCurrencys);
                    this.balanceList = data.balanceCurrencys;
                })
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
	.speeding{
		.balance-wrapper{
			position: relative;
			z-index: 1;
		}
		.speeding-wrapper{
			position: fixed;
			padding-bottom: 30px;
			top: 133px;
			bottom: 50px;
			width: 100%;
			overflow: auto;
			background-color: @layout-bg-color;
			.menu{
				display: flex;
				padding: 0 14px;
				justify-content: space-between;
				height: 40px;
				line-height: 40px;
				font-size: @hm-font-size-xs;
				.checkall{
					color: @link-color;
				}
			}
			.record-date{
				padding: 0 14px;
				height: 40px;
				line-height: 40px;
				background-color: #fff;
				font-size: 0;
				.border-1px(@border-1px-color);
				.text,.date{
					font-size: @hm-font-size-xs;
				}
				.text{
					padding-right: 8px;
				}
			}
		}
	}
</style>