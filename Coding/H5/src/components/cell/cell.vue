<template>
    <div class="cell">
        <div class="content border-1px" @click="toLink" :style="rootStyle">
            <img  :src="icon" class="icon" alt="" :style="css" v-show="icon">
            <span class="title" v-show="title" :style="titleStyle">{{title}}</span>
            <span class="value" v-show="value" :style="valueStyle">{{value}}</span>
            <i class="icon-right" v-show="isLink" :style="linkStyle"></i>
            <img :src="src" alt="" v-show="src" class="rightStyle" :style="rightStyle">
        </div>
    </div>
</template>
<script>
export default {
    props: {
        rootStyle: {
            type: Object
        },
        valueStyle: {
            type: Object
        },
        linkStyle: {
            type: Object
        },
        titleStyle: {
            type: Object
        },
        title: {
            type: String,
            // default: 'Password'
        },
        icon: {
            type: String,
            // default: './static/images/password_3x.png'
        },
        src: {
            type: String,
        },
        to: {
            type: String
        },
        value: {
            type: String,
            default: ''
        },
        label: {
            type: String
        },
        isLink: {
            type: Boolean,
            default: true
        },
        query: {
        	type: Object
        },
        css: {
            type: Object,
            default(){
            	return{
            	}
            }
        },
        rightStyle: {
            type: Object,
            default() {
                return {
                    right: '36px'
                }
            }
        }

    },
    methods: {
        toLink() {
            this.$router.push({
                path: this.to,
                query: this.query
            });
        }
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.cell {
    .content {
        position: relative;
        padding: 0 0.24rem;
        height: 50px;
        background-color: @content-bg-color;
        line-height: 50px;
        font-size: 0;
        .border-1px(@default-border-color);
        .icon {
            display: inline-block;
            position: relative;
            width: 21px;
            height: 22px;
            top: 14px;
            margin: 0 0.44rem 0 0;
            vertical-align: top;
            background-size: 19px 22px;
            background-repeat: no-repeat;
        }
        .title {
            display: inline-block;
            font-size: @hm-font-size-base;
            line-height: 50px;
            color: @text-color;
        }
        .value{
        	position:absolute;
        	right: 36px;
        	line-height: 50px;
        	font-size: @hm-font-size-xs;
			color: @tips-color;
        }
        .icon-right,.rightStyle{
            position: absolute;
        }
        .icon-right{
            right: 16px;
            top: 16px;
            width: 10px;
            height: 18px;
            background-size: 10px 18px;
            background-repeat: no-repeat;
            .bg-image('right_list_n');
        }
    }
}
</style>
