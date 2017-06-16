/*
 * 保存注册信息
 * @Date    : 2017-05-09
 * @Author  : wangliang
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'
import config from '../../config/index'
const state = {
  lang: localStorage.getItem('language') || config.lang  
}

// getters
const getters = {
  lang: state => state.lang
}

// actions
const actions = {
  saveLanguage ({ commit }, option) {
    commit(types.LANG_SAVE, option);
  },
  removeLanguage ({ commit }) {
    commit(types.LANG_REMOVE);
  },
}

// mutations
const mutations = {
  [types.LANG_SAVE] (state, option) {
    state.lang = option.lang;
    option.lang && localStorage.setItem('language', option.lang);
  },
  [types.LANG_REMOVE] (state) {
    state.lang = '';
    localStorage.removeItem('language');
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
