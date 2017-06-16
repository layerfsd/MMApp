/**
 * 钱包-首页
 * @author 徐伟辉(1506487526@qq.com)
 * 
 * 
 */
<template>
	<div class="cash-title-wrapper">
		<div class="cash_title_position" id="cash_title_position">
			<nav-header title="Cash Wallet" leftText="Home" :leftFunc='cashToHome'>
        	</nav-header>
			<div class="cash-title-middle">
				<ul>
					<li>
						<span>Balance</span>
						<span><b>€</b><b>2,900.00</b></span>
					</li>
					<!--<li><img src="../../assets/images/tubiao_2x.png"/></li>-->
				</ul>
			</div>
			<div class="cash-title-bottom">
				<ul>
					<li>Recent</li>
					<li>
						<router-link to='/transactions' slot="right">	
							Check all
						</router-link>	
					</li>
				</ul>
			</div>
		</div>
		<!--根据MintUI给的例子，需要计算滚动区域的高度-->
		<div class="cash-content" ref="wrapper" :style="{ height: wrapperHeight + 'px' }">
			<!--infinite-scroll-disabled: 若为真，则无限滚动不会被触发-->
			<!--infinite-scroll-distance: 触发加载方法的滚动距离阈值（像素）-->
			<!--infinite-scroll-immediate-check 若为真，则指令被绑定到元素上后会立即检查是否需要执行加载方法。 -->
			<div
			  v-infinite-scroll="loadMore"           
			  infinite-scroll-disabled="infiniteScrollDisabled"
			  infinite-scroll-distance="10"
			  infinite-scroll-immediate-check="false"			  
			  class="cash-content-wrapper">
			  	<ul v-for="(item, index) in list">
					<li class="cash-content-top">
						<span>{{item.month}}</span>
						<span>{{item.year}}</span>
					</li>
					<li class="cash-content-bottom">
						<dl>
							<dt>{{item.week}}</dt>
							<dd>{{item.date}}</dd>
						</dl>
						<dl>
							<dd><img src="~assets/images/common/logo_2x.png"/></dd>
							<dd></dd>
						</dl>
						<dl>
							<dt>{{item.week}}</dt>
							<dd>{{item.merchant}}</dd>
						</dl>
					</li>
					<li class="cash-content-bottom">
						<dl>
							<dt>{{item.week}}</dt>
							<dd>{{item.date}}</dd>
						</dl>
						<dl>
							<dd><img src="~assets/images/common/starbuck.png"/></dd>
						</dl>
						<dl>
							<dt>{{item.money}}</dt>
							<dd>{{item.merchant}}</dd>
						</dl>
					</li>
				</ul>
			</div>
			<!-- 加载更多 -->
			<p v-show="loading" class="page-infinite-loading">
		        <mt-spinner type="fading-circle"></mt-spinner>
		        Loading...
		    </p>
			<!-- 已经没有更多数据了 -->
		</div>
		<footer class="cash-footer" ref="footer" ></footer>
	</div>
</template>
<script>
// import InfiniteScroll from '../../../../components/infinite-scroll';
import NavHeader from '../../../../components/header/nav-header';
import { Toast, MessageBox } from 'mint-ui';

export default {
	name:"cash",
	components: {
   		NavHeader
   	},
	data() {
		return {
			list: [],           //无限滚动加载的数据
			loading: false,     //无限滚动加载中
			noMoreData: false,  //无限滚动数据已经全部加载
			wrapperHeight: 0    //无限滚动区域高度，在mounted里计算

//			loading: true
		}
	},
	beforeCreate(){
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'cash');

    },
    beforeMount: function () {
        console.log("cash, beforeMount");
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleLight();
        }
    },
    activated: function () {
        console.log("cash, activated");
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleLight();
        }
    },
    deactivated: function () {
        console.log("cash, deactivated");
    },
    beforeUpdate: function () {
        console.log("cash, beforeUpdate");
    },
	computed: {
	    // a computed getter
	    infiniteScrollDisabled: function () {
	    	if (this.loading)
	    		return true;
	    	if (this.noMoreData)
	    		return true;
	    	return false;
	    }
	},
    mounted()
    {
    	//this.wrapperHeight = document.documentElement.clientHeight - this.$refs.wrapper.getBoundingClientRect().top;
    	this.wrapperHeight = this.$refs.footer.getBoundingClientRect().top - this.$refs.wrapper.getBoundingClientRect().top;
    	this.loadMore();
    },
	methods: {
		//获取更多数据
		moreData(start, limit, callback){
            this.serverApi.getCashWalletTrans({start: start, limit:limit}, null, function(error, data, wentLogin) {
                callback(error, data, wentLogin);
            });
        },
		//供无限滚动调用
		loadMore(){
			console.log("loadMore");
			//已经全部加载完成
	        if (this.noMoreData)
	        	return;
	        //触发加载中
			this.loading = true;
			let start =  this.list.length;
			let limit = 5;  //每次加载的记录中

			let self = this;
			this.moreData(start, limit, function(error, data, wentLogin) {
				self.loading = false;
				//如果出错，给出提示信息
				if (error) {
					if (wentLogin)
						return;
					MessageBox({
					  title: '',
					  message: error.message,
					  showCancelButton: true,
					  confirmButtonText: 'Retry',
					  cancelButtonText: 'Cancel'
					}).then(action => {
						if (action==='cancel') {
							return;
						}
						self.loadMore();
					});
					return;
				}
				if (data.result.length < limit) {
					self.noMoreData = true;
				}
				self.list = self.list.concat(data.result);
			});
		},
        //页面创建时
        created(){

        },
        cashToHome(){
   			this.$router.replace('/home');
   		}
	}
}
</script>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
	#cash_title_position .nav-left-text{
		font-size: 0.26rem;
		/*line-height: 36px;*/
	}
	/*#cash_title_position .header img{
		margin-top:0.32rem;
	}*/
	#cash_title_position .header{
		background-color: none;
	}
	.cash-content-wrapper{
		/*background: #FFFFFF;*/
		/*padding-top: 10px;*/
		margin-top: 25px;
	}
	.cash-content-wrapper ul{
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
	}
	.cash-title-wrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background: #f8f8f8;
		/*font-size: 0.36rem;*/
	}
	.cash_title_position{
		position: fixed;
		width: 100%;
		top: 0;
		left: 0;
		z-index: 1;
	}
	.cash-title-middle{
		/*height: 1.42rem;*/
		height: 71px;
		background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#D90647), to(#EB402C)); 
	} 
	.cash-title-middle li:nth-child(1){
		float: left;
		margin-left: 0.24rem;
	}
	.cash-title-middle li span{
		display: block;
	}
	.cash-title-middle li:nth-child(1) span:nth-child(1){
		/*width: 0.54rem;
		height: 0.27rem;*/
		width: 27px;
		height: 13.5px;
		font-size: @hm-font-size-sm;
		color: @theme-font-color;
		margin-top: 8px;
	}
	.cash-title-middle li:nth-child(1) span:nth-child(2){
		/*height: 0.56rem;*/
		height: 28px;
		margin-top: 9px;
		color: #FFFFFF;
	}
	.cash-title-middle li:nth-child(1) span:nth-child(2) b{
		display: block;
		float: left;
	}
	.cash-title-middle li:nth-child(1) span:nth-child(2) b:nth-child(1){
		/*font-size: 0.28rem;
		margin-top: 0.16rem;*/
		font-size: 18px;
		margin-top: 8px;
	}
	.cash-title-middle li:nth-child(1) span:nth-child(2) b:nth-child(2){
		/*font-size: 0.5rem;*/
		font-size: 30px;
		margin-left: 0.1rem;
	}
	.cash-title-middle li:nth-child(2){
		float: right;
		margin-right: 0.6rem;
	}
	.cash-title-middle li:nth-child(2) img{
		width: 0.92rem;
		height: 0.96rem;
		margin-top: 0.18rem;
	}
	.cash-title-bottom{
		background: #f8f8f8;
		/*height: 0.62rem;
		line-height: 0.82rem;*/
		height: 41px;
		line-height: 41px;
	}
	.cash-title-bottom li:nth-child(1){
		float: left;
		margin-left: 0.24rem;
		color: @tips-color;
		/*font-size: 0.28rem;*/
		font-size: @hm-font-size-sm;
	}
	.cash-title-bottom li:nth-child(2){
		float: right;
		margin-right: 0.25rem;
		/*font-size: 0.28rem;*/
		font-size: @hm-font-size-sm;
	}
	.cash-title-bottom li:nth-child(2) a{
		color: #6E85ED;
	}
	.cash-content{
		/*margin-top: 2.92rem;*/
		margin-top: 148px;
		height: 9.5rem;
		overflow: auto;
        -webkit-overflow-scrolling: touch;
	}
	.cash-content-top{
		height: 0.8rem;
		line-height: 0.8rem;
		font-size: 0.28rem;
		color: #333333;
		background: #FFFFFF;
	} 
	.cash-content-top span:nth-child(1){
		margin-left: 0.24rem;
	}
	.cash-content-top span:nth-child(2){
		margin-left: 0.12rem;
	}
	.cash-content-bottom{
		height: 1.29rem;
		border-top:1px solid lightgray;
		background: #FFFFFF;
	}
	.cash-content-bottom dl{
		float: left;
	}
	.cash-content-bottom dl:nth-child(1){
		width: 2.26rem;
		margin-left: 0.24rem;
	}
	.cash-content-bottom dl:nth-child(1) dt{
		font-size: 0.32rem;
		color: #999999;
		margin-top: 0.34rem;
	}
	.cash-content-bottom dl:nth-child(1) dd{
		font-size: 0.2rem;
		color: #999999;
		margin-top: 0.1rem;
	}
	.cash-content-bottom dl:nth-child(2) dd img{
		width: 0.9rem;
		height: 0.9rem;
		margin-top: 0.2rem;
	}
	.cash-content-bottom dl:nth-child(3){
		margin-left: 0.64rem;
	}
	.cash-content-bottom dl:nth-child(3) dt{
		font-size: 0.32rem;
		color: #333333;
		margin-top: 0.34rem;
	}
	.cash-content-bottom dl:nth-child(3) dd{
		font-size: 0.2rem;
		color: #333333;
		margin-top: 0.1rem;
	}
	.cash-footer{
		width: 100%;
		height: 1px;
		background: #FFFFFF;
		position: fixed;
		bottom: 0;
		left: 0;
	}
	.page-infinite-loading {
		text-align: center;
        height: 50px;
        line-height: 50px;
        div {
          display: inline-block;
          vertical-align: middle;
          margin-right: 5px;
        }
	}
</style>

