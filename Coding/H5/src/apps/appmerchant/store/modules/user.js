/*
 * 保存注册信息
 * @Date    : 2017-04-12
 * @Author  : wangliang
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'

const state = {
  operatorName: '',
  idType: '',
  idCardNo: '',
  phone: '',  //用户的手机号
  shortCode: '', //手机短号
  headPortrait: '', //头像
  merchantLogo: '' //商家logo
}

// getters
const getters = {
  phone: state => state.phone
}

// actions
const actions = {
  saveUser ({ commit }, option) {
    commit(types.USER, option);
  }
}

// mutations
const mutations = {
  [types.USER] (state, option) {
    option.operatorName && (state.operatorName = option.operatorName);

    option.idType && (state.idType = option.idType);

    option.idCardNo && (state.idCardNo = option.idCardNo);

    option.phone && (state.phone = option.phone);

    option.shortCode && (state.shortCode = option.shortCode);

    option.merchantLogo && (state.merchantLogo = option.merchantLogo);

    option.headPortrait && (state.headPortrait = option.headPortrait);

  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
