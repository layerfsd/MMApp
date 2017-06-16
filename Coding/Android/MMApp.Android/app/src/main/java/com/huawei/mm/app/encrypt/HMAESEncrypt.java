package com.huawei.mm.app.encrypt;

import android.util.Base64;

import com.huawei.mm.app.util.ILog;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 * <AES加密>
 *
 */
public class HMAESEncrypt implements HMEncrypt {
	
	private String TAG = HMAESEncrypt.class.getCanonicalName();
	
//	public static final String ALGORITHM = "AES/CBC/PKCS5Padding";
	public static final String ALGORITHM = "AES";

	public static final String CHARSETNAME = "UTF-8"; 
	
//	private static final  IvParameterSpec iv = new IvParameterSpec(getHexByte("31323334353630303030303030303030"));
//	private static final  IvParameterSpec iv = new IvParameterSpec(getHexByte("30f0db2f8d77a1aa"));
//	private static final IvParameterSpec iv = new IvParameterSpec("1234567812345678".getBytes());

	@Override
	public String encryptData(String data, byte[] key) {
		try {
			byte rs[] = encrypt(data.getBytes(),key,Cipher.ENCRYPT_MODE);
//			ILog.i("remind","toHex==>" + toHex(rs));
			return Base64.encodeToString(rs, Base64.NO_WRAP);
//			return toHex(rs);
		} catch (Exception e) {
			ILog.e(TAG, "" + e.getMessage());
		}
		return null;
		    
	}
	@Override
	public String decryptData(String data, byte[] key) {
		try {
			byte rs[] = encrypt(Base64.decode(data.getBytes(), Base64.NO_WRAP),key,Cipher.DECRYPT_MODE);
//			byte rs[] = encrypt(toByte(data),key,Cipher.DECRYPT_MODE);
			return new String(rs,CHARSETNAME);
		} catch (Exception e) {
			ILog.e(TAG, "" + e.getMessage());
		}
		return null;
	}

	/**
	 * 加解密
	 * @param data
	 * @param key
	 * @param mode
	 * @return
	 * @throws Exception
	 */
	private byte[] encrypt(byte[] data,byte[] key,int mode) throws Exception{
		SecretKeySpec skeySpec = new SecretKeySpec(key, ALGORITHM);
		Cipher cipher = Cipher.getInstance(ALGORITHM);
//		String ivKey = HMAESEncrypt.toHex(HMKeyGenerator.getSalt());
//		IvParameterSpec iv = new IvParameterSpec(getHexByte(ivKey));
//		MyController.getInstance().setIvParameterSpec(iv);
//		MyController.getInstance().setIvParameter(Base64.encodeToString(iv.getIV(),Base64.NO_WRAP));
		cipher.init(mode, skeySpec);
		byte[] encrypted = cipher.doFinal(data);
		return encrypted;
	}

	/**
	 * 获得十六进制的字符
	 * @param hex
	 * @return
	 */
	public static byte[] getHexByte(String hex){
		
		byte [] result=new byte[16];
		char[] chars= hex.toCharArray();
		byte[] bytes = new byte[chars.length];
		for(int i=0;i<chars.length;i++){
			switch (chars[i]) {
				case 'a':
					bytes[i] = 10;
					break;
				case 'b':
					bytes[i] = 11;
					break;
				case 'c':
					bytes[i] = 12;
					break;
				case 'd':
					bytes[i] = 13;
					break;
				case 'e':
					bytes[i] = 14;
					break;
				case 'f':
					bytes[i] = 15;
					break;
				default:
					bytes[i] = (byte)(chars[i] -'0');
					break;
			}
		}
		int j=0;
		for(int i=0;i<chars.length;i+=2){
			byte tmp =(byte)(bytes[i]*16+bytes[i+1]);
			result[j++] =tmp;
		}
		return result;
	}

	public static String toHex(byte[] buf) {
		if (buf == null)
			return "";
		StringBuffer result = new StringBuffer(2*buf.length);
		for (int i = 0; i < buf.length; i++) {
			appendHex(result, buf[i]);
		}
		return result.toString();
	}
	private final static String HEX = "0123456789ABCDEF";
	private static void appendHex(StringBuffer sb, byte b) {
		sb.append(HEX.charAt((b>>4)&0x0f)).append(HEX.charAt(b&0x0f));
	}

	public static byte[] toByte(String hexString) {
		int len = hexString.length()/2;
		byte[] result = new byte[len];
		for (int i = 0; i < len; i++)
			result[i] = Integer.valueOf(hexString.substring(2*i, 2*i+2), 16).byteValue();
		return result;
	}

}

    