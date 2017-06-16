package com.huawei.mm.app.util;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by liuym on 2017/2/24.
 */

public class HMPermissions {
    private static HMPermissions mJGPermissions = null;
    private JGPermissionsListener mListener = null;
    public static HMPermissions getInstance(){
        if(mJGPermissions == null){
            mJGPermissions = new HMPermissions();
        }

        return mJGPermissions;
    }

    public void checkAndRequestPermissions(Context context, String[] psemissions, JGPermissionsListener listener){

        mListener = listener;

        List<String> checkList = new ArrayList<>();

        for(int i = 0; i < psemissions.length; i++){
            if(ActivityCompat.checkSelfPermission(context, psemissions[i]) != PackageManager.PERMISSION_GRANTED){
                checkList.add(psemissions[i]);
            }
        }

        if (checkList.size() > 0) {
            //需要请求权限
            String[] checks = (String[]) checkList.toArray(new String[0]);
            ActivityCompat.requestPermissions((Activity) context, checks, HMGlobals.PERMISSIONS_REQUEST_CDOE);
        }else{
            if(mListener != null){
                mListener.permissionsSuccess();
            }
        }
    }

    public void onRequestPermissionsResult(String[] permissions, int[] grantResults){

        List<String> permissionList = new ArrayList<>();
        for(int i = 0; i < permissions.length; i++){
            if(grantResults[i] != PackageManager.PERMISSION_GRANTED){
                permissionList.add(permissions[i]);
            }
        }

        if(mListener != null) {
            if (permissionList.size() > 0) {
                String[] stringArray = (String[]) permissionList.toArray(new String[0]);
                mListener.permissionsFail(RequestPermissionFailMessage(stringArray));
            } else {
                mListener.permissionsSuccess();
            }
        }
    }

    public String[] RequestPermissionFailMessage(String[] permissions){
        List<String> messageList = new ArrayList<>();

        for(int i = 0; i < permissions.length; i++){
            messageList.add(getPermissionError(permissions[i]));
        }

        return (String[]) messageList.toArray(new String[0]);
    }

    private String getPermissionError(String permissionId){
        switch (permissionId){
            case Manifest.permission.CAMERA:
                return "用户没有开启摄像头权限";
            case Manifest.permission.ACCESS_COARSE_LOCATION:
                return "没有开启定位权限";
            case Manifest.permission.READ_PHONE_STATE:
                return "用户没有开启读取手机信息权限";
            case Manifest.permission.WRITE_EXTERNAL_STORAGE:
                return "用户没有开启读写SD卡权限";
            case Manifest.permission.RECORD_AUDIO:
                return "用户没有开启麦克风权限";
        }

        return "";
    }

    public interface JGPermissionsListener{
        void permissionsSuccess();
        void permissionsFail(String[] messages);
    }
}
