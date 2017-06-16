/*
 * Copyright (C) 2015 China Construction Bank
 *
 * 本程序中所包含的信息属于机密信息，如无中国建设银行的书面许可，任何人都无权复制或利用。
 */
package com.huawei.mm.app.util;

import android.app.Activity;


public class HMContextUtil {

	private static HMContextUtil instance;

	/** 当前Activity */
	private Activity currentActitivity;

	public static HMContextUtil getInstance() {
		if (instance == null) {
			instance = new HMContextUtil();
		}
		return instance;
	}

	public Activity getCurrentActitivity() {
		return currentActitivity;
	}

	public void setCurrentActitivity(Activity currentActitivity) {
		this.currentActitivity = currentActitivity;
	}

}
