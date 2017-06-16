package com.ccbsz.ccbgjj.util;

/**
 * Created by liuym on 2017/2/22.
 */

public class JGGlobals {
    //页面跳转标识

    //设置手势密码请求码
    public static int REQUEST_SET_GESTRUE_PASSWORD = 1001;
    //验证手势密码请求码
    public static int REQUEST_CHECK_GESTRUE_PASSWORD = 1002;

    //页面跳转后获取传递参数Key

    //手机号码
    public static final String PARAM_PHONE_NUMBER = "PARAM_PHONE_NUMBER";
    //页面返回code标识
    public static final String PARAM_INTENT_CODE = "PARAM_INTENT_CODE";
    //手势密码
    public static final String PARAM_GESTURE_PASSWORD = "PARAM_GESTURE_PASSWORD";
    //显示提示信息
    public static final String PARAM_TOAST_MESSAGE = "PARAM_TOAST_MESSAGE";
    //传递URL地址
    public static final String PARAM_PAGE_URL = "PARAM_PAGE_URL";


    //指纹认证类型
    public static final int FINGER_AUTH_SUCCESS = 2001;
    public static final int FINGER_AUTH_FAILED = 2002;
    public static final int FINGER_AUTH_ERROR = 2003;
    public static final int FINGER_AUTH_HELP = 2004;
    public static final int FINGER_AUTH_CANCEL = 2005;
    public static final int FINGERPRINT = 2006;

    //定位
    public static final int LOCATION_REQUEST = 10004;

    //请求权限码
    public static final int PERMISSIONS_REQUEST_CDOE = 10001;


    public static final String FINGER_KEY_NAME = "FINGER_KEY_NAME";

    /**
     * 手势密码存在本地文件名
     * */
    public static final String GESTRUE_PASSWORD_NAME="bplusbank_gestrue";
    /**
     * 指纹在本地文件名
     * */
    public static final String PRINT_PASSWORD_NAME="bplusbank_print";
    /**
     * 手势密码或者指纹密码存储key
     * */
    public static final String PHONE_KEY="phone_key";
    /**
     * 手势密码或者指纹密码存储key
     * */
    public static final String PASSWORD_KEY="password_key";
    /**
     * 手势或者指纹存储SeesionId的key
     * */
    public static final String CHECK_INFO ="guest_info";



    //成功代码
    public static final String CODE_SUCCESS="0";

    //失败代码
    public static final String CODE_FAIL="1";

    public static final String CODE_USE_PASSWORD="2";

    public static final String LAST_INPUT = "last_input";

    public static final String DQB = "dqb";
    public static final String PD_ID = "pd_id";
    public static final String FND_ECD = "fnd_ecd";
    public static final String FND_CD_ID = "fnd_cd_id";
    public static final String GUEST_RETRY = "guest_retry";
    public static final String GUEST_TIMEOUT = "guest_timeout";
}
