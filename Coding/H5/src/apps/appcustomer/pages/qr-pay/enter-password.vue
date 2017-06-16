/**
 * 扫码支付-输入PIN码页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="enter-pwd">
		<nav-header title="GO Dutch" :showRight="false"></nav-header>
		
		
		<enter-pwd :shopLogo="shopLogo" :money="money"></enter-pwd>
	</div>
	
	
	
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import enterPwd from '../../components/enter-pwd/enter-pwd';
	export default {
		name:'enter-password',
		data() {
			return {
				shopLogo:true,
				money:"222",
				text: ''
			}
		},
		components: {
			enterPwd,
			NavHeader
		},
		beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'enter-password');
    	},
		mounted() {
	        this.$nextTick(() => {
	            /*this.$on('listen-child-msg', (msg) => {
	                this.show = msg;
	            })*/
	        });
	        this.$on('listen-password', (msg) => {
	                this.text = msg;
	                if(this.text === '1234'){
	                    this.$router.push('/qr-pay/details');
	                }else{
	                    alert('密码错误')
	                    this.isShow = false;
	                }
	            });
	    },
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');

	.enter-pwd{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		
		}
</style>