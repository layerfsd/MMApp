package com.huawei.mm.app.encrypt;

import android.util.Base64;

import com.huawei.mm.app.util.ILog;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

/**
 * hmac加密
 */
public class HMACEncrypt {
	
	private static String TAG = HMACEncrypt.class.getCanonicalName();
	
//	private final static String KEY_MAC = "HmacMD5";  
	private final static String KEY_MAC = "HmacSHA256";

	/**
	 * <BASE64加密>
	 * @param key
	 * @return
	 * @throws Exception
	 */
    public static String encryptBase64(byte[] key) throws Exception {  
        return Base64.encodeToString(key, Base64.NO_WRAP);  
    }

	/**
	 * <BASE64解码>
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static byte[] decryptBase64(String key) throws Exception {
        return Base64.decode(key, Base64.DEFAULT);  
    }

	/**
	 * <HMAC产生密钥>
	 * @return
	 * @throws Exception
	 */
	public static String init() throws Exception{
        SecretKey key;  
        String str = "";  
		javax.crypto.KeyGenerator generator = javax.crypto.KeyGenerator.getInstance(KEY_MAC);
		key = generator.generateKey();
		str = encryptBase64(key.getEncoded());
        return str;  
    }

	/**
	 * <HMAC加密数据>
	 * @param data
	 * @param key
	 * @return
	 */
	public static byte[] encryptHMAC(byte[] data, String key) {
        SecretKey secretKey;  
        byte[] bytes = null;  
        try {  
            secretKey = new SecretKeySpec(decryptBase64(key), KEY_MAC);  
            Mac mac = Mac.getInstance(secretKey.getAlgorithm());  
            mac.init(secretKey);  
            bytes = mac.doFinal(data);  
        } catch (Exception e) {  
        	ILog.e(TAG, "" + e);
        }  
        return bytes;  
    }  


}

    