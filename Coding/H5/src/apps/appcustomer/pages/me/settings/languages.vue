<template>
	<div class="language-wrapper">
		 <nav-header title="Languages settings" :showLeft="true" :showRight="false" :rightFunc="toSettings" :leftFunc="goBack">
	 		<div class="languages-right-btn" slot="right">
    				<slot name="right">Save</slot>
       	 	</div>
        </nav-header>
		<div class="language-content">
		     <mt-radio
		    align="right"
      		v-model="value1"
      		:options="options1" />
		</div>
	</div>
</template>
<script>
	import NavHeader from '../../../../../components/header/nav-header';
	import { Radio } from 'mint-ui';
	
	export default {
		name: 'languages',
		data(){
			return{
				value1:"",
				value2:'',
				options1:['English', 'Japanese', 'Korean','French']
			}
		},
	    components: {
	        NavHeader
	    },
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'languages');
//	        console.log("languages","pushKeepAlive")
	    },
    	methods: {
	   		toSettings () {
	   			this.value2 = this.value1;
//	   			alert(this.value1)
	   			this.$router.push({
					path:'/me/settings',
					query: {bill_type: this.value2}
				});
	   		},
	   		goBack(){
//			this.$store.dispatch('popKeepAlive', "languages");
				this.$router.push({
					path:'/me/settings',
					query: {bill_type: this.value2}
				});
			}
   		},
   		    activated: function () {
        		this.value1=this.$route.query.bill_type;
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleBlack();
            }
        },
// 		 created() {
// 		 	this.options1 = ['English', 'Japanese', 'Korean','French'];
//		 },
 		
	};
</script>
<style lang="less">
	@import url('../../../assets/css/mixin.less');
	@import url('../../../assets/css/base.less');
	html{ height:100%;background: #f8f8f8; }
	.language-wrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
	}
	.language-wrapper .mint-cell-wrapper{
		padding: inherit;
	}
	.languages-right-btn{
		font-size: 0.28rem;
		color: #1551e3;
	}
	.language-content{
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.language-content .mint-radio-input{
		background: url(~assets/images/common/icon_choose_2x.png);
	}
	.language-content .mint-radio-input:checked{
		background-color:none;
	}
	.language-content .mint-radio-core{
		background-color:none;
		border-color: none;
		border: none;
		width: 0.42rem;
		height: 0.42rem;
	}
	.language-content .mint-radio-core:after{
		background: url(~assets/images/common/icon_choose_2x.png);
		background-size: 0.42rem 0.42rem;
		background-position: center center;
		border-radius: 100%;
		/*border:1px solid green;*/
		left: 0;
		top: 0;
		width: 0.42rem;
		height: 0.42rem;
	}
	.language-content .mint-radio{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		display: inline-block;
	}
	.language-content .mint-radio-label{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		display: inline-block;
	}
	.language-content .mint-radio-input:checked{
		background-color:none;
	}
	.language-content .mint-radio-input:checked+.mint-radio-core{
		background: none;
		border-color:green;
	}
</style>

