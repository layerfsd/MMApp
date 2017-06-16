/**
 * 选择朋友 页面
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */

<template>
	<div class="transfer-select-friend">
		<div>
			<nav-header title="Details" :showLeft="true" :showRight="true" >
	        	<div slot="right">
		            <img class="friend-header" src="~assets/images/common/friends_h_2x.png" alt='' /> 
	            </div>
	        </nav-header>
        </div>
        <div style="overflow: auto;">
		<select-friend></select-friend>
		</div>
			  
		
	</div>
	
</template>
<script>
	import NavHeader from '../../../../components/header/nav-header';
	
	import selectFriend from '../../components/friends/select-friend';
	export default {
		name:'select-firend',
		components: {
			selectFriend,
			NavHeader
		},
		data() {
			return {
				seen:false,
				to:"/transfer/transfer"
			}
		},
		

	}
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');
	.transfer-select-friend{
		.header{
			border-bottom: 1px solid #ccc;
		}
		.friend-header{
			width: .52rem;
			height: .38rem !important;
		}
	}
	
	
</style>