<template>
	<div class="language-wrapper layout">
		 <nav-header title="Languages settings" :showLeft="true" :showRight="false" :rightFunc="toSettings" :leftFunc="goBack">
	 		<div class="languages-right-btn" slot="right">
    			<slot name="right">Save</slot>
       	 	</div>
        </nav-header>
		<div class="language-content">
		     <mt-radio align="right" v-model="value" :options="options" />
		</div>
	</div>
</template>
<script>
	import navHeader from '../../../../components/header/nav-header';
	import Vue from 'vue';

	export default {
		name: 'languages',
		data(){
			return{
				value:'',
				options: [
					{
						label: 'English',
						value: 'en'
					},
					{
						label: 'Japanese',
						value: 'jp'
					},
					{
						label: 'Korean',
						value: 'kr'
					},
					{
						label: 'French',
						value: 'fr'
					}
				]
			}
		},
	    components: {
	        navHeader
	    },
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'languages');
	    },

	    created() {
	    	this.value=this.$route.query.lang;
	    	// this.value=this.$store.state.language.lang;
	    	console.log('选择语言：' + this.value);
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
        deactivated() {
        	console.log(this.$store.state.language.lang);
        },
        destroyed() {

	    },
    	methods: {
	   		toSettings () {
	   			this.showIndicator();
	   			Vue.config.lang = this.value;
	   			this.$store.dispatch('saveLanguage',{lang: this.value});

	   			console.log('============localStorage:  =============')
	   			console.log(localStorage);

	   			//返回时删除缓存
	            this.$store.dispatch('popKeepAlive');

	            //设置返回标志，在动画里面处理
	            this.$store.dispatch('setPageAnimationBack', true);

	   			setTimeout(() => {
	   				this.hideIndicator();
		   			this.$router.replace({
						path:'/settings'
					});
	   			}, 1000);
	   		},
	   		goBack(){
	   			//返回时删除缓存
	            this.$store.dispatch('popKeepAlive');

	            //设置返回标志，在动画里面处理
	            this.$store.dispatch('setPageAnimationBack', true);

	            // 回退到注册页面
				this.$router.replace({
					path:'/settings'
				});
			}
   		}
	};
</script>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
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

