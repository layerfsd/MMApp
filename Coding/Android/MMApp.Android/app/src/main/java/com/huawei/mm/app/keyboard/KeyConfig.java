package com.huawei.mm.app.keyboard;

import android.graphics.Color;
/**
 * 常量类
 * 
 * @author luohao
 *
 */
class KeyConfig {
	static final int key_txt_size = 21; // 常量:按钮字体大小

	// 小弹出框的设置
	static final int hint_txt_size = 32; // 常量:小弹出框 字体大小
	static final int hint_txt_color = Color.WHITE; // 常量:弹出框字体颜色
	static final int upHeightDip = 20; // 常量:小弹框的底部与按键的距离 dip
	static int upHeightInPixel = 100; // 常量:小弹框的底部与按键的距离 px

	// 常量:删除的速度
	static final int delete_speed = 200;

	// 使用黑体
	static final boolean useBoldInLow = true; // 小写字符
	static final boolean useBoldInCap = false; // 大写字符
	static final boolean useBoldInSym = true; // 特殊字符
	static final boolean useBoldInDig = true; // 数字键盘
	static final boolean useBoldInPopup = true; // 小弹出框
}
