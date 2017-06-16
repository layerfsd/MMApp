package com.huawei.mm.app;

import java.io.Serializable;

/**
 * @author Remind.jiang
 *         date on 2017/3/27.
 */

public class Login implements Serializable{

    private String phone;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
