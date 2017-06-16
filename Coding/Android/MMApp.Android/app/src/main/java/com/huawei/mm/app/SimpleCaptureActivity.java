package com.huawei.mm.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.text.TextUtils;
import android.util.Log;
import android.view.Window;
import android.widget.Toast;

import io.github.xudaojie.qrcodelib.CaptureActivity;


/**
 * @author Remind.jiang
 *         date on 2017/4/17.
 */

public class SimpleCaptureActivity extends CaptureActivity {

    private Activity mActivity;
    private AlertDialog mDialog;
    private Dialog dialog;
    private static final int DIALOG_PROGRESS = 0x8;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        mActivity = this;
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void handleResult(String resultString) {
        dismissProgressDialog();
        Log.e("remind","resultString==>" + resultString);
        if (TextUtils.isEmpty(resultString)) {
            Toast.makeText(mActivity, io.github.xudaojie.qrcodelib.R.string.scan_failed, Toast.LENGTH_SHORT).show();
            restartPreview();
        } else {
            if (mDialog == null) {
                mDialog = new AlertDialog.Builder(mActivity)
                        .setMessage(resultString)
                        .setPositiveButton("确定", null)
                        .create();
                mDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
                    @Override
                    public void onDismiss(DialogInterface dialog) {
                        restartPreview();
                    }
                });
            }
            if (!mDialog.isShowing()) {
                mDialog.setMessage(resultString);
                mDialog.show();
            }
        }
    }

    @Override
    protected void showDecodeImage() {
        if (null == dialog) {
            dialog = new Dialog(this, R.style.Theme_LargeDialog);
            dialog.setCanceledOnTouchOutside(false);
            dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
            dialog.setContentView(R.layout.dialog_progress_loading);
        }
        if (!this.isFinishing()) {
            if (null == dialog) {
                showDialog(DIALOG_PROGRESS);
            }
            if (null != dialog && !dialog.isShowing()) {
                dialog.show();
            }
        }
    }

    public void dismissProgressDialog() {
        if (null != dialog && dialog.isShowing()) {
            dialog.cancel();
            removeDialog(DIALOG_PROGRESS);
        }
    }

}
