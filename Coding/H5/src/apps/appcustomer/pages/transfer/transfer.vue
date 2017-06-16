/**
 * 转账 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="transfer">
		<div>
			<nav-header title="Transfer" :showLeft="true" :showRight="true">
					<label slot="left" class="transfer-back">Home</label>
		    	<div slot="right">
		            <img class="transfer-nav-scan" src="~assets/images/common/nav_sys_n_2x.png" alt='' /> 
		        </div>
		    </nav-header>
    	</div>
		<div class="transfer-account">
			
			
			<!--<div class="transfer-account-input-content">-->
				<label class="transfer-account-lable" for="phone-no">Account</label>
				
				<input class="transfer-account-input" id="phone-no" type="tel" placeholder="Phone No." @keyup="checkFiled($event)" v-model="phoneNo" />
			<!--</div>-->
			
			<!--<div class="transfer-account-input-linkman">-->
				<!--<router-link to="/transfer/select-friend">-->
					<img class="linkman" src="~assets/images/common/friends_h_2x.png">
				<!--</router-link>-->
			<!--</div>-->
			
			
			
			
		</div>
		<div class="transfer-btn">
			<router-link to="/transfer/transfer-to-friend">
			<mt-button type="danger" class="next-btn" :disabled="this.isEmpty" @click="">Next</mt-button>
			</router-link>
		</div>
		<p class="recent">Recent</p>
		
		<div class="recent-scroll">
		<div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div>
		<div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div>
		<div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div><div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div><div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div><div class="recent-content">
			<img src="~assets/images/common/tx1_2x.png"/>
			<label class="recent-content-name">Mike</label>
			<label class="recent-content-no">134***2092</label>
		</div>
			  
		</div>
		
	</div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
	
	export default {
		name:'transfer',
		components: {
			NavHeader
		},
		data() {
			return {
				isEmpty: true,
				imgs:"~assets/images/common/tx1_2x.png",
				to:"/home",
				phoneNo:''
			}
		},
		beforeCreate(){
        	//添加到缓冲机制中
        	this.$store.dispatch('pushKeepAlive', 'transfer');
    	},
    	
		mounted() {
	        this.$nextTick(() => {
	            this.$on('listen-child-msg', (msg) => {
	                this.isShow = msg;
	            })
	            this.$on('listen-password', (msg) => {
	                this.text = msg;
	                if(this.text === '1234'){
	                    this.$router.push('/transfer/transfer-success');
	                }else{
	                    alert('密码错误')
	                    this.isShow = false;
	                }
	            })
	        });
    	},
		methods:{
			checkFiled(event) {
				let val = event.target.value;
				if(val === ''){
					this.isEmpty = true;
				}else if(this.amount !== ''){
					this.isEmpty = false;
				}
			}
			
		},
		activated:function(){
        	if(this.phoneNo!=''){
				this.phoneNo='';
				this.isEmpty=true;
			}
        }

	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	
	.transfer{
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		right: 0;
		background-color: #F8F8F8;
		.is-center{
			flex: 6 !important;
		}
		.transfer-back{
			font-size:.3rem;
		    vertical-align: middle;
		}
	}
	.is-center{
		flex:6 !imporant;
	}
	.transfer-nav-scan{
	    width: .47rem;
    	height: .42rem !important;
	}
	.linkman{
	    height: .38rem;
    	width: .52rem;
		vertical-align: middle;
		position: relative;
	    float: right;
	    margin-top: .28rem;
	    margin-right: .24rem;
	}
	/*.transfer-account-input-content{
			height: 1rem;
    		background-color: #fff;
    		display: flex;
		}
		.transfer-account-input-linkman{
			    position: absolute;
    		right: 0;
    		top: .3rem;
		}*/
	.transfer-account{
		margin-top: .2rem;
		
		height: 1rem;
		background-color: #FFFFFF;
		
		.transfer-account-lable{
			font-size: .36rem;
			vertical-align: middle;
			margin-left: .25rem;
		    line-height: 1rem;
		}
		.transfer-account-input{
			font-size: .36rem;
			vertical-align: middle;
			margin-left: .9rem;
			width: 4rem;
		    line-height: 1rem;
		}
		
	}
	
	.transfer-btn{
		text-align: center;
		.mint-button--danger{
		    width: 6.5rem;
		    height: 1rem;
		    margin-top: .5rem;
	        border-radius: 6px;
        }
	}
	.transfer-btn .mint-button.is-disabled{
		background-color: #c6c6c6;
	}
	.recent{
		font-size: .3rem;
		color:#999999;
	    margin-top: .25rem;
    	margin-left: .25rem;
    	margin-bottom: .1rem;
	}
	.recent-scroll{
	    position: relative;
		overflow: scroll;
		padding-bottom: 1rem;
	}
	.recent-content .mint-cell-wrapper{
		background-image: none;
	}
	.recent-content{
		background-color: #FFFFFF;
		height: 1.31rem;
		border-bottom: 1px solid #f5f5f5;
		img{
			height: .91rem;
			width: .91rem;
			margin-top: .2rem;
			margin-left: .24rem;
		}
		.recent-content-name{
			position: absolute;
			font-size: .32rem;
			color: #222222;
			margin-top:.33rem;
			margin-left: .28rem;
		}
		.recent-content-no{
			position: absolute;
			font-size: .24rem;
			color: #999;
			margin-top: .77rem;
			margin-left: .28rem;
		}
	}
	
	
</style>