/**
 * 账户信息组件
 * wangliang
 * 2017-05-16
 */

<template>
	<div class="cell-account">
		<div class="cell-account-wrapper border-1px">
			<div class="part-left">
				<span class="time">{{record.transactionDate | filterTime}}</span>
				<span class="time-info" v-show="record.transactionDate">{{timeTips}}</span>
			</div>
			<div class="part-middle" v-show="record.transationType">
				<span :class="classMap[record.transationType]" class="icon-transaton-type"></span>
			</div>
			<div class="part-right">
				<span class="money">{{record.currency | formatCurrency}} {{record.transationAmount}}</span>
				<span class="money-info">{{record.transationType | transationType}}</span>
			</div>
		</div>
	</div>
</template>
<script>
	export default {
		props: {
			record: {
				type: Object,
				default() {
					return {
						"transationType": "1", //交易类型  //1：账户交易   2：银行卡交易 3：社保卡交易
	                    "transationAmount": "34.00", //交易金额
	                    "currency": "1", //币种
	                    "transactionDate": "17-05-2017 11:12:36", //交易时间
	                    "transactionId": "", //交易流水号
	                    "tax": "0.00", //税
	                    "commission": "0.00", //佣金
	                    "brokerage": "0.00" //手续费
					}
				}
			}
		},
		data() {
			return {
				classMap: ['','transationType_1','transationType_2','transationType_3']
			}
		},
		filters: {
			filterTime(value) {
				return value.substr(11);
			},
			formatCurrency(value){
				switch(value) {
					case '1': return '$';
					case '2': return '￥';
					default : return '';
				}
			},
			transationType(value) {
				switch(value) {
					case '1': return 'Cash out';
					case '2': return 'Card Pay';
					default : return '';
				}
			}
		},
		computed: {
			timeTips() {
				let hour = this.record.transactionDate.substr(11).slice(0,2);
				return hour >= 12 ? 'PM' : 'AM';
			}

		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
	.cell-account{
		.cell-account-wrapper{
			display: flex;
			padding: 0 14px;
			height: 65px;
			font-size: 0;
			background-color: #fff;
			color: @text-color;
			.border-1px(@default-border-color);
			.part-left{
				display: inline-block;
				margin-right: 0.8rem;
				padding-top: 18px;
				flex: 0 0 1.22rem;
				width: 1.22rem;
				height: inherit;
				box-sizing: border-box;
				font-size: @hm-font-size-base;
				text-align: center;
				color: @tips-color;
				.time{
					display: block;
					margin-bottom: 5px;
				}
			}
			.part-middle{
				display: inline-block;
				margin-right: 0.64rem;
				flex: 0 0 0.92rem;
				width: 0.92rem;
				height: inherit;
				box-sizing: border-box;
				padding-top: 10px;
				.icon-transaton-type{
					display: inline-block;
					width: 45px;
					height: 45px;
					background-size: 45px 45px;
					background-repeat: no-repeat;
					border: 1px solid @default-border-color;
					border-radius: 50%;
				}
				.transationType_1{
					.bg-image('Property');
				}
				.transationType_2{
					.bg-image('Property');
				}
				.transationType_3{
					.bg-image('Property');
				}
			}
			.part-right{
				display: inline-block;
				padding-top: 18px;
				flex: 1;
				height: inherit;
				box-sizing: border-box;
				font-size: @hm-font-size-base;
				text-align: center;
				.money{
					display: block;
					margin-bottom: 5px;
				}
			}
		}
	}
</style>