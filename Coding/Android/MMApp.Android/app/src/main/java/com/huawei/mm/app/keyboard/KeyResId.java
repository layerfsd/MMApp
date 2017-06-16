package com.huawei.mm.app.keyboard;

import android.content.Context;

import com.huawei.mm.app.R;


/***
 * 
 * 键盘按键字符
 * 
 * @author luohao
 *
 */
class KeyResId {
	/** 大写字符 默认顺序,这些顺序与布局资源顺序相对应 */
	public static final String CHAR_CAP = "QWERTYUIOP" + "ASDFGHJKL" + "ZXCVBNM";

	/** 小写字符 默认顺序 */
	public static final String CHAR_LOW = "qwertyuiop" + "asdfghjkl" + "zxcvbnm";

	/** 特设字符 默认顺序 */
	public static final String CHAR_SYM = "[]{}#%^*+=" + "_\"|~<>€£￥\'" + "-\\;()$&•";

	/** 数字 默认顺序 */
	public static final String CHAR_DIG = "1234567890" + "/?!:" + ",.@";
	
	private Context mContext;

	// 大写26个字符对应的位置
	static final int[] resIdCapChar = new int[] {
			//
			R.id.jar_cap_char_row_one_1, //
			R.id.jar_cap_char_row_one_2,//
			R.id.jar_cap_char_row_one_3,//
			R.id.jar_cap_char_row_one_4,//
			R.id.jar_cap_char_row_one_5, //
			R.id.jar_cap_char_row_one_6, //
			R.id.jar_cap_char_row_one_7,//
			R.id.jar_cap_char_row_one_8, //
			R.id.jar_cap_char_row_one_9, //
			R.id.jar_cap_char_row_one_A,//
			//
			R.id.jar_cap_char_row_two_1, //
			R.id.jar_cap_char_row_two_2, //
			R.id.jar_cap_char_row_two_3, //
			R.id.jar_cap_char_row_two_4, //
			R.id.jar_cap_char_row_two_5, //
			R.id.jar_cap_char_row_two_6,//
			R.id.jar_cap_char_row_two_7, //
			R.id.jar_cap_char_row_two_8, //
			R.id.jar_cap_char_row_two_9,
			//
			R.id.jar_cap_char_row_three_1, //
			R.id.jar_cap_char_row_three_2, //
			R.id.jar_cap_char_row_three_3, //
			R.id.jar_cap_char_row_three_4, //
			R.id.jar_cap_char_row_three_5,//
			R.id.jar_cap_char_row_three_6,//
			R.id.jar_cap_char_row_three_7 };

	// 小写26个小写字符对应的位置
	static final int[] resIdLowChar = new int[] {
			//
			R.id.jar_low_char_row_one_1,//
			R.id.jar_low_char_row_one_2, //
			R.id.jar_low_char_row_one_3,//
			R.id.jar_low_char_row_one_4, //
			R.id.jar_low_char_row_one_5, //
			R.id.jar_low_char_row_one_6,//
			R.id.jar_low_char_row_one_7,//
			R.id.jar_low_char_row_one_8, //
			R.id.jar_low_char_row_one_9, //
			R.id.jar_low_char_row_one_A,
			//
			R.id.jar_low_char_row_two_1,//
			R.id.jar_low_char_row_two_2, //
			R.id.jar_low_char_row_two_3, //
			R.id.jar_low_char_row_two_4,//
			R.id.jar_low_char_row_two_5, //
			R.id.jar_low_char_row_two_6, //
			R.id.jar_low_char_row_two_7, //
			R.id.jar_low_char_row_two_8, //
			R.id.jar_low_char_row_two_9,//
			R.id.jar_low_char_row_three_1, //
			R.id.jar_low_char_row_three_2, //
			R.id.jar_low_char_row_three_3, //
			R.id.jar_low_char_row_three_4,//
			R.id.jar_low_char_row_three_5, //
			R.id.jar_low_char_row_three_6,//
			R.id.jar_low_char_row_three_7 };

	// 数字对应的位置
	static final int[] resIdDigital = new int[] {
			//
			R.id.jar_digit_dig_1, //
			R.id.jar_digit_dig_2, //
			R.id.jar_digit_dig_3, //
			R.id.jar_digit_dig_4,//
			R.id.jar_digit_dig_5,//
			R.id.jar_digit_dig_6, //
			R.id.jar_digit_dig_7, //
			R.id.jar_digit_dig_8, //
			R.id.jar_digit_dig_9, //
			R.id.jar_digit_dig_A,//

			R.id.jar_digit_column_one_1, //
			R.id.jar_digit_column_one_2, //
			R.id.jar_digit_column_one_3,//
			R.id.jar_digit_column_one_4,

			R.id.jar_digit_column_five_2, //
			R.id.jar_digit_column_five_3,//
			R.id.jar_digit_column_two_4 };

	// 28个符号对应的位置
	static final int[] resIdsymbol = new int[] {
			//
			R.id.jar_symbol_row_one_1, //
			R.id.jar_symbol_row_one_2,//
			R.id.jar_symbol_row_one_3,//
			R.id.jar_symbol_row_one_4, //
			R.id.jar_symbol_row_one_5, //
			R.id.jar_symbol_row_one_6,//
			R.id.jar_symbol_row_one_7,//
			R.id.jar_symbol_row_one_8,//
			R.id.jar_symbol_row_one_9, //
			R.id.jar_symbol_row_one_A,

			R.id.jar_symbol_row_two_1, //
			R.id.jar_symbol_row_two_2, //
			R.id.jar_symbol_row_two_3,//
			R.id.jar_symbol_row_two_4,//
			R.id.jar_symbol_row_two_5,//
			R.id.jar_symbol_row_two_6, //
			R.id.jar_symbol_row_two_7,//
			R.id.jar_symbol_row_two_8,//
			R.id.jar_symbol_row_two_9, //
			R.id.jar_symbol_row_two_A,//

			R.id.jar_symbol_row_three_1, //
			R.id.jar_symbol_row_three_2,//
			R.id.jar_symbol_row_three_3,//
			R.id.jar_symbol_row_three_4,//
			R.id.jar_symbol_row_three_5,//
			R.id.jar_symbol_row_three_6,//
			R.id.jar_symbol_row_three_7, //
			R.id.jar_symbol_row_three_8,
	};
}
