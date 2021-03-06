package com.ccbsz.ccbgjj.util;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

/**
 * Created by liuym on 2017/2/23.
 */

public class JGLocationHelper {
    private Context mContext;
    private LocationClient mLocationClient;

    private JGLocationHelperListener mListener = null;
    public JGLocationHelper(Context context){
        mContext = context;

        initLocation();

        mLocationClient.registerLocationListener(new BDLocationListener() {
            @Override
            public void onReceiveLocation(BDLocation bdLocation) {
                System.out.println("onReceiveLocation 定位回调");
                if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                        || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation
                        || bdLocation.getLocType() == BDLocation.TypeOffLineLocation) {

                    //成功 获取定位结果
                    double latitude = bdLocation.getLatitude();//纬度
                    double longitude = bdLocation.getLongitude();//经度
                    String address = bdLocation.getAddrStr();//位置

                    if(mListener != null){
                        mListener.locationHelperSuccess(latitude, longitude, address == null ? "未连接网络，不能获取具体地址信息" : address);
                    }
                } else {
                    if(mListener != null){
                        mListener.locationHelperFail(bdLocation.getLocTypeDescription());
                    }
                }

                stopGetLocation();
            }

            @Override
            public void onConnectHotSpotMessage(String s, int i) {
                System.out.println("onConnectHotSpotMessage 定位回调");
            }
        });
    }

    //初始化定位
    private void initLocation() {
        //声明LocationClient类
        mLocationClient = new LocationClient(mContext);

        LocationClientOption option = new LocationClientOption();
        option.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy);
        //可选，默认高精度，设置定位模式，高精度，低功耗，仅设备

        option.setCoorType("bd09ll");
        //可选，默认gcj02，设置返回的定位结果坐标系

        int span = 1000;
        option.setScanSpan(span);
        //可选，默认0，即仅定位一次，设置发起定位请求的间隔需要大于等于1000ms才是有效的

        option.setIsNeedAddress(true);
        //可选，设置是否需要地址信息，默认不需要

        option.setOpenGps(true);
        //可选，默认false,设置是否使用gps

        option.setLocationNotify(true);
        //可选，默认false，设置是否当GPS有效时按照1S/1次频率输出GPS结果

        option.setIsNeedLocationDescribe(true);
        //可选，默认false，设置是否需要位置语义化结果，可以在BDLocation.getLocationDescribe里得到，结果类似于“在北京天安门附近”

        option.setIsNeedLocationPoiList(true);
        //可选，默认false，设置是否需要POI结果，可以在BDLocation.getPoiList里得到

        option.setIgnoreKillProcess(false);
        //可选，默认true，定位SDK内部是一个SERVICE，并放到了独立进程，设置是否在stop的时候杀死这个进程，默认不杀死

        option.SetIgnoreCacheException(false);
        //可选，默认false，设置是否收集CRASH信息，默认收集

        option.setEnableSimulateGps(false);
        //可选，默认false，设置是否需要过滤GPS仿真结果，默认需要

        mLocationClient.setLocOption(option);
    }

    public void startGetLocation(){
        if(mLocationClient != null && mLocationClient.isStarted() == false){
            mLocationClient.start();

        }else{

        }


    }

    public void stopGetLocation(){
        if(mLocationClient != null && mLocationClient.isStarted() == true){
            mLocationClient.stop();
        }
    }

    public void setJGLocationHelperListener(JGLocationHelperListener listener){
        mListener = listener;
    }

    public interface JGLocationHelperListener{
        void locationHelperSuccess(double latitude, double longitude, String address);
        void locationHelperFail(String error);
    }
}
