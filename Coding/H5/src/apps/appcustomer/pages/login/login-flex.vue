<template>
	<div class="login-container">
		<div class="login-wrapper">
			<!-- 组件:用于显示提示信息 -->
        	<!-- <validator name="validation">
		    	<input type="text" v-model='comment' id='comment' v-validate:comment="{ minlength: 3, maxlength: 15 }">
			    <div>
			      <span v-show="$validation.comment.minlength">不得少于3个字符</span>
			      <span v-show="$validation.comment.maxlength">不得大于15个字符</span>
			    </div>
		 	</validator> -->
			<div class="logo">
				<img src="../../assets/images/common/logo_2x.png" alt="" width="100" height="100">
			</div>
			<div class="content-wrapper">
				<div for="account" class="content-div">
					<div class="content-info">
						<span class="account-name">Acount</span><span class="pre-no" ref="preno">+40</span><i class="icon-down" @click="showList"></i>
					</div>
					<input type="number" id="account" class="content-input account-input" placeholder="Phone No" @focus="onInputFocus()" @blur="onInputBlur()" v-model="telphone" @keyup="checkFiled($event)">
				</div>
				<div for="password" class="content-div">
					<div class="content-info">
						<span class="pwd-name">Password</span></span>
					</div>
					<input type="password" id="passwrod" class="content-input pwd-input" placeholder="Log in password" @focus="onInputFocus()" @blur="onInputBlur()" v-model="password" @keyup="checkFiled($event)">
					<i class="icon-eye" :class="{'open-eye':isOpenEye,'close-eye':!isOpenEye}"></i>
				</div>
				<div class="forgot">
					<router-link to="/forgotPassword">Forgot password?</router-link> 
				</div>
				<router-link to="/home">
					<mt-button type="default" class="loginBtn" :disabled="this.isEmpty" @click="login">Login</mt-button>
				</router-link>
			</div>
			<div class="footer is-center">
				<router-link class="signup" to="/signUp">Sign up</router-link>
			</div>
		</div>
		<overlay v-if="listShow"></overlay>
		<transition name="fold">
			<div v-show="listShow" class="selectList">
				<div class="list-header">
					<a href="#" class="cancel" @click="listShow=false">Cancel</a>
					<a href="#" class="done" @click="">Done</a>
				</div>
				<!-- <div class="list-content" ref="list-content">
					<ul>
						<li v-for="(item, index) in selectLists" class="list-item" :class="{'checked':currentIndex==index}" @click="currentIndex=index">
							<span class="pre-no">{{item.preNo}}</span>
							<img class="national-flag" :src="item.image"></img>
							<span class="country">{{item.country}}</span>
						</li>
					</ul>
					<div class="picker-center-highlight" :style="{ height: itemHeight + 'px', marginTop: -itemHeight / 2 + 'px' }"></div>
				</div> -->
				<mt-picker :slots="slots" @change="onValuesChange" value-key="preNo"
				 :visibleItemCount="visibleItemCount" class="list-content" >
				</mt-picker>
			</div>
		</transition>
	</div>
</template>
<script>
	import Vue from 'vue';
	import { Picker, Toast } from 'mint-ui';
	import validator from '../../validator/validation';
	import Overlay from '../../../../components/overlay/overlay';
	Vue.component(Picker.name, Picker);
	export default {
		data() {
			return {
				isEmpty: true,
				telphone: '',
				password: '',
				isOpenEye: true,
				visibleItemCount: 3,
				currentIndex: 1,
				isFoucs: false,
				listShow: false,
				showSignUp: true,
				selectLists: [
					{
						preNo: '+40',
						image: '',
						country: 'Romnia'
					},
					{
						preNo: '+86',
						image: '',
						country: 'China'
					},
					{
						preNo: '+97',
						image: '',
						country: 'Switzerland'
					},
					{
						preNo: '+37',
						image: '',
						country: 'HoKong'
					},
					{
						preNo: '+40',
						image: '',
						country: 'Romnia'
					},
					{
						preNo: '+86',
						image: '',
						country: 'China'
					},
					{
						preNo: '+97',
						image: '',
						country: 'Switzerland'
					},
				],
				slots: [
			        {
			          flex: 1,
			          name: 'picker',
			          values: [{
						preNo: '+40',
						image: '',
						country: 'Romnia'
						},
						{
							preNo: '+86',
							image: '',
							country: 'China'
						},
						{
							preNo: '+97',
							image: '',
							country: 'Switzerland'
						},
						{
							preNo: '+37',
							image: '',
							country: 'HoKong'
						},
						{
							preNo: '+40',
							image: '',
							country: 'Romnia'
						},
						{
							preNo: '+86',
							image: '',
							country: 'China'
						},
						{
							preNo: '+97',
							image: '',
							country: 'Switzerland'
					}],
			          className: 'slot1',
			          textAlign: 'center',
			          defaultIndex: 1
			        }
		      	]
			}
		},
		created() {
			
		},
		computed: {
	        
    	},
		methods: {
			onValuesChange(picker, values) {
		      if (values[0] > values[1]) {
		        picker.setSlotValue(1, values[0]);
		        alert(values[0])
		      }
		    },
	      	
			showList() {
				this.listShow = true;
				
			},
			done() {
				Picker.getSlotValue(index);
				this.listShow = false;
			},
			login() {
				this.serverApi.login(this.telphone, this.password,
					function(error, res){
						if (error) {
							Toast(error.message);
							return;
						}
						Toast('success');
						//跳转到下一页面

					});


			},
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.telphone !== '' && this.password !== ''){
					this.isEmpty = false;
				}
			},
			onInputFocus() {
				this.showSignUp = false;

			},
			onInputBlur() {
				this.showSignUp = true;
			}
			
			
		},
		components: {
			Overlay
		}
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.login-container {
		background-size: 100% 100%;
		background-repeat: repeat;
		background-image: url('~assets/images/home/login_signUp/first_login/login_bg_3x.png');
		height: 100%;
		display: flex;
		flex-direction: column;
		overflow-y:auto;
	}
	.login-wrapper {
		flex: 1;
	}
	.logo{
		display: flex;
		justify-content: center;
		width: 100px;
		height: 100px;
		margin: 2rem auto 0;
	}
	.content-wrapper{
		padding: 0 36px;
		line-height: 40px;
		margin-top: 68px;
	    padding-bottom: 68px;	
	    z-index: 1;	
		.content-div{
			position: relative;
			border-radius: 10px;
			.content-info{
				position: absolute;
				top: 0;
				left: 20px;
				.account-name{
					margin-right: 44px;
				}
				.pre-no{
					padding-right: 2px;
				}
				.icon-down{
					display: inline-block;
					// font-size: 12px;
					display: inline-block;
					width: 16px;
					height: 10px;
					background-size: 16px 10px;
					background-repeat: no-repeat;
					.bg-image('xiala');
					cursor: pointer;
				}
			}
			.icon-eye{
			    position: absolute;
			    right: 10px;
			    top: 14px;
			    font-size: @hm-font-size-base;
				line-height: 40px;
				width: 20px;
				height: 12px;
				background-size: 20px 12px;
				background-repeat: no-repeat;
			}
			.open-eye{
				.bg-image('open_eyes');
			}
			.close-eye{
				.bg-image('close_eyes');
			}
		}
		.content-input{
			display: inline-block;
			width: 100%;
			height: 44px;
			background-color: rgba(0, 0, 0, 0.3);
			border-radius: 10px;
			margin-bottom: 18px;
			color: #fff;
			-webkit-user-modify: read-write-plaintext-only;
		}
		.account-input{
			text-indent: 160px;
		}
		.pwd-input{
			text-indent: 100px;
			margin-bottom: 0;
		}
		.forgot{
			text-align: right;
			a{
				display: inline-block;
				padding: 13px 0 18px 0;
				font-size: @hm-font-size-sm;
				line-height: 15px;
				text-decoration: none;
				color: #fff;
			}
		}
		.button{
			height: 44px;
			line-height: 44px;
			border:none;
			background-color: #fff;
			color: #FF837F;
			font-size: @hm-font-size-lg;
		}
		.loginBtn{
			width: 100%;
			color: #FF837F;
		}
	}
	.signup{
		width: 100%;
		text-align: center;
		color: white;
		font-size: @hm-font-size-base;
		margin-bottom: 2rem;
	}

	.selectList{
		position: absolute;
		bottom: 0;
		left: 0;
		width: 100%;
		z-index: 1;
		&.fold-enter-active,&.fold-leave-active{
		  	transition: all .5s;
			transform: translate3d(0,0,0);
		}
		&.fold-enter,&.fold-leave-active{
		  	transform: translate3d(0,100%,0);
		}
		.list-header{
			display: flex;
			justify-content:space-between;
			height: 45px;
			line-height: 45px;
			padding: 0 8px;
			background-color: #f6f6f6;
			.cancel,.done{
				display: inline-block;
				height: 100%;
			}
		}
		.list-content{
			position: relative;
			max-height:128px;
			overflow: hidden;
			background-color: #fff;
			color: #333;
			cursor: pointer;
			.list-item{
				box-sizing: border-box;
				padding: 12px 0 12px 106px;
				.pre-no,.national-flag,.country{
					line-height: 16px;
					font-size: @hm-font-size-base;
					vertical-align: top;
				}
				.national-flag{
					display: inline-block;
					width: 24px;
					height: 18px;
					margin: 0 12px 0 20px;
				}
			}
			// .checked{
			// 	background-color: #f6f6f6;
			// 	border-top: 1px solid #c6c6c6;
			// 	border-bottom: 1px solid #c6c6c6;
			// }
			.picker-center-highlight {
			    box-sizing: border-box;
			    position: absolute;
			    left: 0;
			    width: 100%;
			    height: 40px;
			    top: 50%;
			    margin-top: -18px;
			    pointer-events: none
			  }

			  .picker-center-highlight:before,
			  .picker-center-highlight:after {
			    content: '';
			    position: absolute;
			    height: 1px;
			    width: 100%;
			    background-color: #c6c6c6;
			    display: block;
			    z-index: 15;
			    transform: scaleY(0.5);
			  }

			  .picker-center-highlight:before {
			    left: 0;
			    top: 0;
			    bottom: auto;
			    right: auto;
			  }

			  .picker-center-highlight:after {
			    left: 0;
			    bottom: 0;
			    right: auto;
			    top: auto;
			  }
		}
	}
</style>
