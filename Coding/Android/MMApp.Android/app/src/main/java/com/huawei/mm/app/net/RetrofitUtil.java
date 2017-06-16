package com.huawei.mm.app.net;

import android.content.Context;
import android.util.Base64;
import android.util.Log;
import android.webkit.CookieSyncManager;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.huawei.mm.app.HMApiServiceImpl;
import com.huawei.mm.app.MyApplication;
import com.huawei.mm.app.MyController;
import com.huawei.mm.app.encrypt.HMEncryptApi;
import com.huawei.mm.app.util.ILog;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import okhttp3.Cache;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * 联网工具类
 *
 * @author Remind.jiang
 *         date on 2017/1/22.
 */

public class RetrofitUtil implements HttpLoggingInterceptor.Logger , Interceptor{

    private static final String TAG = RetrofitUtil.class.getCanonicalName();

    private static RetrofitUtil instance;
    public static final String SERVER_URL = "https://192.168.1.169:8443/";

    public Retrofit mRetrofit;
    private OkHttpClient okHttpClient;
    private Cache cache;
    private List<String> hostList = new ArrayList<>();

    public void setTrustHost(List<String> hostList){
        this.hostList = hostList;
    }

    public static RetrofitUtil getInstance() {
        synchronized (RetrofitUtil.class) {
            if (instance == null) {
                instance = new RetrofitUtil();
            }
        }
        return instance;
    }

    public RetrofitUtil() {
        initRetrofit();
    }

    private void initRetrofit() {
        initOkHttp();
        Gson mGson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();
        mRetrofit = new Retrofit.Builder()
                .baseUrl(SERVER_URL)
                .addConverterFactory(GsonConverterFactory.create(mGson))
                .client(okHttpClient)
                .build();
    }

    private void initOkHttp() {

        final TrustManager[] trustAllCerts = new TrustManager[]{new X509TrustManager() {
            @Override
            public void checkClientTrusted(java.security.cert.X509Certificate[] chain,String authType) throws CertificateException {
            }

            @Override
            public void checkServerTrusted(java.security.cert.X509Certificate[] chain,String authType) throws CertificateException {
//                if (chain == null) {
//                    throw new IllegalArgumentException("checkServerTrusted:x509Certificate array isnull");
//                }
//
//                if (!(chain.length > 0)) {
//                    throw new IllegalArgumentException("checkServerTrusted: X509Certificate is empty");
//                }
//
//                if (!(null != authType && authType.equalsIgnoreCase("RSA"))) {
//                    throw new CertificateException("checkServerTrusted: AuthType is not RSA");
//                }
//
//                // Perform customary SSL/TLS checks
//                try {
//                    TrustManagerFactory tmf = TrustManagerFactory.getInstance("X509");
//                    tmf.init((KeyStore) null);
//                    for (TrustManager trustManager : tmf.getTrustManagers()) {
//                        ((X509TrustManager) trustManager).checkServerTrusted(chain, authType);
//                    }
//                } catch (Exception e) {
//                    throw new CertificateException(e);
//                }
            }

            @Override
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return new X509Certificate[0];
            }
        }};

        // Install the all-trusting trust manager
        SSLContext sslContext = null;
        try {
            sslContext = SSLContext.getInstance("SSL");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        try {
            sslContext.init(null, trustAllCerts, new SecureRandom());
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }

        File cacheFile = new File(MyApplication.getInstance().getCacheDir(), "HttpCache");
        Log.d("remind", "cacheFile===>" + cacheFile.getAbsolutePath());
        cache = new Cache(cacheFile, 1024 * 1024 * 100); //100Mb
        HttpLoggingInterceptor mHttpLogInterceptor = new HttpLoggingInterceptor(this);
        mHttpLogInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        //基本参数
        Map<String, String> headers = getHeaderParams();
        byte[] transportKey = MyController.getInstance().getTransportKey();
        byte[] payloadKey = MyController.getInstance().getPayloadKey();

        Map<String, String> tempParams = getBaseParams();
        tempParams.put("appVersion","1.0");
        tempParams.put("deviceVersion","10");
        tempParams.put("deviceModel","Android");
        tempParams.put("appChannel","10000");
        tempParams.put("timestamp",HMApiServiceImpl.time + "");
        tempParams.put("payloadKey",HMEncryptApi.encryptAESData(Base64.encodeToString(payloadKey, Base64.NO_WRAP),transportKey));
        tempParams.put("IMEIFactor", MyController.getInstance().getIMEIfactor());
        tempParams.put("debug","false");
        tempParams.put("sign",HMEncryptApi.encryptAESData(HMApiServiceImpl.md5Values,payloadKey));

        BasicParamsInterceptor mBaseParamsInterceptor = new BasicParamsInterceptor.Builder()
                .addHeaderParamsMap(headers)
                .addParamsMap(tempParams)
                .build();
        okHttpClient = new OkHttpClient.Builder()
                .connectTimeout(20, TimeUnit.SECONDS)
                .writeTimeout(20, TimeUnit.SECONDS)
                .readTimeout(20, TimeUnit.SECONDS)
                .retryOnConnectionFailure(true)
                .addInterceptor(mHttpLogInterceptor)
//                .addInterceptor(mBaseParamsInterceptor)
                .addInterceptor(this)
                .addInterceptor(new GetCookiesInterceptor(MyApplication.getInstance()))
                .cache(cache)
//                .sslSocketFactory(new MySocketFactory(MyApplication.getInstance()))
                .sslSocketFactory(sslContext.getSocketFactory())
                .hostnameVerifier(getHostnameVerifier(hostList))
                .build();
    }

    public <T> T getAPIService(Class<T> service) {
        return mRetrofit.create(service);
    }

    public <D> void enqueueCall(Call<BaseResp<D>> call, final RetrofitCallBack<D> retrofitCallBack) {
        call.enqueue(new Callback<BaseResp<D>>() {
            @Override
            public void onResponse(Call<BaseResp<D>> call, Response<BaseResp<D>> response) {
                BaseResp<D> resp = response.body();
                Log.i("remind", "resp===>" + resp.toString());
                if (null != resp) {
                    if (retrofitCallBack != null)
                        retrofitCallBack.onSuccess(resp);
                } else {
                    if (retrofitCallBack != null)
                        retrofitCallBack.onFailure(null != resp && resp.getHead() != null ? resp.getHead().getMsg() : "加载失败，请重试...");
                }
            }

            @Override
            public void onFailure(Call<BaseResp<D>> call, Throwable t) {
                Log.e("remind", "error==>" + t.toString());
                if (retrofitCallBack != null) {
                    retrofitCallBack.onFailure(t.toString());
                }
            }
        });
    }

    /**
     * 添加基本参数
     *
     * @return
     */
    public Map<String, String> getBaseParams() {
        Map<String, String> params = new HashMap<>();
        return params;
    }

    /**
     * 添加消息头
     *
     * @return
     */
    public Map<String, String> getHeaderParams() {
        Map<String, String> params = new HashMap<>();
        return params;
    }

    @Override
    public okhttp3.Response intercept(Chain chain) throws IOException {
        byte[] transportKey = MyController.getInstance().getTransportKey();
        byte[] payloadKey = MyController.getInstance().getPayloadKey();

        ILog.i("remind","transportKey==>" + Base64.encodeToString(transportKey,Base64.NO_WRAP));
        ILog.i("remind","payloadKey==>" + Base64.encodeToString(payloadKey,Base64.NO_WRAP));
        Request newRequest = chain.request().newBuilder()
                .addHeader("Accept-Language","zh")
                .addHeader("Content-Type","application/json;charset=utf-8")
                .addHeader("sign",HMEncryptApi.encryptAESData(HMApiServiceImpl.pbkdf2Values,payloadKey))
                .addHeader("IMEIFactor", MyController.getInstance().getIMEIfactor())
                .addHeader("payloadKey",HMEncryptApi.encryptAESData(Base64.encodeToString(payloadKey, Base64.NO_WRAP), MyController.getInstance().getTransportKey()))
                .addHeader("transportKey",HMEncryptApi.encryptRSAData(Base64.encodeToString(MyController.getInstance().getTransportKey(),Base64.NO_WRAP)))
//                .addHeader("Accept","application/json")
                .build();
        ILog.i("remind","header==>" + newRequest.headers());
        return chain.proceed(newRequest);
    }

    /**
     * 回调接口
     *
     * @param <D>
     */
    public interface RetrofitCallBack<D> {
        void onSuccess(BaseResp<D> baseResp);

        void onFailure(String error);
    }

    /**
     * 获取缓存
     *
     * @return
     */
    public Cache getCache() {
        return cache;
    }

    /**
     * 清除缓存
     *
     * @throws IOException
     */
    public void clearCache() throws IOException {
        cache.delete();
    }

    @Override
    public void log(String message) {
        Log.w("remind", "OkHttp===>" + message);
    }

    protected static HostnameVerifier getHostnameVerifier(final List<String> hostList) {
        HostnameVerifier TRUSTED_VERIFIER = new HostnameVerifier() {
            public boolean verify(String hostname, SSLSession session) {
//                boolean ret = false;
//                for (String host : hostList) {
//                    if (host.equalsIgnoreCase(hostname)) {
//                        ret = true;
//                    }
//                }
                return true;
            }
        };
        return TRUSTED_VERIFIER;
    }

    public class VerifyEverythingHostnameVerifier implements HostnameVerifier {
        @Override
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    }

    public class GetCookiesInterceptor implements Interceptor {
            private Context context;
            public GetCookiesInterceptor(Context context) {
                super();
                this.context = context;
            }
        @Override
        public okhttp3.Response intercept(Chain chain) throws IOException {
            okhttp3.Response originalResponse = chain.proceed(chain.request());
            if (!originalResponse.headers("Set-Cookie").isEmpty()) {
                String cookie = originalResponse.headers().get("Set-Cookie");
                ILog.i("remind","cookie==>" + cookie);
                CookieSyncManager.createInstance(context);
                android.webkit.CookieManager cookieManager = android.webkit.CookieManager.getInstance();
                String cookie1 = cookieManager.getCookie("cookie");
                ILog.i("remind","cookie1==>" + cookie1);
//                MyController.getInstance().getHmConfigXML().save("cookie",cookie);
            }
            return originalResponse;
        }
    }

    public JSONObject getBaseHeader(){
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("appVersion","1.0");
            jsonObject.put("deviceVersion","10");
            jsonObject.put("deviceModel","Android");
            jsonObject.put("appChannel","10000");
            jsonObject.put("timestamp",HMApiServiceImpl.time + "");
            jsonObject.put("debug","false");
            return jsonObject;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}
