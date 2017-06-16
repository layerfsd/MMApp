/**
 * AA付款-历史-详细 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="go-dutch-received">
		<div>
			<nav-header title="GO Dutch" :showRight="false"></nav-header>
		</div>
		<div style="overflow: auto;">
			<go-dutch-details :isFinished="isFinished" :remind="remind" :toPay="toPay" :payNow="payNow" :qrCode="qrCode" :enterPwd="enterPwd"></go-dutch-details>
		</div>
		<!--密码弹窗-->
		<!--<dialog-pwd :show="show" :name="name"></dialog-pwd>-->
	</div>
</template>
<script>
	import dialogPwd from '../../components/message-box/dialog-pwd';
	import goDutchDetails from '../../components/details/go-dutch-details';
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'history-details',
		components:{
			goDutchDetails,
			dialogPwd,
			NavHeader
		},
		data() {
			return {
				toPay:false,
				payNow:false,
				qrCode:false,
				isFinished:true,
				show:false,
				remind:false,
				name:"/transfer/transfer-success"
			}
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'history-details');
    	},
		methods:{
			enterPwd(){
				this.show=true;
			}
		},
		
		mounted() {
	        this.$nextTick(() => {
	            this.$on('listen-child-msg', (msg) => {
	                this.show = msg;
	            })
	        });
	        
	    },
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.go-dutch-received{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		
		
	}
</style>




