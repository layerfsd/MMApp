package com.huawei.mm.app.keyboard;

/** 4个图层:大写{@link #CAP}/ 小写{@link #LOW}/ 数字{@link #DIG}/ 特殊字符{@link #SYM} */
public enum KeyLayer {
	
	CAP("大写层"), //
	LOW("小写层"), //
	DIG("数字层"), //
	SYM("特殊字符层");

	//
	String detail;
	KeyLayer(String s) {
		detail = s;
	}

	public String tosString() {
		return detail;
	}

}
