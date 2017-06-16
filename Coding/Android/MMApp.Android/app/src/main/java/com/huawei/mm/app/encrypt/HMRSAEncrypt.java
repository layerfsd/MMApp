package com.huawei.mm.app.encrypt;

import android.util.Base64;

import com.huawei.mm.app.MyApplication;
import com.huawei.mm.app.util.ILog;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.security.PrivateKey;
import java.security.PublicKey;


/**
 * RSA加解密
 */
public class HMRSAEncrypt implements HMEncrypt {
	
	private static String TAG = HMRSAEncrypt.class.getCanonicalName();
	
	public static String PUBLICKEYPATH = "rsa_public_key.pem";
	public static String PRIVATEPATH = "pkcs8_private_key.pem";
	private static String PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDFL3xak3PWRLKk2OHyPhZ9zDVjOamAHki203jd7AD64HzkiX++wOviXdH9rziYUJ1YdSXzI5J4UEhD7ldPcJNgoGL0XZEEt8jkmiTsxErc6ZDoHGsP9jw57aLbpMgfazYWdroGCikEzvyRoVlGXzfXHOvyDiz8WtL3yUhZoXaN9QIDAQAB";


	@Override
	public String encryptData(String data, byte[] key) {
		
		try {
			//加载公钥文件
//			InputStream in = MyApplication.getInstance().getResources().getAssets().open(PUBLICKEYPATH);
			InputStream in = new ByteArrayInputStream(PUBLIC_KEY.getBytes());
			//生成公钥对象
			PublicKey publicKey = RSAUtils.loadPublicKey(in);
			//RSA加密
			byte[] rs = RSAUtils.encryptData(data.getBytes(),publicKey);
			//返回base64编码
			return Base64.encodeToString(rs,Base64.NO_WRAP);
		} catch (Exception e) {
			ILog.e(TAG, "" + e);
		}
		return null;

	}


	@Override
	public String decryptData(String data, byte[] key) {
		try {
			//加载公钥文件
			InputStream in = MyApplication.getInstance().getResources().getAssets().open(PRIVATEPATH);
			//生成公钥对象
			PrivateKey privateKey = RSAUtils.loadPrivateKey(in);
			//RSA�?			
			byte[] rs = RSAUtils.decryptData(Base64.decode(data, Base64.DEFAULT), privateKey);
			return new String(rs);
			
		} catch (Exception e) {
			ILog.e(TAG, "" + e);
		}
		return null;

	}

}

    