<template>
	<div class="settings-title-wrapper">
        <!-- <nav-header title="Settings" :showRight="false"></nav-header> -->
        <div>
        	<nav-header title="Settings" :showRight="false" :leftFunc='settingsToMe'>
	  		</nav-header>
        </div>
	  
<!--           <nav-header title="Settings" :showLeft="false" :showRight="false" :customClass="`custom-nav-header`">
        	<div slot="left">
        		<img src="~assets/images/common/nav_left_h_2x.png" alt='' />
	            <span class="nav-left-text"> Me </span>
            </div>
          </nav-header>
 -->
 		  <!-- <nav-header title="Settings" :showLeft="false" :showRight="false" :customClass="`custom-nav-header`">
        	<div slot="left">
	            <span class="nav-left-text"> Me </span>
            </div>
          </nav-header>
 -->
          <!-- <nav-header title="Settings" :showRight="true" :customClass="`custom-nav-header`">
        	<div slot="right">
        		<img src="~assets/images/common/nav_left_h_2x.png" alt='' />
            </div>
          </nav-header> -->

          <!-- <nav-header title="Settings" :showRight="true" :customClass="`custom-nav-header`">
        	<div slot="right">
        		<span class="nav-right-text"> Me </span>
            </div>
          </nav-header> -->
 		

<!-- 以下是自定义的navHeader的例子 -->
<!--         <nav-header title="Settings" :showLeft="false" :showRight="false" :customClass="`customNavHeader`">
        	<div slot="left">
	            <img src="~assets/images/common/nav_left_h_2x.png" alt='' />
            </div>
        </nav-header>
 --> 		
 		<div class="settings-content">
			<ul>
				<router-link to='/languages' slot="right">
				<li @click="linkLanguages">
					<span>Multiple languages</span>
					<span><b> {{lua}} </b><b><img src="~assets/images/common/right_list_n_2x.png"/></b></span>
				</li>
				</router-link>
				<router-link to='/feedback' slot="right">
				<li>
					<span>Feedback</span>
					<span class="settings-content-pic"><img src="~assets/images/common/right_list_n_2x.png"/></span>
				</li>
				</router-link>
				<!--<router-link to='/languages' slot="right">-->
				<li>
					<span>Service Agreement</span>
					<span class="settings-content-pic"><img src="~assets/images/common/right_list_n_2x.png"/></span>
				</li>
				<!--</router-link>-->
			</ul>
		</div>
		<router-link to='/about' slot="right">
		<div class="settings-content-bottom">
			<ul>
				<li>About</li>
				<li>
					<span>1.0.0</span>
					<span><img src="~assets/images/common/right_list_n_2x.png"/></span>
				</li>
			</ul>
		</div>
		</router-link>
		<div class="settings-content-footer">
			<button @click="alertMsgBox">Log out</button>
		</div>
	</div>	
</template>
<script>
import NavHeader from '../../../../../components/header/nav-header';
import { MessageBox } from 'mint-ui';
	export default{
		name: 'settings',
		data(){
			return {
				lua:'',
			}
		},
		components: {
	        NavHeader
	    },
	    //创建之前
	    beforeCreate(){
	        //添加到缓冲机制中
	        this.$store.dispatch('pushKeepAlive', 'settings');
	    },
        beforeMount: function () {
            //设置沉浸式状态栏
            console.log("settings, beforeMount");
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleBlack();
            }
        },
        activated: function () {
        		this.lua=this.$route.query.bill_type;
//      	alert(this.lua)
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleBlack();
            }
        },
        deactivated: function () {
            console.log("settings, deactivated");
        },
        beforeUpdate: function () {
            console.log("settings, beforeUpdate");
        },
		methods: {
			alertMsgBox() {
				this.$store.dispatch('refreshPageMe');
				  MessageBox({
				  title: '',
				  message: 'Do you confirm to log out ?',
				  showCancelButton: true,
				  confirmButtonText: 'Confirm',
				  cancelButtonText: 'Cancel',
				  confirmButtonClass: 'setting_confirm_btn',
				  cancelButtonClass: 'setting_cancael_btn'
				});
			},
			settingsToMe(){
	       	 	this.$store.dispatch('pushKeepAlive', 'settings');
   				this.$router.push('/me');
   			},
   			linkLanguages(){
   				this.$router.push({
					path:'/languages',
					query: {bill_type: this.lua}
				});
   			}
		}
		
		
	}
</script>
<style lang="less">
	@import url('../../../assets/css/mixin.less');
	@import url('../../../assets/css/base.less');
	.custom-nav-header {
		background-color: #D90647 !important; 
        color: #ffffff !important;
    }
	.settings-title-wrapper{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
		overflow: auto;
	}
	.settings-content{
		/*height: 3.02rem;
		margin-top: 0.2rem;*/
		height: 151px;
		margin-top: 10px;
		background: #FFFFFF;
	}
	.settings-content li{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
	}
	.settings-content li:nth-child(1){
		border-bottom:1px solid lightgray;
	}
	.settings-content li:nth-child(1) span{
		display: block;
		/*height: 1rem;*/
		height: 50px;
	}
	.settings-content li:nth-child(1) span:nth-child(1){
		margin-left: 0.24rem;
		float: left;
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color: #484848;
	}
	.settings-content li:nth-child(1) span:nth-child(2){
		float: right;
		margin-right: 0.24rem;
	}
	.settings-content li:nth-child(1) span:nth-child(2) b{
		display: block;
	}
	.settings-content li:nth-child(1) span:nth-child(2) b:nth-child(1){
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color: @tips-color;
		float: left;
		margin-right: 0.18rem;
	}
	.settings-content li:nth-child(1) span:nth-child(2) b:nth-child(2){
		float: right;
	}
	.settings-content li:nth-child(1) span:nth-child(2) b:nth-child(2) img{
		width: 0.19rem;
		height: 0.35rem;
		/*margin-top: 0.33rem;*/
		/*margin-top: 15px;*/
		vertical-align: middle;
	}
	.settings-content li:nth-child(2){
		border-bottom:1px solid lightgray;
	}
	.settings-content li:nth-child(2) span{
		display: block;
		/*height: 1rem;*/
		height: 50px;
	}
	.settings-content li:nth-child(2) span:nth-child(1){
		margin-left: 0.24rem;
		float: left;
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color: #484848;
	}
	.settings-content li:nth-child(2) span:nth-child(2){
		float: right;
		margin-right: 0.24rem;
	}
	.settings-content-pic img{
		width: 0.19rem;
		height: 0.35rem;
		/*margin-top: 0.33rem;*/
		vertical-align: middle;
	}
	.settings-content li:nth-child(3) span:nth-child(1){
		margin-left: 0.24rem;
		float: left;
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color: #484848;
	}
	.settings-content li:nth-child(3) span:nth-child(2){
		float: right;
		margin-right: 0.24rem;
	}
	.settings-content-bottom{
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		/*margin-top: 0.2rem;*/
		margin-top: 10px;
		background: @content-bg-color;
	}
	.settings-content-bottom li:nth-child(1){
		float: left;
		/*font-size: 0.32rem;*/	
		font-size: @font-16px;
		margin-left: 0.24rem;
		color: #484848;
	}
	.settings-content-bottom li:nth-child(2){
		float: right;
		margin-right: 0.24rem;
		/*font-size: 0.32rem;*/	
		font-size: @font-16px;
	}
	.settings-content-bottom li:nth-child(2) span{
		display: block;
	}
	.settings-content-bottom li:nth-child(2) span:nth-child(1){
		float: left;
		margin-right: 0.2rem;
	}
	.settings-content-bottom li:nth-child(2) span:nth-child(2){
		float: right;
	}
	.settings-content-bottom li:nth-child(2) span:nth-child(2) img{
		width: 0.19rem;
		height: 0.35rem;
		/*margin-top: 0.33rem;*/
		vertical-align: middle;
	}
	/*.settings-content-footer{
		width: 6.5rem;
		height: 1rem;
		line-height: 1rem;
		text-align: center;
		background: #de153f;
		font-size: 0.32rem;
		color: #FFFFFF;
		border-radius: 4px;
		margin:1.26rem auto ;
	}*/
	.settings-content-footer button{
		display: block;
		width: 6.5rem;
		/*height: 1rem;
		line-height: 1rem;*/
		height: 50px;
		line-height: 50px;
		text-align: center;
		background: #de153f;
		/*font-size: 0.32rem;*/
		font-size: @font-16px;
		color: @theme-font-color;
		border-radius: 4px;
		margin:63px auto ;
		border: none;
	}
	.setting_confirm_btn{
		font-size: 0.3rem;
		color: #084de9;
	}
	.setting_cancael_btn{
		font-size: 0.3rem;
		color: #074ce7;
		font-weight: bold;
	}
	.mint-msgbox{
		border-radius: 4px;
		width: 5.6rem;
		height: 2.6rem;
	}
	.mint-msgbox-content{
		height: 1.6rem;
		padding: inherit;
	}
	.mint-msgbox-message{
		color: #333333;
		font-size: 0.3rem;
		font-weight: bold;
		line-height: 1.6rem;
		padding: initial;
	}
	.mint-msgbox-btns{
		height: 1rem;
	}
</style>
