/**
 * 付款-输入密码页面组件
 * @author 沈飞(179920638@qq.com)
 * 
 * 
 */
<template>
		<div class="enter-pwd-content">
			<div class="shop-logo">
				<img v-if="shopLogo" src="~assets/images/common/7-Eleven_2x.png"  />
				<label>{{shopName}}</label>
			</div>
			<p class="enter-pwd-money">€{{money}}</p>
			<div class="enter-pwd-pwd">
				<p>{{enterTips}}</p>
                <input-control class="input-padding2" :count="count" @getChange="getChange"></input-control>
			</div>
		</div>
	
</template>
<script>
	import inputControl from '../../components/input/input-control';
	export default {
		data() {
			return {
				count: 4,
			}
		},
		components: {
			inputControl
		},
		props: {
			shopLogo: {
				type: Boolean,
				default: true
			},
			shopName: {
				type: String,
				default:"7-Eleven"
			},
			money: {
				type: String,
				default:"22.00"
			},
			enterTips: {
				type: String,
				default:"Enter  Payment Password"
			},
			text:{
				type: String,
				default:""
			}
		},
        mounted() {
//	        this.$nextTick(() => {
//	            this.$on('getChange', (msg) => {
//	            	console.log(msg)
//	                this.text = msg;
//	                this.$parent.$emit('listen-password', this.text);
//	            })
//	        });
	    },
	    methods: {
	    	getChange(msg) {
                this.$parent.$emit('listen-password', msg);
	    	}
	    }
		
	};
	
	
</script>
<style lang="less">
	@import url('../../assets/css/base.less');
	@import url('../../assets/css/mixin.less');

	
	.enter-pwd-content{
		background-color: #FFFFFF;
		margin:.2rem .24rem;
		/*height: 4.9rem;*/
	
	.shop-logo{
		text-align: center;
    	padding-top: 0.49rem;
	}
	.shop-logo img{
		width: .81rem;
		height: .81rem;
	    vertical-align: middle;
	}
	.shop-logo label{
		font-size: .36rem;
		color: #333333;
	    vertical-align: middle;
	    margin-left: .2rem;
	}
	.enter-pwd-money{
		font-size: .6rem;
		color: #333333;
		text-align: center;
		margin-top: .2rem;
	}
	.enter-pwd-pwd{
		padding: 0 .2rem .2rem;
		p{
			color: #333333;
			font-size: .36rem;
			margin-left:.3rem ;
			margin-top: .55rem;
			margin-bottom: .2rem;
		}
	}
	
	
	}
</style>