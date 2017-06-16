/* * 注册 set-new-pin
* @Date : 2017-03-17
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
	<div class="set-new-pin layout">
		<nav-header :title="title" :isKeepAlive="false" :leftFunc="leftFunc"></nav-header>
		<input-text @input-completed="getChecked" :text1="text1" :text2="text2"></input-text>
		<mt-button type="default"  :class="{'active':checked}" class="btn" @click="submit" :disabled="!checked">{{$t('action_提交')}}</mt-button>
		<p class="tips">{{$t('info_提示记住PIN')}}!</p>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputText from '../../components/input/input-text';
	import { Toast } from 'mint-ui';
	export default {
		data() {
			return {
				text1:this.$t('label_登录_密码'),
        		text2:this.$t('label_确认_密码'),
				title:this.$t('label_激活标题'),
				checked: false,
				password: ''
			}
		},
		methods: {
			leftFunc() {
				this.$store.dispatch('popKeepAlive');
				this.$router.replace('/login');
			},
			getChecked(msg) {
				this.checked = msg.checked;
				this.password = msg.password;
			},
			submit() {
				this.showIndicator();
				this.serverApi.activation({
					phone: this.$store.state.signUp.user.phone,
					intitialPIN: '111111',
					newPIN: '999999'
				}, null, (error, data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
                        return;
					}else{
						this.$store.dispatch('newSession', {
                        	token: data.sessionToken
                    	});
						this.$router.replace('/home');
					}
				})
			}
		},
		components: {
			NavHeader,
			inputText
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	.set-new-pin{
		.btn{
			width: 90%;
			height: 1rem;
			line-height: 1rem;
			background-color: @default-bg-btn-color;
			color: @default-font-btn-color;
			margin: 1.26rem 5% 0 5%;
			border-radius: 0.06rem;
			&.active{
				background-color: @active-bg-btn-color;
			}
		}
		.tips{
			margin: 0.24rem 0.24rem 0;
			text-align: center;
			color: @tips-color;
			font-size: 0.24rem;
		}

	}
	.alertMsg{
		width: 210px;
		height: 65px;
		line-height: 45px;
		background-color: rgba(0, 0, 0, 0.6);

	}
</style>