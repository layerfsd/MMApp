<template>
	<div class="security layout">
		<nav-header title="Security"></nav-header>
		<div class="security-content">
			<!-- 问题一 -->
			<section>
				<div class="question">{{randomQuestions[0]}}</div>
				<div class="answer">
					<input type="text" v-model="answer1">
				</div>
			</section>
			<!-- 问题二 -->
			<section>
				<div class="question">{{randomQuestions[1]}}</div>
				<div class="answer">
					<input type="text" v-model="answer2">
				</div>
			</section>
			<!-- 问题三 -->
			<!-- <section>
				<div class="question">What's your favorite book?</div>
				<div class="answer">
					<input type="text" v-model="answer3">
				</div>
			</section> -->
		</div>
		<div class="btn-wrapper">
			<button class="btn" :class="{active: checked}" :disabled="!checked" @click="submit">Submit</button>
		</div>
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import questions from '../../config/security-questions';
	export default {
		data() {
			return {
				answer1: '',
				answer2: '',
				answer3: '',
				randomQuestions: [],
				satefyProblemNum: ''
			}
		},
		mounted() {
			this.$nextTick(() => {
				this.showIndicator();
				this.serverApi.securityRecordRandom({
					phone: '11'
				}, null, (error, data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
					}
					// [
					// {
					// 	id:
					// 	question:
					// },
					// {
					// 	id:
					// 	question:
					// }]
					let ret = data.satefyProblemNum.split(',');
					this.satefyProblemNum = data.satefyProblemNum;
					for(let i=0; i<ret.length; i++){
						for(let j=0;j<questions.length;j++){
							if(ret[i] == questions[j].id){
								this.randomQuestions.push(questions[j].question);
							}
						}
					}
				});
			});
		},
		computed: {
			checked() {
				if(this.answer1 && this.answer2){
					return true;
				}
				return false;
			}
		},
		methods: {
			submit() {
				this.showIndicator();
				// [{
				// 	id:
				// 	answer:
				// },
				// {
				// 	id:
				// 	answer:
				// }]
				this.serverApi.securityRecord({
					phone: '11',
					satefyProblemNum: '1,2',//this.satefyProblemNum,
        			answer: '1392830517,1990-09-02'//1392830517,1990-09-02,liLei
				}, null, (error,data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
						return;
					}
					this.$router.push({
						path: '/setNewPassword',
						query: {title: 'Forgot Password'}
					});
				});
			}
		},
		components: {
			NavHeader
		}
	};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
	.security{
		overflow: hidden;
		.security-content{
			margin: 0.2rem 0.24rem 0;
			.question{
				padding: 0.18rem 0.2rem;
				line-height: 0.26rem;
				font-size: 0.26rem;
				color: @tips-color;
			}
			.answer{
				width: 100%;
				padding: 0.34rem 0.2rem;
				line-height: 0.32rem;
				border: 1px solid @default-border-color;
				box-sizing: border-box;
				background-color: @content-bg-color;
				font-size: @font-16px;
				color: @text-color;
				input{
					width: 100%;
					height: 100%;
					border-radius: 0.06rem;
					outline: none;
				}
			}
		}
		.btn-wrapper{
			margin-top: 1.2rem;
			.btn{
				width: 90%;
	            height: 1rem;
	            line-height: 1rem;
	            background-color: @default-bg-btn-color;
	            border: none;
	            outline: none;
	            border-radius: 0.06rem;
	            color: @default-font-btn-color;
	            margin: 0 5%;
	            font-size: @font-16px;
	            &.active {
	                background-color: @active-bg-btn-color;
	            }
			}
		}
	}
</style>