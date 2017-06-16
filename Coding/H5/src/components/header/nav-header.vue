/*
 * 导航条
 * @Date    : 2017-03-28
 * @Author  : samyu
 * @Version : V1.0
 *
 */

<template>
    <div class="header" v-if="showHeader" v-bind:class="[{ 'top-status': this.$root.supportTranslucentStatus}]">
        <div class="header-wrapper" :class="[customClass]">
            <div class="is-left" @click="back">
                <img v-if="showLeft" src="~assets/images/common/nav_left_n_2x.png" alt='' />
                <span v-if="showLeft" class="nav-left-text"> {{leftText}} </span>
                <slot name="left" ></slot>
            </div>
            <div class="is-center">
                <div v-if="showCenter">{{title}}</div>
                <slot name="center"></slot>
            </div>
            <div class="is-right" @click="right">
                <slot name="right"></slot>
            </div>
        </div>
    </div>
</template>

<script>
	export default {
		props:{
            customClass:{ //自定义样式
                type:String,
                default:'custom-header',
            },
            showHeader:{ //是否显示导航条
                type:Boolean,
                default:true,
            },
            title:String, //导航条文本
            showLeft:{    //是否显示左边按钮
                type:Boolean,
                default:true,
            },
            leftText:String, //左边文本
            leftFunc:{    //左边按钮触发函数，默认返回上一页
                type: Function,
            },
            showCenter:{  //是否显示中间
                type:Boolean,
                default:true,
            },
            showRight:{  //是否显示右边
                type:Boolean,
                default:true,
            },
            rightFunc:{ //右边触发函数，默认返回首页
                type: Function,
            },
            isKeepAlive:{ //是否缓存页面，默认缓存
                type:Boolean,
                default: true,
            }

        },
		
		methods: {
			back(){
                if(typeof this.leftFunc === 'function'){
                    this.leftFunc();
                }else{
                    this.$router.back();

                    //返回时删除缓存
                    if(this.isKeepAlive){
                        this.$store.dispatch('popKeepAlive');
                    }
                    //设置返回标志，在动画里面处理
                    this.$store.dispatch('setPageAnimationBack', true);
                    console.log("back");
                }
            },
            right(){
                if(typeof this.rightFunc === 'function'){
                    this.rightFunc();
                }
                // else{
                //     console.log("home");
                //     this.$store.dispatch('popRootKeepAlive');
                //     this.$router.replace('/home');
                // }
            }
		}
	}
</script>
<style lang="less" scoped>
	@import url('~assets/css/base.less');
	@import url('~assets/css/mixin.less');
    .top-status {
        padding-top: 20px !important;
        // height: 64px !important;
        // line-height: 64px !important;
    }
	.header{
        // padding-top: 20px;
        background-color: #fff;
    }
    .header-wrapper{
        height: 45px;
        line-height: 45px;
        box-sizing: border-box;
        padding: 0 12px;
        color: #2d2d2d;
        display: flex;
        align-items:center;
        color: #333;
    }
    .nav-left-text {
        font-size: @hm-font-size-base;
        height: 45px;
        line-height: 45px;
        vertical-align: middle;
        display: inline-block;
    }
    .nav-right-text {
        font-size: @hm-font-size-base;
        height: 45px;
        line-height: 45px;
        vertical-align: middle;
        display: inline-block;
    }
	.header {
        .is-left {
            flex: 2;
            text-align: left;

            img{
                vertical-align: middle;
                height: 22px;
            }
        }
    }
    .is-center {
        flex: 8;
        font-size: @hm-font-size-lg;
        text-align: center;
    }
    .header {
        .is-right {
            flex: 2;
            text-align: right;

            img{
                vertical-align: middle;
                height: 22px;
            }

        }
    }
</style>