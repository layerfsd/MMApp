package com.huawei.mm.app.keyboard;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

import com.huawei.mm.app.R;
import com.huawei.mm.app.util.ILog;

import java.util.Random;


/**
 * @author Remind.jiang
 *         date on 2017/3/23.
 */

public class PinView {

    public static View pinView;
    private static View layer_dig;// 数字层
    private static StringBuilder sb_dig = new StringBuilder();
    public static int kbHeight;
    public static StringBuffer sb = new StringBuffer();
    private static boolean isStopDelete = true; // 删除操作是否结束
    private static Context mContext;

    public static void initPINView(Context context){
        mContext = context;
        pinView = LayoutInflater.from(mContext).inflate(R.layout.jar_pin_layer_digit, null);

        // 初始化:测量高度
        int w = View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED);
        int h = View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED);
        pinView.measure(w, h);
        kbHeight = pinView.getMeasuredHeight();

        initLayerDig();

        Button btnCancel = (Button) pinView.findViewById(R.id.jar_key_btn_cancel);

        btnCancel.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
//                KeyboardUtil.getInstancce().hideKeyboard();
                initRandomDig();
            }
        });

        // 完成按键
        Button btnConfirm = (Button) pinView.findViewById(R.id.jar_key_btn_confirm);
        btnConfirm.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                KeyboardUtil.getInstancce().hideKeyboard();
            }
        });
    }

    public static void initRandomDig(){
        Random random = new Random();
        for(int i = 0; i < 10; i++){
            int order = random.nextInt(10);
            String charAtI = sb_dig.substring(i, i + 1);
            String charAtOrder = sb_dig.substring(order, order + 1);
            sb_dig.replace(i, i + 1, charAtOrder);
            sb_dig.replace(order, order + 1, charAtI);
        }
        // 数字和字符层
        for (int i = 0; i < 10; i++) {
            final Button btn = (Button) pinView.findViewById(KeyResId.resIdDigital[i]);
            btn.setText(sb_dig.substring(i, i + 1));
            btn.setOnClickListener(clickListener);
        }
    }

    /**
     * 初始化数字
     */
    private static void initLayerDig(){
        sb_dig.delete(0, sb_dig.length());
        for (int i = 0;i<10;i++) {
            sb_dig.append(KeyResId.CHAR_DIG.charAt(i));
        }
        initRandomDig();
        // 删除键
        ImageButton deleteDig = (ImageButton) (pinView.findViewById(R.id.jar_digit_delete));
        deleteDig.setOnTouchListener(touchListener_delete);
    }

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

    private static Handler deleteHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 200:
                    if(sb.length() <= 0){
                        return;
                    }
                    sb.deleteCharAt(sb.length()-1);
                    ILog.i("remind","sb==>" + sb.toString());
                    changePIN();
            }
        }
    };

    /**
     * 按键点击事件处理:向输入框中添加字符
     */
    private static View.OnClickListener clickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(v instanceof Button){
                sb.append(((Button)v).getText().toString());
                ILog.i("remind","sb==>" + sb.toString());
                changePIN();
            }
        }
    };

    private static void changePIN(){
        TextChangeListener textChangeListener = KeyboardUtil.getInstancce().getTextChangeListener();
        if(null != textChangeListener){
            textChangeListener.pinChangeListener(sb.toString());
        }
    }
}
