package com.huawei.mm.app.encrypt;

/**
 * @author Remind.jiang
 *         date on 2017/2/15.
 */

public interface HMEncrypt {

    /**
     * 加密
     * @param data
     * @param key
     * @return
     */
    public String encryptData(String data, byte[] key);

    /**
     * 解密
     * @param data
     * @param key
     * @return
     */
    public String decryptData(String data, byte[] key);
}
