/*
 * 保存注册信息
 * @Date    : 2017-04-12
 * @Author  : wangliang
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'

const state = {
  user: {
    phone: '13544284627',  //用户的手机号
    imei: '20170410082539',
    phoneModel: 'iOS',
    phoneSystem: '10.2',
    pushToken: '123'
  }
}

// getters
const getters = {
  phone: state => state.phone
}

// actions
const actions = {
  saveUser ({ commit }, option) {
    commit(types.SIGN_UP, option);
  }
}

// mutations
const mutations = {
  [types.SIGN_UP] (state, option) {
    state.user.phone = option.phone;
    state.user.imei = option.imei;
    state.user.phonemodel = option.phonemodel;
    state.user.phoneSystem = option.phoneSystem;
    state.user.pushToken = option.pushToken;
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
