/*
 * 保存回话
 * @Date    : 2017-03-28
 * @Author  : samyu
 * @Version : V1.0
 *
 */
import * as types from '../mutation-types'
const SESSION_KEY = 'MM_SESSION_KEY';

const state = {
  session: JSON.parse(localStorage.getItem(SESSION_KEY)) || '' //会话 {token:   expired:}
}

// getters
const getters = {
  sessionToken: state => state.session.token,
  sessionIsValid: state => {
    console.log("expired="+state.session.expired);

    if (state.session === null) {
      return false;
    }
    else if (state.token === null)
      return false;
    else if (state.expired !== null) {  //tbd: 要判断有效期

    }
    return true;
  }
}

// actions
const actions = {
  newSession ({ commit, state }, session) {
    commit(types.SESSION_NEW, session);
  },
  removeSession ({ commit, state }) {
    commit(types.SESSION_REMOVE);
  },
}

// mutations
const mutations = {
  [types.SESSION_NEW] (state, session) {
    state.session = session;
    localStorage.setItem(SESSION_KEY, JSON.stringify(state.session));
  },
  [types.SESSION_REMOVE] (state) {
    state.session = {};
    localStorage.setItem(SESSION_KEY, JSON.stringify(state.session));
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
