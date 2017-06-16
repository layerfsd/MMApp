package com.huawei.mm.app;

import android.app.Application;

import com.huawei.mm.app.util.CrashHandler;

/**
 *
 * @author Remind.jiang
 * date on 2017/1/20.
 */

public class MyApplication extends Application {

    private static MyApplication instance;


    public static MyApplication getInstance(){
        if(null == instance){
            instance = new MyApplication();
        }
        return instance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;
        MyController.getInstance().initManager(this);
        //add by licm 2017.05.17 获取闪退日志并保存到本地
        CrashHandler.getInstance().init(this);
    }
}
