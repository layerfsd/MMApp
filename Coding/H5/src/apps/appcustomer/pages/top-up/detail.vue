/**
 * detail 充值详情页
 * @author 王亮
 *
 *
 */
<template>
    <div class="detail layout">
        <nav-header title="Mobile Top Up" :rightFunc="rightFunc">
            <div slot="right">
                <span class="rightText">Done</span>
            </div>
        </nav-header>
        <div class="content-wrapper">
       	 	<payment-successful :message="message" :amount="amount"></payment-successful>
	        <div class="phoneNo">
	        	<span class="name">Phone No.</span>
	        	<span class="text">13810700070</span>
	        </div>
	        <div class="item">
	        	<span class="name">Item</span>
	        	<span class="text">€10 mobile phone</span>
	        </div>
        </div>
    </div>
</template>
<script>
import PaymentSuccessful from '../../components/payment-successful/payment-successful';
import NavHeader from '../../../../components/header/nav-header';
export default {
	data() {
		return {
			message: 'Payment successful',
			amount: '49.90'
		}
	},
    methods: {
        rightFunc() {
            this.$router.replace('/home');
        }
    },
    components: {
        PaymentSuccessful,
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.detail {
    .rightText{
        font-size: @font-15px;
        color: #1352E2;
    }
    .content-wrapper{
    	.details-content-label2{
    		padding-bottom: 0.8rem;
    	}
    	.phoneNo,.item{
    		display: flex;
    		justify-content: space-between;
			padding: 0.4rem 0.24rem;
			background-color: @content-bg-color;
			.border-1px-top(@default-border-color);
			.name,.text{
				display: inline-block;
				font-size: 0.3rem;
				line-height: 0.23rem;
			}
			.name{
				color: @tips-color;
			}
			.text{
				color: @text-color;
			}
    	}
    }
}
</style>
