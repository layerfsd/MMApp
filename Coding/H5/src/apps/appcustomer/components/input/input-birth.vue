/**
 * date: 2017-04-12
 * author: wangliang
 * 日期控件
 * 
 */
<template>
    <div class="input-birth">
        <div class="input-wrapper">
            <input type="number" id="text" class="birth" placeholder="YYMMDD" v-model="birth" maxlength="6" @keyup="birthday($event)">
        </div>
        <label for="text">
	        <div class="show-wrapper">
	            <span class="show-item">{{birth[0]}}</span>
	            <span class="show-item">{{birth[1]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{birth[2]}}</span>
	            <span class="show-item">{{birth[3]}}</span>
	            <span class="decollator"></span>
	            <span class="show-item">{{birth[4]}}</span>
	            <span class="show-item">{{birth[5]}}</span>
	        </div>
        </label>
    </div>
</template>
<script>
const LENGTH = 6;
export default {
	data() {
		return {
			birth: 'YYMMDD',
			require: false
		}
	},
	watch: {
		birth: function(value) {
			if(!value) {
				this.birth = 'YYMMDD';
			}
		}
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
			position: absolute;
			z-index: -1;
			opacity: 0;
			.birth{
			}
		}
	}
	.show-wrapper{
		display: flex;
		.show-item{
			flex: 1;
			display: inline-block;
			width: 0.7rem;
			height: 0.7rem;
			line-height: 0.7rem;
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
			border-top: 1px solid #3a3a3a;
			text-align: center;
			margin-right: 0.2rem;
		}
	}
</style>
