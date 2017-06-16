/**
 * wangliang
 * 已废弃不用
 */
<template>
    <div class="index">
        <router-view></router-view>
        <navbar></navbar>
    </div>
</template>
<script>
import Navbar from '../../components/navbar/navbar';
export default {
	components: {
		Navbar
	}
};
</script>
<style>
</style>
