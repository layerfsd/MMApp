/* * 输入社保卡号 enter-account * 
 * 	 @Date : 2017-05-18 * 
	 @Author : 徐伟辉 * 
	 @Version : V1.0 
 * */
<template>
	<div class="enterAccountWrapper">
		<div class="enterAccountHead">
			<nav-header :title="title"></nav-header>
		</div>
		<div class="enterAccountMiddle">
			<img class="enterAccountPic" src="~assets/images/common/social_security_card_1_2x.png"/>
			<input-account @getValue="getValue"></input-account>
		</div>
    	<div class="enterAccountFooter">
			<button type="button" :class="{active: !isEmpty}" class="btn" :disabled="this.isEmpty" @click='submit'>{{$t('action_下一步')}}</button>
    	</div>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import inputAccount from '../../components/input/input-account';
	
	export default{
		name:'enterAccount',
		data(){
			return{
				title:this.$t('label_社保卡'),
				text: '',
				cardNo:'',
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'enterAccount');
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
		computed:{
			isEmpty() {
	    		if(this.cardNo.length==10){
	    			return false;
	    		}
	    		return true;
	    	}
		},
		activated(){
			this.cardNo = '';
		},
		methods:{
			getValue(msg){
				this.cardNo = msg;
			},
			submit(){
           	 	this.showIndicator();
				this.serverApi.querySSCStatus(
					{cardNo:this.cardNo},
					null,
                (error, data) => {
                    this.hideIndicator();
                    if (error) {
                        this.showToast(error.message);
                        return;
                    } else {
                    	this.$router.push("chargeSocialSecurityFee");
//                  	this.$router.push({
//							path:'/forgotPassword/verficationCode',
//							query: {phone:this.phone}
//						});
                    }
            	});
			}
		},
		components:{
			navHeader,
			inputAccount
		}
	}
	
</script>
<style lang="less" scoped>
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
.enterAccountWrapper{
	position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background:url("~assets/images/common/card_pay_bg_2.jpg");
		background-color: @layout-bg-color;
}
.enterAccountMiddle{
		text-align: center;
		.enterAccountPic{
			width:65px;
			height:65px;
			margin-top: 60px;
		}
	}
.enterAccountFooter{
	.btn{
		margin: 15px 5% 0 5%;
		&.active{
			/*background-color: @active-bg-btn-color;*/
		}
	}
}
	
</style>