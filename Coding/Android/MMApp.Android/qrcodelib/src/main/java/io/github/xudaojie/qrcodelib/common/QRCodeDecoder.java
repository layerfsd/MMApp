package io.github.xudaojie.qrcodelib.common;

import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.RGBLuminanceSource;
import com.google.zxing.Result;
import com.google.zxing.common.HybridBinarizer;

import java.util.ArrayList;
import java.util.EnumMap;
import java.util.List;
import java.util.Map;

/**
 * @author Remind.jiang
 *         date on 2017/4/18.
 */

public class QRCodeDecoder {

    public static final Map<DecodeHintType, Object> HINTS = new EnumMap<DecodeHintType, Object>(DecodeHintType.class);

    static {
        List<BarcodeFormat> allFormats = new ArrayList<BarcodeFormat>();
        allFormats.add(BarcodeFormat.AZTEC);
        allFormats.add(BarcodeFormat.CODABAR);
        allFormats.add(BarcodeFormat.CODE_39);
        allFormats.add(BarcodeFormat.CODE_93);
        allFormats.add(BarcodeFormat.CODE_128);
        allFormats.add(BarcodeFormat.DATA_MATRIX);
        allFormats.add(BarcodeFormat.EAN_8);
        allFormats.add(BarcodeFormat.EAN_13);
        allFormats.add(BarcodeFormat.ITF);
        allFormats.add(BarcodeFormat.MAXICODE);
        allFormats.add(BarcodeFormat.PDF_417);
        allFormats.add(BarcodeFormat.QR_CODE);
        allFormats.add(BarcodeFormat.RSS_14);
        allFormats.add(BarcodeFormat.RSS_EXPANDED);
        allFormats.add(BarcodeFormat.UPC_A);
        allFormats.add(BarcodeFormat.UPC_E);
        allFormats.add(BarcodeFormat.UPC_EAN_EXTENSION);

        HINTS.put(DecodeHintType.POSSIBLE_FORMATS, allFormats);
        HINTS.put(DecodeHintType.CHARACTER_SET, "utf-8");
    }

    private QRCodeDecoder() {
    }

    /**
     * 解析二维码图片
     *
     * @param bitmap   要解析的二维码图片
     * @param delegate 解析二位码图片的代理
     */
    public static void decodeQRCode(final Bitmap bitmap, final Delegate delegate) {
        new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                try {
                    int width = bitmap.getWidth();
                    int height = bitmap.getHeight();
                    int[] pixels = new int[width * height];
                    bitmap.getPixels(pixels, 0, width, 0, 0, width, height);
                    RGBLuminanceSource source = new RGBLuminanceSource(width, height, pixels);
                    Result result = new MultiFormatReader().decode(new BinaryBitmap(new HybridBinarizer(source)), HINTS);
                    return result.getText();
                } catch (Exception e) {
                    Message msg = new Message();
                    msg.obj = delegate;
                    mHandler.sendMessage(msg);
                    return null;
                }
            }

            @Override
            protected void onPostExecute(String result) {
                if (delegate != null) {
                    if (!TextUtils.isEmpty(result)) {
                        delegate.onDecodeQRCodeSuccess(result);
                    } else {
                        delegate.onDecodeQRCodeFailure("");
                    }
                }
            }
        }.execute();
    }

    public interface Delegate {
        /**
         * 解析二维码成功
         *
         * @param result 从二维码中解析的文本，如果该方法有被调用，result不会为空
         */
        void onDecodeQRCodeSuccess(String result);

        /**
         * 解析二维码失败
         */
        void onDecodeQRCodeFailure(String error);
    }

    private static Handler mHandler = new Handler(){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            Delegate delegate = (Delegate) msg.obj;
            if(delegate != null){
                delegate.onDecodeQRCodeFailure("");
            }
        }
    };
}
