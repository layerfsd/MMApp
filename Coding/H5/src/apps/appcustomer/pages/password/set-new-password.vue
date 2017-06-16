<template>
	<div class="set-new-password layout">
		<nav-header title="Forgot Password" :isKeepAlive="false" :leftFunc="backToForgotPwd"></nav-header>
		<input-text text1="New Password" text2="Comfirm Password" v-on:input-completed="inputCompleted"></input-text>
		<mt-button type="default"  :class="{'active':checked}" class="btn" @click="submit">Submit</mt-button>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputText from '../../components/input/input-text';
	export default {
		name: 'setNewPassword',
		data() {
			return {
				password: '',
				passwordConfirm: '',
				checked: false,
			}
		},
		beforeCreate() {
			this.$store.dispatch('pushKeepAlive');
		},
		activated() {
			this.$store.dispatch('popKeepAlive');
		},
		components: {
			NavHeader,
			inputText
		},
		methods: {
			backToForgotPwd() {
				this.$router.replace('/forgotPassword');
    		},
			inputCompleted(msg){
				this.checked = msg.checked;
				this.password = msg.password;
			},
			submit() {
				this.showIndicator();
				this.serverApi.forgotPassword({
					// phone: this.$store.state.signUp.user.phone,
					phone: '11',
					password: this.password
				}, null, (error, data) => {
					this.hideIndicator();
					if(error) {
						this.showToast(error.message);
						return;
					}else{
						let toast = this.showToast('Password Reset Successfully');
						setTimeout(() => {
							toast.close();
							this.$router.replace('/login');
						},2000);
					}
				})
			}

		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
	.set-new-password{
		.btn{
			width: 90%;
			height: 1rem;
			line-height: 1rem;
			color: @default-font-btn-color;
			background-color: @default-bg-btn-color;
			margin: 1.26rem 5% 0 5%;
			&.active{
				background-color: @active-bg-btn-color;
			}
		}
		.tips{
			margin: 0.24rem 0.24rem 0;
			text-align: center;
		}
	}
</style>