package com.ccbsz.ccbgjj.activitys;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.ccbsz.ccbgjj.R;
import com.ccbsz.ccbgjj.util.JGGlobals;
import com.github.lzyzsd.jsbridge.BridgeWebView;

/**
 * Created by liuym on 2017/2/24.
 */

public class JGSubActivity extends MainActivity {
    private String mPageUrl = "";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        TextView textCancel = (TextView) findViewById(R.id.text_cancel);
        textCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
    }

    @Override
    public int getLayoutResID() {
        return R.layout.activity_sub_activity;
    }

    @Override
    public void loadWebPage(BridgeWebView webView) {
        Intent intent = getIntent();
        mPageUrl = intent.getStringExtra(JGGlobals.PARAM_PAGE_URL);
        System.out.println("pageUrl = " + mPageUrl);

        loadRemotePage(webView, mPageUrl);
//        loadRemotePage(webView, "http://192.168.43.207:8080/modules/appserver.html");
    }
}
