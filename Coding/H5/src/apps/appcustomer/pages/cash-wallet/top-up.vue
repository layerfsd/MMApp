<template>
	<div>
		 <sign-up-header title="Balance Top-Up"></sign-up-header>
		 <div>
		 	<ul>
		 		<li>Debit Card</li>
		 		<li>
		 		<span>SPDB Debit Card (7666)</span>
		 		<span><b>Daily max amout:</b><b>€50000.00</b></span>
		 		</li>
		 	</ul>
		 </div>
	</div>
</template>
<script>
import signUpHeader from '../../components/header/sign-up-header';
	export default {
    components: {
        signUpHeader
    }
};
</script>
<style lang="less">
	@import url('../../assets/css/mixin.less');
	@import url('../../assets/css/base.less');
</style>