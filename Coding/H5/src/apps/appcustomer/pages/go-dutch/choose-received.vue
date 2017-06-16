/**
 * AA付款-选择付款-详细 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="go-dutch-received">
		<div>
        	<nav-header title="GO Dutch" :showRight="false" ></nav-header>
		</div>

		<div style="overflow: auto;-webkit-overflow-scrolling: touch; ">
			<go-dutch-details :isStong="isStong" :toPay="toPay" :payNow="payNow" :qrCode="qrCode" :enterPwd="enterPwd" :remind="remind"></go-dutch-details>
		</div>
		<!--密码弹窗-->
		<dialog-pwd :show="show" @listen-child-msg="getMsg"></dialog-pwd>
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
	import dialogPwd from '../../components/message-box/dialog-pwd';
	import goDutchDetails from '../../components/details/go-dutch-details';
	export default {
		name:'choose-received',
		components:{
			goDutchDetails,
			dialogPwd,
			NavHeader
		},
		data() {
			return {
				toPay:true,
				payNow:true,
				qrCode:false,
				isStong:true,
				show:false,
				remind:false,
			}
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'choose-received');
    	},
		methods:{
			enterPwd(){
				this.show=true;
			},
			getMsg(msg){
				this.show = msg;
			}
		},
		
		mounted() {
	        this.$nextTick(() => {
	            this.$on('listen-child-msg', (msg) => {
	                this.show = msg;
	            })
	        });
	        this.$on('listen-password', (msg) => {
	                this.text = msg;
	                if(this.text === '1234'){
						this.toPay=false;
						this.payNow=false;
	                    this.show =false;
	                   
	                   
	                }else{
	                    alert('密码错误')
	                    this.show = false;
	                }
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




