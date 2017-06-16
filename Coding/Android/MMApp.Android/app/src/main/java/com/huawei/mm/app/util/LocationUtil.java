package com.huawei.mm.app.util;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.widget.Toast;

/**
 * @author Remind.jiang
 *         date on 2017/5/15.
 */

public class LocationUtil implements LocationListener {

    private static LocationUtil instance;
    private LocationManager locationManager;
    private Context mContext;
    private Location location;
    private LocationCallBack locationCallBack;

    public static LocationUtil getInstance(){
        if(instance == null){
            instance = new LocationUtil();
        }
        return instance;
    }

    public void startLocation(Context mContext,LocationCallBack locationCallBack) {
        this.mContext = mContext;
        this.locationCallBack = locationCallBack;
        locationManager = (LocationManager) mContext.getSystemService(Context.LOCATION_SERVICE);
        if (ActivityCompat.checkSelfPermission(mContext, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(mContext, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 2000, 10, this);
    }

    @Override
    public void onLocationChanged(Location location) {
        if(null == location){
            Toast.makeText(mContext,"没有定位到",Toast.LENGTH_SHORT).show();
            return;
        }
        if(null != locationCallBack){
            locationCallBack.locationCallBack(location);
        }
        setLocation(location);
        ILog.i("remind","getLatitude==>" + location.getLatitude());
        ILog.i("remind","getLongitude==>" + location.getLongitude());
    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {

    }

    @Override
    public void onProviderEnabled(String provider) {

    }

    @Override
    public void onProviderDisabled(String provider) {

    }

    public void destory(){
        locationManager.removeUpdates(this);
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public interface LocationCallBack{
        void locationCallBack(Location location);
    }
}
