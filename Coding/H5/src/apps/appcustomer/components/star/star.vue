<template>
    <div class="star">
        <span class="star-item" v-for="(itemClass,index) in itemClasses" @click="render(index,score)" :class="itemClass"></span>
    </div>
</template>
<script>
const LENGTH = 5;
const CLS_ON = 'on';
const CLS_OFF = 'off';

export default {
	data() {
		return {
			itemClasses: []
		}
	},
    props: {
        count: {
            type: Number,
            default: 5
        },
        score:{
            type: Number
        }
    },
    mounted() {
    	this.$nextTick(() => {
    		this.init();
    	});
    },
    methods: {
    	 init() {
            let result = [];
            if(!this.score){
                let len = this.count;
                for (let i = 0; i < len; i++) {
                    result.push(CLS_OFF);
                }
            }else{
                for (let i = 0; i < this.score; i++) {
                    result.push(CLS_ON);
                }
                if (this.score < LENGTH) {
                    for (let i = 0; i < (LENGTH - this.score); i++) {
                        result.push(CLS_OFF);
                    }
                }
            }
            this.itemClasses = result;
        },
        render(index,score) {
            let result = [];
            if(score){
                return false;
            }else{
                for (let i = 0; i <= index; i++) {
                    result.push(CLS_ON);
                }
                if (index < (LENGTH - 1)) {
                    for (let i = 0; i < (LENGTH -1 - index); i++) {
                        result.push(CLS_OFF);
                    }
                }
            }
            this.itemClasses = result;
        }
    }
};
</script>
<style lang="less" scoped>
@import url('~assets/css/base.less');
@import url('~assets/css/mixin.less');
.star {
    .star-item {
        display: inline-block;
        width: 29px;
        height: 29px;
        background-size: 29px 29px;
        background-repeat: no-repeat;
        &.on {
            .bg-image('aixin_h');
        }
        &.off {
            .bg-image('aixin_n');

        }
        &:last-child {
            margin: 0;
        }
    }
}
</style>
