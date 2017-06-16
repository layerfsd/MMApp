/** * 密保页面 * wangliang * 2017-04-11 */
<template>
    <div class="security layout">
        <!-- 头部导航栏 -->
        <div class="security-header">
            <nav-header :title="title"></nav-header>
        </div>
        <!-- 内容区 -->
        <div class="security-content">
            <ul class="item-list">
                <li class="item question1">
                    <!-- 标题 -->
                    <h2 class="title">Question 1.</h2>
                    <!-- 问题下拉框 -->
                    <div class="select-question">
                        <div class="desc">{{descQuestion1}}</div>
                        <!-- 下拉按钮 -->
                        <span class="icon-down" @click="toggleList_1"></span>
                        <!-- 下拉选项 -->
                        <transition name="fold">
                            <ul class="question-list" v-show="!fold1">
                                <li class="option" @click.stop.prevent="select1($event)" v-for="(item,index) in questions">{{item.question}}</li>
                            </ul>
                        </transition>
                    </div>
                    <!-- 填写内容区域 -->
                    <div class="show-area">
                        <input type="text" class="text" v-model="answer1">
                    </div>
                </li>
                <li class="item question2">
                    <!-- 标题 -->
                    <h2 class="title">Question 2.</h2>
                    <!-- 问题下拉框 -->
                    <div class="select-question">
                        <div class="desc">{{descQuestion2}}</div>
                        <!-- 下拉按钮 -->
                        <span class="icon-down" @click.stop.prevent="toggleList_2"></span>
                        <!-- 下拉选项 -->
                        <transition name="fold">
                            <ul class="question-list" v-show="!fold2">
                                <li class="option" @click.stop.prevent="select2($event)" v-for="(item,index) in questions">{{item.question}}</li>
                            </ul>
                        </transition>
                    </div>
                    <!-- 填写内容区域 -->
                    <div class="show-area">
                        <input type="text" class="text" v-model="answer2">
                    </div>
                </li>
                <li class="item question3">
                    <!-- 标题 -->
                    <h2 class="title">Question 3.</h2>
                    <!-- 问题下拉框 -->
                    <div class="select-question">
                        <div class="desc">{{descQuestion3}}</div>
                        <!-- 下拉按钮 -->
                        <span class="icon-down" @click="toggleList_3"></span>
                        <!-- 下拉选项 -->
                        <transition name="fold">
                            <ul class="question-list" v-show="!fold3">
                                <li class="option border-1px" @click.stop.prevent="select3($event)" v-for="(item,index) in questions">{{item.question}}</li>
                            </ul>
                        </transition>
                    </div>
                    <!-- 填写内容区域 -->
                    <div class="show-area">
                        <input type="text" class="text" v-model="answer3">
                    </div>
                </li>
            </ul>
            <div class="button-wrapper">
                <button class="btn" @click="next" :class="{active: checked}" :disabled="!checked">{{$t("action_下一步")}}</button>
            </div>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import questions from '../../config/security-questions';

export default {
    data() {
            return {
            	title:this.$t('label_密保标题'),
                descQuestion1: '',
                descQuestion2: questions[1].question,
                descQuestion3: questions[2].question,
                fold1: true,
                fold2: true,
                fold3: true,
                answer1: '',
                answer2: '',
                answer3: '',
                questions: questions
            }
        },
        filter: {
            filterQuestions (questions) {

            }
        },
        created(){
        	
        	
        },
        computed: {
            checked() {
                if(this.answer1 && this.answer2 && this.answer3){
                    return true;
                }
                return false;
            }
        },
        methods: {
            select1(event) {
                console.log(event.target.innerText);
                this.descQuestion1 = event.target.innerText;
                this.fold1 = true;
            },
            select2(event) {
                console.log(event.target.innerText);
                this.descQuestion2 = event.target.innerText;
                this.fold2 = true;
            },
            select3(event) {
                console.log(event.target.innerText);
                this.descQuestion3 = event.target.innerText;
                this.fold3 = true;
            },
            toggleList_1() {
                this.fold1 = !this.fold1;
                if(!this.fold1){
                    this.fold2 = true;
                    this.fold3 = true;
                }
            },
            toggleList_2() {
                this.fold2 = !this.fold2;
                if(!this.fold2){
                    this.fold1 = true;
                    this.fold3 = true;
                }
            },
            toggleList_3() {
                this.fold3 = !this.fold3;
                if(!this.fold3){
                    this.fold1 = true;
                    this.fold2 = true;
                }
            },
            next() {
                this.showIndicator();
                this.serverApi.register({
                    phone: this.$store.state.signUp.user.phone,
                    password: '123123',
                    imei: this.$store.state.signUp.user.imei,
                    phoneModel: this.$store.state.signUp.user.phoneModel,
                    phoneSystem: this.$store.state.signUp.user.phoneSystem,
                    pushToken: this.$store.state.signUp.user.pushToken,
                    satefyProblem: 'What\'s your number?,What is your spouse\'s birthday?,What is your childhood friend?',
                    answer: '1392830517,1990-09-02,liLei'
                }, null, (error, data) => {
                    this.hideIndicator();
                    if(data.unVerified && data.unActiviated){
                        //待认征，待激活
                        this.$router.push({
                             path: '/signUp/personalInformation'
                        });
                    }else if(!data.unVerified && data.unActiviated){
                        //已认证，待激活
                         this.$router.push({
                             path: '/signUp/changeInitialPIN'
                        });
                    }else if(!data.unVerified && !data.unActiviated){
                        //已认征激活
                        this.$store.dispatch('newSession', {
                            token: data.sessionToken
                        });
                        this.showToast('Registered successfully');
                        this.$router.replace('/home');
                    }
                })
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
.security {
    .security-content {
        overflow: auto;
        margin-top: 0.1rem;
        padding-bottom: 1rem;
        .item-list {
            .item {
                position: relative;
                margin: 0 0.24rem;
                .title {
                    margin-left: 0.2rem;
                    height: 0.6rem;
                    line-height: 0.6rem;
                    font-size: 0.26rem;
                }
                .select-question {
                    position: relative;
                    width: 100%;
                    .desc {
                        position: relative;
                        padding: 0.26rem 0.2rem;
                        line-height: 0.26rem;
                        border: 1px solid @default-border-color;
                        border-radius: 0.06rem;
                        background-color: @content-bg-color;
                        font-size: 0.26rem;
                        color: @text-color;
                        // z-index: 2;
                    }
                    .icon-down {
                        position: absolute;
                        right: 0.08rem;
                        top: 0.16rem;
                        padding:0.2rem;
                        background-position: center;
                        display: inline-block;
                        width: 12px;
                        height: 6px;
                        background-size: 12px;
                        background-repeat: no-repeat;
                        .bg-image('icon-down');
                    }
                    .question-list {
                        position: absolute;
                        left: 0;
                        top: 100%;
                        width: 100%;
                        z-index: 1;
                        transform: translate3d(0, 0, 0);
                        &.fold-enter-active,
                        &.fold-leave-active {
                            transition: transform .2s linear;
                        }
                        &.fold-enter,
                        &.fold-leave-active {
                            transform: translate3d(0, -0.8rem, 0);
                        }
                        .option {
                            padding: 0.26rem 0.2rem;
                            line-height: 0.26rem;
                            // border-radius: 0.06rem;
                            background-color: @content-bg-color;
                            font-size: 0.26rem;
                            color: @text-color;
                            box-sizing: border-box;
                            // .border-1px(#e9e9e9);
                            border-bottom: 1px solid @default-border-color;
                            &:last-child{
                                border: none;
                            }
                        }
                    }
                }
                .show-area {
                    margin-top: 0.2rem;
                    padding: 0 0.24rem;
                    height: 1rem;
                    line-height: 1rem;
                    border: 1px solid @default-border-color;
                    border-radius: 0.06rem;
                    color: @text-color;
                    background-color: @content-bg-color;
                    font-size: @font-16px;
                    .text {}
                }
            }
            &.question1{
                z-index: 3;
            }
            &.question2{
                z-index: 2;
            }
            &.question3{
                z-index: 1;
            }
        }
        .button-wrapper {
            .btn {
                width: 90%;
                height: 1rem;
                line-height: 1rem;
                background-color: @default-bg-btn-color;
                color: @default-font-btn-color;
                margin: 0.86rem 5% 0 5%;
                border: none;
                border-radius: 0.06rem;
                font-size: @font-16px;
                &.active {
                    background-color: @active-bg-btn-color;
                }
            }
        }
    }
}
</style>
