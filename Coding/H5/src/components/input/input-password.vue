/* * 文件输入框组件
 * @Date : 2017-03-16
 * @Author : wangliang
 * @Version : V1.0
 *
 */
<template>
	<div class="input-text">
		<div class="input-wrapper" v-for="item in infoList">
			<input type="password" id="input1" v-model="item.password" @keyup="checkField($event,item)" ref="input" maxlength="6" unselectable="on" :placeholder="item.placeholder" @focus="checkValue($event,item)" @blur="hide(item)">
			<span class="icon-close"  ref="clear" v-show="item.isShow" @mousedown="clear($event,item)"></span>
		</div>
	</div>
</template>
<script>
	export default {
		name: 'input-text',
		data() {
			return {
				isOpenEye: true,
				password1: '',
				password2: '',
				checked: false,
				isShow1: false,
				isShow2: false,
				infoList: []
			}
		},
		created() {
			this.infoList = [
				{
					placeholder: this.text1,
					isShow: this.isShow1,
					password: this.password1
				},
				{
					placeholder: this.text2,
					isShow: this.isShow2,
					password: this.password2
				}
			]
		},
		deactivated() {
			this.password1 = '';
			this.password2 = '';
		},
		props: {
			text1: {
				type: String,
				default: 'Login Password'
			},
			text2: {
				type: String,
				default: 'Comfirm Password'
			},
			openEye: {
				type: Boolean,
				default: true
			}
		},
		methods: {
			checkField(event,item) {
				this.checkValue(event,item);
				this.checked = true;
				this.infoList.forEach((info, index) => {
					if(!info.password){
						this.checked = false;
					}
					this['password' + (index+1)] = info.password;
				});

				console.log('password1: '+ this.password1 + ';' + 'password2: '+ this.password2)

				this.$emit('input-completed',{
					checked: this.checked,
					setPassword: this.password1,
					comfirmPassword: this.password2
				});
			},
			checkValue(event,item) {
				let value = event.target.value || '';
				item.password = value;
	            if(value){
	                //有内容，显示清空按钮
	                item.isShow = true;
	            }else {
	                // 没有内容,隐藏清空按钮
	                item.isShow = false;
	            }
	        },
	        // 隐藏
	        hide(item){
	        	item.isShow = false;
	        },
	        // 清空
			clear(event,item) {
				item.password = '';
				this.checkField(event,item);
			}
		},
	};
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	@import url('~assets/css/icon.less');
	.input-text{
		font-size: @hm-font-size-base;
		color: @text-color;
		margin-top: 0.2rem;
		.input-wrapper{
			position: relative;
			display: flex;
			padding: 0 0.24rem;
			height: 50px;
			line-height: 50px;
			box-sizing: border-box;
			background-color: @content-bg-color;
			.border-1px(@default-border-color);
			&:last-child::after{
				.border-none();
			}
			input{
				width: 100%;
				height: 100%;
				line-height: 1;
				text-align: center;
				outline: none;
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
</style>