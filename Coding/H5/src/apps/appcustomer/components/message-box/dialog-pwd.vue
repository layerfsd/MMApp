 /** * transfer页面输入密码弹窗 * @author 沈飞(179920638@qq.com) * * */
<template>
    <div class="dialog-pwd" v-if="show">
        <div class="dialog-pwd-content">
            <img @click="close" class="close" src="~assets/images/common/close_tc_n_2x.png" />
            <p class="no">Pay to Mike(134****3470)</p>
            <p class="money">€21.65</p>
            <p class="tip">Enter Payment Password</p>
            <div class="dialog-pwd-input">
                <input-control class="input-padding2" :count="count" @getChange="getChange"></input-control>
            </div>
        </div>
    </div>
</template>
<script>
import inputControl from '../../components/input/input-control';
export default {
    data() {
        return {
            count: 4
        }
    },
    components: {
        inputControl
    },
    props: {
        name: {
            type: String
        },
        show: {
            type: Boolean,
            default: false
        }



        //			shopLogo: {
        //				type: Boolean,
        //				default: true
        //			},
        //			shopName: {
        //				type: String,
        //				default:"7-Eleven"
        //			},
        //			money: {
        //				type: String,
        //				default:"22.00"
        //			},
        //			enterTips: {
        //				type: String,
        //				default:"Enter  Payment Password"
        //			}
    },
    mounted() {
//      this.$nextTick(() => {
//          this.$on('getChange', (msg) => {
//          	console.log(msg)
//              this.$parent.$emit('listen-password', msg);
//          })
//      });
    },
    methods: {
        close() {
//          this.show = false;
            this.$emit('listen-child-msg', false);
        },
        getChange(msg) {
        	this.$parent.$emit('listen-password', msg);
        }
        

    }
};
</script>
<style lang="less">
@import url('../../assets/css/base.less');
@import url('../../assets/css/mixin.less');
.dialog-pwd {
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 10;
    background-color: rgba(0, 0, 0, 0.3);
    .dialog-pwd-content {
        height: 4rem;
        width: 70%;
        background-color: #FFF;
        margin: 3rem auto;
        text-align: center;
        border-radius: 6px;
        .close {
            height: .24rem;
            width: .24rem;
            position: absolute;
            margin-left: 2.1rem;
            margin-top: .2rem;
        }
        .no {
            padding-top: .7rem;
            font-size: .3rem;
            color: #666666;
        }
        .money {
            font-size: .6rem;
            color: #333;
            margin-top: .3rem;
        }
        .tip {
            font-size: .34rem;
            color: #333;
            margin-top: .45rem;
        }
        .dialog-pwd-input {
            margin-top: .2rem;
            padding: 0 .2rem;
        }
    }
}
</style>
