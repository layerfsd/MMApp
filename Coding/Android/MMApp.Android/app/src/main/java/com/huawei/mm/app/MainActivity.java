package com.huawei.mm.app;

import android.Manifest;
import android.content.CursorLoader;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.location.Location;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.provider.MediaStore;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import com.github.lzyzsd.jsbridge.BridgeHandler;
import com.github.lzyzsd.jsbridge.BridgeWebView;
import com.github.lzyzsd.jsbridge.CallBackFunction;
import com.huawei.mm.app.encrypt.HMEncryptApi;
import com.huawei.mm.app.gesture.activity.GestureEditActivity;
import com.huawei.mm.app.gesture.activity.GestureVerifyActivity;
import com.huawei.mm.app.keyboard.KeyboardUtil;
import com.huawei.mm.app.util.HMDeviceHelper;
import com.huawei.mm.app.util.HMGlobals;
import com.huawei.mm.app.util.HMLocationHelper;
import com.huawei.mm.app.util.ILog;
import com.huawei.mm.app.util.HMPermissions;
import com.huawei.mm.app.util.LocationUtil;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;

public class MainActivity extends BaseWebViewActivity {
    private static final int JPG_DEFAULT_COMPRESSION_QUALITY = 70;
    //js调用原生后回调处理
    CallBackFunction mCallBack = null;

    private HMLocationHelper mJGLocationHelper = null;

    private static final int HANDLE_JS_CALLBACK = 1;

    private String mInputId;
    private JSONObject inputJson;
    private String JSRequireImgType;
    private int JSRequireCompressionQuality;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            bridgeWebView.setWebContentsDebuggingEnabled(true);
        }

//        mJGLocationHelper = new HMLocationHelper(this);
//        mJGLocationHelper.setJGLocationHelperListener(new HMLocationHelper.JGLocationHelperListener() {
//            @Override
//            public void locationHelperSuccess(double latitude, double longitude, String address) {
//                JSONObject object = new JSONObject();
//
//                jsonPut(object, "ret", "0");
//                jsonPut(object, "longitude", longitude + "");
//                jsonPut(object, "latitude", latitude + "");
//                jsonPut(object, "address", address);
//
//                handleJSCallBack(object);
//            }
//
//            @Override
//            public void locationHelperFail(String error) {
//                JSONObject object = new JSONObject();
//
//                jsonPut(object, "ret", "-1");
//                jsonPut(object, "message", error);
//
//                handleJSCallBack(object);
//            }
//        });
    }

    @Override
    public void loadWebPage(BridgeWebView webView) {
        loadLocalPage(webView, "http://192.168.1.86:8080/appmerchant.html");
//        loadLocalPage(webView, "http://www.baidu.com");
//        loadLocalPage(webView, "file:///android_asset/www/index.html");
//        loadRemotePage(webView, "http://192.168.1.153:8088/appmerchant.html");
    }

    @Override
    public void registerNativeHandles() {

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
                function.onCallBack(HMDeviceHelper.getDeviceId());
            }
        });

        //函数说明 获取设备Ip
        bridgeWebView.registerHandler("deviceIP", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMDeviceHelper.getDeviceIP());
            }
        });

        //函数说明 获取设备版本号
        bridgeWebView.registerHandler("deviceOSVersion", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMDeviceHelper.getAndroidVersion());
            }
        });

        //取App的版本
        bridgeWebView.registerHandler("appVersion", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMDeviceHelper.getAppVersionName());
            }
        });

        //取设备当前的语言代码
        bridgeWebView.registerHandler("currentLanguageCode", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMDeviceHelper.getLanguage());
            }
        });

        //函数说明 获取位置信息
        bridgeWebView.registerHandler("getLocation", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

                if (null != LocationUtil.getInstance().getLocation()) {
                    Location location = LocationUtil.getInstance().getLocation();
                    JSONObject object = new JSONObject();
//
                    jsonPut(object, "ret", "0");
                    jsonPut(object, "longitude", location.getLongitude() + "");
                    jsonPut(object, "latitude", location.getLatitude() + "");
                    jsonPut(object, "address", location.describeContents());

                    handleJSCallBack(object);
                } else {
                    HMPermissions.getInstance().checkAndRequestPermissions(mContext, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, new HMPermissions.JGPermissionsListener() {
                        @Override
                        public void permissionsSuccess() {
                            ILog.i("remind", "permissionsSuccess");
                            LocationUtil.getInstance().startLocation(mContext, new LocationUtil.LocationCallBack() {
                                @Override
                                public void locationCallBack(Location location) {
                                    JSONObject object = new JSONObject();
//
                                    jsonPut(object, "ret", "0");
                                    jsonPut(object, "longitude", location.getLongitude() + "");
                                    jsonPut(object, "latitude", location.getLatitude() + "");
                                    jsonPut(object, "address", location.describeContents());

                                    handleJSCallBack(object);
                                }
                            });
                        }

                        @Override
                        public void permissionsFail(String[] messages) {
                            JSONObject object = new JSONObject();

                            jsonPut(object, "ret", "-1");

                            JSONArray array = new JSONArray();
                            for (String value : messages) {
                                array.put(value);
                            }

                            jsonPut(object, "message", array);

                            handleJSCallBack(object);
                        }
                    });
                }

            }
        });

        //函数说明 设置手势密码
        bridgeWebView.registerHandler("setGesturePassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                Intent intent = new Intent(MainActivity.this, GestureEditActivity.class);
                intent.putExtra(HMGlobals.PARAM_PHONE_NUMBER, "18675599607");
                startActivityForResult(intent, HMGlobals.REQUEST_SET_GESTRUE_PASSWORD);
                //function.onCallBack("回调处理");

                mCallBack = function;
            }
        });

        //函数说明 验证手势密码
        bridgeWebView.registerHandler("checkGesturePassword", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                Intent intent = new Intent(MainActivity.this, GestureVerifyActivity.class);
                startActivityForResult(intent, HMGlobals.REQUEST_CHECK_GESTRUE_PASSWORD);
                //function.onCallBack("回调处理");
                mCallBack = function;
            }
        });

        //取IMEIFactor，已用RSA根密钥加密
        bridgeWebView.registerHandler("getIMEIFactor", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMEncryptApi.encryptRSAData(MyController.getInstance().getIMEIfactor()));
            }
        });

        //取TransportKey，已用RSA根密钥加密
        bridgeWebView.registerHandler("getTransportKey", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMEncryptApi.encryptRSAData(Base64.encodeToString(MyController.getInstance().getTransportKey(), Base64.NO_WRAP)));
            }
        });

        //取PayloadKey，已用TransportKey加密。每调用一次，就会重新产生PayloadKey。
        bridgeWebView.registerHandler("getPayloadKey", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                MyController.getInstance().randomPayloadKey();
                function.onCallBack(HMEncryptApi.encryptAESData(Base64.encodeToString(MyController.getInstance().getPayloadKey(), Base64.NO_WRAP), MyController.getInstance().getTransportKey()));
            }
        });

        //用PayloadKey加密数据
        bridgeWebView.registerHandler("encryptWithPayloadKey", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack(HMEncryptApi.encryptAESData(data, MyController.getInstance().getPayloadKey()));
            }
        });

        //函数说明 弹出密码键盘
        bridgeWebView.registerHandler("popSafeKeyboard", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

                final JSONObject object = stringToJsonObject(data);
                if (object != null) {
                    mInputId = jsonGet(object, "id");
                    int type = stringToInt(jsonGet(object, "type"));
                    if (type >= 0) {
                        KeyboardUtil.getInstancce().showDigitKeyboard(false);
                    }
                }
            }
        });

        //函数说明 获取密码密文数据
        bridgeWebView.registerHandler("getEncryptedInput", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                mCallBack = function;

//                final JSONObject object = stringToJsonObject(data);
                JSONObject result = new JSONObject();
                if (inputJson != null) {
                    try {
                        jsonPut(result, "id", inputJson.getString("id"));
                        jsonPut(result, "ret", "0");
                        jsonPut(result, "text", HMEncryptApi.encryptAESData(inputJson.getString("text"), MyController.getInstance().getTransportKey()));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                } else {
                    try {
                        jsonPut(result, "id", inputJson.getString("id"));
                        jsonPut(result, "ret", "-1");
                        jsonPut(result, "text", "");
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
                handleJSCallBack(result);
            }
        });

        //描述：是否支持沉浸式状态栏。
        bridgeWebView.registerHandler("supportTranslucentStatus", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                function.onCallBack((Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT ? true : false) + "");
            }
        });

        //描述：设置沉浸式状态栏字体颜色为深色
        bridgeWebView.registerHandler("setStatusStyleBlack", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                JSONObject jsonObject = new JSONObject();
                try {
                    if (null != linear_bar) {
                        linear_bar.setBackgroundColor(getResources().getColor(R.color.black));
                        jsonObject.put("ret", 0);
                    } else {
                        jsonObject.put("ret", -1);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                function.onCallBack(jsonObject.toString());
            }
        });

        //描述：设置沉浸式状态栏字体颜色为浅色
        bridgeWebView.registerHandler("setStatusStyleLight", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                JSONObject jsonObject = new JSONObject();
                try {
                    if (null != linear_bar) {
                        linear_bar.setBackgroundColor(getResources().getColor(R.color.white));
                        jsonObject.put("ret", 0);
                    } else {
                        jsonObject.put("ret", -1);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                function.onCallBack(jsonObject.toString());
            }
        });

        /**
         * 函数说明 从照片库选取照片
         * add by licm 2017.05.17
         */
        bridgeWebView.registerHandler("pickPhotoFromLibrary", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                JSONObject jsonObject = null;
                try {
                    jsonObject = new JSONObject(data);
                    JSRequireImgType = jsonObject.getString("imageType");
                    JSRequireImgType = "".equals(JSRequireImgType) ? "jpg" : JSRequireImgType;
                    JSRequireCompressionQuality = jsonObject.getInt("compressionQuality");

                    Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                    intent.setType("image/*");
                    startActivityForResult(intent, HMGlobals.OPEN_PHOTO_FOLDER_REQUEST_CODE);
                    //function.onCallBack("回调处理");
                    mCallBack = function;
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        });

        /**
         * 函数说明 拍照
         * add by licm 2017.05.17
         */
        bridgeWebView.registerHandler("takePhoto", new BridgeHandler() {
            @Override
            public void handler(final String data, final CallBackFunction function) {
                HMPermissions.getInstance().checkAndRequestPermissions(MainActivity.this, new String[]{Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE}, new HMPermissions.JGPermissionsListener() {
                    @Override
                    public void permissionsSuccess() {
                        JSONObject jsonObject = null;
                        try {
                            jsonObject = new JSONObject(data);
                            JSRequireImgType = jsonObject.getString("imageType");
                            JSRequireImgType = "".equals(JSRequireImgType) ? "jpg" : JSRequireImgType;
                            JSRequireCompressionQuality = jsonObject.getInt("compressionQuality");
                            Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                            startActivityForResult(intent, HMGlobals.OPEN_CAMERA_CODE);
                            //function.onCallBack("回调处理");
                            mCallBack = function;
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }

                    @Override
                    public void permissionsFail(String[] messages) {
                        Log.e("licm", "failed." + messages[0]);
                        Toast.makeText(MainActivity.this,"未获取拍照权限!",Toast.LENGTH_SHORT).show();
                        JSONObject object = new JSONObject();
                        jsonPut(object, "ret", -1);
                        jsonPut(object, "base64Encoded", "");

                        handleJSCallBack(object);
                    }
                });

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

            switch (msg.what) {
                case HANDLE_JS_CALLBACK: {
                    if (mCallBack != null) {
                        ILog.i("remind", "js call data ==>" + msg.obj.toString());
                        mCallBack.onCallBack(msg.obj.toString());
                        mCallBack = null;
                    }
                }
                break;
            }
        }
    };

    private void handleJSCallBack(JSONObject object) {
        Message msg = customHandler.obtainMessage();
        msg.what = HANDLE_JS_CALLBACK;
        msg.obj = object.toString();
        customHandler.sendMessage(msg);
    }

    private JSONObject stringToJsonObject(String data) {
        try {
            JSONObject object = new JSONObject(data);
            return object;
        } catch (JSONException e) {
            return null;
        }
    }

    private String jsonGet(JSONObject object, String key) {
        if (object != null) {
            try {
                return object.getString(key);
            } catch (JSONException e) {
                e.printStackTrace();
                return "";
            }
        }

        return "";
    }

    private void jsonPut(JSONObject object, String key, Object value) {
        if (object != null) {
            try {
                object.put(key, value);
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (resultCode == RESULT_OK) {
            //处理设置手势处理
            if (requestCode == HMGlobals.REQUEST_SET_GESTRUE_PASSWORD) {
                String code = data.getStringExtra(HMGlobals.PARAM_INTENT_CODE);

                JSONObject object = new JSONObject();

                if (code.equals(HMGlobals.CODE_SUCCESS)) {
                    jsonPut(object, "ret", "0");
                    jsonPut(object, "device_id", HMDeviceHelper.getDeviceId());
                    jsonPut(object, "guesture_pwd", data.getStringExtra(HMGlobals.PARAM_GESTURE_PASSWORD));

                } else if (code.equals(HMGlobals.CODE_FAIL)) {
                    jsonPut(object, "ret", "-1");
                }

                handleJSCallBack(object);
            } else if (requestCode == HMGlobals.REQUEST_CHECK_GESTRUE_PASSWORD) {
                String code = data.getStringExtra(HMGlobals.PARAM_INTENT_CODE);

                JSONObject object = new JSONObject();

                if (code.equals(HMGlobals.CODE_SUCCESS)) {
                    jsonPut(object, "ret", "0");
                    jsonPut(object, "message", "手势密码登陆成功");
                    jsonPut(object, "guesture_pwd", data.getStringExtra(HMGlobals.PARAM_GESTURE_PASSWORD));
                } else if (code.equals(HMGlobals.CODE_FAIL)) {
                    jsonPut(object, "ret", "-1");
                    jsonPut(object, "message", data.getStringExtra(HMGlobals.PARAM_TOAST_MESSAGE));
                } else if (code.equals(HMGlobals.CODE_USE_PASSWORD)) {
                    jsonPut(object, "ret", "2");
                    jsonPut(object, "message", "选择密码登陆");
                }

                handleJSCallBack(object);
            } else if (requestCode == HMGlobals.OPEN_PHOTO_FOLDER_REQUEST_CODE) {
                try {
                    Uri uri = data.getData();
                    //get the image path
                    String[] projection = {MediaStore.Images.Media.DATA};
                    CursorLoader cursorLoader = new CursorLoader(this, uri, projection, null, null, null);
                    Cursor cursor = cursorLoader.loadInBackground();
                    int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
                    cursor.moveToFirst();
                    final String path = cursor.getString(column_index);
                    handleImage(path);
                } catch (Exception ex) {
                    Log.e("licm", "failed." + ex.getMessage());
                    JSONObject object = new JSONObject();
                    jsonPut(object, "ret", -1);
                    jsonPut(object, "base64Encoded", "");

                    handleJSCallBack(object);
                }

            } else if (requestCode == HMGlobals.OPEN_CAMERA_CODE) {
                Bundle bundle = data.getExtras();
                Bitmap bm = (Bitmap) bundle.get("data");
                String encodeStr = base64Encoded(bm);
                JSONObject object = new JSONObject();
                jsonPut(object, "ret", 0);
                jsonPut(object, "base64Encoded", encodeStr);

                handleJSCallBack(object);
            }
        }
    }

    private void handleImage(final String path) {
        HMPermissions.getInstance().checkAndRequestPermissions(MainActivity.this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, new HMPermissions.JGPermissionsListener() {
            @Override
            public void permissionsSuccess() {
                //decode to bitmap
                Bitmap bitmap = BitmapFactory.decodeFile(path);
                String encodeStr = base64Encoded(bitmap);
                JSONObject object = new JSONObject();
                jsonPut(object, "ret", 0);
                jsonPut(object, "base64Encoded", encodeStr);

                handleJSCallBack(object);
            }

            @Override
            public void permissionsFail(String[] messages) {
                Log.e("licm", "permission deny++++++++++");
                JSONObject object = new JSONObject();
                jsonPut(object, "ret", -1);
                jsonPut(object, "base64Encoded", "");

                handleJSCallBack(object);
            }
        });

    }

    /**
     * 图片base64编码
     *
     * @return
     */
    private String base64Encoded(Bitmap bitmap) {
        //convert to byte array
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        if ("jpg".equalsIgnoreCase(JSRequireImgType)) {
            bitmap.compress(Bitmap.CompressFormat.JPEG, JPG_DEFAULT_COMPRESSION_QUALITY, baos);
        } else {
            bitmap.compress(Bitmap.CompressFormat.PNG, JSRequireCompressionQuality, baos);
        }
        byte[] bytes = baos.toByteArray();
        return Base64.encodeToString(bytes, Base64.DEFAULT);
    }

    //权限请求后判断
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (requestCode == HMGlobals.PERMISSIONS_REQUEST_CDOE) {
            //判断权限结果
            HMPermissions.getInstance().onRequestPermissionsResult(permissions, grantResults);
        }
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    protected void setInputValue(JSONObject data) {
        inputJson = data;
        //回调处理 每次修改后需要调用js接口来显示*数据
        bridgeWebView.callHandler("setJsInputFieldValue", data.toString(), new CallBackFunction() {
            @Override
            public void onCallBack(String data) {
                //处理成功后
            }
        });
    }

    //返回大于等于0
    protected int stringToInt(String value) {
        try {
            return new Integer(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    @Override
    public void textChangeListener(String text) {
        editText.setText(text);
        editText.setSelection(text.length());
        InputValues(text);
    }

    @Override
    public void pinChangeListener(String pin) {
        editText.setText(pin);
        editText.setSelection(pin.length());
        InputValues(pin);
    }

    private void InputValues(String values) {
        JSONObject inputJson = new JSONObject();
        jsonPut(inputJson, "id", mInputId);
        jsonPut(inputJson, "text", values);

        setInputValue(inputJson);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }
}
