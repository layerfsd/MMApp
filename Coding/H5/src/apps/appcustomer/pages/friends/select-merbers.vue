/* * select-merbers
* @Date : 2017-03-31
* @Author : wangliang
* @Version : V1.0
*
*/
<template>
    <div class="select-merbers layout">
        <div class="select-merbers-header">
            <!-- 导航条 -->
            <nav-header title="Select Members">
                <div class="rightText" slot="right">
                    <div @click="ok">OK<span>(3)</span></div>
                </div>
            </nav-header>
            <!-- 搜索框 -->
            <mt-search v-model="value" cancel-text="Cancel" placeholder="search" @click="isSearch=true">
            </mt-search>
        </div>
        <div class="select-merbers-content">
            <div class="myself">
                <div class="title">Myself</div>
                <mt-cell title="Amy" label="134***2311">
                    <label class="icon" :class="{checked: checked}">
                        <input type="checkbox" class="checkbox"  @click="select($event)" ref="input">
                    </label>
                    <img slot="icon" src="~assets/images/common/amy_2x.png" class="avatar">
                </mt-cell>
            </div>
            <mt-index-list>
                <mt-index-section index="A">
                    <mt-cell title="Apic" label="134***2311">
                        <label class="icon" :class="{checked: checked}">
                        	
                        <input type="checkbox" class="checkbox"  @click="select($event)" ref="input">
                        	
                        	
                        </label>
                        <img slot="icon" src="~assets/images/common/pic_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
                <mt-index-section index="B">
                    <mt-cell title="Becan" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/becan_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Buster" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/buster_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Becan" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/becan_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Buster" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/buster_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
                <mt-index-section index="C">
                    <mt-cell title="Caleb" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/caleb_2x.png" class="avatar">
                    </mt-cell>
                    <mt-cell title="Cameron" label="134***2311">
                        <label class="icon"></label>
                        <img slot="icon" src="~assets/images/common/cameron_2x.png" class="avatar">
                    </mt-cell>
                </mt-index-section>
            </mt-index-list>
        </div>
    </div>
</template>
<script>
import NavHeader from '../../../../components/header/nav-header';
export default {
    data() {
        return {
            isSearch: false,
            checked: false
        }
    },
    methods: {
        select(event) {
            console.log(event.target.checked)
            this.checked = !this.checked;
        },
        ok(){
			this.$router.push({
				
				
				
				path: '/go-dutch/go-dutch'
			});
			}
    },
    components: {
        NavHeader
    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.select-merbers {
    // mint-cell
    .mint-cell-wrapper {
        position: relative;
        padding: 0;
        .border-1px(@default-border-color);
        &:last-child:after{
            .border-none();
        }
        .mint-cell-title {
            position: relative;
            padding: 0.20rem 1.24rem;
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
                color: @text-color;
            }
            .mint-cell-label {
                position: absolute;
                left: 2.36rem;
                bottom: 0.32rem;
                font-size: 0.24rem;
                line-height: 0.24rem;
                color: #1C1C1C;
            }
        }
        .mint-cell-value {
            position: absolute;
            top: 0.3rem;
            left: 0.24rem;
            .icon {
                display: inline-block;
                width: 0.58rem;
                height: 0.58rem;
                background-size: contain;
                background-repeat: no-repeat;
                background-image: url('~assets/images/common/icon_n_2x.png');
                &.checked{
                    background-image: url('~assets/images/common/icon_s_2x.png');
                }
            }
            .checkbox{
                position: absolute;
                width: 100%;
                height: 100%;
                padding: 0.2rem;
                display: none;
            }
        }
    }
    // 搜索框
    .mint-search {
        height: auto;
        .mint-searchbar {
            padding: 0.14rem 0.25rem;
            background-color: #fff;
            .mint-searchbar-inner {
                .mintui-search {
                    position: relative;
                    &::before {
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
    .select-merbers-content{
        overflow: auto;
        // myself
        .myself {
            .title {
                padding: 0.2rem 0.24rem;
                font-size: 0.3rem;
                line-height: 0.28rem;
                color: @tips-color;
            }
        }
        .mint-indexlist {
            .mint-indexlist-content {
                height: auto !important;
                margin-right: 0 !important;
                .mint-indexsection-index {
                    padding: 0.20rem 0.24rem;
                    font-size: 0.36rem;
                    line-height: 0.26rem;
                    background-color: transparent;
                }
            }
            // 右侧索引导航
            .mint-indexlist-nav {
                border: none;
                background: none;
            }
        }
    }
}
</style>
