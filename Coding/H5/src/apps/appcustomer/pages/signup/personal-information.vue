/* * 注册 personal-information
 * @Date : 2017-03-16
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
					<input type="text"  placeholder="" class="text" id="first-name" v-model="firstName">
				</div>
			</label>
			<label for="middle-name">
				<div class="input-wrapper">
					<span v-text="text[1]" class="name"></span>
					<input type="text"  placeholder="" class="text" id="middle-name" v-model="middleName">
				</div>
			</label>
			<label for="last-name">
				<div class="input-wrapper lastName">
					<span v-text="text[2]" class="name"></span>
					<input type="text"  placeholder="" class="text" id="last-name" v-model="lastName">
				</div>
			</label>
			<div class="birth-title">
				{{$t('info_出生日期')}}
			</div>
			<div class="birth-input">
				<input-birth @getBirthday="getBirthday"></input-birth>
			</div>
			<label for="id-type">
				<div class="input-wrapper">
					<span v-text="text[3]" class="name"></span>
					<input type="text" class="text" placeholder="" id="id-type" v-model="idType">
				</div>
			</label>
			<label for="id-card-no">
				<div class="input-wrapper">
					<span v-text="text[4]" class="name"></span>
					<input type="text" class="text" placeholder="" id="id-card-no" v-model='idCardNo'>
				</div>
			</label>
			<label for="email">
				<div class="input-wrapper email">
					<span v-text="text[5]" class="name"></span>
					<input type="text" class="text" placeholder="" id="email" v-model="email">
				</div>
			</label>
			<mt-button type="default"  :class="{'active':required}" class="btn" @click="next" :disabled="!required">{{$t('action_提交')}}</mt-button>
		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import inputBirth from '../../components/input/input-birth';
	const ACTIVATION = '0'; //待激活
	export default {
		data() {
			return {
				text:[
					this.$t('label_第一姓名'),
					this.$t('label_中间姓名'),
					this.$t('label_最后姓名'),
					this.$t('label_证件类型'),
					this.$t('label_证件号码'),
					this.$t('label_电子邮箱')
					],
				title:this.$t('label_用户信息标题'),
				firstName: '',
				middleName: '',
				lastName: '',
				birthday: '',
				idType: '',
				idCardNo: '',
				email: ''
			}
		},
		beforeCreate() {
			this.$store.dispatch('pushKeepAlive');
		},
		computed: {
			customerName() {
				return this.firstName + this.middleName + this.lastName;
			},
			required() {
				if(!this.firstName || !this.middleName || !this.lastName || !this.birthday || !this.idType || !this.idCardNo || !this.email){
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
			getBirthday(msg) {
				this.birthday = msg.birthday;
				console.log('birthday:' + this.birthday);
			},
			next() {
				this.showIndicator();
				this.serverApi.authentication({
					phone: this.$store.state.signUp.user.phone,
					customerName: this.customerName,
					birthday: this.birthday,
					idType: this.idType,
					idCardNo: this.idCardNo,
					email: this.email
				}, null, (error, data) => {
					console.log('认征结果============')
					console.log(data);
					this.hideIndicator();
					if(data.unActiviated){
						//待激活
						this.$router.push({
							path: '/signUp/changeInitialPIN'
						});
					}else {
						//已激活
						this.$router.replace('/home');
					}
				})
			}
		},
		components: {
			NavHeader,
			inputBirth
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
			// .border-1px(#e4e4e4);
			border-bottom: 1px solid @default-border-color;
			.name{
				flex: 1;
				padding: 0.36rem 0.24rem 0.26rem;
				background-color: @content-bg-color;
				font-size: @font-17px;
				line-height: 0.26rem;
				color: @text-color;

			}
			.text{
				flex: 1;
				width: 50%;
				padding: 0.38rem 0.24rem 0.26rem;
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
			width: 90%;
			height: 45px;
			line-height: 45px;
			background-color: @default-bg-btn-color;
			color: @default-font-btn-color;
			margin: 0.86rem 5% 0;
			@media screen and (width: 320px) {
				margin: 0.4rem 5% 0;
			}
			&.active{
				background-color: @active-bg-btn-color;
			}
		}
	}
</style>