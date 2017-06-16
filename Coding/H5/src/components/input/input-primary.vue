<template>
    <div class="input-primary">
        <div class="input-primary-wrapper">
            <div class="input-wrapper" :style="css">
                <input type="text" :id="label" class="input" @keyup="checkField" v-model="text" @focus="checkValue()" @blur="hide()" :placeholder="placeholder" :style="inputStyle">
                <span class="icon-close"  ref="clear" v-show="isShow && isRequired" @mousedown="clear()"></span>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: {
        isRequired: {
            type: Boolean,
        },
        label: {
            type: String
        },
        placeholder: {
            type: String
        },
        css: {
            type: Object
        },
        inputStyle: {
            type: Object
        },
    },
    data() {
        return {
            text: '', //输入框输入内容
            isShow: false //显示清空按钮
        }
    },
    methods: {
        // 将值传递给父组件
        checkField() {
            this.checkValue();
            this.$emit('getValue', this.text);
        },
        checkValue() {
            if(this.text){
                //有内容，显示清空按钮
                this.show();
            }else {
                // 没有内容,隐藏清空按钮
                this.hide();
            }
        },
        // 隐藏清空按钮
        hide(){
            this.isShow = false;
        },
        // 显示清空按钮
        show(){
            this.isShow = true;
        },
        // 清空
        clear() {
            this.text = '';
            this.$emit('getValue', this.text);
        }
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
@import url('~assets/css/icon.less');
.input-primary {
    .input-primary-wrapper {
        .input-wrapper {
            display: flex;
            position: relative;
            flex: 1;
            width: 100%;
            height: 50px;
            line-height: 50px;
            border: none;
            outline: none;
            background-color: transparent;
            font-size: @hm-font-size-sm;
            .input {
            	width: 100%;
                padding: 5px 25px 5px 5px;
                margin: 0;
                box-sizing: border-box;
            }
            .icon-close {
                position: absolute;
                display: inline-block;
                padding: 5px 5px 5px 0;
                right: 0;
                top: 10px;
                width: 20px;
                height: 20px;
                font-size: 20px;
                color: @text-color;
            }
        }
    }
}
</style>
