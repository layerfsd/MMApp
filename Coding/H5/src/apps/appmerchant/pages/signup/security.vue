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
                <li class="item question" v-for="(item, index) in randomQuestions">
                    <!-- 标题 -->
                    <h2 class="title">{{$t('info_问题')}} {{index + 1}}</h2>
                    <!-- 问题下拉框 -->
                    <div class="select-question" @click="toggleList(item)">
                        <div class="desc">{{$t(item.question)}}</div>
                        <!-- 下拉按钮 -->
                        <span class="icon-down" v-show="otherQuestions.length>0"></span>
                        <!-- 下拉选项 -->
                        <transition name="fold">
                            <ul class="question-list" v-show="item.show" ref="questionList">
                                <li class="option" @click.stop.prevent="select(item,other)" v-for="(other,index) in otherQuestions">{{$t(other.question)}}</li>
                            </ul>
                        </transition>
                    </div>
                    <!-- 填写内容区域 -->
                    <div class="show-area">
                        <textarea  class="text" ref="input" @keyup="checkField()"></textarea>
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
import navHeader from '../../../../components/header/nav-header';
import configInfo from '../../config/index';
import overlay from '../../../../components/overlay/overlay';
import { mapState } from 'vuex';

const LENGTH = 3;
export default {
    name: 'security',
    data() {
        return {
            title: this.$t('label_密保标题'), //导航栏标题
            questions: configInfo.questions, //问题
            checked: false,//控制按钮是否可点击
            answers: [], //答案
            otherQuestions: [],//其它用户可选择的问题（点击下拉框可见）,
            randomQuestions: []   // {index: 问题序号}

        }
    },
    beforeCreate() {
        // 加入缓存
        this.$store.dispatch('pushKeepAlive', 'security');
    },
    created() {
        this.$nextTick(() => {

            // 随机获取3个问题
            this.getRandomQuestions();

            // 给questions的每一项添加show属性，以便控制是否展示下拉框
            this.questions.forEach((item) => {
                this.$set(item, 'show', false);
            });

        });
    },
    beforeMount() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    computed: {
        // randomQuestions() {
        //     let ret = this.getRandomQuestions();
        //     return ret;
        // }
    },
    activated() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    deactivated() {
        // // 清空问题答案
        // let inputs = this.$refs.input;
        // for(let i=0; i<inputs.length; i++){
        //     inputs[i].value = '';
        // }
        // this.checked = false;
    },
    methods: {
        getRandomQuestions() {
            this.otherQuestions = configInfo.questions.concat();
            // 获取数组的长度
            let len = this.otherQuestions.length;

            // 随机获取3个问题
            for(let i=0; i<LENGTH; i++){

                // 随机获取索引
                let index = (Math.floor(Math.random()*100)) % len;

                // 将问题添加到数组中
                this.randomQuestions.push(this.otherQuestions[index])

                // 把此问题在原数组中删除
                this.otherQuestions.splice(index, 1);

                // 将数组长度减1
                len--;
            }
            console.log(this.randomQuestions);
            console.log(this.otherQuestions);
        },
        // 检查输入内容
        checkField() {
            this.inputs = this.$refs.input;
            let checked = true;
            let answers = [];
            this.inputs.forEach((item) => {
                if(!item.value) {
                    checked = false;
                }
                answers.push(item.value);
            });
            this.checked = checked;
            this.answers = answers;
        },
        // 选择下拉框选项
        select(item,other) {
            console.log(item, other);
            // 将要更换的问题临时保存起来
            let temp = {
                id: item.id,
                question: item.question,
                show: item.show
            };

            // 将更换的问题放入otherQuestions中
            this.otherQuestions.forEach((o, i) => {
                if(o.id === other.id){
                    this.otherQuestions.splice(i,1,temp);
                }
            });

            // 更换问题
            item.id = other.id;
            item.question = other.question;

            console.log(this.randomQuestions)

            // 关闭下拉框
            item.show = false;

        },
        // 切换下拉框
        toggleList(item) {

            if(!item.show){
                this.$set(item,'show', true);
            }else {
                item.show = !item.show;
            }
        },
        // 下一步
        next() {
            this.showIndicator();
            this.serverApi.register({
                phone: this.$store.state.user.phone,
                shortCode: this.$store.state.user.shortCode,
                password: this.$route.query.password,
                randomQuestions: this.randomQuestions,
                answer: this.answers.join()
            }, null, (error, data) => {
                this.hideIndicator();
               if (data.unActiviated) {
                    //待激活
                    this.$router.push({
                        path: '/signUp/changeInitialPIN',
                        query: {
                            phone: this.$route.query.phone
                        }
                    });
                } else {
                    //已激活
                    this.$store.dispatch('newSession', {
                        token: data.sessionToken
                    });
                    this.showToast('Registered successfully');
                    setTimout(() => {
                        this.$router.replace('/home');
                    }, 2000);
                }
            })
        }
    },
    components: {
        navHeader,
        overlay
    }
};
</script>
<style lang="less" scoped>
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
                    height: 30px;
                    line-height: 30px;
                    font-size: @hm-font-size-xs;
                }
                .select-question {
                    position: relative;
                    width: 100%;
                    .desc {
                        position: relative;
                        padding: 13px 0.2rem;
                        line-height: @hm-font-size-xs;
                        border: 1px solid @default-border-color;
                        border-radius: 0.06rem;
                        background-color: @content-bg-color;
                        font-size: @hm-font-size-xs;
                        color: @text-color;
                    }
                    .icon-down {
                        position: absolute;
                        right: 0.08rem;
                        top: 8px;
                        padding: 0.2rem;
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
                            transform: translate3d(0, -40px, 0);
                        }
                        .option {
                            padding: @hm-font-size-xs 0.2rem;
                            line-height: @hm-font-size-xs;
                            background-color: @content-bg-color;
                            font-size: @hm-font-size-xs;
                            color: @text-color;
                            box-sizing: border-box;
                            border-bottom: 1px solid @default-border-color;
                            &:last-child {
                                border: none;
                            }
                        }
                    }
                }
                .show-area {
                    margin-top: 0.2rem;
                    padding: 0 0.24rem;
                    overflow:hidden;
                    height: 50px;
                    line-height: 50px;
                    border: 1px solid @default-border-color;
                    border-radius: 0.06rem;
                    color: @text-color;
                    background-color: @content-bg-color;
                    font-size: @hm-font-size-base;
                    .text {
                        width: 100%;
                        min-height: 100%;
                        border: none;
                        padding: 10px 0;
                        box-sizing: border-box;
                        resize: none;
                    }
                }
            }
            &.question1 {
                z-index: 3;
            }
            &.question2 {
                z-index: 2;
            }
            &.question3 {
                z-index: 1;
            }
        }
        .button-wrapper {
            .btn {
                margin-top: 43px;
            }
        }
    }
}
</style>
