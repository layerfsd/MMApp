package com.huawei.mm.app.gesture.util;

import android.content.Context;
import android.graphics.Point;
import android.view.WindowManager;

/**
 * Created by CCB on 2016/12/7.
 */

public class DisPlayUtils {
    public static int[] getScreenDisplay(Context mContext){
        int []screen=new int[2];
        WindowManager manager= (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
        if(manager!=null){
            Point point=new Point();
            manager.getDefaultDisplay().getSize(point);
            screen[0]=point.x;
            screen[1]=point.y;
        }
        return screen;
    }
}
