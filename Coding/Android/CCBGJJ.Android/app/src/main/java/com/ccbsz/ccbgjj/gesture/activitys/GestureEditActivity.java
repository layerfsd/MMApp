package com.ccbsz.ccbgjj.gesture.activitys;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Vibrator;
import android.text.Html;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.FrameLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.ccbsz.ccbgjj.R;
import com.ccbsz.ccbgjj.gesture.util.MD5Utils;
import com.ccbsz.ccbgjj.gesture.views.GestureContentView;
import com.ccbsz.ccbgjj.gesture.views.GestureDrawline;
import com.ccbsz.ccbgjj.gesture.views.LockIndicator;
import com.ccbsz.ccbgjj.util.JGGlobals;

/**
 *
 * 手势密码设置界面
 *
 */
public class GestureEditActivity extends Activity implements View.OnClickListener {
    private TextView mTextTitle;
    private TextView mTextCancel;
    private LockIndicator mLockIndicator;
    private TextView mTextTip;
    private FrameLayout mGestureContainer;
    private GestureContentView mGestureContentView;
    private TextView mTextReset;
    private String mParamSetUpcode = null;
    private String mParamPhoneNumber;
    private boolean mIsFirstInput = true;
    private String mFirstPassword = null;
    private String mConfirmPassword = null;
    private int mParamIntentCode;
    private ProgressBar mProgressBar;
    private Vibrator vibrator;
    // private String seesionId;
  //  private String url="http://128.192.179.152/tran/WCCMainPlatV5?CCB_IBSVersion=V5&isAjaxRequest=true&SERVLET_NAME=WCCMainPlatV5&TXCODE=6GB064&Ctlg_SN=90009&Lv1_Br_No=442000000&Step_ID=900090000001&Trstr_InsID=442999999999&Txn_Chnl_ID=9000900000&Ssn_No=";
            //"Sessionid&Fcn_ID=JSON";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gesture_edit);
        setUpViews();
        setUpListeners();
        initVibrator();
    }

    private void initVibrator() {
        vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);
    }

    private void setUpViews() {
        mParamPhoneNumber=getIntent().getStringExtra(JGGlobals.PARAM_PHONE_NUMBER);
        mTextTitle = (TextView) findViewById(R.id.text_title);
        mTextCancel = (TextView) findViewById(R.id.text_cancel);
        mTextReset = (TextView) findViewById(R.id.text_reset);
        mTextReset.setClickable(false);
        mLockIndicator = (LockIndicator) findViewById(R.id.lock_indicator);
        mTextTip = (TextView) findViewById(R.id.text_tip);
        mGestureContainer = (FrameLayout) findViewById(R.id.gesture_container);
        // 初始化一个显示各个点的viewGroup
        mGestureContentView = new GestureContentView(this, false, "", new GestureDrawline.GestureCallBack() {
            @Override
            public void onGestureCodeInput(String inputCode) {
                if (!isInputPassValidate(inputCode)) {
                    mTextTip.setText(Html.fromHtml("<font color='#c70c1e'>最少链接6个点, 请重新输入</font>"));
                    mGestureContentView.clearDrawlineState(0L);
                    vibrator.vibrate(300);
                }else {
                    mTextTip.setText("确认解锁图案");
                    if (mIsFirstInput) {
                        mFirstPassword = inputCode;
                        updateCodeList(inputCode);
                        mGestureContentView.clearDrawlineState(0L);
                        mTextReset.setClickable(true);
                        mTextReset.setText(getString(R.string.reset_gesture_code));
                    } else {
                        if (inputCode.equals(mFirstPassword)) {
                            mGestureContentView.clearDrawlineState(0L);
                            //TODO

                            SharedPreferences sp=GestureEditActivity.this.getApplication().getSharedPreferences(JGGlobals.GESTRUE_PASSWORD_NAME, Context.MODE_PRIVATE);
                            SharedPreferences.Editor editor=sp.edit();
                            //手势密码与号码保存
                            String md5InputCode = "";
                            md5InputCode= MD5Utils.encryptStringToMd5(inputCode);

                            editor.putString(JGGlobals.PASSWORD_KEY,md5InputCode);
                            editor.putString(JGGlobals.PHONE_KEY,mParamPhoneNumber);
                            editor.commit();

                            SharedPreferences sp_retry = getSharedPreferences(JGGlobals.GUEST_RETRY,MODE_PRIVATE);
                            SharedPreferences.Editor edit_retry = sp_retry.edit();
                            edit_retry.putInt(JGGlobals.GUEST_RETRY,0);
                            edit_retry.commit();

                            SharedPreferences sp_timeout = getSharedPreferences(JGGlobals.GUEST_TIMEOUT,MODE_PRIVATE);
                            SharedPreferences.Editor edit_timeout = sp_timeout.edit();
                            edit_timeout.putLong(JGGlobals.GUEST_TIMEOUT,0);
                            edit_timeout.commit();

                            Intent intent=new Intent();
                            intent.putExtra(JGGlobals.PARAM_INTENT_CODE, JGGlobals.CODE_SUCCESS);
                            intent.putExtra(JGGlobals.PARAM_GESTURE_PASSWORD,md5InputCode);
                            setResult(RESULT_OK,intent);
                            GestureEditActivity.this.finish();

                        } else {
                            mTextTip.setText(Html.fromHtml("<font color='#c70c1e'>与上一次绘制不一致，请重新绘制</font>"));
                            // 左右移动动画
                            Animation shakeAnimation = AnimationUtils.loadAnimation(GestureEditActivity.this, R.anim.shake);
                            mTextTip.startAnimation(shakeAnimation);
                            // 保持绘制的线，1.5秒后清除
                            mGestureContentView.clearDrawlineState(1300L);
                            vibrator.vibrate(300);
                        }
                    }
                    mIsFirstInput = false;
                }

            }

            @Override
            public void checkedSuccess(String input) {

            }

            @Override
            public void checkedFail(String input) {

            }
        });
        // 设置手势解锁显示到哪个布局里面
        mGestureContentView.setParentView(mGestureContainer);
        updateCodeList("");
    }

    private void setUpListeners() {
        mTextCancel.setOnClickListener(this);
        mTextReset.setOnClickListener(this);
    }

    private void updateCodeList(String inputCode) {
        // 更新选择的图案
        mLockIndicator.setPath(inputCode);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.text_cancel:
                //TODO 返回数据给JS,设置手势密码失败。
                Intent intent=new Intent();
                intent.putExtra(JGGlobals.PARAM_INTENT_CODE, JGGlobals.CODE_FAIL);
                setResult(RESULT_OK,intent);
                this.finish();
                break;
            case R.id.text_reset:
                mIsFirstInput = true;
                updateCodeList("");
                mTextTip.setText(getString(R.string.set_gesture_pattern));
                break;
            default:
                break;
        }
    }

    private boolean isInputPassValidate(String inputPassword) {
//        if (TextUtils.isEmpty(inputPassword) || inputPassword.length() < 4) {
//            return false;
//        }
        return !(TextUtils.isEmpty(inputPassword) || inputPassword.length() < 6);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if(keyCode==KeyEvent.KEYCODE_BACK){
            //TODO 如果用户按返回键取消设置手势密码，则设置失败
            Intent intent=new Intent();
            intent.putExtra(JGGlobals.PARAM_INTENT_CODE, JGGlobals.CODE_FAIL);
            setResult(RESULT_OK,intent);
            finish();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }


}
