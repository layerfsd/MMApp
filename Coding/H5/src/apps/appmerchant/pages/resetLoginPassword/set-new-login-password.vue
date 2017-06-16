/*
* 密码重置-输入新密码
* @Date : 2017-05-09
* @Author : 徐伟辉
* @Version : V1.0
*
*/
<template>
	<div class="set-new-password layout">
		<nav-header :title="title"></nav-header>
		<input-password :text1="text1" :text2="text2" v-on:input-completed="inputCompleted"></input-password>
		<button type="button" :class="{'active':checked}" class="btn" :disabled="this.isEmpty" @click="submit">{{$t('action_提交')}}</button>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputPassword from '../../../../components/input/input-password';
	import {isEqual} from '../../assets/js/common/util';
	import {checkLength} from '../../assets/js/common/util';
	
	export default {
		name: 'setNewPassword',
		data() {
			return {
				password: '',
				passwordConfirm: '',
				checked: false,
				setPassword: '',//密码
            	comfirmPassword: '',
            	title:this.$t("label_重置密码"),
            	text1:this.$t("label_新密码"),
            	text2:this.$t("label_确认密码"),
			}
		},
		beforeCreate() {
			this.$store.dispatch('pushKeepAlive',"setNewPassword");
		},
		activated(){
			//设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
		},
		deactivated() {
			this.setPassword = '';
			this.comfirmPassword = '';
		},
		computed:{
	    	isEmpty() {
	    		if(this.setPassword && this.comfirmPassword){
	    			return false;
	    		}
	    		return true;
	    	}
	    },
		components: {
			NavHeader,
			inputPassword
		},
		methods: {
			backToForgotPwd() {
//				this.$router.replace('/password');
    		},
			inputCompleted(msg){
				this.checked = msg.checked;
				this.password = msg.password;
				this.setPassword = msg.setPassword;
            	this.comfirmPassword = msg.comfirmPassword;
			},
			submit() {
				if(!isEqual(this.setPassword, this.comfirmPassword)){
	                this.showToast('密码输入不一致！');
	                return false;
	            }else if(!checkLength(this.setPassword, this.comfirmPassword)){
	            	this.showToast('请输入6位密码！');
	            	return false;
	            }
				else{
					this.showIndicator();
					this.serverApi.modifyLoginPassword({
						newPassword:this.comfirmPassword,
						initialPassword:this.$route.query.initialPassword
					}, null, (error, data) => {
						this.hideIndicator();
						if(error) {
							this.showToast(error.message);
							return;
						}else{
							let toast = this.showToast(this.$t("info_成功重置密码"));
							//清除缓存
							this.$store.dispatch('popKeepAlive');
							//设置返回标志，在动画里面处理
                			this.$store.dispatch('setPageAnimationBack', true);
							setTimeout(() => {
								toast.close();
								this.$router.replace('/settings');
							},2000);
						}
					})
				}
			}

		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
	.set-new-password{
		.btn{
			/*width: 90%;
			height: 1rem;
			line-height: 1rem;
			color: @default-font-btn-color;
			background-color: @default-bg-btn-color;*/
			margin: 1.26rem 5% 0 5%;
			&.active{
				/*background-color: @active-bg-btn-color;*/
			}
		}
		.tips{
			margin: 0.24rem 0.24rem 0;
			text-align: center;
		}
	}
</style>