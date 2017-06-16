package com.huawei.mm.app.keyboard;

import android.content.Context;
import android.graphics.Typeface;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.huawei.mm.app.R;
import com.huawei.mm.app.util.ILog;


/**
 * @author Remind.jiang
 *         date on 2017/3/17.
 */

public class KeyboardView {

    public static View boardView;
    private static View layer_sym;// 符号层
    private static View layer_dig;// 数字层
    private static View layer_cap;// 大写
    private static View layer_low;// 小写

    private static StringBuilder sb_cap = new StringBuilder();
    private static StringBuilder sb_low = new StringBuilder();
    private static StringBuilder sb_sym = new StringBuilder();
    private static StringBuilder sb_dig = new StringBuilder();

    private static Context mContext;

    private static KeyLayer mLayer;
    /** 键盘整体高度 */
    public static int kbHeight;

    public static StringBuffer sb = new StringBuffer();

    private static boolean isStopDelete = true; // 删除操作是否结束

    /** 小弹出框相关 */
    private static PopupWindow hint; // 按钮后出现的弹出框提框-小弹出框
    private static View viewInPop;// 按键之后弹出框，里面显示所按键的内容
    private static int popWidth;
    private static int popHeight; // popwindow的宽和高
    private static TextView hintTxt; // 显示的字符

    public static void initKeyboardView(Context context){
        mContext = context;
        boardView = LayoutInflater.from(mContext).inflate(R.layout.jar_keyboard_layers_v2, null);

        // 初始化:测量高度
        int w = View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED);
        int h = View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED);
        boardView.measure(w, h);
        kbHeight = boardView.getMeasuredHeight();

//        initPopu();
        initLayerData();
        initLayerSym();
        initLayerCap();
        initLayerDig();
        initLayerLow();

        Button btnCancel = (Button) boardView.findViewById(R.id.jar_key_btn_cancel);

        btnCancel.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                KeyboardUtil.getInstancce().hideKeyboard();
            }
        });

        // 完成按键
        Button btnConfirm = (Button) boardView.findViewById(R.id.jar_key_btn_confirm);
        btnConfirm.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                KeyboardUtil.getInstancce().hideKeyboard();
            }
        });
    }


    private static void initPopu(){
        // viewInPop是按键之后弹出框，里面显示所按键的内容
        viewInPop = LayoutInflater.from(mContext).inflate(R.layout.jar_key_pop_window, null);
        hint = new PopupWindow(viewInPop, ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        hintTxt = (TextView) viewInPop.findViewById(R.id.jar_hint_txt);
        hintTxt.setTextSize(KeyConfig.hint_txt_size);
        hintTxt.setTextColor(KeyConfig.hint_txt_color);
        if (KeyConfig.useBoldInPopup) {
            hintTxt.setTypeface(null, Typeface.BOLD);
        }
//        viewInPop.measure(w, h);
        popHeight = viewInPop.getMeasuredHeight();
        popWidth = viewInPop.getMeasuredWidth();
    }

    private static void initLayerData(){
        // 大写
        sb_cap.delete(0, sb_cap.length());
        for (int i = 0, size = KeyResId.CHAR_CAP.length(); i < size; i++) {
            sb_cap.append(KeyResId.CHAR_CAP.charAt(i));
        }

        // 小写
        sb_low.delete(0, sb_low.length());
        for (int i = 0, size = KeyResId.CHAR_LOW.length(); i < size; i++) {
            sb_low.append(KeyResId.CHAR_LOW.charAt(i));
        }

        // 数字
        sb_dig.delete(0, sb_dig.length());
        for (int i = 0, size = KeyResId.CHAR_DIG.length(); i < size; i++) {
            sb_dig.append(KeyResId.CHAR_DIG.charAt(i));
        }

        // 特殊字符
        sb_sym.delete(0, sb_sym.length());
        for (int i = 0, size = KeyResId.CHAR_SYM.length(); i < size; i++) {
            sb_sym.append(KeyResId.CHAR_SYM.charAt(i));
        }
    }

    /**
     * 初始化符号
     */
    private static void initLayerSym(){
        layer_sym = boardView.findViewById(R.id.jar_layer_symbol);
        // 特殊字符
        int size = sb_sym.length();
        for (int i = 0; i < size; i++) {
            final Button btn = (Button) (layer_sym.findViewById(KeyResId.resIdsymbol[i]));
            btn.setTextSize(KeyConfig.key_txt_size);
            btn.setText(sb_sym.substring(i,i + 1));
//            if (KeyConfig.useBoldInSym) {
//                btn.setTypeface(null, Typeface.BOLD);
//            }
            btn.setOnClickListener(clickListener);
            btn.setOnTouchListener(touchListener_normal);
        }

        // sym->123
        Button symToDig = (Button) (layer_sym.findViewById(R.id.jar_symbol_row_four_1));
        symToDig.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.DIG);
            }
        });

        // sym->abc
        Button symToLow = (Button) (layer_sym.findViewById(R.id.jar_symbol_row_four_3));
        symToLow.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.LOW);
            }
        });

        // 空格键盘
        Button spaceSym = (Button) (layer_sym.findViewById(R.id.jar_symbol_row_four_2));
        spaceSym.setText(" ");
        spaceSym.setOnClickListener(clickListener);
        // 删除键
        View deleteSym = (Button) (layer_sym.findViewById(R.id.jar_symbol_row_three_delete));
        deleteSym.setOnTouchListener(touchListener_delete);
    }

    /**
     * 初始化数字
     */
    private static void initLayerDig(){
        layer_dig = boardView.findViewById(R.id.jar_layer_digit);
        // 数字和字符层
        int size = sb_dig.length();
        for (int i = 0; i < size; i++) {
            final Button btn = (Button) (layer_dig.findViewById(KeyResId.resIdDigital[i]));
            btn.setTextSize(KeyConfig.key_txt_size);
            btn.setText(sb_dig.substring(i,i + 1));
//            if (KeyConfig.useBoldInDig) {
//                btn.setTypeface(null, Typeface.BOLD);
//            }
            btn.setOnClickListener(clickListener);
            btn.setOnTouchListener(touchListener_normal);
        }

        // digit->sym
        Button digToSym = (Button) (layer_dig.findViewById(R.id.jar_digit_to_symbol));
        digToSym.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.SYM);
            }
        });

        // digit->abc
        Button ditToLow = (Button) (layer_dig.findViewById(R.id.jar_digit_to_abc));
        ditToLow.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.LOW);
            }
        });

        // 空格
        Button spaceDig = (Button) (layer_dig.findViewById(R.id.jar_digit_space));
        spaceDig.setText(" ");
        spaceDig.setOnClickListener(clickListener);

        // 删除键
        View deleteDig = (Button) (layer_dig.findViewById(R.id.jar_digit_delete));
        deleteDig.setOnTouchListener(touchListener_delete);
    }

    /**
     * 初始化大写
     */
    private static void initLayerCap(){
        layer_cap = boardView.findViewById(R.id.jar_layer_char_caps);
        int size = sb_cap.length();
        for (int i = 0; i < size; i++) {
            final Button btn = (Button) (layer_cap.findViewById(KeyResId.resIdCapChar[i]));
            btn.setTextSize(KeyConfig.key_txt_size);
            btn.setText(sb_cap.substring(i,i + 1));
            if (KeyConfig.useBoldInCap) {
                btn.setTypeface(null, Typeface.BOLD);
            }
            btn.setOnClickListener(clickListener);
            btn.setOnTouchListener(touchListener_normal);
        }

        // 大写->小写
        Button capToLow = (Button) (layer_cap.findViewById(R.id.jar_cap_char_row_three_switch));
        capToLow.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.LOW);
            }
        });
        capToLow.setTextSize(KeyConfig.key_txt_size);

        // 大写->数字
        Button capToDig = (Button) (layer_cap.findViewById(R.id.jar_cap_char_row_four_1));
        capToDig.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.DIG);
            }
        });

        // 大写->特殊字符
        Button capToSym = (Button) (layer_cap.findViewById(R.id.jar_cap_char_row_four_3));
        capToSym.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.SYM);
            }
        });

        // 空格
        Button capSpace = (Button) (layer_cap.findViewById(R.id.jar_cap_char_row_four_2));
        capSpace.setText(" ");
        capSpace.setOnClickListener(clickListener);

        // 删除
        Button deleteCap = (Button) (layer_cap.findViewById(R.id.jar_cap_char_row_three_delete));
        deleteCap.setOnTouchListener(touchListener_delete);
        deleteCap.setTextSize(KeyConfig.key_txt_size);

    }

    /**
     * 初始化小写
     */
    private static void initLayerLow(){
        layer_low = boardView.findViewById(R.id.jar_layer_char_low);
        // 小写字符
        int size = sb_low.length();
        for (int i = 0; i < size; i++) {
            final Button btn = (Button) (layer_low.findViewById(KeyResId.resIdLowChar[i]));
            btn.setTextSize(KeyConfig.key_txt_size);
            btn.setText(sb_low.substring(i,i + 1));
            if (KeyConfig.useBoldInLow) {
                btn.setTypeface(null, Typeface.NORMAL);
            }
            btn.setOnClickListener(clickListener);
            btn.setOnTouchListener(touchListener_normal);
        }

        // 小写->大写
        Button lowToCap = (Button) (layer_low.findViewById(R.id.jar_low_char_row_three_switch));
        lowToCap.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.CAP);
            }
        });
        lowToCap.setTextSize(KeyConfig.key_txt_size);

        // 小写->数字
        Button lowToDig = (Button) (layer_low.findViewById(R.id.jar_low_char_row_four_1));
        lowToDig.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.DIG);
            }
        });

        // 小写->字符
        Button lowToSym = (Button) (layer_low.findViewById(R.id.jar_low_char_row_four_3));
        lowToSym.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                switchStateTo(KeyLayer.SYM);
            }
        });

        // 空格
        Button lowSpace = (Button) (layer_low.findViewById(R.id.jar_low_char_row_four_2));
        lowSpace.setText(" "); // space
        lowSpace.setOnClickListener(clickListener);
        // 删除
        Button deleteLow = (Button) (layer_low.findViewById(R.id.jar_low_char_row_three_delete));
        deleteLow.setOnTouchListener(touchListener_delete);
        deleteLow.setTextSize(KeyConfig.key_txt_size);//设置大小为了保持与字母按钮大小一致
    }

//    private static boolean is_ea_layer(MbsKeyLayer layer) {
//        switch (layer) {
//            case CAP:
//                return MbsKeyboardV2.inputCtrl.ea_cap;
//            case LOW:
//                return MbsKeyboardV2.inputCtrl.ea_low;
//            case DIG:
//                return MbsKeyboardV2.inputCtrl.ea_dig;
//            case SYM:
//                return MbsKeyboardV2.inputCtrl.ea_sym;
//            default:
//                return MbsKeyboardV2.inputCtrl.ea_sym;
//        }
//    }

    // 转换显示图层
    private static void switchStateTo(KeyLayer layer) {
        // 不允许切换到此图层
//        if (!is_ea_layer(layer)) {
//            ILog.i("remind","不允许切换到" + layer.tosString() + "图层");
//            return;
//        }

        layer_sym.setVisibility(View.GONE);
        layer_cap.setVisibility(View.GONE);
        layer_low.setVisibility(View.GONE);
        layer_dig.setVisibility(View.GONE);
        switch (layer) {
            case CAP:
                layer_cap.setVisibility(View.VISIBLE);
                break;
            case LOW:
                layer_low.setVisibility(View.VISIBLE);
                break;
            case DIG:
                layer_dig.setVisibility(View.VISIBLE);
                break;
            case SYM:
                layer_sym.setVisibility(View.VISIBLE);
            default:
                layer_sym.setVisibility(View.VISIBLE);
                break;
        }
        mLayer = layer;
    }

    /**
     * 按键点击事件处理:向输入框中添加字符
     */
    private static View.OnClickListener clickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(v instanceof Button){
                sb.append(((Button)v).getText().toString());
                ILog.i("remind","sb==>" + sb.toString());
                changeText();
            }
        }
    };

    /**
     * 删除键监听
     */
    private static View.OnTouchListener touchListener_delete = new View.OnTouchListener() {
        @Override
        public boolean onTouch(View view, MotionEvent event) {
            // 如果按到删除键,启动删除,down:启动删除 up:停止删除
            switch (event.getAction()){
                case MotionEvent.ACTION_DOWN:
                    isStopDelete = false;
                    new Thread() {
                        @Override
                        public void run() {
                            while (!isStopDelete) {
                                Message msg = deleteHandler.obtainMessage(200);
                                deleteHandler.sendMessage(msg);
                                try {
                                    Thread.sleep(KeyConfig.delete_speed);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }.start();
                    break;
                case MotionEvent.ACTION_UP:
                    if (!isStopDelete) {
                        isStopDelete = true;
                    }
                    break;
            }
            return false;
        }
    };

    private static View.OnTouchListener touchListener_normal = new View.OnTouchListener() {
        @Override
        public boolean onTouch(View view, MotionEvent event) {
//            switch (event.getAction()) {
//                case MotionEvent.ACTION_DOWN:
//                    // 获取当前按钮的位置
//                    int[] viewLoc = new int[2];
//                    view.getLocationOnScreen(viewLoc);
//                    // 按钮的宽度
//                    int width = view.getWidth();
//                    // 弹出框的位置left top
//                    int left = viewLoc[0] + width / 2 - popWidth / 2;
//                    left = Math.max(0, left);
//                    int top = viewLoc[1] - popHeight;
//                    top -= KeyConfig.upHeightInPixel;
//                    top = Math.max(top, 0);
//                    if (hint != null) {
//                        hintTxt.setText(((Button) view).getText().toString());
//					    hint.showAtLocation(view,Gravity.NO_GRAVITY, left, top);
//                    }
//                    break;
//                case MotionEvent.ACTION_UP:
//                    if (hint != null && hint.isShowing())
//                        hint.dismiss();
//                    break;
//            }
            return false;
        }
    };

    private static Handler deleteHandler = new Handler() {
//		@Override
		public void handleMessage(Message msg) {
			switch (msg.what) {
			case 200:
				if(sb.length() <= 0){
                    return;
                }
				sb.deleteCharAt(sb.length()-1);
                ILog.i("remind","sb==>" + sb.toString());
                changeText();
			}
		}
	};

	private static void changeText(){
        TextChangeListener textChangeListener = KeyboardUtil.getInstancce().getTextChangeListener();
        if(null != textChangeListener){
            textChangeListener.textChangeListener(sb.toString());
        }
    }

    public static void showLayerType(boolean isShowNum){
        if(isShowNum){
            switchStateTo(KeyLayer.DIG);
        }else{
            switchStateTo(KeyLayer.LOW);
        }
    }
}
