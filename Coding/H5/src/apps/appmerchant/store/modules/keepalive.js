/*
 * 将页面状态保存到缓存里
 * @Date    : 2017-03-28
 * @Author  : samyu
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'

const state = {
  keepAliveArray: []    //保存的页面
}

// getters
const getters = {
  keepAliveArray: state => state.keepAliveArray
}

// actions
const actions = {
  pushKeepAlive({commit}, type){ //设置页面缓存
    commit(types.KEEPALIVE_PUSH,type);
  },
  popKeepAlive({commit}, type){  //清除页面缓存
    commit(types.KEEPALIVE_POP,type);
    commit(types.PAGE_ANIMATION_BACK_SET, true);   //设置返回动画
  },
  popKeepAliveToRoot({commit}, type){ //清除所有页面缓存
    commit(types.KEEPALIVE_POP_TO_ROOT,type); 
    commit(types.PAGE_ANIMATION_BACK_SET, true);   //设置返回动画
  },
  popKeepAliveTo({commit}, type){ //返回指定页面，清除该页面之前的页面缓存
    commit(types.KEEPALIVE_POP_TO,type);  
    commit(types.PAGE_ANIMATION_BACK_SET, true);   //设置返回动画
  },
}

// mutations
const mutations = {
  [types.KEEPALIVE_PUSH](state, type){
    state.keepAliveArray.push(type);
  },
  [types.KEEPALIVE_POP](state, type){
    state.keepAliveArray.pop();
  },
  [types.KEEPALIVE_POP_TO_ROOT](state){
    state.keepAliveArray = [];
  },
  [types.KEEPALIVE_POP_TO](state, type){
    var index = state.keepAliveArray.indexOf(type);
    if(index >= 0){
      state.keepAliveArray.splice(index, state.keepAliveArray.length);
    }
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
