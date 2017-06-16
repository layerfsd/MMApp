/**
 * 提现-输入PIN 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="withdraw-enter-pin">
		<nav-header :title="title" :showLeft="true" :showRight="false"></nav-header>
		<div class="enter-pin">
			<p class="tip-withdraw">{{$t('info_提现')}}</p>
			<p class="sum">€{{sum}}</p>
			<p class="fee">{{$t('info_手续费')}} € {{fee}}</p>
			<p class="tip-enter">{{$t('label_输入PIN')}}</p>
			
			<div class="enter-input">
        		<password-control :count="count" class="input-padding" name="changeInitialPIN" @getChange="compare" ref="passwordControl"></password-control>
			</div>

		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import passwordControl from '../../../../components/input/password-control';
	
	export default {
		name:'enter-pin',
		components: {
			NavHeader,
			passwordControl
		},
		data() {
			return {
				title:this.$t('label_提现标题'),
				count:4,//PIN码位数
				sum:'21.20',
				fee:'4.00',
				
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'enter-pin');
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
		methods:{
			//获取密码框值
			compare(value) {
				this.$router.push('/withdraw/withdrawSuccess');
//	            this.showIndicator();
//	            this.serverApi.checkVerificationCode({//无接口，暂用验证码接口替代
//	                phone: this.$store.state.user.phone,
//	                verificationCodeType: this.verificationCodeType,
//	                verificationCode: value
//	            },null, (error, data) => {
//	                this.hideIndicator();
//	                if(error){
//	                    this.showToast(error.message);
//	                    return;
//	                }
//	                this.$router.push('/signUp/setNewPIN');
//	            })
	        }
			
		},
		
		mounted() {
	        
	        
	    },
	    
	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.withdraw-enter-pin{
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: @layout-bg-color;
		
		.enter-pin{
			margin:10px;
			background-color:@content-bg-color ;
			p{
				text-align: center;
			}
			.tip-withdraw{
				color:@text-color;
				font-size: @hm-font-size-lg;
				margin-top: 32px;
			}
			.sum{
				color:@theme-text-color;
				font-size: @hm-font-size-xxl;
				margin-top: 20px;
				
			}
			.fee{
				color:@tips-color;
				font-size: @hm-font-size-xxs;
				margin-top: 5px;
			}
			.tip-enter{
				text-align: left;
				color:@text-color;
				font-size: @hm-font-size-lg;
				margin-top: 24px;
				margin-bottom: 13px;
				margin-left: .3rem;
			}
			
			.enter-input{
				margin-bottom: 30px;
				padding: 0 .3rem;
			}
		}
		
	}

	
	
</style>