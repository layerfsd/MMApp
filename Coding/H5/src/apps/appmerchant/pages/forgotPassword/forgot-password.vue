/* * 忘记密码 forgot-password
* @Date : 2017-03-18
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
	<div class="forgot-password layout">
		<nav-header :title="title" :leftFunc="backToHome"></nav-header>
		<div class="content-wrapper">
			<div class="content-div account-content">
                <div class="account">
                    <label for="account" class="account-name">
                        {{$t("label_账号")}}
                    </label>
                </div>
                <div class="input-wrapper">
                    <span class="plus">＋</span><span class="pre-no" ref="preno" @click="">58</span>
                    <!-- <i class="icon-down" @click=""></i> -->
                    <input-primary :isRequired="true" :placeholder="placeholder" @getValue="getValue" :label="'account'"></input-primary>
                </div>
            </div>
            <input-label :label="$t('label_证件号码')" @getMessage="getMessage"  :isRequired="true"></input-label>
			<button type="button" :class="{active: !isEmpty}" class="btn" :disabled="this.isEmpty" @click="sendMessage">{{$t('action_下一步')}}</button>
		</div>
		<overlay v-if="listShow"></overlay>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import overlay from '../../../../components/overlay/overlay';
	import inputPrimary from '../../../../components/input/input-primary';
	import inputLabel from '../../../../components/input/input-label';
	export default {
		name: 'forgotPassword',
		data() {
			return {
				phone: '',//手机号码
				cardNo: '',//id card号
				listShow: false,
				title: this.$t('label_忘记密码标题'), //导航栏标题
				placeholder:this.$t('label_手机号码'), //提示语
				verificationCodeType:"2"
			}
		},
		beforeCreate() {
			//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'forgotPassword');
		},
		activated() {
			//设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
		},
	    beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
	    computed:{
	    	isEmpty() {
	    		if(this.phone && this.cardNo){
	    			return false;
	    		}
	    		return true;
	    	}
	    },
		methods: {
			backToHome() {
				//返回时删除缓存
                 this.$store.dispatch('popKeepAlive');
                
                //设置返回标志，在动画里面处理
                this.$store.dispatch('setPageAnimationBack', true);
                
				this.$router.replace('/login');
    		},
    		getValue(msg) {
    			this.phone = msg;
    		},
    		getMessage(msg) {
    			this.cardNo = msg;
    		},
			checkField(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.phone !== '' && this.cardNo !== ''){
					this.isEmpty = false;
				}
			},
//			sendMessage() {
//         	 	this.showIndicator();
////         	 	let verificationCodeType = "2";
//				let sendData = {};
//				this.serverApi.getVerificationCode(
//					{phone:this.phone,
//					verificationCodeType:this.verificationCodeType},
//					null,
//              (error, data) => {
//                  this.hideIndicator();
//                  if (error) {
//                      this.showToast(error.message);
//                      return;
//                  } else {
//                  	this.$router.push({
//							path:'/forgotPassword/verficationCode',
//							query: {phone:this.phone}
//						});
//                  }
//          	});
//				
//			},
			sendMessage() {
				this.$store.dispatch('saveUser', {phone:this.phone})
				this.$router.push({
					path:'/forgotPassword/verficationCode',
					query: {phone:this.phone}
				});
			},
			showList() {
				//显示遮罩
				this.listShow = true;
			}
		},
		components:{
			navHeader,
			overlay,
			inputPrimary,
			inputLabel
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.forgot-password{
		.content-wrapper{
			margin-top: 10px;
			overflow: hidden;
			.content-div {
	            position: relative;
	            display: flex;
	            height: 50px;
	            border-radius: 0.1rem;
	            background-color: @content-bg-color;
	            color: @text-color;
	            &:last-child {
	                .border-none();
	            }
	            .border-1px(@default-border-color);
	            .account {
	                flex: 0 0 2.4rem;
	                width: 2.4rem;
	                line-height: 50px;
	            }
	            .account-name{
	                box-sizing: border-box;
	                display: inline-block;
	                width: 100%;
	                padding-left: 0.4rem;
	                font-size: @hm-font-size-lg;
	            }
	            .input-wrapper {
	                display: flex;
	                flex: 1;
	                width: 100%;
	                line-height: 50px;
	                border: none;
	                outline: none;
	                background-color: transparent;
	                font-size: @hm-font-size-sm;
	                .plus {
	                    flex: 0 0 0.4rem;
	                    width: 0.4rem;
	                    padding-right: 0.04rem;
	                    font-size: @hm-font-size-lg;
	                    vertical-align: top;
	                }
	                .pre-no {
	                    display: inline-block;
	                    padding-right: 6px;
	                    flex: 0 0 0.4rem;
	                    width: 0.4rem;
	                    font-size: @hm-font-size-lg;
	                    vertical-align: top;
	                }
	                .icon-down {
	                    display: inline-block;
	                    margin-top: 18px;
	                    flex: 0 0 16px;
	                    width: 16px;
	                    height: 9px;
	                    line-height: 50px;
	                    vertical-align: top;
	                    background-size: 16px 9px;
	                    background-repeat: no-repeat;
	                    .bg-image('xiala_n');
	                }
	            }
        	}
			.btn{
				/*width: 90%;
				height: 50px;
				line-height: 50px;
				color: @default-font-btn-color;
				background-color: @default-bg-btn-color;
				margin: 0 5%;
				font-size: @font-16px;*/
				margin-top: 38px;
				&.active{
					/*background-color: rgb(248, 0, 65);*/
					/*background: @active-bg-btn-color;*/
				}
			}

		}
		.content-div-account{
			.border-1px(@default-border-color);
			.content-info{
				flex: 0 0 192px;
				.name{
						padding-right: 48px;
						vertical-align: top
					}
			}
		}
		.content-div-card{
			.content-info{
				flex: 0 0 119px;
			}
		}

	}

</style>
