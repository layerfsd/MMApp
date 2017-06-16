//服务器地址
const remoteUrl = '/api';

/*wangliang 2017-04-10*/
/*判断是否注册注册接口*/
export const registerStatus = remoteUrl + '/mGate/login/m_queryAdminIsExist.do';

/*wangliang 2017-04-10*/
/*获取短信验证码接口*/
export const getVerificationCode = remoteUrl + '/mGate/common/m_getVerificationCode.do';

/*wangliang 2017-04-10*/
/*校验短信验证码接口*/
export const checkVerificationCode = remoteUrl + '/mGate/common/m_checkVerificationCode.do';

/*wangliang 2017-04-10*/
/*注册接口*/
export const register = remoteUrl + '/mGate/login/m_adminRegister.do';

/*wangliang 2017-04-10*/
/*认征接口*/
export const authentication = remoteUrl + '/mGate/customer/m_authentication.do';

/*wangliang 2017-04-11*/
/*激活接口*/
export const activation = remoteUrl + '/mGate/login/m_adminActivation.do';

/*wangliang 2017-04-12*/
/*登录接口*/
   export const login = remoteUrl + '/mGate/login/m_merchantLogin.do';

/*wangliang 2017-04-13*/
/*更换设备接口*/
export const bindPhoneChange = remoteUrl + '/mGate/login/m_bindPhoneChange.do';

/*wangliang 2017-04-13*/
/*忘记密码接口*/
export const forgotPassword = remoteUrl + '/mGate/merchant/m_forgetPwd.do';

/*wangliang 2017-04-17*/
/*接收密保问题接口*/
export const securityRecordRandom = remoteUrl + '/mGate/merchant/m_marchantSecurityRandom.do';

/*wangliang 2017-04-13*/
/*验证密保接口*/
export const securityRecord = remoteUrl + '/mGate/merchant/m_selectMarchantSecurity.do';

/*wangliang 2017-04-18*/
/*重置登录密码接口*/
export const changeLoginPassword = remoteUrl + '/mGate/me/m_changeLoginPassword.do';

/*徐伟辉 2017-05-11*/
/*提交反馈意见借口*/
export const feedbackSubmit = remoteUrl + '/mGate/merchant/m_marchantFeedback.do';

/*徐伟辉 2017-05-12*/
/*判断原密码接口*/
export const checkOriginalPassword = remoteUrl + '/mGate/merchant/m_queryOriginalPassword.do';

/*徐伟辉 2017-05-12*/
/*修改登录密码接口*/
export const modifyLoginPassword = remoteUrl + '/mGate/merchant/m_modifyLoginPassword.do';

//wangliang 2017-05-12
/*查询密保记录接口*/
export const queryMarchantSecurity = remoteUrl + '/mGate/merchant/m_queryMarchantSecurity.do';

//wangliang 2017-05-12
/*修改密保记录接口*/
export const modifySecurityRecord = remoteUrl + '/mGate/merchant/m_modifySecurityRecord.do';

//沈飞 2017-05-12
/*修改PIN*/
export const updatePIN = remoteUrl + '/mGate/merchant/m_modifyPIN.do';

//wangliang 2017-05-16
/*修改密保记录接口*/
export const getMyAccountInfo = remoteUrl + '/mGate/merchant/myAccount/m_myAccountInfo.do';

//wangliang 2017-05-18
/*查询商户信息接口*/
export const queryMarchantInfo = remoteUrl + '/mGate/merchant/m_queryMarchantInfo.do';

//wangliang 2017-05-18
/*查询home信息接口*/
export const homeInfo = remoteUrl + '/mGate/merchant/m_homeInfo.do';

//wangliang 2017-05-19
/*上传图标接口*/
export const fileUpload = remoteUrl + '/mGate/merchant/m_fileUpload.do';

//徐伟辉 2017-05-19
/*社保卡号查询接口*/
export const querySSCStatus = remoteUrl + '/mGate/ssc/m_querySSCStatus.do';
