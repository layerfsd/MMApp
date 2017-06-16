<template>
    <div id="app">
        <transition 
        :enter-active-class="enterAnimation" 
        :leave-active-class="leaveAnimation"
        >
        <keep-alive :include="keepAlive">
            <router-view class="router-view"></router-view>
        </keep-alive>
        </transition>
        <tabbar></tabbar>
    </div>
</template>
<script>
import Tabbar from './components/tabbar/tabbar';
import { mapState } from 'vuex';

export default {
    components:{
        Tabbar
    },
    data() {
        return {
            isShow: true
        }
    },
    computed: mapState({
        keepAlive: function(state){
            console.log("keepAliveArray", state.keepAlive.keepAliveArray + "");
            return state.keepAlive.keepAliveArray + "";
        },
        enterAnimation : function(state){
            console.log('enter', state.pageAnimation.pageAnimationClass.enter)
            return state.pageAnimation.pageAnimationClass.enter;
        },
        leaveAnimation : function(state){
            console.log('leave', state.pageAnimation.pageAnimationClass.leave)
            return state.pageAnimation.pageAnimationClass.leave;
        }
    }),
    created() {
        // let router = this.$router;
        // this.$router.go({path: './pages/login/login'});
    }
}
</script>
<style lang="less">
    // .slide-enter-active,.slide-leave-active{
    //     transition: all .5s ease;
    //     transform: translate3d(-100%, 0, 0);
    // }
    // .slide-enter,.slide-leave-active{
    //     transform: translate3d(0, 0, 0);
    // }


    .router-view{
        position: absolute;
        top: 0;
        width: 100%;
        //background: white;
        //height: 100%;
        bottom: 0px;
        display: flex;
        flex-direction: column;
    }
</style>
