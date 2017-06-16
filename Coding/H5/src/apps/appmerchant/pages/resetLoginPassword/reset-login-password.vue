/*
* 密码重置-输入原始密码
* @Date : 2017-05-08
* @Author : 徐伟辉
* @Version : V1.0
*
*/
<template>
    <div class="reset-login-password">
        <nav-header :title="title"></nav-header>
        <div class="initial-info">
            <span class="text">{{$t("info_输入原始密码")}}</span>
        </div>
        <div class="input-wrapper">
            <password-control class="input-padding" :count="count" @getChange="compare"></password-control>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
import passwordControl from '../../../../components/input/password-control';
export default {
    data() {
        return {
            count: 6,
            title:this.$t('label_重置密码'),
          
        }
    },
    methods: {
        compare(value) {
        	var originPassword = event.target.value;
            this.showIndicator();
            this.serverApi.checkOriginalPassword({
                initialPassword:originPassword,
            },null, (error, data) => {
            	if(error) {
            		this.hideIndicator();
					this.showToast(error.message);
					return;
				}else{
					this.hideIndicator();
	                this.$router.push({
	                    path: '/setNewLoginPassword',
	                    query: {initialPassword:originPassword}
	                });
				}
            })
        }
    },
    components: {
        NavHeader,
        passwordControl
    }
};
</script>
<style lang="less" scoped>
@import url('../../assets/css/base.less');
.reset-login-password {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    background-color: @layout-bg-color;
    &:before {
        content: "";
        position: fixed;
        z-index: -1;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background-color: @content-bg-color;
        background-repeat: no-repeat;
        background-size: cover;
    }
    .initial-info {
        height: 0.7rem;
        margin: 0 0.24rem;
        line-height: 0.7rem;
        color: @text-color;
        font-size: @font-15px;
    }
    .input-wrapper {
        padding: 0.2rem 0.24rem;
        background-color: @content-bg-color;
    }
}
</style>
