<template>
    <div class="complete-transaction">
    	<img class="mer-logo" src="../../assets/images/common/choose@2x.png" />
    	<p class="complete-tips">{{tips}}</p>
    	<p class="complete-sum">€{{sum}}</p>
    </div>
</template>
<script>
export default {
    props: {
        tips: {
            type: String,
            default: '' //提示信息（交易类型）
        },
        sum: {
            type: String,
            default: ''//交易金额
        }
    },
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
@import url('~assets/css/icon.less');
.complete-transaction {
	background-color:@content-bg-color ;
	margin-top:10px;
	text-align: center;
	.mer-logo{
		margin-top: 30px;
	}
	.complete-tips{
		margin-top: 10px;
		font-size: @hm-font-size-sm;
		color:@success-text-color;
	}
	.complete-sum{
		color:@text-color;
		margin-top: 22px;
		font-size: @hm-font-size-xxl;
		margin-bottom: 50px;
	}
}
</style>
