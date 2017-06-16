package com.huawei.mm.app.keyboard;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;

import com.huawei.mm.app.R;

/**
 * @author Remind.jiang
 *         date on 2017/3/17.
 */

public class KeyboardUtil {

    private static KeyboardUtil instancce;
    private Context mContext;
    private Dialog dialog;
    private Dialog pinDialog;
    private View pinView;
    private View keyboardView;

    private TextChangeListener textChangeListener;

    public static KeyboardUtil getInstancce(){
        if(null == instancce){
            instancce = new KeyboardUtil();
        }
        return instancce;
    }

    public void initKeyboard(Context mContext){
        this.mContext = mContext;
        KeyboardView.initKeyboardView(mContext);
        PinView.initPINView(mContext);
    }

    public void showKeyboard(Context mContext){
        showView(mContext,KeyboardView.boardView, R.style.jar_dialog);
    }

    public void showPINKeyboard(Context mContext){
        showPINView(mContext,PinView.pinView, R.style.jar_dialog);
    }

    public void setTextChangeListener(TextChangeListener textChangeListener){
        this.textChangeListener = textChangeListener;
    }

    private Dialog showView(Context mContext,View view, int style) {
        this.keyboardView = view;
        if(dialog == null){
            int width = mContext.getResources().getDisplayMetrics().widthPixels;
            dialog = new Dialog(mContext,style);
            dialog.setContentView(view,new ViewGroup.LayoutParams(width, ViewGroup.LayoutParams.WRAP_CONTENT));
            dialog.setCancelable(true);
            Window window = dialog.getWindow();
            window.setGravity(Gravity.BOTTOM);
            window.setWindowAnimations(R.style.DialogPopupAnimation);
            WindowManager.LayoutParams lp = window.getAttributes();
            lp.width = width;
            window.setAttributes(lp);
        }
        if(dialog != null && !dialog.isShowing() && !((Activity)mContext).isFinishing()){
            dialog.show();
        }
        return dialog;
    }

    private Dialog showPINView(Context mContext,View view, int style){
        this.pinView = view;
        if(pinDialog == null){
            int width = mContext.getResources().getDisplayMetrics().widthPixels;
            pinDialog = new Dialog(mContext,style);
            pinDialog.setContentView(view,new ViewGroup.LayoutParams(width, ViewGroup.LayoutParams.WRAP_CONTENT));
            pinDialog.setCancelable(true);
            Window window = pinDialog.getWindow();
            window.setGravity(Gravity.BOTTOM);
            window.setWindowAnimations(R.style.DialogPopupAnimation);
            WindowManager.LayoutParams lp = window.getAttributes();
            lp.width = width;
            window.setAttributes(lp);
            PinView.initRandomDig();
        }
        if(pinDialog != null && !pinDialog.isShowing() && !((Activity)mContext).isFinishing()){
            pinDialog.show();
        }
        return pinDialog;
    }

    public void dissmissDialog(){
        if(null != dialog){
            ViewGroup parent = (ViewGroup) keyboardView.getParent();
            parent.removeView(keyboardView);
            dialog.dismiss();
            dialog = null;
        }
    }

    public void dissmissPIN(){
        if(null != pinDialog){
            ViewGroup parent = (ViewGroup) pinView.getParent();
            parent.removeView(pinView);
            pinDialog.dismiss();
            pinDialog = null;
        }
    }

    public void hideKeyboard(){
        dissmissDialog();
        dissmissPIN();
    }

    public TextChangeListener getTextChangeListener() {
        return textChangeListener;
    }

    public void showDigitKeyboard(boolean isShowNum){
        KeyboardView.showLayerType(isShowNum);
    }
}
