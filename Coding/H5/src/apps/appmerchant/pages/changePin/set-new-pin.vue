/**
 * changePIN-输入新PIN 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="set-new-pin layout">
		<nav-header :title="title"></nav-header>
		<!--<input-password @input-completed="getChecked" :text1="text1" :text2="text2"></input-password>-->
		
		<div class="initial-info">
            <span class="text">{{$t('label_新PIN')}}</span>
        </div>
        <div class="input-wrapper">
        	<password-control :count="count"  class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
        </div>
        	
        <div class="initial-info">
            <span class="text">{{$t('label_重复新PIN')}}</span>
        </div>
		<div class="input-wrapper">
        	<password-control :count="count"  class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
        </div>		
		
		<button type="button"  :class="{'active':checked}" class="btn" @click="submit" :disabled="!checked">{{$t('action_提交')}}</button>
		<p class="tips">{{$t('info_提示记住PIN')}}!</p>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import inputPassword from '../../../../components/input/input-password';
	import {isEqual} from '../../assets/js/common/util';
	import passwordControl from '../../../../components/input/password-control';
	
	export default {
		name: 'setNewPin',
		data() {
			return {
				text1:this.$t('label_新PIN'),//子组件传入参数
        		text2:this.$t('label_重复新PIN'),//子组件传入参数
				title:this.$t('label_修改支付密码'),//导航栏标题信息
				checked: false, //控制按钮是否可点击
				intitialPIN: '',//初始PIN
				loginPassword: '', //登录密码
				comfirmPassword: '',//确定密码
				count:4,
			}
		},
		beforeCreate() {
			// 加入缓存
			this.$store.dispatch('pushKeepAlive', 'setNewPin');
		},
		created() {
			this.$nextTick(() => {
				this.intitialPIN = this.$route.query.intitialPIN;
				console.log(this.intitialPIN)
			});
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
		methods: {
			// 接收子组件参数
			getChecked(msg) {
				this.checked = msg.checked;
				this.loginPassword = msg.setPassword;
				this.comfirmPassword = msg.comfirmPassword;
			},
			// 提交
			submit() {
				// 检查数据
				if(!isEqual(this.loginPassword, this.comfirmPassword)){
					this.showToast(this.$t('info_密码输入不一致'));
					return;
				}else if(isEqual(this.intitialPIN, this.comfirmPassword)){
					this.showToast(this.$t('info_与初始密码一致'));
					return;
				}
				this.showIndicator();
				this.serverApi.updatePIN({
					sessionToken: this.$store.state.session.session.token,
					intitialPIN: this.intitialPIN,
					newPIN: this.comfirmPassword
				}, null, (error, data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
                        return;
					}else{
                    	this.showToast(this.$t('info_成功重置密码'));
                    	setTimeout(() => {
							this.$router.replace('/settings');
                    	} , 2000);
					}
				})
			}
		},
		components: {
			navHeader,
			inputPassword,
			passwordControl
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	.set-new-pin{
		.btn{
			margin-top: 1.26rem;
		}
		.tips{
			margin: 0.24rem 0.24rem 0;
			text-align: center;
			color: @tips-color;
			font-size: 0.24rem;
		}
		.initial-info {
            padding: 12px 0.24rem 10px;
		    color: @text-color;
	        font-size: @hm-font-size-sm;
		    line-height: 11px;
		}
		.input-wrapper {
	        padding: 0 0.24rem;
	        background-color: @content-bg-color;
	        .input-padding {
	            padding:10px 0;
	        }
    	}

	}
</style>