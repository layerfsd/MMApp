package com.ccbsz.ccbgjj.activitys;

import android.Manifest;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;


import com.ccbsz.ccbgjj.finger.JGFingerManager;
import com.ccbsz.ccbgjj.gesture.activitys.GestureEditActivity;
import com.ccbsz.ccbgjj.gesture.activitys.GestureVerifyActivity;
import com.ccbsz.ccbgjj.util.JGLocationHelper;
import com.ccbsz.ccbgjj.util.JGPermissions;
import com.github.lzyzsd.jsbridge.BridgeHandler;
import com.github.lzyzsd.jsbridge.BridgeWebView;
import com.github.lzyzsd.jsbridge.CallBackFunction;

import com.ccbsz.ccbgjj.util.JGDeviceHelper;
import com.ccbsz.ccbgjj.util.JGGlobals;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends BaseWebViewActivity {
    //js调用原生后回调处理
    CallBackFunction mCallBack = null;

    private JGFingerManager mJGFingerManager = null;

    private JGLocationHelper mJGLocationHelper = null;

    private static final int HANDLE_JS_CALLBACK = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            bridgeWebView.setWebContentsDebuggingEnabled(true);
        }

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            mJGFingerManager = new JGFingerManager(this);
            mJGFingerManager.setJGFingerManagerListener(new JGFingerManager.JGFingerManagerListener() {
                @Override
                public void fingerResult(int result, String message) {
                    JSONObject object = new JSONObject();

                    if (result == JGGlobals.FINGER_AUTH_SUCCESS) {
                        //认证成功
                        jsonPut(object, "ret", "0");
                        jsonPut(object, "message", "指纹验证成功");
                        jsonPut(object, "device_id", JGDeviceHelper.getDeviceId());
                    } else {
                        jsonPut(object, "ret", "-1");
                        jsonPut(object, "message", message);
                    }

                    handleJSCallBack(object);
                }
            });
        }

        mJGLocationHelper = new JGLocationHelper(this);
        mJGLocationHelper.setJGLocationHelperListener(new JGLocationHelper.JGLocationHelperListener() {
            @Override
            public void locationHelperSuccess(double latitude, double longitude, String address) {
                JSONObject object = new JSONObject();

                jsonPut(object, "ret", "0");
                jsonPut(object, "longitude", longitude + "");
                jsonPut(object, "latitude", latitude + "");
                jsonPut(object, "address", address);

                handleJSCallBack(object);
            }

            @Override
            public void locationHelperFail(String error) {
                JSONObject object = new JSONObject();

                jsonPut(object, "ret", "-1");
                jsonPut(object, "message", error);

                handleJSCallBack(object);
            }
        });

    }

    @Override
    public void loadWebPage(BridgeWebView webView) {
        loadLocalPage(webView, "file:///android_asset/www/index.html");
    }

    @Override
    public void registerNativeHandles() {
        //函数说明 测试js调用和回调
        bridgeWebView.registerHandler("testObjcCallback", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                System.out.println("data = " + data);
                function.onCallBack("Response from testObjcCallback");
            }
        });

        //函数说明 获取设备信息
        bridgeWebView.registerHandler("deviceModel", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack("Android");
            }
        });

        //函数说明 获取设备Id
        bridgeWebView.registerHandler("deviceId", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(JGDeviceHelper.getDeviceId());
            }
        });

        //函数说明 获取设备Ip
        bridgeWebView.registerHandler("deviceIP", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(JGDeviceHelper.getDeviceIP());
            }
        });

        //函数说明 获取设备版本号
        bridgeWebView.registerHandler("deviceOSVersion", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(JGDeviceHelper.getAndroidVersion());
            }
        });
        
        //函数说明 获取位置信息
        bridgeWebView.registerHandler("getLocation", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

                JGPermissions.getInstance().checkAndRequestPermissions(mContext, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, new JGPermissions.JGPermissionsListener() {
                    @Override
                    public void permissionsSuccess() {
                        if(mJGLocationHelper != null){
                            mJGLocationHelper.startGetLocation();
                        }
                    }

                    @Override
                    public void permissionsFail(String[] messages) {
                        JSONObject object = new JSONObject();

                        jsonPut(object, "ret", "-1");

                        JSONArray array = new JSONArray();
                        for(String value : messages) {
                            array.put(value);
                        }

                        jsonPut(object, "message", array);

                        handleJSCallBack(object);
                    }
                });
            }
        });

        //函数说明 设置手势密码
        bridgeWebView.registerHandler("setGesturePassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                Intent intent = new Intent(MainActivity.this, GestureEditActivity.class);
                intent.putExtra(JGGlobals.PARAM_PHONE_NUMBER, "18603036536");
                startActivityForResult(intent, JGGlobals.REQUEST_SET_GESTRUE_PASSWORD);
                //function.onCallBack("回调处理");

                mCallBack = function;
            }
        });

        //函数说明 验证手势密码
        bridgeWebView.registerHandler("checkGesturePassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {


            Intent intent = new Intent(MainActivity.this, GestureVerifyActivity.class);
            startActivityForResult(intent, JGGlobals.REQUEST_CHECK_GESTRUE_PASSWORD);


            //function.onCallBack("回调处理");
            mCallBack = function;
            }
        });

        //函数说明 设置指纹
        bridgeWebView.registerHandler("setFingerprintPassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

                if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (mJGFingerManager.isSupportFinger() == false) {
                        JSONObject object = new JSONObject();

                        jsonPut(object, "ret", "-1");
                        jsonPut(object, "message", mJGFingerManager.getError());

                        handleJSCallBack(object);
                    } else {
                        mJGFingerManager.setFingerprintPassword();
                    }
                }else{
                    JSONObject object = new JSONObject();

                    jsonPut(object, "ret", "-1");
                    jsonPut(object, "message", "系统版本低");

                    handleJSCallBack(object);
                }
            }
        });

        //函数说明 验证指纹
        bridgeWebView.registerHandler("checkFingerprintPassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

                if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (mJGFingerManager.isSupportFinger() == false) {
                        JSONObject object = new JSONObject();

                        jsonPut(object, "ret", "-1");
                        jsonPut(object, "message", mJGFingerManager.getError());

                        handleJSCallBack(object);
                    } else {
                        mJGFingerManager.checkFingerprintPassword();
                    }
                }else{
                    JSONObject object = new JSONObject();

                    jsonPut(object, "ret", "-1");
                    jsonPut(object, "message", "系统版本低");

                    handleJSCallBack(object);
                }
            }
        });

        //函数说明 跳转新的activity
        bridgeWebView.registerHandler("newPageWithURL", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {


                JSONObject object = stringToJsonObject(data);

                Intent intent = new Intent(MainActivity.this, JGSubActivity.class);
                if(object != null){
                    intent.putExtra(JGGlobals.PARAM_PAGE_URL, jsonGet(object, "url"));
                }else{

                }

                startActivity(intent);

                function.onCallBack("\"ret\":\"0\"");
            }
        });

        //函数说明 关闭新的页面
        bridgeWebView.registerHandler("closePage", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                if(mContext.getClass() == JGSubActivity.class){
                    finish();
                }

                function.onCallBack("\"ret\":\"0\"");
            }
        });

    }

    @Override
    public void onStart() {
        super.onStart();

    }

    @Override
    public void onStop() {
        super.onStop();

        mJGLocationHelper.stopGetLocation();

    }

    private Handler customHandler = new Handler() {

        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);

            switch (msg.what){
                case HANDLE_JS_CALLBACK:
                {
                    if(mCallBack != null){
                        System.out.println("js call data = " + msg.obj.toString());
                        mCallBack.onCallBack(msg.obj.toString());
                        mCallBack = null;
                    }
                }
                    break;
            }
        }
    };

    private void handleJSCallBack(JSONObject object){
        Message msg = customHandler.obtainMessage();
        msg.what = HANDLE_JS_CALLBACK;
        msg.obj = object.toString();
        customHandler.sendMessage(msg);
    }

    private JSONObject stringToJsonObject(String data){
        try{
            JSONObject object = new JSONObject(data);
            return object;
        }catch (JSONException e){
            return null;
        }
    }

    private String jsonGet(JSONObject object, String key){
        if(object != null){
            try{
                return object.getString(key);
            }catch (JSONException e){
                return "";
            }
        }

        return "";
    }

    private void jsonPut(JSONObject object, String key, Object value){
        if(object != null){
            try {
                object.put(key, value);
            }catch (JSONException e){

            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == RESULT_OK){
            //处理设置手势处理
            if(requestCode == JGGlobals.REQUEST_SET_GESTRUE_PASSWORD){
                String code = data.getStringExtra(JGGlobals.PARAM_INTENT_CODE);

                JSONObject object = new JSONObject();

                if(code.equals(JGGlobals.CODE_SUCCESS)){
                    jsonPut(object, "ret", "0");
                    jsonPut(object, "device_id", JGDeviceHelper.getDeviceId());
                    jsonPut(object, "guesture_pwd", data.getStringExtra(JGGlobals.PARAM_GESTURE_PASSWORD));

                }else if(code.equals(JGGlobals.CODE_FAIL)){
                    jsonPut(object, "ret", "-1");
                }

                handleJSCallBack(object);
            }else if(requestCode == JGGlobals.REQUEST_CHECK_GESTRUE_PASSWORD){
                String code = data.getStringExtra(JGGlobals.PARAM_INTENT_CODE);

                JSONObject object = new JSONObject();

                if(code.equals(JGGlobals.CODE_SUCCESS)){
                    jsonPut(object, "ret", "0");
                    jsonPut(object, "message", "手势密码登陆成功");
                    jsonPut(object, "guesture_pwd", data.getStringExtra(JGGlobals.PARAM_GESTURE_PASSWORD));
                }else if(code.equals(JGGlobals.CODE_FAIL)){
                    jsonPut(object, "ret", "-1");
                    jsonPut(object, "message", data.getStringExtra(JGGlobals.PARAM_TOAST_MESSAGE));
                }else if(code.equals(JGGlobals.CODE_USE_PASSWORD)){
                    jsonPut(object, "ret", "2");
                    jsonPut(object, "message", "选择密码登陆");
                }

                handleJSCallBack(object);
            }
        }
    }

    //权限请求后判断

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if(requestCode == JGGlobals.PERMISSIONS_REQUEST_CDOE){
            //判断权限结果
            JGPermissions.getInstance().onRequestPermissionsResult(permissions, grantResults);
        }
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }
}
