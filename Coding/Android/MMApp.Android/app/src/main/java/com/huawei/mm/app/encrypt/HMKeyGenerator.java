/**
 * 文 件 名:  HMKeyGenerator.java
 * 版    权:  Huawei Technologies Co., Ltd. Copyright YYYY-YYYY,  All rights reserved
 * 描    述:  <描述>
 * 修 改 人:  msl
 * 修改时间:  2015年5月8日
 * 跟踪单号:  <跟踪单号>
 * 修改单号:  <修改单号>
 * 修改内容:  <修改内容>
 */
package com.huawei.mm.app.encrypt;

import com.huawei.mm.app.util.ILog;

import java.math.BigInteger;
import java.security.SecureRandom;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;


/**
 * <密钥生成器> <功能详细描述>
 */
public class HMKeyGenerator {
	
	private static String TAG = HMKeyGenerator.class.getCanonicalName();
	
	public static final int KEY_LEN = 16;
	public static final String ALGORITHM = "AES/CBC/PKCS5Padding";

	/**
	 * <根据因子，产生固定的密钥>
	 * @param factor
	 * @return
	 */
	public static byte[] generateKey(String factor){
		return generateKey(factor, factor);
	}

	/**
	 * <根据因子和盐值，产生密钥>
	 * @param factor
	 * @param salt
	 * @return
	 */
	public static byte[] generateKey(String factor,String salt){
		try {
//			int iterations = 1000;
//			char[] chars = factor.toCharArray();
//			byte[] saltBytes = salt.getBytes();
//			PBEKeySpec spec = new PBEKeySpec(chars, saltBytes, iterations, 16 * 8);
//			SecretKeyFactory skf = SecretKeyFactory
//					.getInstance(ALGORITHM);
			javax.crypto.KeyGenerator kg = javax.crypto.KeyGenerator.getInstance("AES");
			SecureRandom random = new SecureRandom();
			random.setSeed(factor.getBytes("UTF-8"));
			kg.init(16 * 8, random);
			return kg.generateKey().getEncoded();
//			byte[] hash = skf.generateSecret(spec).getEncoded();
//			return Arrays.copyOf(hash, KEY_LEN);
		} catch (Exception e) {
			ILog.e(TAG, "" + e);
		}
		return null;
	}

	/**
	 * <产生盐值>
	 * @return
	 */
	public static byte[] getSalt() {
		try {
//			SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
			SecureRandom sr = new SecureRandom();
			byte[] salt = new byte[KEY_LEN];
			sr.nextBytes(salt);
			return salt;
		} catch (Exception e) {
			ILog.e(TAG, "" + e);
		}
		return null;
	}
	
	/** 
     * PBKDF2加密 
     * @return
     */  
    public static String encryptPBKDF2(String password,String salt) {  
        try {  
        	int iterations = 10000;
			char[] chars = password.toCharArray();
			byte[] saltBytes = salt.getBytes();
			PBEKeySpec spec = new PBEKeySpec(chars, saltBytes, iterations, 16 * 8);
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");  
            byte[] hash = skf.generateSecret(spec).getEncoded();  
            return iterations + toHex(saltBytes) + toHex(hash);  
        } catch (Exception e) {  
        	ILog.e(TAG, "" + e);
        }   
        return null;  
    }

	/**
     * PBKDF2加密
     * @return
     */
    public static String encryptPBKDF2(String password,byte[] salt) {
        try {
        	int iterations = 10000;
			char[] chars = password.toCharArray();
			PBEKeySpec spec = new PBEKeySpec(chars, salt, iterations, 16 * 8);
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            byte[] hash = skf.generateSecret(spec).getEncoded();
            return iterations + toHex(salt) + toHex(hash);
        } catch (Exception e) {
        	ILog.e(TAG, "" + e);
        }
        return null;
    }

    /** 
     * 转化十六进制 
     * @param array 
     * @return 
     */  
     private static String toHex(byte[] array) {  
            BigInteger bi = new BigInteger(1, array);  
            String hex = bi.toString(16);  
            int paddingLength = (array.length * 2) - hex.length();  
            if(paddingLength > 0) {  
                return String.format("%0"  +paddingLength + "d", 0) + hex;  
            }else{  
                return hex;  
            }  
        } 

	

}
