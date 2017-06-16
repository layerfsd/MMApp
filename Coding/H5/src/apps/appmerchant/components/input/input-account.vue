/** *2017/5/17 账号输入组件 * @author 徐伟辉 * * */
<template>
	<div class="input-control">
        <input type="tel" @keyup="checkField" class="inputArea" :maxlength="count" v-model="text" autofocus="true" id="verfication" unselectable="on">
        <label for="verfication">
            <ul class="show-wrapper">
                <li v-for="itemValue in itemValues" class="show-item">
                    <span>{{itemValue}}</span>
                </li>
            </ul>
        </label>
	</div>
</template>
<script>
	export default{
		data(){
			return{
				text: ''
			}
		},
		props: {
	        count: {
	            type: Number,
	            default: 10
	        }
	    },
	    deactivated() {
	        this.text = '';
	    },
	    computed: {
	        itemValues() {
	            let result = [];
	            for (let i = 0, len = this.text.length; i < len; i++) {
	                result.push(this.text[i]);
	            }
	            if (this.text.length < this.count) {
	                let i = 0;
	                while (i < (this.count - this.text.length)) {
	                    result.push(' ');
	                    i++;
	                }
	            }
	            return result;
	        }
	    },
		methods:{
//			keyup(event) {
//          	let len = event.target.value.length;
//	            if (len === this.count) {
//	                this.$emit('getChange', event.target.value);
//	            }
//	       },
	       checkField(){
	       		this.$emit('getValue', this.text);
	       }
		},
	}
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
	/*.enter-account-middle{
		text-align: center;
		.enter-account-pic{
			margin-top: 60px;
		}
	}*/
	.input-control {
		width:7rem;
		margin:30px auto;
    .inputArea {
        position: absolute;
        left: -1000px;//将光标移至屏幕外
        opacity: 0;
        z-index: -2;
    }
    .show-wrapper {
        display: flex;
    }
    .show-item {
        flex: 1;
        display: inline-block;
        width: 50px;
        height: 40px;
        line-height: 40px;
        text-align: center;
        /*margin-right: 9px;*/
       border-right: 1px solid white;
        background-color: #ececec;
        color: @theme-text-color;
        &:last-child {
            margin-right: 0;
        }
    }
}
</style>