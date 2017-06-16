/* * 认征 personal-information
 * @Date : 2017-05-15
 * @Author : wangliang
 * @Version : V1.0
 *
 */
<template>
	<div class="personal-information layout">
		<nav-header :title="title"></nav-header>
		<div class="personal-information-wrapper">
			<h2 class="title">
				{{$t("info_输入用户信息提示")}}
			</h2>
			<label for="first-name">
				<div class="input-wrapper">
					<span v-text="text[0]" class="name"></span>
					<input-primary :label="text[0]" :isRequired="true"></input-primary>
				</div>
			</label>
			<label for="middle-name">
				<div class="input-wrapper">
					<span v-text="text[1]" class="name"></span>
					<input-primary :label="text[1]" :isRequired="true"></input-primary>
				</div>
			</label>
			<label for="last-name">
				<div class="input-wrapper lastName">
					<span v-text="text[2]" class="name"></span>
					<input-primary :label="text[2]" :isRequired="true"></input-primary>
				</div>
			</label>
			<div class="birth-title">
				{{$t('info_出生日期')}}
			</div>
			<div class="birth-input">
				<input-birth @getBirthday="getBirthday"></input-birth>
			</div>
			<label for="id-type">
				<div class="input-wrapper" @click="showList">
					<span v-text="text[3]" class="name"></span>
					<input type="text" class="text" placeholder="" id="id-type" v-model="idType" readonly="true">
				</div>
			</label>
			<label for="id-card-no">
				<div class="input-wrapper">
					<span v-text="text[4]" class="name"></span>
					<input-primary :label="text[4]" :isRequired="true"></input-primary>
				</div>
			</label>
			<label for="email">
				<div class="input-wrapper email">
					<span v-text="text[5]" class="name"></span>
					<input-primary :label="text[5]" :isRequired="true"></input-primary>
				</div>
			</label>
			<div class="type-list-wrapper" v-show="isShow">
				<overlay></overlay>
				<ul class="id-type-list">
					<li class="type-item" v-for="item in idTypeList" @click="select(item)">{{item}}</li>
				</ul>
			</div>
			<button type="button"  :class="{'active':required}" class="btn" @click="next" :disabled="!required">{{$t('action_提交')}}</button>
		</div>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import inputBirth from '../../components/input/input-birth';
	import inputLable from '../../../../components/input/input-label';
	import inputPrimary from '../../../../components/input/input-primary';
	import overlay from '../../../../components/overlay/overlay';
	import {checkBirthday} from '../../assets/js/common/util';
	import {checkEmail} from '../../assets/js/common/util';
	export default {
		name: 'personalInformation',
		data() {
			return {
				text:[
					this.$t('label_第一姓名'),
					this.$t('label_中间姓名'),
					this.$t('label_最后姓名'),
					this.$t('label_证件类型'),
					this.$t('label_证件号码'),
					this.$t('label_电子邮箱')
					], //lable提示信息
				title:this.$t('label_用户信息标题'), //导航栏标题
				firstName: '',
				middleName: '',
				lastName: '',
				birthday: '', //生日
				idType: '', //证件类型
				idCardNo: '',//证件号码
				email: '',//电子邮件
				isShow: false, //是否显示证件类型选择列表
				idTypeList: [this.$t('info_身份证'), this.$t('info_社保卡')] //证件类型选择列表
			}
		},
		beforeCreate() {
			// 加入缓存
			this.$store.dispatch('pushKeepAlive', 'personalInformation');
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
		deactivated() {

		},
		computed: {
			// 判断按钮是否可点击
			required() {
				if(!this.firstName || !this.lastName || !this.birthday || !this.idType || !this.idCardNo || !this.email){
					return false;
				}
				return true;
			}
		},
		mounted() {
			this.$nextTick(() => {

			});
		},
		methods: {

			// 接收子组件参数
			getBirthday(msg) {
				this.birthday = msg.birthday;
				console.log('birthday:' + this.birthday);
			},
			// 展开列表
			showList() {
				this.isShow = true;
			},
			// 选择证件类型
			select(item){
				this.idType = item;
				this.isShow = false;
			},
			// 下一步
			next() {
				// 检查生日
				if(!checkBirthday(this.birthday)){
					this.showToast(this.$t('info_请输入合法的日期'));
					return;
				}
				// 检查邮箱
				if(!checkEmail(this.email)){
					this.showToast(this.$t('info_请输入合法的邮箱'));
					return;
				}
				// 将卡类型，卡号存入store
				this.$store.dispatch('saveUser', {idType: this.idType, idCardNo: this.idCardNo});
				this.showIndicator();
				this.serverApi.authentication({
					phone: this.$store.state.user.phone,
					firstName: this.firstName,
					middleName: this.middleName,
					lastName: this.lastName,
					birthday: this.birthday,
					idType: this.idType,
					idCardNo: this.idCardNo,
					email: this.email
				}, null, (error, data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
						return;
					}
					if(data.unActiviated){
						//待激活
						this.$router.push({
							path: '/signUp/changeInitialPIN',
							query: {
								phone: this.$route.query.phone
							}
						});
					}else {
						//已激活
						this.$router.replace('/home');
					}
				})
			}
		},
		components: {
			navHeader,
			inputBirth,
			overlay,
			inputLable,
			inputPrimary
		}
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.personal-information{
		.personal-information-wrapper{
			height: 100%;
			padding-bottom: 0.4rem;
			overflow-y: auto;
			overflow-x: hidden;
			@media screen and (width: 320px){
				padding-bottom: 0.2rem;
			}
		}
		.title{
			font-weight: 400;
		    padding: 0.24rem 0.24rem 0.26rem;
			vertical-align: middle;
			text-align: center;
			font-size: 0.3rem;
			line-height: 0.3rem;
			color: @tips-color;
		}
		.input-wrapper{
			display: flex;
			width: 100%;
			background-color: @content-bg-color;
			border-bottom: 1px solid @default-border-color;
			.name{
				flex: 0 0 2.8rem;
				width: 2.8rem;
				box-sizing: border-box;
				padding-left: 0.24rem;
				background-color: @content-bg-color;
				font-size: @font-17px;
				line-height: 50px;
				color: @text-color;

			}
			.text{
				flex: 1;
				padding-left: 0.24rem;
				width: 100%;
				line-height: 50px;
				color: @theme-text-color;
				font-size: @font-17px;
			}
		}
		.lastName{
			border: none;
		}
		.email{
			margin-top: 0.2rem;
			border: none;
		}
		.birth-title{
			width: 100%;
			padding: 0.28rem 0.24rem;
			font-size: 0.3rem;
			color: @text-color;
		}
		.birth-input{
			background-color: @content-bg-color;
			padding: 0.16rem 0.24rem;
			margin-bottom: 0.2rem;
		}
		.btn{
			margin-top: 0.86rem;
			@media screen and (width: 320px) {
				margin: 0.4rem 5% 0;
			}
		}
		.id-type-list{
			position: fixed;
	        left: 0;
	        bottom: 0;
	        right: 0;
	        z-index: 1;
	        .type-item {
	            width: 100%;
	            height: 1rem;
	            line-height: 1rem;
	            background-color: @content-bg-color;
	            text-align: center;
	            .border-1px(@default-border-color);
	            &:last-child {
	                .border-none();
	            }
	        }
		}
	}
</style>