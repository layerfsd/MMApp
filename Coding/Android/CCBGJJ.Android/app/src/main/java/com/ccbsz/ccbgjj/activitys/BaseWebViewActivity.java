package com.ccbsz.ccbgjj.activitys;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebView;

import com.github.lzyzsd.jsbridge.BridgeWebView;
import com.github.lzyzsd.jsbridge.BridgeWebViewClient;
import com.github.lzyzsd.jsbridge.DefaultHandler;

import com.ccbsz.ccbgjj.R;
import com.ccbsz.ccbgjj.util.JGContextUtil;

/**
 * Created by liuym on 2017/2/22.
 */

public class BaseWebViewActivity extends Activity {
    protected BridgeWebView bridgeWebView = null;

    protected Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mContext = this;

        setContentView(getLayoutResID());

        bridgeWebView = (BridgeWebView) findViewById(R.id.JsBridgeWebView);

        bridgeWebView.setDefaultHandler(new DefaultHandler());

        bridgeWebView.setWebChromeClient(new WebChromeClient());

        bridgeWebView.setWebViewClient( new CustomWebViewClient(bridgeWebView));

        registerNativeHandles();

        loadWebPage(bridgeWebView);
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
                    //完成加载
                    System.out.println("完成加载 newProgress = " + newProgress);
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
        JGContextUtil.getInstance().setCurrentActitivity(this);
        super.onResume();
    }
}
