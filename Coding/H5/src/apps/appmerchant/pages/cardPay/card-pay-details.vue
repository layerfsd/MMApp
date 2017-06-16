/**
 *社保卡付款完成页面
 * @author 徐伟辉
 * date:2017/5/18
 * 
 */
<template>
	<div class="card-pay-success">
		<nav-header :title="title" :showLeft="false" :showRight="true" >
        	<div slot="right">
	            <label class="nav-right" @click="done">{{$t('action_完成')}}</label>
            </div>
        </nav-header>
		<complete-transaction :tips="tips" :sum="sum"></complete-transaction>
		<cell-no-pic :label="$t('label_交易编号')" :text="payAccount"></cell-no-pic>
		<cell-no-pic :label="$t('label_商家')" :text="seller"></cell-no-pic>
		<cell-no-pic :label="$t('label_社保卡')" :text="socialCard"></cell-no-pic>
		<cell-no-pic :label="$t('label_余额')" :text="balance"></cell-no-pic>
		<cell-no-pic :label="$t('info_交易日期')" :text="time"></cell-no-pic>
	</div>
</template>
<script>
	import CompleteTransaction from '../../../../components/details/complete-transaction';
	import NavHeader from '../../../../components/header/nav-header';
	import cellNoPic from '../../../../components/cell/cell-no-pic';
	
	
	export default {
		name:'card-pay-success',
		data() {
			return {
				title:this.$t('label_详情标题'),
				tips:this.$t('info_交易成功提示'),
				sum:'202.20',
				payAccount:'SPDB （7666）',
				seller:'7-eleven',
				socialCard:"2568789823",
				balance:'€4.00',
				time:'10-09-2017 12:12:30',
			}
		},
		components: {
			NavHeader,
			CompleteTransaction,
			cellNoPic
		},
		beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
	    activated() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'card-pay-success');
    	},
		methods:{
			done(){
                this.$router.replace('/home');
			}
		}
		
	}
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.card-pay-success{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		.nav-right{
			font-size:@hm-font-size-sm;
			color:#1352E2;
		}
		.cell-no-pic .cell-no-pic-wrapper{
		    border-top: 1px solid #eee;
		    font-size: @hm-font-size-sm; 
		    .label{
		    	color:@tips-color;
		    }
		    .text{
		    	color:@text-color;
		    }
		}
	}
</style>




