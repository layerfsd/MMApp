/*
 * 保存页面切换动画
 * @Date    : 2017-03-28
 * @Author  : samyu
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'

const state = {
  pageAnimationClass:{
    enter:'', //进入动画样式
    leave:'', //退出动画样式
  },
  pageAnimationBack: false // 是否点击了返回按钮
}

// getters
const getters = {
  pageAnimationClass: state => state.pageAnimationClass,
  pageAnimationBack: state => state.pageAnimationBack
}

// actions
const actions = {
  setPageAnimationClass({commit}, type){    //设置页面切换动画
    commit(types.PAGE_ANIMATION_SET, type);
  },
  setPageAnimationBack({commit}, type){   //设置是否点了返回按钮，用来控制返回时动画展示
    commit(types.PAGE_ANIMATION_BACK_SET, type);
  }
}

// mutations
const mutations = {
  [types.PAGE_ANIMATION_SET](state, type){
    state.pageAnimationClass = type;
  },
  [types.PAGE_ANIMATION_BACK_SET](state, type){
    state.pageAnimationBack = type;
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
