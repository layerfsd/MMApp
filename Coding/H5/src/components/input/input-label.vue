<template>
    <div class="input-label">
        <div class="input-label-wrapper border-1px">
            <div class="label">
                <label :for="label" class="label-name">
                    {{label}}
                </label>
            </div>
            <div class="input-primary-wrapper">
                <input-primary :isRequired="isRequired" :label="label" @getValue="getField"></input-primary>
            </div>
        </div>
    </div>
</template>
<script>
import inputPrimary from '../../components/input/input-primary';
export default {
    props: {
        isRequired: {
            type: Boolean,
            default: true //是否必要显示清空按钮
        },
        label: {
            type: String,
            default: 'Cornet'
        },
        placeholder: {
            type: String
        }
    },
    methods: {
        // 将值传递给父组件
        getField(value) {
            this.$emit('getMessage', value);
        },
    },
    components: {
        inputPrimary
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
@import url('~assets/css/icon.less');
.input-label {
    .input-label-wrapper {
        display: flex;
        height: 50px;
        border-radius: 0.1rem;
        background-color: @content-bg-color;
        .border-1px(@default-border-color);
        color: @text-color;
        font-size: 0;
        .label {
            flex: 0 0 2.8rem;
            width: 2.4rem;
            line-height: 50px;
            .label-name {
                display: inline-block;
                padding-left: 0.4rem;
                width: 100%;
                box-sizing: border-box;
                font-size: @hm-font-size-lg;
            }
        }
        .input-primary-wrapper{
            flex: 1;
            width: 100%;
        }
    }
}
</style>
