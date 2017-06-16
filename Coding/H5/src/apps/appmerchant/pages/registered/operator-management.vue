/**
 * 2017-05-15
 * 人员管理
 * wangliang
 */
<template>
	<div class="operator-management layout">
		<!-- 导航头 -->
		<div class="operator-management-header border-1px">
			<nav-header :title="'Operator management'"></nav-header>
		</div>
		<div class="operator-management-wrapper">
			<div class="operator-input-wrapper">
				<input-primary :isRequired="true" :placeholder="'MSISDN'" :inputStyle="{'text-indent': '1.5rem'}" @getValue="getValue"></input-primary>
				<span class="icon-search"></span>
			</div>
			<div class="btn-wrapper">
				<button class="btn" type="button" :class="{active: active}" :disabled="!active" @click="next">next</button>
			</div>
		</div>
	</div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import inputPrimary from '../../../../components/input/input-primary';
	export default {
		data() {
			return {
				phone: null,
			}
		},
		computed: {
			active() {
				if(this.phone){
					return true;
				}
				return false;
			}
		},
		methods: {
			getValue(msg){
				this.phone = msg;
			},
			next() {
				this.$router.push({
					path: '/createOperator',
					query: {
						phone: this.phone
					}
				})
			}
		},
		components: {
			navHeader,
			inputPrimary
		}
	};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.operator-management{
	.operator-management-header{
		.border-1px(@border-1px-color)
	}
	.operator-management-wrapper{
		margin-top: 10px;
		.operator-input-wrapper{
			position: relative;
			width: 100%;
			height: 50px;
			box-sizing: border-box;
			.icon-search{
				position: absolute;
				display: inline-block;
				top: 15px;
				left: 0.8rem;
				width: 21px;
				height: 21px;
				background-size: 21px 21px;
				background-repeat: no-repeat;
				.bg-image('search-icon');
			}
		}
		.btn-wrapper{
			margin-top: 45px;
		}
	}
}
</style>