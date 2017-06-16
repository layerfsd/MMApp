/* * 注册 set-password
 * @Date : 2017-03-15
 * @Author : wangliang
 * @Version : V1.0
 *
 */
<template>
    <div class="set-password layout">
        <nav-header :title="title" :leftFunc="linkPath" :isKeepAlive="false"></nav-header>
        <input-password @input-completed="getChecked" :text1="text1" :text2="text2"></input-password>
        <button type="button" :class="{'active':checked}" class="btn" :disabled="false" @click="submit">{{$t('action_提交')}}</button>
    </div>
</template>
<script>
import navHeader from '../../../../components/header/nav-header';
import inputPassword from '../../../../components/input/input-password';
import {isEqual} from '../../assets/js/common/util'
export default {
    name: 'setPassword',
    data() {
        return {
        	text1:this.$t('label_登录_密码'),//传入子组件的参数
        	text2:this.$t('label_确认_密码'),//传入子组件的参数
        	title:this.$t('label_注册标题'),//导航栏标题
            checked: false, //控制按钮是否可点击
            setPassword: '',//密码
            comfirmPassword: ''
        }
    },
    beforeCreate() {
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'setPassword');
    },
    created() {

    },
    beforeMount() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    activated() {
        //设置沉浸式状态栏
        if (this.$root.supportTranslucentStatus) {
            this.$root.setStatusStyleBlack();
        }
    },
    deactived() {
        this.setPassword = '';
        this.comfirmPassword = '';
    },
    methods: {
        // 回退
        linkPath() {

            //返回时删除缓存(清除2个页面)
            this.$store.dispatch('popKeepAlive');
            this.$store.dispatch('popKeepAlive');

            //设置返回标志，在动画里面处理
            this.$store.dispatch('setPageAnimationBack', true);

            // 回退到注册页面
            this.$router.replace('/signUp');
        },
        // 接收子组件参数
        getChecked(msg) {
            this.checked = msg.checked;
            this.setPassword = msg.setPassword;
            this.comfirmPassword = msg.comfirmPassword;
        },
        // 下一步
        submit() {
            if(!isEqual(this.setPassword, this.comfirmPassword)){
                this.showToast(this.$t('info_密码输入不一致'));
                return false;
            }

            

            this.$router.push({
                path: '/signUp/setSecurity',
                query: {
                    password: this.comfirmPassword,
                    phone: this.$route.query.phone
                }
            });
        }
    },
    components: {
        navHeader,
        inputPassword
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.set-password {
    .btn {
        margin-top: 0.86rem;
    }
}
</style>
