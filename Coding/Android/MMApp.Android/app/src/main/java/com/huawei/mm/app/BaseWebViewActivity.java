package com.huawei.mm.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.EditText;
import android.widget.LinearLayout;

import com.github.lzyzsd.jsbridge.BridgeWebView;
import com.github.lzyzsd.jsbridge.BridgeWebViewClient;
import com.github.lzyzsd.jsbridge.DefaultHandler;
import com.huawei.mm.app.keyboard.KeyboardUtil;
import com.huawei.mm.app.keyboard.TextChangeListener;
import com.huawei.mm.app.util.HMContextUtil;

import java.lang.reflect.Field;

/**
 * Created by liuym on 2017/2/22.
 */

public abstract class BaseWebViewActivity extends Activity implements TextChangeListener{
    private static final String TAG = BaseWebViewActivity.class.getCanonicalName();
    protected BridgeWebView bridgeWebView = null;

    protected Context mContext;
    protected EditText editText;
    protected LinearLayout linear_bar;

    private static final String SENDER_ID = "4815162342";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mContext = this;

        setContentView(getLayoutResID());

        initState();

//        GCMRegistrar.checkDevice(this);
//        GCMRegistrar.checkManifest(this);
//        final String regId = GCMRegistrar.getRegistrationId(this);
//        if (regId.equals("")) {
//            GCMRegistrar.register(this, SENDER_ID);
//        } else {
//            Log.v(TAG, "Already registered");
//        }

//        MbsKeyboardUtil.getInstance().initKeyboard(this);
        KeyboardUtil.getInstancce().initKeyboard(this);
        KeyboardUtil.getInstancce().setTextChangeListener(this);
        editText = (EditText) findViewById(R.id.editText);

        bridgeWebView = (BridgeWebView) findViewById(R.id.JsBridgeWebView);

        bridgeWebView.setDefaultHandler(new DefaultHandler());

        bridgeWebView.setWebChromeClient(new WebChromeClient());

        bridgeWebView.setWebViewClient( new CustomWebViewClient(bridgeWebView));
        bridgeWebView.getSettings().setDomStorageEnabled(true);

        registerNativeHandles();


        loadWebPage(bridgeWebView);

        findViewById(R.id.button).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                KeyboardUtil.getInstancce().showKeyboard(BaseWebViewActivity.this);
                Intent intent = new Intent(BaseWebViewActivity.this, SimpleCaptureActivity.class);
                BaseWebViewActivity.this.startActivity(intent);
            }
        });
        findViewById(R.id.button2).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                KeyboardUtil.getInstancce().showPINKeyboard(BaseWebViewActivity.this);
            }
        });

    }

    public int getLayoutResID(){
        return R.layout.activity_base_webview;
    }

    /**
     * 注册JavaScript可调用的函数
     */
    public void registerNativeHandles(){

    }

    /**
     * 启动Web页面
     * @param webView
     */
    public void loadWebPage(BridgeWebView webView){

    }

    public void loadLocalPage(BridgeWebView webView, String path){
        webView.loadUrl(path);
    }

    public void loadRemotePage(BridgeWebView webView, String remoteURLStr){
        webView.loadUrl(remoteURLStr);
        webView.setWebChromeClient(new WebChromeClient(){
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                if(newProgress == 100){
                    //
                    System.out.println("完成加载完成加载 newProgress = " + newProgress);
                }else{
                    //加载进度
                    System.out.println("加载进度 newProgress = " + newProgress);
                }
                super.onProgressChanged(view, newProgress);
            }
        });
    }


    class CustomWebViewClient extends BridgeWebViewClient {
        public CustomWebViewClient(BridgeWebView webView) {
            super(webView);
        }
    }

    @Override
    protected void onResume() {
        HMContextUtil.getInstance().setCurrentActitivity(this);
        super.onResume();
    }

    @Override
    protected void onDestroy() {
        KeyboardUtil.getInstancce().dissmissDialog();
        super.onDestroy();
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
    }

    /**
     * 沉浸式状态栏
     */
    private void initState() {
        //当系统版本为4.4或者4.4以上时可以使用沉浸式状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            //透明状态栏
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
            //透明导航栏
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
            //
            linear_bar = (LinearLayout) findViewById(R.id.ll_bar);
            linear_bar.setVisibility(View.VISIBLE);
            //获取到状态栏的高度
            int statusHeight = getStatusBarHeight();
            //动态的设置隐藏布局的高度
            LinearLayout.LayoutParams params = (LinearLayout.LayoutParams) linear_bar.getLayoutParams();
            params.height = statusHeight;
            linear_bar.setLayoutParams(params);
        }
    }

    /**
     * 通过反射的方式获取状态栏高度
     *
     * @return
     */
    private int getStatusBarHeight() {
        try {
            Class<?> c = Class.forName("com.android.internal.R$dimen");
            Object obj = c.newInstance();
            Field field = c.getField("status_bar_height");
            int x = Integer.parseInt(field.get(obj).toString());
            return getResources().getDimensionPixelSize(x);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if(keyCode == KeyEvent.KEYCODE_BACK && bridgeWebView.canGoBack()){
            bridgeWebView.goBack();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
