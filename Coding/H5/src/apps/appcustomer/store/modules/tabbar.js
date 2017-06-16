
import * as types from '../mutation-types'

const state = {
  tabbarIsShow: true       //是否显示tabbar
}

// getters
const getters = {
  tabbarIsShow: state => state.tabbarIsShow
}

// actions
const actions = {
  showTabbar({commit}){ //显示tabbar
    commit(types.TABBAR_SHOW);
  },
  hideTabbar({commit}){  //隐藏tabbar
    commit(types.TABBAR_HIDE);
  }
}

// mutations
const mutations = {
  [types.TABBAR_SHOW](state){
    state.tabbarIsShow = true;
  },
  [types.TABBAR_HIDE](state, type){
    state.tabbarIsShow = false;
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
