//服务器地址
const remoteUrl = '/api';

export const productAll = '/product/all'
export const productBuy = '/product/buy'
export const productAdd = '/product/add'

//登陆接口
// export const login = remoteUrl + '/mGate/customer/customerLogin.do';

export const getCashWalletTrans = remoteUrl + '/cashwallet/trans';

export const getAccountBalance = remoteUrl + '/account/balance';

/*wangliang 2017-04-10*/
/*判断是否注册注册接口*/
// export const registerStatus = remoteUrl + '/mGate/customer/m_registerStatus.do';//联调
export const registerStatus = remoteUrl + '/merchant/registerStatus';//merchant本地mock

/*wangliang 2017-04-10*/
/*获取短信验证码接口*/
// export const getVerificationCode = remoteUrl + '/mGate/common/m_getVerificationCode.do';//联调(公共)
export const getVerificationCode = remoteUrl + '/merchant/getVerificationCode';//merchant本地mock


/*wangliang 2017-04-10*/
/*校验短信验证码接口*/
// export const checkVerificationCode = remoteUrl + '/mGate/common/m_checkVerificationCode.do';//联调
export const checkVerificationCode = remoteUrl + '/merchant/checkVerificationCode';//merchant本地mock

/*wangliang 2017-04-10*/
/*注册接口*/
// export const register = remoteUrl + '/mGate/customer/m_register.do';//联调
export const register = remoteUrl + '/merchant/register'; //merchant本地mock

/*wangliang 2017-04-10*/
/*认征接口*/
// export const authentication = remoteUrl + '/mGate/customer/m_authentication.do';//联调
export const authentication = remoteUrl + '/merchant/authentication';//merchant本地mock

/*wangliang 2017-04-11*/
/*激活接口*/
// export const activation = remoteUrl + '/mGate/login/m_activation.do';//联调
export const activation = remoteUrl + '/merchant/activation';//merchant本地mock

/*wangliang 2017-04-12*/
/*登录接口*/
// export const login = remoteUrl + '/mGate/login/m_merchantLogin.do'; //merchant接口联调
export const login = remoteUrl + '/merchant/login';//本地mock

/*wangliang 2017-04-13*/
/*更换设备接口*/
// export const bindPhoneChange = remoteUrl + '/mGate/login/m_bindPhoneChange.do'; //接口联调
export const bindPhoneChange = remoteUrl + '/merchant/bindPhoneChange';//本地mock

/*wangliang 2017-04-13*/
/*忘记密码接口*/
// export const forgotPassword = remoteUrl + '/mGate/customer/m_forgetPwd.do'; //接口联调
export const forgotPassword = remoteUrl + '/merchant/forgotPassword';//本地mock

/*wangliang 2017-04-17*/
/*接收密保问题接口*/
// export const securityRecordRandom = remoteUrl + '/mGate/customer/m_securityRecordRandom.do'; //接口联调
export const securityRecordRandom = remoteUrl + '/merchant/securityRecordRandom';//本地mock

/*wangliang 2017-04-13*/
/*验证密保接口*/
// export const securityRecord = remoteUrl + '/mGate/customer/m_securityRecord.do'; //接口联调
export const securityRecord = remoteUrl + '/merchant/securityRecord';//本地mock

/*wangliang 2017-04-18*/
/*重置登录密码接口*/
// export const changeLoginPassword = remoteUrl + '/mGate/me/m_changeLoginPassword.do'; //接口联调
export const changeLoginPassword = remoteUrl + '/merchant/changeLoginPassword';//本地mock