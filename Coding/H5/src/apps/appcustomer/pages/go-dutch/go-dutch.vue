/** * AA付款页面 * @author 沈飞(179920638@qq.com) * * */
<template>
	<div class="go-dutch">
		<div>
			<nav-header title="Go Dutch" class="history-header" :showLeft="false" :showRight="true">
				<div slot="left">
					<img src="~assets/images/common/nav_left_n_2x.png" alt='' />
					<label class="go-dutch-back">Home</label>
				</div>
				<div slot="right" class="go-dutch-history" @click="history">History</div>
			</nav-header>
		</div>

		<!--支付消息（有消息显示，没有隐藏）-->
		<div class="payment-msg" v-if="msg">
			<p>You have <span>2</span> payment <span class="to-pay" @click="toPay">to pay</span></p>
		</div>
		<!--间距-->
		<div class="space"></div>
		<div class="go-dutch-content">
			<div class="set-amount-input">
				<div>
					<label>Total</label>
					<img @click="currency" class="zhuanhuan" src="~assets/images/common/zhuanhuan_n_2x.png" />
				</div>
				<span>€</span>
				<input type="text" placeholder="0.00" v-model="amount" @keyup="checkFiled($event)" @focus="isFoucs=true" />
			</div>

			<!--<mt-cell class="members"
			  title="Members"
			  to="/friends/select-merbers"
			  is-link>
			  <span class="set-members">0</span>
			   <span><img class="right" src="~assets/images/common/common/right_list_2x.png"></span>
			</mt-cell>
			<mt-cell title="Event bill"></mt-cell>
			-->

			<div class="members">
				<label>Members</label>
				<span>0</span>
				<img class="right" src="~assets/images/common/right_list_2x.png">
			</div>
			<div class="event-bill">
				<input type="text" placeholder="Event bill" />

			</div>

		</div>
		<p class="identical">Identical Amount</p>
		<p class="jine">€<span class="amount">0.00</span></p>

		<div class="go-dotch-btn">
			<mt-button type="danger" class="next-btn" :disabled="this.isEmpty" @click="createNow">Create Now</mt-button>
		</div>

		<!--遮罩层-->
		<overlay v-if="listShow"></overlay>

		<transition name="fold">
			<div v-show="listShow" class="selectList">
				<div class="list-header">
					<img @click="" class="close" src="~assets/images/common/close_tc_n_2x.png" />
					<a href="#" class="done" @click="">Payment method</a>
				</div>

				<mt-picker :slots="slots" @change="onValuesChange" value-key="preNo" :visibleItemCount="visibleItemCount" class="list-content">
				</mt-picker>
			</div>
		</transition>

	</div>
</template>
<script>
	import Vue from 'vue';
	import {
		Picker
	} from 'mint-ui';
	import Overlay from '../../../../components/overlay/overlay';
	import NavHeader from '../../../../components/header/nav-header';
	import areaCodeList from '../../config/area-code-list';

	export default {
		name: 'go-dutch',
		components: {
			NavHeader,
			Overlay
		},

		data() {
			return {
				isEmpty: true,
				amount: '',
				msg: true,
				listShow: false,
				visibleItemCount: 3,

				slots: [{
					flex: 1,
					name: 'picker',
					values: areaCodeList,
					className: 'slot1',
					textAlign: 'center',
					defaultIndex: 1
				}]

			}
		},
		beforeCreate() {
			//添加到缓冲机制中
			this.$store.dispatch('pushKeepAlive', 'go-dutch');
		},
		activated: function() {
			this.amount = '';
			this.isEmpty = true;
		},
		methods: {
			currency() {

			},
			//选择支付方式（暂未实现）
			currency() {
				//	            this.listShow = true;

			},
			onValuesChange() {

			},

			checkFiled(event) {
				let val = event.target.value;
				if(val === '') {
					this.isEmpty = true;
				} else if(this.amount !== '') {
					this.isEmpty = false;
				}
			},
			createNow() {
				this.$router.push({
					path: '/go-dutch/received'
				});
			},
			toPay() {
				this.$router.push({
					path: '/go-dutch/choose'
				});
			},
			history() {
				this.$router.push({
					path: '/go-dutch/history'
				});
			}

		}

	};
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.go-dutch {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		overflow: auto;
		.selectList {
			z-index: 1;
			background-color: @content-bg-color;
			position: absolute;
			width: 100%;
			bottom: 0;
		}
		.list-header {
			border-bottom: 1px solid @layout-bg-color;
		}
		.close {
			display: inline;
			vertical-align: middle;
			height: 24px;
			width: 24px;
			margin-left: .2rem;
		}
		.done {
			display: inline;
			height: 100%;
			color: @text-color;
			font-size: @hm-font-size-sm;
			vertical-align: middle;
			line-height: 36px;
			margin-left: 1.8rem;
		}
		.is-center {
			flex: 6 !important;
		}
		.go-dutch-back {
			font-size: @hm-font-size-sm;
			vertical-align: middle;
		}
		.zhuanhuan {
			width: 17px;
			height: 17px;
			vertical-align: middle;
			margin-left: 6rem;
			position: absolute;
			right: 0;
			margin-right: .5rem;
			padding: 0 .2rem;
		}
		.go-dutch-history {
			font-size: @hm-font-size-sm;
			color: @link-color;
		}
		
		.nav-back .mint-button-text {
			font-size: @hm-font-size-sm;
			color: @text-color;
		}
		.mint-button-text {
			color: #1249DE;
			font-size: @hm-font-size-sm;
		}
		.go-dutch-content {
			background-color: #fff;
		}
		.members {
			background-color: #FFF;
			border-bottom: 1px solid #E0E0E0;
			padding: 0 .28rem;
			label {
				line-height:  45px;
				vertical-align: middle;
				font-size: @hm-font-size-lg;
				color: @text-color;
			}
			span {
				font-size: @hm-font-size-lg;
				color: #666666;
				vertical-align: middle;
				right: 0;
				position: absolute;
				margin: 15px .6rem;
			}
			.right {
			    height: 19px;
			    width: 10px;
			    vertical-align: middle;
			    position: absolute;
			    margin: 13px;
			    right: 0;
			}
		}
		.event-bill {
			height: 40px;
			background-color: #FFF;
			padding: 0 .28rem;
			input {
				line-height: 40px;
				width: 100%;
				font-size: @hm-font-size-sm;
			}
		}
		.members .mint-cell-wrapper {
			background-image: none;
		}
		/*.mint-cell-wrapper {
			background-origin: inherit;
			line-height: .5rem;
		}*/
		.mint-cell:last-child {
			background: none;
		}
		.members .mint-cell-text {
			font-size: @hm-font-size-lg;
			color: @text-color;
		}
		.mint-cell-text {
			font-size: @hm-font-size-lg;
			color: #666666;
		}
		.mint-cell-allow-right:after {
			border-width: 0;
			display: none;
		}
		.mint-cell-value.is-link {
			margin-right: 0;
		}
		.members .set-members {
			margin-right: .15rem;
		}
		.identical {
			font-size: @hm-font-size-sm;
			color: @text-color;
			text-align: center;
			margin-top: 35px;
		}
		.jine {
			font-size: @hm-font-size-lg;
			color: @text-color;
			text-align: center;
			margin-top: 10px;
			.amount {
				color: @tips-color;
			}
		}
		
		.go-dotch-btn {
			text-align: center;
			.mint-button--danger {
				width: 6.5rem;
				height: 50px;
				margin: 25px .5rem;
				border-radius: 6px;
			}
			.mint-button.is-disabled {
				background-color: @default-bg-btn-color;
			}
			.mint-button-text {
				color: @default-font-btn-color;
				font-size: @hm-font-size-base;
			}
		}
		.set-amount-input {
			height: 80px;
			background-color: #f9f9f9;
		    margin-top: 9px;
    		padding-top: 10px;
		}
		.set-amount-input label {
			font-size: @hm-font-size-sm;
			color: @text-color;
			padding: 5px;
			margin-left: @hm-font-size-sm;
		}
		.set-amount-input span {
			font-size: @hm-font-size-xxl;
			color: @text-color;
			padding-top: 10px;
			margin-left: .3rem;
		}
		.set-amount-input input {
			font-size: @hm-font-size-xxl;
			color: @text-color;
			padding-top: .2rem;
			width: 6rem;
			background-color: #F9F9F9;
			line-height: 50px;
		}
		.payment-msg {
			background-color: #EBEBEB;
			font-size: @hm-font-size-base;
			color: @text-color;
			height: 40px;
			p {
				line-height: 40px;
				padding-left: .2rem;
			}
			.to-pay {
				color: @link-color;
			}
		}
		.space {
			background-color: @layout-bg-color;
			height: 9px;
		}
	}
</style>