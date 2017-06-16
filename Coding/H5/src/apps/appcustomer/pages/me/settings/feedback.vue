<template>
	<div class="feeback-wrapper">
		<div>
			<nav-header title="Feedback" :showLeft="true" :showRight="true">
		   		<div class="feedback-right-btn" slot="right">
        			<slot name="right">Submit</slot>
           	 	</div>
        	</nav-header>
		</div>
		<div class="feedback-content">
			<ul>
				<li>
				<textarea rows="4" cols="60" @keyup="checkLen()" v-model="textArea" maxlength="240" placeholder="Please describe your issue">
				</textarea>
				<li>
					<!--<span>
						<img src="../../../assets/images/me/settings/add_n_2x.png"/>
					</span>-->
					<span v-bind:class="{'active2': isActive,'active-gray':hasError}">{{count}}</span>
				</li>
			</ul>
		</div>
	</div>
</template>
<script>
import NavHeader from '../../../../../components/header/nav-header';
	export default {
		name: 'feedback',
		data() {
			return {
				rightText : 'Submit',
				showRightButton: "true",
				textArea: '',
				count:240,
				isActive: '',
				hasError:true
			}
		},
		 //创建之前
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'feedback');
	    },
	    components: {
	        NavHeader
	    },
		methods:{
		    checkLen(){
		    	var maxChars = 240;//最多字符数 
		    	this.textArea = this.textArea.substring(0,maxChars); 
			   	this.count = maxChars - this.textArea.length; 
			    if (this.textArea.length === maxChars){
			    	this.isActive = true;
			    	this.hasError = false;
			    }
			    else{
			    	this.hasError = true;
			    	this.isActive = false;
			    }
		    }
		}
};
</script>
<style lang="less">
@import url('../../../assets/css/base.less');
@import url('../../../assets/css/mixin.less');
	html{
		height: 100%;
		background: #f8f8f8;
	}
	.feeback-wrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
	}
	.feedback-right-btn{
		font-size: 0.26rem;
		color: #1552e1;
	}
	.feedback-content{
		background: #FFFFFF;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.feedback-content li:nth-child(1){
		/*width: 7.02rem;*/
		/*height: 2.51rem;*/
		height: 125px;
		/*margin-top: 0.23rem;*/
		margin-top: 12px;
		margin-left: 0.24rem;
	}
	.feedback-content textarea{
		width: 7.02rem;
		/*height: 2.3rem;*/
		height: 115px;
		resize: none;
		font-size: 0.32rem;
		border: none;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.feedback-content li:nth-child(2){
		/*height: 1.3rem;*/
		height: 65px;
		margin-left: 0.24rem;
		margin-top: 10px;
	}
	.feedback-content li:nth-child(2) span{
		display: block;
	}
	/*.feedback-content li:nth-child(2) span:nth-child(1){
		background: #f1f1f1;
		width: 1.8rem;
		height: 1.8rem;
		margin-top: 0.1rem;
		margin-left: 0.1rem;
		float: left;
	}
	.feedback-content li:nth-child(2) span:nth-child(1) img{
		widows: 0.58rem;
		height: 0.58rem;
		margin-left: 0.6rem;
		margin-top: 0.6rem;
	}*/
	.feedback-content li:nth-child(2) span:nth-child(1){
		float: right;
		/*margin-top: 0.7rem;*/
		margin-top: 35px;
		margin-right: 0.3rem;
		font-size: @font-16px;
	}
	.active-gray{
		color:#cccccc;
	}
	.active2{
		color:red;
	}
	.active3{
		color: yellow;
	}
</style>