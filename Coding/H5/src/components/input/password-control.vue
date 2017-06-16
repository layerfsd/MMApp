/** * 密码框组件 * @author 王亮 * * */
<template>
    <div class="input-control">
        <input type="tel" @keyup="keyup($event)" class="inputArea" :maxlength="count" v-model="text" autofocus="true" id="password" unselectable="true">
        <label for="password">
            <ul class="show-wrapper">
                <li v-for="itemClass in itemClasses" class="show-item" :class="itemStyle">
                    <span :class="itemClass" class="dot"></span>
                </li>
            </ul>
        </label>
    </div>
</template>
<script>
const CLS_ON = 'on'; //表示输入框有内容
const CLS_OFF = 'off'; //表示输入框没有内容
export default {
    data() {
            return {
                text: ''
            }
        },
        deactivated() {
            this.text = '';
        },
        props: {
            count: {
                type: Number,
                default: 6
            }
        },
        computed: {
            itemClasses() {
                let result = [];
                let array = this.text.split('');
                for (let i = 0; i < array.length; i++) {
                    result.push(CLS_ON);
                }
                if (array.length < this.count) {
                    let i = 0;
                    while (i < (this.count - array.length)) {
                        result.push(CLS_OFF);
                        i++;
                    }
                }
                return result;
            },
            itemStyle() {
                return 'count_' + this.count;
            }
        },
        methods: {
            keyup(event) {
                let len = event.target.value.length;
                if (len === this.count) {
                    this.$emit('getChange', event.target.value);
                }
            }
        }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.input-control {
    .inputArea {
        position: absolute;
        left: -1000px; //将光标移至屏幕外
        opacity: 0;
        z-index: -2;
    }
    .show-wrapper {
        display: flex;
        justify-content: space-between;
    }
    .show-item {
        display: inline-block;
        height: 46px;
        line-height: 46px;
        text-align: center;
        background-color: #ececec;
        &.count_4 {
        	flex: 0 0 20%;
        	width: 20%;
            margin-right: 0.46rem;
            &:last-child {
                margin-right: 0;
            }
        }
        &.count_6 {
        	flex: 0 0 13.6%;
        	width: 13.6%;
            margin-right: 0.18rem;
            &:last-child {
                margin-right: 0;
            }
        }
        .dot {
            display: inline-block;
            padding: auto;
            width: 10px;
            height: 10px;
            vertical-align: middle;
            line-height: 46px;
            text-align: center;
            border-radius: 50%;
        }
        .on {
            background-color: #000;
        }
        .off {
            background-color: transparent;
        }
    }
}
</style>
