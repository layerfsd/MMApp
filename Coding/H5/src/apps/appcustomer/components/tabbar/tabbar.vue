<template>
    <div class="tabbar" v-if="tabbarIsShow">
        <router-link to="/home" class="nav-item nav-item-home" :class="{'home-active':active==='home'}" @click="active='home'" active-class="home-active">
            <i class="icon icon-home"></i>
            <span class="span">Home</span>
        </router-link>
        <router-link to="/friends" class="nav-item nav-item-friends" :class="{'friends-active':active==='friends'}" @click="active='friends'" active-class="friends-active">
            <i class="icon icon-friends"></i>
            <span class="span">Friends</span>
        </router-link>
        <router-link to="/me" class="nav-item nav-item-me" :class="{'me-active':active==='me'}" @click="active='me'" active-class="me-active">
            <i class="icon icon-me"></i>
            <span class="span">Me</span>
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
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.tabbar {
    position: fixed;
    bottom: 0;
    left: 0;
    display: flex;
    width: 100%;
    height: 1rem;
    background-color: #fff;
    text-align: center;
    font-size: 0;
    .nav-item-home {
        flex: 1;
        .icon{
            display: block;
            margin: 0.17rem auto 0.08rem;
            width: 21px;
            height: 22px;
            background-size: 21px 22px;
            background-repeat: no-repeat;
            vertical-align: top;
        }
        .icon-home{
            .bg-image('home_n');
        }
        .span{
            font-size: 0.24rem;
            line-height: 0.18rem;
            color: #ABABAB
        }
        &.home-active{
            color: #DB1B43;
            .icon{
                .bg-image('home_h');
            }
        }
    }
    .nav-item-friends{
        flex: 1;
        .icon{
            display: block;
            width: 26px;
            height: 19px;
            background-size: 26px 19px;
            background-repeat: no-repeat;
            margin: 0.20rem auto 0.08rem;
        }
        .icon-friends{
            .bg-image('friends_n');
        }
        .span{
            font-size: 0.24rem;
            line-height: 0.18rem;
            color: #ABABAB;
        }
        &.friends-active{
            color: #DB1B43;
            .icon{
                .bg-image('friends_h');
            }
        }
    }
    .nav-item-me{
        flex: 1;
        .icon{
            display: block;
            width: 20px;
            height: 20px;
            background-size: 20px 20px;
            background-repeat: no-repeat;
            margin: 0.20rem auto 0.05rem;
        }
        .icon-me{
            .bg-image('me_n');
        }
        .span{
            font-size: 0.24rem;
            line-height: 0.18rem;
            color: #ABABAB
        }
        &.me-active{
            color:#DB1B43;
            .icon{
                .bg-image('me_h');
            }
        }
    }
}
</style>
