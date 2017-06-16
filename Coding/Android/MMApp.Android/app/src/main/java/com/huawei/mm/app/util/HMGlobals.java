package com.huawei.mm.app.util;

/**
 * Created by liuym on 2017/2/22.
 */

public class HMGlobals {

    //请求权限码
    public static final int PERMISSIONS_REQUEST_CDOE = 10001;

    //设置手势密码请求码
    public static int REQUEST_SET_GESTRUE_PASSWORD = 1001;
    //验证手势密码请求码
    public static int REQUEST_CHECK_GESTRUE_PASSWORD = 1002;
    //打开系统相册请求码
    public static int OPEN_PHOTO_FOLDER_REQUEST_CODE = 1003;
    //打开系统相机
    public static int OPEN_CAMERA_CODE = 1004;

    //成功代码
    public static final String CODE_SUCCESS = "0";

    //失败代码
    public static final String CODE_FAIL = "1";

    public static String DEVICEID = "";

    public static String API_CALLER_KEY = "hua_wei_cps_app_";     //登录密码key

    //手机号码
    public static final String PARAM_PHONE_NUMBER = "PARAM_PHONE_NUMBER";

    /**
     * 手势密码或者指纹密码存储key
     */
    public static final String PHONE_KEY = "phone_key";
    /**
     * 手势密码或者指纹密码存储key
     */
    public static final String PASSWORD_KEY = "password_key";
    /**
     * 手势或者指纹存储SeesionId的key
     */
    public static final String CHECK_INFO = "guest_info";

    /**
     * 手势密码存在本地文件名
     */
    public static final String GESTRUE_PASSWORD_NAME = "hm_gestrue";

    public static final String GUEST_RETRY = "guest_retry";
    public static final String GUEST_TIMEOUT = "guest_timeout";
    //页面返回code标识
    public static final String PARAM_INTENT_CODE = "PARAM_INTENT_CODE";
    //重置手势密码
    public static final String PARAM_RESET_GESTURE = "PARAM_RESET_GESTURE";
    //手势密码
    public static final String PARAM_GESTURE_PASSWORD = "PARAM_GESTURE_PASSWORD";
    //显示提示信息
    public static final String PARAM_TOAST_MESSAGE = "PARAM_TOAST_MESSAGE";
    public static final String LAST_INPUT = "last_input";
    public static final String CODE_USE_PASSWORD = "2";


    //**************************commondID  start******************************//

    //**************************commondID  end******************************//

    //**************************IdentifierType start **********************//
    public static final String RECEIVER_IDENTIFIER_TYPE = "4";
    public static final String IDENTIFIER_TYPE = "1";
    public static final String ACCOUNT_TYPE = "m-pesa";
    public static final String TRANSACTION_STATUS = "Completed";
    public static final String INSURANCE_TYPE_CODE = "InsuranceTypeCode";
    public static final String CURRENCY_USD = "USD";
    //**************************IdentifierType end **********************//

    //**************************parameter start **********************//
    public static final String NEW_PIN = "NewPIN";
    //**************************parameter end **********************//

    //**************************Sms start **********************//
    public static final String DURATION = "600";
    public static final String APPLICATION_CODE = "CPSAPP";
    public static final String DESTINATION_TYPE = "1001";
    //**************************Sms end **********************//

    public static final String IMEI_FACTOR = "IMEIfactor";
    public static final String TRANSPORT_KEY = "transportKey";

}
