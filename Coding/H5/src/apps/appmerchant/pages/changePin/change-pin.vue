/**
 * 修改PIN 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
	<div class="change-pin">
		<nav-header title="Reset Pin Password"></nav-header>
		<div class="initial-info">
            <span class="text">{{$t('info_重置初始PIN')}}</span>
        </div>
        <div class="input-wrapper">
        	<password-control :count="count" class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
        </div>

	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import passwordControl from '../../../../components/input/password-control';
	
	export default {
		name:'set-new-pin',
		data() {
			return {
				text1:this.$t('label_登录_密码'),//子组件传入参数
        		text2:this.$t('label_确认_密码'),//子组件传入参数
				active: false,
				password: '',
				count:4,
			}
		},
		computed: {

		},
		components: {
			NavHeader,
			passwordControl
		},
		beforeCreate() {
			// 加入缓存
			this.$store.dispatch('pushKeepAlive', 'set-new-pin');
		},
		beforeMount() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
	    activated() {
	        //设置沉浸式状态栏
	        if (this.$root.supportTranslucentStatus) {
	            this.$root.setStatusStyleBlack();
	        }
	    },
		methods: {
			compare(value) {
//          let register = 1;//验证类型： 1：注册  2：登录
//          this.showIndicator();
//          this.serverApi.checkVerificationCode({
//              phone: this.$route.query.phone,
//              verificationCodeType: register,
//              verificationCode: value
//          }, null, (error, data) => {
//              this.hideIndicator();
//              if(error){
//                  this.showToast(error.message);
//                  this.$refs.passwordControl.text = '';
//                  return;
//              }
//              this.$router.push({
//                  path: '/resetPin/setNewPin',
//                  query: {
//                      intitialPIN: value
//                  }
//              });
//          })
            this.$router.push({
                    path: '/changePin/set-new-pin',
                    query: {
                        intitialPIN: value
                    }
                });
    	},
		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
	.change-pin{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: @layout-bg-color;
		&:before {
		  content: "";
		  position: fixed;
		  z-index: -1;
		  top: 0;
		  right: 0;
		  bottom: 0;
		  left: 0;
		  background-color: @content-bg-color;
		  background-repeat: no-repeat;
		  background-size: cover;
		}
		.initial-info {
            padding: 12px 0.24rem 10px;
		    color: @text-color;
	        font-size: @hm-font-size-sm;
		    line-height: 11px;
		}
		
		.input-wrapper {
	        padding: 0 0.24rem;
	        background-color: @content-bg-color;
	        .input-padding {
	            padding:10px 0;
	        }
    	}
		
	}
</style>