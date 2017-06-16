/*
 * 页面是否要刷新
 * @Date    : 2017-03-28
 * @Author  : samyu
 * @Version : V1.0
 *
 */

import * as types from '../mutation-types'

const state = {
  needRefreshPageMe: false //是否要刷新页面
}

// getters
const getters = {
  needRefreshPageMe: state => state.needRefreshPageMe
}

// actions
const actions = {
  refreshPageMe ({ commit, state }) {
    commit(types.REFRESH_PAGE_ME_UPDATE, true);
  },
  refreshPageMeDone ({ commit, state }) {
    commit(types.REFRESH_PAGE_ME_UPDATE, false);
  }

}

// mutations
const mutations = {
  [types.REFRESH_PAGE_ME_UPDATE] (state, val) {
    state.needRefreshPageMe = val;
  },
}

export default {
  state,
  getters,
  actions,
  mutations
}
