//服务器地址
const remoteUrl = '/api';

/*wangliang 2017-04-10*/
/*判断是否注册注册接口*/
export const registerStatus = remoteUrl + '/merchant/registerStatus';

/*wangliang 2017-04-10*/
/*获取短信验证码接口*/
export const getVerificationCode = remoteUrl + '/merchant/getVerificationCode';

/*wangliang 2017-04-10*/
/*校验短信验证码接口*/
export const checkVerificationCode = remoteUrl + '/merchant/checkVerificationCode';

/*wangliang 2017-04-10*/
/*注册接口*/
export const register = remoteUrl + '/merchant/register';

/*wangliang 2017-04-10*/
/*认征接口*/
export const authentication = remoteUrl + '/merchant/authentication';

/*wangliang 2017-04-11*/
/*激活接口*/
export const activation = remoteUrl + '/merchant/activation';

/*wangliang 2017-04-12*/
/*登录接口*/
export const login = remoteUrl + '/merchant/login';

/*wangliang 2017-04-13*/
/*更换设备接口*/
export const bindPhoneChange = remoteUrl + '/merchant/bindPhoneChange';

/*wangliang 2017-04-13*/
/*忘记密码接口*/
export const forgotPassword = remoteUrl + '/merchant/forgotPassword';

/*wangliang 2017-04-17*/
/*接收密保问题接口*/
export const securityRecordRandom = remoteUrl + '/merchant/securityRecordRandom';

/*wangliang 2017-04-13*/
/*验证密保接口*/
export const securityRecord = remoteUrl + '/merchant/securityRecord';

/*wangliang 2017-04-18*/
/*重置登录密码接口*/
export const changeLoginPassword = remoteUrl + '/merchant/changeLoginPassword';

/*徐伟辉 2017-05-11*/
/*提交反馈意见借口*/
export const feedbackSubmit = remoteUrl + '/merchant/marchantFeedback'; //接口联调

/*徐伟辉 2017-05-12*/
/*判断原密码接口*/
export const checkOriginalPassword = remoteUrl + '/merchant/queryOriginalPassword'; //接口联调

/*徐伟辉 2017-05-12*/
/*修改登录密码接口*/
export const modifyLoginPassword = remoteUrl + '/merchant/modifyLoginPassword'; //接口联调

/*沈飞 2017-05-12*/
/*重置PIN接口*/
export const updatePIN = remoteUrl + '/merchant/updatePIN';

//wangliang 2017-05-12
/*查询密保记录接口*/
export const queryMarchantSecurity = remoteUrl + '/merchant/queryMarchantSecurity';

//wangliang 2017-05-12
/*修改密保记录接口*/
export const modifySecurityRecord = remoteUrl + '/merchant/modifySecurityRecord';

//wangliang 2017-05-16
/*获取账户信息接口*/
export const getMyAccountInfo = remoteUrl + '/merchant/getMyAccountInfo';

//wangliang 2017-05-18
/*查询商户信息接口*/
export const queryMarchantInfo = remoteUrl + '/merchant/queryMarchantInfo';

//wangliang 2017-05-18
/*查询home页面信息接口*/
export const homeInfo = remoteUrl + '/merchant/homeInfo';

//wangliang 2017-05-19
/*上传图标接口*/
export const fileUpload = remoteUrl + '/merchant/fileUpload';

//徐伟辉 2017-05-19
/*社保卡号查询接口*/
export const querySSCStatus = remoteUrl + '/ssc/m_querySSCStatus';
