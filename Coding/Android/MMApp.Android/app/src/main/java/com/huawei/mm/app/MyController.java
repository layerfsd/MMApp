package com.huawei.mm.app;

import android.content.Context;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Base64;

import com.huawei.mm.app.encrypt.HMACEncrypt;
import com.huawei.mm.app.encrypt.HMKeyGenerator;
import com.huawei.mm.app.util.HMConfigXML;
import com.huawei.mm.app.util.HMGlobals;
import com.huawei.mm.app.util.ILog;

import java.io.UnsupportedEncodingException;
import java.util.Random;

/**
 * 项目控制器
 *
 * @author Remind.jiang
 *         date on 2017/1/20.
 */

public class MyController {

    private final String TAG = MyController.class.getCanonicalName();
    private static MyController instance;
    private HMConfigXML hmConfigXML;
    private static byte[] transportKey;
    private static byte[] payloadKey;
    private static String IMEIfactor;

    public static MyController getInstance() {
        synchronized (MyController.class) {
            if (null == instance) {
                instance = new MyController();
            }
        }
        return instance;
    }

    MyController() {
        hmConfigXML = new HMConfigXML(this);
    }

    public void initManager(Context context){
        TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        HMGlobals.DEVICEID = tm.getDeviceId();
        //TODO android6.0动态权限获取
        HMGlobals.DEVICEID = "12312312432";
        Random random = new Random();
        String IMEIfactor = HMGlobals.DEVICEID + System.currentTimeMillis()+ random.nextInt(1000000);
        saveIMEIfactor(IMEIfactor);
        setIMEIfactor(IMEIfactor);
        randomPayloadKey();
        ILog.i("remind","IMEIfactor==>" + IMEIfactor);
        try {
            byte[] has = HMACEncrypt.encryptHMAC(IMEIfactor.getBytes("UTF-8"), HMACEncrypt.init());
            ILog.i("remind","has==>" + has.length);
            byte[] has1 = new byte[16];
            for (int i = 0; i < has.length / 2; i++) {
                has1[i] = has[i];
            }
            ILog.i("remind","has1==>" + has1.length);
            setTransportKey(has1);
            saveTransportKey(has1);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public byte[] getTransportKey() {
        if(transportKey == null || transportKey.length == 0){
            transportKey = readTransportKey();
        }
        return transportKey;
    }

    public void setTransportKey(byte[] transportKey) {
        this.transportKey = transportKey;
    }

    public void randomPayloadKey(){
        this.payloadKey = HMKeyGenerator.getSalt();
    }

    public byte[] getPayloadKey() {
        return payloadKey;
    }

    public String getIMEIfactor() {
        if(TextUtils.isEmpty(IMEIfactor)){
            IMEIfactor = readIMEIfactor();
        }
        return IMEIfactor;
    }

    public void setIMEIfactor(String IMEIfactor) {
        MyController.IMEIfactor = IMEIfactor;
    }

    public HMConfigXML getHmConfigXML() {
        return hmConfigXML;
    }

    /**
     * 存储IMEIfactor
     * @param IMEIfactor
     */
    public void saveIMEIfactor(String IMEIfactor){
        if(TextUtils.isEmpty(readIMEIfactor()) && null != IMEIfactor){
            getHmConfigXML().save(HMGlobals.IMEI_FACTOR,IMEIfactor);
        }
    }

    /**
     * 获取IMEIfactor
     * @return
     */
    public String readIMEIfactor(){
        return getHmConfigXML().read(HMGlobals.IMEI_FACTOR,"");
    }

    /**
     * 存储transportKey
     * @param transportKey
     */
    public void saveTransportKey(byte[] transportKey){
        if(TextUtils.isEmpty(readIMEIfactor()) && null != transportKey && transportKey.length > 0){
            getHmConfigXML().save(HMGlobals.TRANSPORT_KEY,Base64.encodeToString(transportKey,Base64.NO_WRAP));
        }
    }

    /**
     * 获取transportKey
     * @return
     */
    public byte[] readTransportKey(){
        return Base64.decode(getHmConfigXML().read(HMGlobals.TRANSPORT_KEY,""),Base64.NO_WRAP);
    }
}


