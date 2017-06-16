<template>
	<div class="security layout">
		<nav-header :title="title" :leftFunc="backToVerification"></nav-header>
		<div class="security-content">
			<!-- 问题一 -->
			<section>
				<div class="question">{{$t(randomQuestions[0])}}</div>
				<div class="show-area">
					<textarea class="text" v-model="answer1" ></textarea>
				</div>
			</section>
			<!-- 问题二 -->
			<section>
				<div class="question">{{$t(randomQuestions[1])}}</div>
				<div class="show-area">
					<textarea  class="text" v-model="answer2" ></textarea>
				</div>
			</section>
		</div>
		<div class="btn-wrapper">
			<button class="btn" :class="{active: checked}" :disabled="!checked" @click="submit">{{$t("action_提交")}}</button>
		</div>
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import configInfo from '../../config/index';
	export default {
		name:"forgotPasswordSecurity",
		data() {
			return {
				answer1: '',//答案1
				answer2: '',//答案2
//				answer3: '',
				randomQuestions: [],
				satefyProblemNum: '',
//				tel:"",
				phone:this.$route.query.phone,//获取手机号码
				title: this.$t('label_密保标题'), //导航栏标题
				answers:[],//问题答案
			}
		},
		mounted() {
			this.$nextTick(() => {
				this.showIndicator();
				this.serverApi.securityRecordRandom({
					phone: this.phone
				}, null, (error, data) => {
					this.hideIndicator();
					if(error){
						this.showToast(error.message);
						return;
					}else{
						let questions = configInfo.questions;
						let ret = data.satefyProblemNum.split(',');
						this.satefyProblemNum = data.satefyProblemNum;
						for(let i=0; i<ret.length; i++){
							for(let j=0;j<questions.length;j++){
								if(ret[i] == questions[j].id){
									this.randomQuestions.push(questions[j].question);
								}
							}
						}
					}
				});
			});
		},
		beforeCreate() {
			//添加到缓冲机制中
			this.$store.dispatch('pushKeepAlive', 'forgotPasswordSecurity');
		},
		created() {
//			this.tel=this.$route.query.bill_type;
		},
		activated(){
			//设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
			this.answer1 = '';
			this.answer2 = '';
			this.answers = '';
		},
		beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
		computed: {
			checked() {
				var answers = [];
				if(this.answer1 && this.answer2){
					answers.push(this.answer1);
					answers.push(this.answer2);
					this.answers = answers;
					return true;
				}
				return false;
			}
		},
		methods: {
			backToVerification() {
				 //返回时删除缓存
                 this.$store.dispatch('popKeepAlive');
                
                //设置返回标志，在动画里面处理
                this.$store.dispatch('setPageAnimationBack', true);
                
                this.$router.replace('/forgotPassword');
    		},

			submit() {
				this.showIndicator();
				this.serverApi.securityRecord({
					phone: this.phone,
					satefyProblemNum:this.satefyProblemNum,
        			answer:this.answers,
				}, null, (error,data) => {
					this.hideIndicator();
					if(error){
						console.log(this.answers);
						this.showToast(error.message);
						return;
					}
					this.$router.push({
						path: '/setNewPassword',
						query: {title: 'Forgot Password',
								phone:this.phone
						}
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
			margin: 10px 0.24rem 0;
			.question{
				padding: 9px 0.2rem;
				line-height: 0.26rem;
				font-size: @hm-font-size-sm;
				color: @tips-color;
			}
			.answer{
				width: 100%;
				padding: 17px 0.2rem;
				line-height: 16px;
				border: 1px solid @default-border-color;
				box-sizing: border-box;
				background-color: @content-bg-color;
				font-size: @hm-font-size-base;
				color: @text-color;
				input{
					width: 100%;
					height: 100%;
					border-radius: 3px;
					outline: none;
				}
			}
			.show-area {
                margin-top: 0.2rem;
                padding: 0 0.24rem;
                /*height: 1rem;
                line-height: 1rem;*/
                border: 1px solid @default-border-color;
                border-radius: 0.06rem;
                color: @text-color;
                background-color: @content-bg-color;
                font-size: @hm-font-size-sm;
                .text {
                    width: 100%;
                    min-height: 100%;
                    border: none;
                    padding: 10px 0;
                    box-sizing: border-box;
                    resize: none;
                    font-size: @hm-font-size-sm;
                }
            }
		}
		.btn-wrapper{
			margin-top: 60px;
			.btn{
				/*width: 90%;
	            height: 50px;
	            line-height: 50px;
	            background-color: @default-bg-btn-color;
	            border: none;
	            outline: none;
	            border-radius: 3px;
	            color: @default-font-btn-color;
	            margin: 0 5%;
	            font-size: @font-16px;*/
	            &.active {
	                /*background-color: @active-bg-btn-color;*/
	            }
			}
		}
	}
</style>