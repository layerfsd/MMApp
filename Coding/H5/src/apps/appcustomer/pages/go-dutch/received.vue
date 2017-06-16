/**
 * AA付款-收款详细 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="go-dutch-received">
		<div>
	        <nav-header title="GO Dutch" :showRight="false">
	        	<div slot="right" class="close" @click="close">close</div>
	        </nav-header>
		</div>
		<div style="overflow: auto;">
		<go-dutch-details></go-dutch-details>
		</div>
	</div>
</template>
<script>
import { MessageBox } from 'mint-ui';
	import goDutchDetails from '../../components/details/go-dutch-details';
	import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'received',
		components:{
			goDutchDetails,
			NavHeader
			
		},
		data() {
			return {
				
			}
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'received');
    	},
		methods:{
			
			//关闭付款
			close(){
				//弹出对话框
				this.showConfirm("If you colse the payment,your friends will be able to make any additional payments.",function(index){
					if(index==1){
						this.$router.push('/Home');
					}else{
						
					}
				},'Confirm','Cancel');
			}
			
			
			
			
			
		}
		
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
		
		.close{
			font-size: @hm-font-size-lg;
			color: @link-color;
		}
		
	}
</style>




