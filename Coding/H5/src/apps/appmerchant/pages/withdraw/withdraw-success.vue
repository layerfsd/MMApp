/**
 * 提现-提现完成页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="withdraw-success">
		<nav-header :title="title" :showLeft="false" :showRight="true" >
        	<div slot="right">
	            <label class="nav-right" @click="done">{{$t('action_完成')}}</label>
            </div>
        </nav-header>
        
		<complete-transaction :tips="tips" :sum="sum"></complete-transaction>
		<cell-no-pic :label="$t('info_支付账户')" :text="debitAccount"></cell-no-pic>
		<cell-no-pic :label="$t('info_手续费')" :text="fee"></cell-no-pic>
		<cell-no-pic :label="$t('info_交易日期')" :text="time"></cell-no-pic>
		
	</div>
</template>
<script>
	import CompleteTransaction from '../../../../components/details/complete-transaction';
	import NavHeader from '../../../../components/header/nav-header';
	import cellNoPic from '../../../../components/cell/cell-no-pic';
	
	
	export default {
		name:'withdraw-success',
		data() {
			return {
				title:this.$t('label_详情标题'),
				tips:this.$t('info_提示类型'),
				sum:'202.20',
				debitAccount:'SPDB （7666）',
				fee:'€4.00',
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
        	this.$store.dispatch('pushKeepAlive', 'withdraw-success');
    	},
		methods:{
			
			done(){
				this.$router.push({
					path: '/home'
				});
			}
		}
		
	}
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.withdraw-success{
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




