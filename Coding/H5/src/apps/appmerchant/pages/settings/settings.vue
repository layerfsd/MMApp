<template>
	<div class="about-settings">
		<div class="about-settings-header" :class="{ 'top-status': this.$root.supportTranslucentStatus}">
			<h1 class="title">{{title}}</h1>
			<div class="header-content-wrapper">
				<router-link to="/profile">
					<div class="avatar">
						<img :src="headPortrait" alt="" width="100%" height="100%">
					</div>
				</router-link>
				<div class="header-content">
					<div class="name">{{operatorName}}</div>
					<div class="tel">{{phone | filterPhone}}</div>
				</div>
				<div class="QR-code">
					<router-link to="/profile">
						<i class="icon-right"></i>
					</router-link>
				</div>
			</div>
		</div>
		<div class="about-settings-content">
			<div class="cell-container">
				<div class="cell-wrapper" v-show="isModifyMerchantIcon">
					<cell :title="settingList[0]" :icon="icons[0]" :src="merchantLogo" :rightStyle="{width:'35px',height: '35px', right: '36px','border-radius': '50%', top: '8px',border: '1px solid #eee'}" :to="'/uploadLogo'"></cell>
				</div>
				<div class="cell-wrapper">
					<cell :title="settingList[1]" :icon="icons[1]" :to="'/languages'" :query="{'lang': this.lang}" :value="lang | selectedLanguage"></cell>
				</div>
				<div class="cell-wrapper" v-show="isResetPassword">
					<cell :title="settingList[2]" :icon="icons[2]" :css="{width: '19px'}" :to="'/password'"></cell>
				</div>
			</div>
			<div class="cell-container">
				<div class="cell-wrapper" v-show="isResetFeedback">
					<cell :title="settingList[3]" :icon="icons[3]" :to="'/feedback'"></cell>
				</div>
				<div class="cell-wrapper">
					<cell :title="settingList[4]" :icon="icons[4]" :value="'1.0.0'" :to="'/about'"></cell>
				</div>
			</div>
			<div class="button-wrapper">
                <button class="btn active" @click="logOut">{{$t('label_退出登录')}}</button>
            </div>
		</div>
	</div>
</template>
<script>
import cell from '../../../../components/cell/cell';
import { mapState } from 'vuex';
	export default {
		name: 'settings',
		data() {
			return {
				title: this.$t('label_设置'),
				// headPortrait: '',
				operatorName: 'Lara Korvik',
				phone: '134****2392',
				isModifyMerchantIcon: false,
	            isResetSecurity: false,
	            isResetLoginPassword: false,
	            isResetPIN: false,
	            isResetPassword: false,
	            isResetFeedback: false,
	            ismodifyOperatorAvatar: false,
				icons: [
					require('../../../../assets/images/common/merchant_3x.png'),
					require('../../../../assets/images/common/language_3x.png'),
					require('../../../../assets/images/common/password_3x.png'),
					require('../../../../assets/images/common/feedback_3x.png'),
					require('../../../../assets/images/common/about_3x.png'),
				],
				settingList: [
					this.$t('label_设置商户图标'),
					this.$t('label_设置语言'),
					this.$t('label_设置密码'),
					this.$t('label_设置反馈'),
					this.$t('label_设置关于')
				]
			}
		},
		mounted() {
			console.log('设置页面mounted');
			console.log(this.merchantLogo)
			this.showIndicator();
			this.serverApi.queryMarchantInfo(null,{returnToPage: '/settings'}, (error, data, wentLogin) => {
				this.hideIndicator();

				if(wentLogin){
					return ;
				}
				if(error){
					this.showToast(error.message);
					return ;
				}
				// this.headPortrait = data.headPortrait;
				this.$store.dispatch('saveUser', {headPortrait: data.headPortrait});
				this.operatorName = data.operatorName;
				this.phone = data.phone;
				this.isModifyMerchantIcon=data.isModifyMerchantIcon;
	            this.isResetSecurity=data.isResetSecurity;
	            this.isResetLoginPassword=data.isResetLoginPassword;
	            this.isResetPIN=data.isResetPIN;
	            this.isResetPassword=data.isResetPassword;
	            this.isResetFeedback=data.isResetFeedback;
	            this.ismodifyOperatorAvatar=data.ismodifyOperatorAvatar;
				console.log(this);

				// 将头像存在store
				this.$store.dispatch('saveUser', {headPortrait: this.headPortrait, operatorName: this.operatorName, phone: this.phone});
			})
		},
		computed: mapState({
	        lang: state => state.language.lang,
	        merchantLogo: state => state.user.merchantLogo,
	        headPortrait: state => state.user.headPortrait
	    }),
	    filters: {
	    	selectedLanguage(value) {

	        	switch(value) {
	        		case 'en':
	        			return 'English';
	        		case 'jp':
	        			return 'にほんご';
	        		case 'kr':
	        			return '한국어';
	        		case 'fr':
	        			return 'French';
	        		default :
	        			return '';
	        	}
	        },
	        filterPhone(value) {
	        	return value.substr(0, 3) + '****' + value.substr(-4);
	        }
	    },
	    beforeCreate() {
	    	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'settings');
	    },
	    created() {
	    	console.log('所选语言：' + this.lang);
	    },
		beforeMount() {
			console.log('beforeMount');
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
	    deactivated() {

	    },
	    destroyed() {

	    },
		methods: {
			// 退出
			logOut() {
				// 清除sesstion
				this.$store.dispatch('removeSession');

				// 清除语言版本
				this.$store.dispatch('removeLanguage');

				//返回时删除缓存
	            this.$store.dispatch('popKeepAlive');

	            //设置返回标志，在动画里面处理
	            this.$store.dispatch('setPageAnimationBack', false);

				// 跳转到登录页面
				this.$router.replace('/login');
			}
		},
		components: {
			cell
		}
	};
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.about-settings{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
		&:before {
		  content: "";
		  position: fixed;
		  z-index: -1;
		  top: 0;
		  right: 0;
		  bottom: 0;
		  left: 0;
		  background-color: @content-bg-color;
		  background-repeat: no-repeat;
		  background-size: cover;
		}
		.about-settings-header{
			color: @theme-font-color;
	        background: -webkit-linear-gradient(top,@theme-bg-begin-color 0,@theme-bg-end-color 100%);
			.background{
				background-color: @theme-bg-end-color;
			}
			.title{
				text-align: center;
				font-size: 0.36rem;
				line-height: 0.26rem;
				padding: 0.44rem 0 0.47rem 0;
			}
			.header-content-wrapper{
					position: relative;
					padding: 0 0.27rem 0.26rem 0.27rem;
					.avatar{
						display: inline-block;
						width: 1.02rem;
						height: 1.02rem;
						vertical-align: top;
						img{
							border-radius: 50%;
							border: none;
						}
					}
					.header-content{
						display: inline-block;
						padding-top: 0.2rem;
						.name,.tel{
							padding-left: 0.35rem;
						}
						.name{
							margin-bottom: 0.19rem;
							font-size: 0.3rem;
							line-height: 0.23rem;
						}
						.tel{
							font-size: 0.24rem;
							line-height: 0.19rem;
						}

					}
					.QR-code{
						position: absolute;
						right: 0.33rem;
						top: 0.28rem;
						.code{
							display: inline-block;
							margin-right: 0.25rem;
							vertical-align: top;
							width: 22px;
							height: 22px;
							background-size: 22px 22px;
							background-repeat: no-repeat;
							.bg-image('erweima_tit');
						}
						.icon-right{
							display: inline-block;
							margin-top: 0.04rem;
							vertical-align: top;
							width: 10px;
							height: 18px;
							background-size: 10px 18px;
							background-repeat: no-repeat;
							.bg-image('card_right');
						}
					}

			}

		}
		.about-settings-content{
			overflow: auto;
			padding-bottom: 80px;
			.cell-container{
				margin-top: 10px;
			}
			.button-wrapper{
				margin-top: 68px;
			}
		}
	}
</style>