package com.huawei.mm.app.encrypt;


/**
 * 加解密API
 */
public class HMEncryptApi {

	public static HMEncrypt encrypt = new HMAESEncrypt(); //AES加密对象
	public static HMEncrypt keyEncrypt = new HMRSAEncrypt();//RAS加密对象

	/**
	 * AES加密数据
	 * @param data
	 * @param key
	 * @return
	 */
	public static String encryptAESData(String data, byte[] key) {
		return encrypt.encryptData(data, key);
	}

	/**
	 * AES解密数据
	 * @param data
	 * @param key
	 * @return
	 */
	public  static String decryptAESData(String data, byte[] key) {
		return encrypt.decryptData(data, key);
	}


	/**
	 * 基于设备号，生成transport key
	 * @return
	 */
	public static byte[] getTransportKey(){
//		return HttpConstant.HAS_DEVICEID_BYTE;
//		return HMKeyGenerator.generateKey(HttpConstant.DEVICEID);
		return HMKeyGenerator.generateKey("354113060412684");
	}

	/**
	 * 获取随机的payload key
	 * @return
	 */
	public static byte[] getPayLoadKey(){
		return HMKeyGenerator.getSalt();
	}

	/**
	 * 获取RSA加密后的 transport key
	 * @return
	 */
	public static String getEncryptTransportKey(){
		byte[] key = getTransportKey();
		return keyEncrypt.encryptData(new String(key), key);
	}

	/**
	 * 使用 transport key为密钥，AES算法 加密数据
	 * @param data
	 * @return
	 */
	public static String encryptWithCommandKey(String data) {
		return encryptAESData(data, getTransportKey());
	}

	/**
	 * 使用RSA加密数据
	 * @param data
	 * @return
	 */
	public static String encryptRSAData(String data){
		byte[] key = getTransportKey();
		return keyEncrypt.encryptData(data, key);
	}

	/**
	 * 使用RSA解密密数据
	 * @param data
	 * @return
	 */
	public static String decryptRSAData(String data){
		byte[] key = getTransportKey();
		return keyEncrypt.decryptData(data, key);
	}
}

    