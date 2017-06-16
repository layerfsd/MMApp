/**
 * date: 2017-04-12
 * author: wangliang
 * 日期控件
 *
 */
<template>
    <div class="input-birth">
        <div class="input-wrapper">
            <input type="tel" id="text" class="birth" v-model="birth" @keyup="birthday($event)" unselectable="on" maxlength="6">
        </div>
        <label for="text">
	        <div class="show-wrapper" v-show="birth">
	            <span class="show-item">{{birth[0]}}</span>
	            <span class="show-item">{{birth[1]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{birth[2]}}</span>
	            <span class="show-item">{{birth[3]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{birth[4]}}</span>
	            <span class="show-item">{{birth[5]}}</span>
	        </div>
	        <div class="show-wrapper" v-show="!birth">
	            <span class="show-item">{{placeHolder[0]}}</span>
	            <span class="show-item">{{placeHolder[1]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{placeHolder[2]}}</span>
	            <span class="show-item">{{placeHolder[3]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{placeHolder[4]}}</span>
	            <span class="show-item">{{placeHolder[5]}}</span>
	        </div>
        </label>
    </div>
</template>
<script>
const LENGTH = 6;
export default {
	data() {
		return {
			birth: '',
			placeHolder: 'YYMMDD',
			require: false
		}
	},
	activated() {
		this.birth = '';
	},
	methods: {
		birthday(event) {
			let value = event.target.value;
			if(value.length === LENGTH){
				console.log(value);
				this.$emit('getBirthday', {
					birthday: value,
					require: true
				});
			}
		}
	}
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
	.input-birth{
		.input-wrapper{
			position: relative;//解决输入值时，页面上弹的问题
			.birth{
				position: absolute;
				left: -1000px;//处理苹果手机光标问题
				opacity: 0;
				z-index: -1;
			}
		}
	}
	.show-wrapper{
		display: flex;
		.show-item{
			flex: 1;
			display: inline-block;
			width: 35px;
			height: 35px;
			line-height: 35px;
			text-align: center;
			font-size: @hm-font-size-sm;
			margin-right: 0.2rem;
			background-color: #eee;
			color: @theme-text-color;
			&:last-child{
				margin-right: 0;
			}
		}
		.decollator{
			flex: 0.2;
			margin-top: 0.35rem;
			display: inline-block;
			width: 0.06rem;
			border-top: 1px solid @text-color;
			text-align: center;
			margin-right: 0.2rem;
		}
	}
</style>
