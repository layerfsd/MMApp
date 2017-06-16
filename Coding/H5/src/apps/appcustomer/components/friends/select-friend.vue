<template>
    <div class="select-friend">
        <!-- 搜索框 -->
        <div class="select-wrapper">
            <mt-search v-model="value" cancel-text="Cancel" placeholder="search" @click="isSearch=true">
            </mt-search>
        </div>
        <!-- 朋友列表 -->
        <div class="list-wrapper">
            <mt-index-list>
                <mt-index-section index="A">
                	<div @click="selected($event)">
                    <mt-cell title="Apic" :label="phoneno">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/pic_2x.png" class="avatar">
                    </mt-cell>
                    </div>
                    <mt-cell title="Amy" label="134***2311">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/amy_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
                <mt-index-section index="B">
                    <mt-cell title="Becan" label="134***2311">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/becan_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Buster" label="134***2311">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/buster_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
                <mt-index-section index="C">
                    <mt-cell title="Caleb" label="134***2311">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/caleb_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Cameron" label="134***2311">
                        <span class="icon"></span>
                        <img slot="icon" src="~assets/images/common/cameron_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
            </mt-index-list>
        </div>
        <overlay v-show="isSearch"></overlay>
    </div>
</template>
<script>
import overlay from '../../../../components/overlay/overlay';
export default {
    data() {
        return {
            isSearch: false,
            phoneno:'131***11111'
        }
    },
    components: {
        overlay
    },
    methods:{
    	selected(event){
    		let phoneno=event.target.label;
    		alert(event);
    		alert(phoneno);
    		
    	}
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.select-friend {
    background-color: #f8f8f8;
    .select-wrapper{
        position: relative;
        .mint-search {
            height: auto;
            .mint-searchbar {
                padding: 0.14rem 0.25rem;
                background-color: #fff;
                .mint-searchbar-inner {
                    .mintui-search{
                        position: relative;
                        &::before{
                            position: absolute;
                            color: #A2A2A2;
                            left: 0.04rem;
                            top: -0.14rem;
                        }
                    }
                }
                .mint-searchbar-core {
                    display: inline-block;
                    width: 100%;
                    height: 100%;
                    line-height: 1;
                    background-color: #F2EFF0;
                    border-radius: 0.06rem;
                    font-size: 0.22rem;
                    color: #A2A2A2;
                    text-indent: 0.30rem;
                }
            }
        }
    }
    .list-wrapper{
        .mint-indexlist {
            position: absolute;
            top: 1rem;
            bottom: 0;
            width: 100%;
            overflow: auto;
            .mint-indexlist-content {
                height: auto !important;
                margin-right: 0 !important;
                .mint-indexsection-index {
                    padding: 0.20rem 0.24rem;
                    font-size: 0.36rem;
                    line-height: 0.26rem;
                }
                .mint-cell-wrapper {
                    position: relative;
                    padding: 0;
                    .mint-cell-title {
                        position: relative;
                        padding: 0.20rem 0.24rem;
                        font-size: 0;
                        .avatar {
                            display: inline-block;
                            width: 0.91rem;
                            height: 0.91rem;
                            vertical-align: top;
                            border-radius: 50%;
                        }
                        .mint-cell-text {
                            display: inline-block;
                            padding: 0.14rem 0 0 0.26rem;
                            font-size: 0.32rem;
                            line-height: 0.3rem;
                            color: #262626;
                        }
                        .mint-cell-label {
                            position: absolute;
                            left: 1.36rem;
                            bottom: 0.32rem;
                            font-size: 0.24rem;
                            line-height: 0.24rem;
                            color: #1C1C1C;
                        }
                    }
                    .mint-cell-value {
                        position: absolute;
                        top: 0.3rem;
                        right: 0.98rem;
                        .icon {
                            display: inline-block;
                            width: 48px;
                            height: 48px;
                            background-size: contain;
                            background-repeat: no-repeat;
                            .bg-image('icon_list_f');
                        }
                    }
                }
            }
            .mint-indexlist-nav {
                border: none;
                background: none;
            }
        }
    }
}
</style>
