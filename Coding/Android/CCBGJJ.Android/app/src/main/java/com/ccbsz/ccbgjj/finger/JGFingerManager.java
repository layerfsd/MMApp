package com.ccbsz.ccbgjj.finger;

import android.annotation.TargetApi;
import android.app.KeyguardManager;
import android.content.Context;
import android.os.Build;
import android.os.Handler;
import android.os.Message;
import android.os.Vibrator;
import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyPermanentlyInvalidatedException;
import android.security.keystore.KeyProperties;
import android.support.v4.hardware.fingerprint.FingerprintManagerCompat;
import android.support.v4.os.CancellationSignal;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.ccbsz.ccbgjj.R;
import com.ccbsz.ccbgjj.util.JGGlobals;
import com.ccbsz.ccbgjj.views.QDialog;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.spec.ECGenParameterSpec;

/**
 * Created by liuym on 2017/2/23.
 */

public class JGFingerManager {
    private Context mContext;
    private KeyguardManager mKeyguardManager = null;
    private FingerprintManagerCompat mFingerprintManager = null;

    private String mErrorMsg = "";

    private  Vibrator mVibrator;

    //取消指纹操作
    private CancellationSignal mCancellationSignal = null;
    private FingerCallback mFingerCallback = null;
    private QDialog mFingerDialog;

    //指纹认证
    private KeyPairGenerator mKeyPairGenerator;
    private KeyStore mKeyStore;
    private Signature mSignature;

    //监听
    private JGFingerManagerListener mListener;

    public JGFingerManager(Context context){

        mContext = context;

        mFingerprintManager = FingerprintManagerCompat.from(context);

        mKeyguardManager = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);

        mVibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);

    }

    public boolean isSupportFinger(){
        //判断硬件是否支持指纹识别
        if (!mFingerprintManager.isHardwareDetected()) {
            mErrorMsg = "没有指纹识别模块或不是最新系统，不支持此功能";
            return false;
        }

        //判断 是否开启锁屏密码
        if (!mKeyguardManager.isKeyguardSecure()) {
            mErrorMsg = "没有开启锁屏密码，不支持此功能";
            return false;
        }

        //判断是否有指纹录入
        if (!mFingerprintManager.hasEnrolledFingerprints()) {
            mErrorMsg = "没有录入指纹，请到系统设置中录入指纹";
            return false;
        }

        return true;
    }

    public String getError(){
        return mErrorMsg;
    }

    //指纹设置dialog
    private void showFingerSetDialog() {
        View fingerDialogView = View.inflate(mContext, R.layout.dialog_fingerprint, null);
        mFingerDialog = new QDialog(mContext, 0, 0, fingerDialogView, R.style.dialog);
        mFingerDialog.setCancelable(false);
        Button btn_cancel = (Button) fingerDialogView.findViewById(R.id.btn_cancel);


        btn_cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mFingerDialog.dismiss();
                cancelFingerPrint();

                //取消指纹设置
                handleListener(JGGlobals.FINGER_AUTH_CANCEL, "取消指纹设置");
            }
        });
        mFingerDialog.show();
    }

    public void setFingerprintPassword() {
        showFingerSetDialog();

        if (mCancellationSignal == null) {
            mCancellationSignal = new CancellationSignal();
        }
        mFingerCallback = new FingerCallback(fingerSetHandler);
        mFingerprintManager.authenticate(null, 0, mCancellationSignal, mFingerCallback, null);
    }

    //设置指纹
    private Handler fingerSetHandler = new Handler() {

        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case JGGlobals.FINGER_AUTH_SUCCESS:
                    Toast.makeText(mContext, "设置指纹成功！", Toast.LENGTH_SHORT).show();
                    mFingerDialog.dismiss();

                    handleListener(JGGlobals.FINGER_AUTH_SUCCESS, "");

                    break;
                case JGGlobals.FINGER_AUTH_FAILED:
                    Toast.makeText(mContext, "指纹认证失败，请重试！", Toast.LENGTH_SHORT).show();

                    mVibrator.vibrate(300);
                    break;
                case JGGlobals.FINGER_AUTH_ERROR:
                    //                    handleErrorCode(msg.arg1); 5 :手动取消 7：错误次数过多
                    int arg1 = msg.arg1;
                    if (arg1 == 5) {
                        //已取消指纹识别
                    } else if (arg1 == 7) {
                        mFingerDialog.dismiss();
                        handleListener(JGGlobals.FINGER_AUTH_ERROR, "请设置其他登陆方式或30秒之后重试");
                    }
                    break;
                case JGGlobals.FINGER_AUTH_HELP:
                    Toast.makeText(mContext, "手指不要移动过快，请重试！", Toast.LENGTH_SHORT).show();
                    break;
            }
        }
    };

    //初始化指纹
    private void initFingerCore() {
        FingerprintModule fingerprintModule = new FingerprintModule(mContext);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            mKeyPairGenerator = fingerprintModule.providesKeyPairGenerator();
            mKeyStore = fingerprintModule.providesKeystore();
            mSignature = fingerprintModule.providesSignature(mKeyStore);
        }
    }

    //指纹识别dialog
    private void showFingerGetDialog() {
        View fingerDialogView = View.inflate(mContext, R.layout.dialog_fingerprint, null);
        mFingerDialog = new QDialog(mContext, 0, 0, fingerDialogView, R.style.dialog);
        mFingerDialog.setCancelable(false);
        Button btn_cancel = (Button) fingerDialogView.findViewById(R.id.btn_cancel);


        btn_cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mFingerDialog.dismiss();
                cancelFingerPrint();
                //取消指纹设置
                handleListener(JGGlobals.FINGER_AUTH_CANCEL, "取消指纹识别");
            }
        });
        mFingerDialog.show();
    }

    private void createKeyPair() {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                mKeyPairGenerator.initialize(
                        new KeyGenParameterSpec.Builder(JGGlobals.FINGER_KEY_NAME,
                                KeyProperties.PURPOSE_SIGN)
                                .setDigests(KeyProperties.DIGEST_SHA256)
                                .setAlgorithmParameterSpec(new ECGenParameterSpec("secp256r1"))
                                .setUserAuthenticationRequired(true)
                                .build());
            }
            mKeyPairGenerator.generateKeyPair();
        } catch (InvalidAlgorithmParameterException e) {
            throw new RuntimeException(e);
        }
    }

    @TargetApi(Build.VERSION_CODES.M)
    private boolean initSignature() {
        try {
            mKeyStore.load(null);
            PrivateKey key = (PrivateKey) mKeyStore.getKey(JGGlobals.FINGER_KEY_NAME, null);
            mSignature.initSign(key);
            return true;
        } catch (KeyPermanentlyInvalidatedException e) {
            e.printStackTrace();

            handleListener(JGGlobals.FINGER_AUTH_HELP, "指纹库发生变化，请重新密码验证！");

            mFingerDialog.dismiss();
            cancelFingerPrint();

            return false;
        } catch (KeyStoreException | CertificateException | UnrecoverableKeyException | IOException
                | NoSuchAlgorithmException | InvalidKeyException e) {
            throw new RuntimeException("Failed to init Cipher", e);
        }
    }

    public void checkFingerprintPassword(){
        initFingerCore();

        showFingerGetDialog();

        try {
            //第一次验证
            mKeyStore.load(null);
            if (mKeyStore.getKey(JGGlobals.FINGER_KEY_NAME, null) == null) {
                createKeyPair();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (initSignature()) {
            if (mCancellationSignal == null) {
                mCancellationSignal = new CancellationSignal();
            }
            mFingerCallback = new FingerCallback(fingerHandler);
            mFingerprintManager.authenticate(new FingerprintManagerCompat.CryptoObject(mSignature), 0, mCancellationSignal, mFingerCallback, null);

        } else {
            //LogQ.e(TAG, "不能识别");
        }
    }

    //指纹处理
    private Handler fingerHandler = new Handler() {

        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case JGGlobals.FINGER_AUTH_SUCCESS:
                    Toast.makeText(mContext, "指纹认证成功！", Toast.LENGTH_SHORT).show();
                    mFingerDialog.dismiss();

                    handleListener(JGGlobals.FINGER_AUTH_SUCCESS, "指纹认证成功");
                    break;
                case JGGlobals.FINGER_AUTH_FAILED:
                    Toast.makeText(mContext, "指纹认证失败，请重试！", Toast.LENGTH_SHORT).show();
                    mVibrator.vibrate(300);

                    break;
                case JGGlobals.FINGER_AUTH_ERROR:
                    int arg1 = msg.arg1;
                    if (arg1 == 5) {
//                        LogQ.e(TAG, "用户手动取消");
                    } else if (arg1 == 7) {
                        mFingerDialog.dismiss();
                        handleListener(JGGlobals.FINGER_AUTH_ERROR, "指纹无法识别，请选择其他登陆方式或30秒之后重试");
                    }
                    break;
                case JGGlobals.FINGER_AUTH_HELP:
                    Toast.makeText(mContext, "手指不要移动过快，请重试！", Toast.LENGTH_SHORT).show();
                    break;
            }
        }
    };

    private void cancelFingerPrint() {
        // 取消指纹识别
        if (mCancellationSignal != null) {
            mCancellationSignal.cancel();
            mCancellationSignal = null;
        }
        if (mFingerCallback != null) {
            mFingerCallback = null;
        }
    }

    private void handleListener(int result, String message){
        if(mListener != null){
            mListener.fingerResult(result, message);
        }
    }

    public void setJGFingerManagerListener(JGFingerManagerListener listener){
        mListener = listener;
    }

    public interface JGFingerManagerListener{
        public void fingerResult(int result, String message);
    }
}
