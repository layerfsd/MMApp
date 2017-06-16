package com.huawei.mm.app.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import com.huawei.mm.app.MyApplication;
import com.huawei.mm.app.MyController;

/**
 * 本地存储类
 * @author Remind
 *
 */
public class HMConfigXML {
	
	/**
	 * SharedPreference的 存储类和编辑类对象
	 */
	private SharedPreferences share;
	private Editor editor;

	/**
	 * 存储的全局的SharedPreferences文件名
	 */
	private final static String SAYFUNS = "com.mm.app";
	/**
	 * 读写权限
	 */
	private final static int MODE = Context.MODE_PRIVATE;
	
	private MyController controller;
	
	/**
	 * 初始化时默认读取
	 */
	@SuppressLint("CommitPrefEdits")
	public HMConfigXML(MyController controller) {
		this.controller = controller;
		share = MyApplication.getInstance().getSharedPreferences(SAYFUNS, MODE);
		editor = share.edit();
	}
	
	public int read(String key, int back) {
		int result = share.getInt(key, back);
		return result;
	}
	
	public boolean save(String key, int value) {
		editor.putInt(key, value);
		return editor.commit();
	}
	
	public long read(String key, long back) {
		long result = share.getLong(key, back);
		return result;
	}
	
	public boolean save(String key, long value) {
		editor.putLong(key, value);
		return editor.commit();
	}
	
	public boolean save(String key, boolean value) {
		editor.putBoolean(key, value);
		return editor.commit();
	}
	
	public boolean read(String key, boolean back) {
		boolean result = share.getBoolean(key, back);
		return result;
	}

	public float read(String key, float back) {
		float result = share.getFloat(key, back);
		return result;
	}
	
	public boolean save(String key, float value) {
		editor.putFloat(key, value);
		return editor.commit();
	}

	public String read(String key, String back) {
		String result = share.getString(key, back);
		return result;
	}

	public boolean save(String key, String value) {
		editor.putString(key, value);
		return editor.commit();
	}
}
