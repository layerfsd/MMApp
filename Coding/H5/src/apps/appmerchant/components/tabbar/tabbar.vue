<template>
    <div class="tabbar" v-if="tabbarIsShow">
        <router-link to="/home" class="nav-item nav-item-home" :class="{'home-active':active==='home'}" @click="active='home'" active-class="home-active">
            <i class="icon icon-home"></i>
            <span class="span">Home</span>
        </router-link>
        <router-link to="/myAccount" class="nav-item nav-item-mySales" :class="{'mySales-active':active==='mySales'}" @click="active='myAccount'" active-class="mySales-active">
            <i class="icon icon-mySales"></i>
            <span class="span">My account</span>
        </router-link>
        <router-link to="/settings" class="nav-item nav-item-settings" :class="{'settings-active':active==='settings'}" @click="active='settings'" active-class="settings-active">
            <i class="icon icon-settings"></i>
            <span class="span">Settings</span>
        </router-link>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    name: 'tabbar',
    data() {
        return {
            active: ''
        }
    },
    computed: mapState({
        tabbarIsShow: state => state.tabbar.tabbarIsShow
    })
};
</script>
<style lang="less" scoped>

</style>
