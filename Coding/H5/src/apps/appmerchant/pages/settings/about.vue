<template>
	<div class="aboutWrapper">
		<div class="about-head">
			<nav-header :title="title" :showLeft="true" :showRight="false">
        	</nav-header>
		</div>
			<div class="about-content">
			<ul>
				<li><img src="~assets/images/common/mm_logo_2x.png"/></li>
				<li>{{version}}</li>
			</ul>
		</div>
		<div class="about-content-bottom">
			<ul>
				<li class="border-1px">
					<span>{{$t('label_检查新版本')}}</span>
					<span><img src="~assets/images/common/new-01_2x.png"/></span>
				</li>
				<li>
					<span>{{$t('label_服务热线')}}</span>
					<span>{{telephoneHotline}}</span>
				</li>
			</ul>
		</div>
		<div class="about-footer">
			{{copyright}}
		</div>
	</div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import cell from '../../../../components/cell/cell';
	export default {
	name: 'about',
	data(){
		return {
			title:this.$t('label_设置关于'),
			version: 'Mobile Money 1.0.0',
			telephoneHotline:'+46  (0)  727 267 045',
			copyright: this.$t('info_版权')
		}
	},
 	//创建之前
    beforeCreate(){
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'about');
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
    components: {
        navHeader,
        cell
    }
};
</script>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
	/*html{ height:100%;background: #f8f8f8; }*/
	.about-head{
		position: fixed;
		width: 100%;
	}
	.aboutWrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
		overflow: auto;
	}
	.about-content{
		/*height: 3.25rem;*/
		text-align: center;
		/*margin-top: 2rem;*/
		margin-top: 100px;
	}
	.about-content li:nth-child(1) img{
		width: 80px;
		height: 80px;
	}
	.about-content li:nth-child(2){
		/*font-size: 0.4rem;*/
		font-size: @font-20px;
		margin-top: 20px;
		margin-bottom: 40px;
		color: @text-color;
	}
	.about-content-bottom{
		/*height: 2.02rem;*/
		height: 100px;
		background: @content-bg-color;
	}
	.about-content-bottom li{
		/*height: 1rem;*/
		height: 50px;
		.border-1px(@default-border-color);
		&:last-child{
			.border-none();
		}
	}
	.about-content-bottom li span{
		display: block;
	}
	.about-content-bottom li:nth-child(1){
		// border-bottom: 1px solid lightgray;
	}
	.about-content-bottom li:nth-child(1) span:nth-child(1){
		/*font-size: 0.28rem;*/
		font-size: @font-16px;
		color: #343434;
		float: left;
		margin-left: 0.27rem;
		/*line-height: 1rem;*/
		line-height: 50px;
	}
	.about-content-bottom li:nth-child(1) span:nth-child(2){
		float: right;
		margin-right: 0.42rem;
	}
	.about-content-bottom li:nth-child(1) span:nth-child(2) img{
		width: 32px;
		height: 17px;
		margin-top: 16px;
	}
	.about-content-bottom li:nth-child(2){
		/*line-height: 1rem;*/
		line-height: 50px;
	}
	.about-content-bottom li:nth-child(2) span:nth-child(1){
		/*font-size: 0.28rem;*/
		font-size: @font-16px;
		color: #343434;
		float: left;
		margin-left: 0.27rem;
	}
	.about-content-bottom li:nth-child(2) span:nth-child(2){
		float: right;
		margin-right: 0.3rem;
		/*font-size: 0.3rem;*/
		font-size: @font-16px;
		color: #9a9a9a;
	}
	.about-footer{
		font-size: 12px;
		color: #9a9a9a;
		text-align: center;
		/*margin-top: 5.28rem;*/
		margin-top: 264px;
	}
</style>