<template>
	<div>
		<nav-header title="Outflow" :leftFunc='flowToFliters'>
        </nav-header>
        <div class="outflow-banner">
        	<ul>
        		<li>Total outflow {{flowAmount}} pens</li>
        		<li>-€{{flowCost}}</li>
        	</ul>
        </div>
        <div class="transactions-cash-content" ref="wrapper" :style="{ height: wrapperHeight + 'px' }">
			<!--infinite-scroll-disabled: 若为真，则无限滚动不会被触发-->
			<!--infinite-scroll-distance: 触发加载方法的滚动距离阈值（像素）-->
			<!--infinite-scroll-immediate-check 若为真，则指令被绑定到元素上后会立即检查是否需要执行加载方法。 -->
			<div
			  v-infinite-scroll="loadMore"           
			  infinite-scroll-disabled="infiniteScrollDisabled"
			  infinite-scroll-distance="10"
			  infinite-scroll-immediate-check="false"			  
			  >
			  	<ul v-for="(item, index) in list">
					<li class="transactions-content-top">
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
		<footer class="outflow-footer" ref="footer" ></footer>
	</div>
</template>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
	.outflow-banner{
		/*height: 1.6rem;*/
		height: 80px;
		background: #3a3a3a;
	}
	.outflow-banner ul{
		/*padding-top: 0.42rem;*/
		padding-top: 21px;
	}
	.outflow-banner li{
		color: @theme-font-color;
		text-align: center;
	}
	.outflow-banner li:nth-child(1){
		font-size: 0.26rem;
	}
	.outflow-banner li:nth-child(2){
		font-size: 0.36rem;
		/*margin-top: 0.17rem;*/
		margin-top: 9px;
	}
	.outflow-footer{
		width: 100%;
		height: 1px;
		background: #FFFFFF;
		position: fixed;
		bottom: 0;
		left: 0;
	}
	.transactions-cash-content{
		height: 9.5rem;
		overflow: auto;
        -webkit-overflow-scrolling: touch;
	}
	.transactions-content-top{
		/*height: 0.8rem;
		line-height: 0.8rem;*/
		height: 40px;
		line-height: 40px;
		font-size: 0.28rem;
		color: @text-color;
		background: #f8f8f8;
	} 
	.transactions-content-top span:nth-child(1){
		margin-left: 0.24rem;
	}
	.transactions-content-top span:nth-child(2){
		margin-left: 0.12rem;
	}
	.cash-content-bottom{
		/*height: 1.29rem;*/
		height: 65px;
		border-top:1px solid lightgray;
		background: @content-bg-color;
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
		/*margin-top: 0.34rem;*/
		margin-top: 17px;
	}
	.cash-content-bottom dl:nth-child(1) dd{
		font-size: 0.2rem;
		color: #999999;
		/*margin-top: 0.1rem;*/
		margin-top: 5px;
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
		height: 1rem;
		line-height: 1rem;
		text-align: center;
		color: #DD153F;
		font-size: 0.26rem;
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
<script>
	import NavHeader from '../../../../components/header/nav-header';
	import { Toast, MessageBox } from 'mint-ui';
	
	export default{
		data(){
			return{
				flowAmount:"62",
				flowCost:"1,900.00",
				list: [],           //无限滚动加载的数据
				loading: false,     //无限滚动加载中
				noMoreData: false,  //无限滚动数据已经全部加载
				wrapperHeight: 0    //无限滚动区域高度，在mounted里计算
			}
		},
		components: {
	   		NavHeader
	   },
	   computed: {
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
	   methods:{
	   		flowToFliters(){
   				this.$router.replace('/fliters');
   			},
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
	   }
	}
</script>