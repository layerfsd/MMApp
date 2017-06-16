package com.huawei.mm.app.gesture.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Vibrator;
import android.text.Html;
import android.text.TextUtils;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.huawei.mm.app.R;
import com.huawei.mm.app.gesture.views.GestureContentView;
import com.huawei.mm.app.gesture.views.GestureDrawline;
import com.huawei.mm.app.util.HMGlobals;


/**
 * 手势绘制/校验界面
 */
public class GestureVerifyActivity extends Activity implements View.OnClickListener {
    private RelativeLayout mTopLayout;
    private TextView mTextTitle;
    private TextView mTextCancel;
    private ImageView mImgUserLogo;
    private TextView mTextPhoneNumber;
    private TextView mTextTip;
    private FrameLayout mGestureContainer;
    private GestureContentView mGestureContentView;
    private TextView mTextForget;
    private TextView mTextOther;
    private TextView mForgetGesture;
    private String mParamPhoneNumber;
    private long mExitTime = 0;
    private int mParamIntentCode;
    /**
     * 手势密码
     */
    private String password;
    private String info;
    private int retry;
    private Vibrator vibrator;
    private static final int TIMEOUT = 60 * 1000;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gesture_verify);
        ObtainExtraData();
        setUpViews();
        setUpListeners();
        initVibrator();
    }

    private void initVibrator() {
        vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);
    }

    private void ObtainExtraData() {
        SharedPreferences sharedPreferences = getApplication().getSharedPreferences(HMGlobals.GESTRUE_PASSWORD_NAME, Context.MODE_PRIVATE);
        password = sharedPreferences.getString(HMGlobals.PASSWORD_KEY, null);
        mParamPhoneNumber = sharedPreferences.getString(HMGlobals.PHONE_KEY, null);
        info = sharedPreferences.getString(HMGlobals.CHECK_INFO, null);

        SharedPreferences sp_timeout = getSharedPreferences(HMGlobals.GUEST_TIMEOUT, MODE_PRIVATE);
        long last_time = sp_timeout.getLong(HMGlobals.GUEST_TIMEOUT, 0);

        SharedPreferences sp = getSharedPreferences(HMGlobals.GUEST_RETRY, MODE_PRIVATE);

        if (System.currentTimeMillis() - last_time > TIMEOUT) {
            SharedPreferences.Editor edit = sp.edit();
            edit.putInt(HMGlobals.GUEST_RETRY, 0);
            edit.commit();
        }
        retry = sp.getInt(HMGlobals.GUEST_RETRY, 0);

    }

    private void setUpViews() {
        mTopLayout = (RelativeLayout) findViewById(R.id.top_layout);
        mTextTitle = (TextView) findViewById(R.id.text_title);
        mTextCancel = (TextView) findViewById(R.id.text_cancel);
        mImgUserLogo = (ImageView) findViewById(R.id.user_logo);
        mTextPhoneNumber = (TextView) findViewById(R.id.text_phone_number);
        mForgetGesture = (TextView) findViewById(R.id.forget_gesture);
        mTextPhoneNumber.setText(getProtectedMobile(mParamPhoneNumber));
        mTextTip = (TextView) findViewById(R.id.text_tip);
        mGestureContainer = (FrameLayout) findViewById(R.id.gesture_container);

        // 初始化一个显示各个点的viewGroup
        mGestureContentView = new GestureContentView(this, true, password,
                new GestureDrawline.GestureCallBack() {

                    @Override
                    public void onGestureCodeInput(String inputCode) {

                    }

                    @Override
                    public void checkedSuccess(String input) {

                        SharedPreferences sp = getSharedPreferences(HMGlobals.GUEST_RETRY, MODE_PRIVATE);
                        int retry = sp.getInt(HMGlobals.GUEST_RETRY, 0);

                        if (retry <=4){

                            SharedPreferences.Editor edit = sp.edit();
                            edit.putInt(HMGlobals.GUEST_RETRY, 0);
                            edit.commit();

                            SharedPreferences sp_timeout = getSharedPreferences(HMGlobals.GUEST_TIMEOUT, MODE_PRIVATE);
                            SharedPreferences.Editor edit_timeout = sp_timeout.edit();
                            edit_timeout.putLong(HMGlobals.GUEST_TIMEOUT, 0);
                            edit_timeout.commit();

                            mGestureContentView.clearDrawlineState(0L);
                            Toast.makeText(GestureVerifyActivity.this, "密码正确", Toast.LENGTH_SHORT).show();
                            Intent intent = new Intent();
                            intent.putExtra(HMGlobals.PARAM_INTENT_CODE, HMGlobals.CODE_SUCCESS);
                            intent.putExtra(HMGlobals.CHECK_INFO, info);
                            intent.putExtra(HMGlobals.PHONE_KEY, mParamPhoneNumber);
                            intent.putExtra(HMGlobals.PARAM_GESTURE_PASSWORD, password);
                            setResult(RESULT_OK, intent);
                            GestureVerifyActivity.this.finish();
                        }else {
                            Intent intent = new Intent();
                            intent.putExtra(HMGlobals.PARAM_INTENT_CODE, HMGlobals.CODE_FAIL);
                            intent.putExtra(HMGlobals.PARAM_TOAST_MESSAGE, "超过每日5次手势密码重试验证限制，请24小时之后重试！");
                            intent.putExtra(HMGlobals.PHONE_KEY, mParamPhoneNumber);
                            intent.putExtra(HMGlobals.CHECK_INFO, info);
                            intent.putExtra(HMGlobals.LAST_INPUT, input);
                            setResult(RESULT_OK, intent);
                            GestureVerifyActivity.this.finish();
                        }
                    }

                    @Override
                    public void checkedFail(String input) {
//                        retry++;
                        SharedPreferences sp = GestureVerifyActivity.this.getSharedPreferences(HMGlobals.GUEST_RETRY, MODE_PRIVATE);
                        SharedPreferences.Editor edit = sp.edit();
                        edit.putInt(HMGlobals.GUEST_RETRY, ++retry);
                        edit.commit();

                        if (retry <= 4) {
                            mGestureContentView.clearDrawlineState(1300L);
                            mTextTip.setVisibility(View.VISIBLE);
                            String re = 5 - retry + "";
                            mTextTip.setText(Html
                                    .fromHtml("<font color='#c70c1e'>密码错误，可以重试" + re + "次</font>"));
                            // 左右移动动画
                            Animation shakeAnimation = AnimationUtils.loadAnimation(GestureVerifyActivity.this, R.anim.shake);
                            mTextTip.startAnimation(shakeAnimation);
                            vibrator.vibrate(300);

                            SharedPreferences sp_timeout = GestureVerifyActivity.this.getSharedPreferences(HMGlobals.GUEST_TIMEOUT, MODE_PRIVATE);
                            SharedPreferences.Editor edit_timeout = sp_timeout.edit();
                            edit_timeout.putLong(HMGlobals.GUEST_TIMEOUT, System.currentTimeMillis());
                            edit_timeout.commit();

                        } else {

                            SharedPreferences sp_timeout = GestureVerifyActivity.this.getSharedPreferences(HMGlobals.GUEST_TIMEOUT, MODE_PRIVATE);
                            SharedPreferences.Editor edit_timeout = sp_timeout.edit();
                            edit_timeout.putLong(HMGlobals.GUEST_TIMEOUT, System.currentTimeMillis());
                            edit_timeout.commit();

                            Toast.makeText(GestureVerifyActivity.this, "超过每日5次手势密码重试验证限制，请24小时之后重试！", Toast.LENGTH_SHORT).show();
                            Intent intent = new Intent();
                            intent.putExtra(HMGlobals.PARAM_INTENT_CODE, HMGlobals.CODE_FAIL);
                            intent.putExtra(HMGlobals.PARAM_TOAST_MESSAGE, "超过每日5次手势密码重试验证限制，请24小时之后重试！");
                            intent.putExtra(HMGlobals.PHONE_KEY, mParamPhoneNumber);
                            intent.putExtra(HMGlobals.CHECK_INFO, info);
                            intent.putExtra(HMGlobals.LAST_INPUT, input);
                            setResult(RESULT_OK, intent);
                            GestureVerifyActivity.this.finish();

                        }

                    }
                });
        // 设置手势解锁显示到哪个布局里面
        mGestureContentView.setParentView(mGestureContainer);
    }

    private void setUpListeners() {
        mTextCancel.setOnClickListener(this);
        mForgetGesture.setOnClickListener(this);
    }

    private String getProtectedMobile(String phoneNumber) {
        if (TextUtils.isEmpty(phoneNumber) || phoneNumber.length() < 11) {
            return "";
        }
        StringBuilder builder = new StringBuilder();
        builder.append(phoneNumber.subSequence(0, 3));
        builder.append("****");
        builder.append(phoneNumber.subSequence(7, 11));
        return builder.toString();
    }


    @Override
    public void onClick(View v) {
        Intent intent = null;
        switch (v.getId()) {
            case R.id.text_cancel:
//                Intent intent=new Intent();
//                intent.putExtra("code",Constants.CODE_FAIL);
//                setResult(RESULT_OK,intent);
                this.finish();
                break;
            case R.id.forget_gesture:
                intent = new Intent(this,GestureEditActivity.class);
//                intent.putExtra(HMGlobals.PARAM_RESET_GESTURE, HMGlobals.CODE_USE_PASSWORD);
//                intent.putExtra(HMGlobals.PHONE_KEY, mParamPhoneNumber);
//                setResult(RESULT_OK, intent);
//                this.finish();
                break;
            default:
                break;
        }
    }

    /**
     *
     * 屏蔽返回键
     * @see android.app.Activity#onBackPressed()
     */
    @Override
    public void onBackPressed() {

    }

}

