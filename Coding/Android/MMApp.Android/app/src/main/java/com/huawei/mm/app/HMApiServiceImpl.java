package com.huawei.mm.app;

import com.google.gson.Gson;
import com.huawei.mm.app.encrypt.HMEncryptApi;
import com.huawei.mm.app.encrypt.HMKeyGenerator;
import com.huawei.mm.app.encrypt.HMMD5Utils;
import com.huawei.mm.app.net.BaseResp;
import com.huawei.mm.app.net.RetrofitUtil;
import com.huawei.mm.app.util.ILog;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

import retrofit2.Call;
import retrofit2.http.HeaderMap;

/**
 * @author Remind.jiang
 *         date on 2017/3/8.
 */

public class HMApiServiceImpl {

    public static String md5Values = "";
    public static String pbkdf2Values = "";
    public static long time;

    public void testTransportKey(@HeaderMap Map<String, String> headers, String transportKey, String body, String iv){
        HMApiService testService = RetrofitUtil.getInstance().getAPIService(HMApiService.class);
        Call<BaseResp<String>> call = testService.testTransportKey(transportKey,body,iv);
        RetrofitUtil.getInstance().enqueueCall(call, new RetrofitUtil.RetrofitCallBack<String>() {
            @Override
            public void onSuccess(BaseResp<String> baseResp) {
                ILog.i("remind","baseResp==>" + baseResp.getData());
            }

            @Override
            public void onFailure(String error) {
                ILog.e("remind","error==>" + error);
            }
        });
    }

    public void testContent(@HeaderMap Map<String, String> headers,String content){
        HMApiService testService = RetrofitUtil.getInstance().getAPIService(HMApiService.class);
        Call<BaseResp<String>> call = testService.testContent(content);
        RetrofitUtil.getInstance().enqueueCall(call, new RetrofitUtil.RetrofitCallBack<String>() {
            @Override
            public void onSuccess(BaseResp<String> baseResp) {
                ILog.i("remind","baseResp==>" + baseResp.getData());
            }

            @Override
            public void onFailure(String error) {
                ILog.e("remind","error==>" + error);
            }
        });
    }

    public void login(Login login){

        Gson gson=new Gson();
        JSONObject data = new JSONObject();

        JSONObject result = new JSONObject();
        String route= gson.toJson(login);//通过Gson将Bean转化为Json字符串形式
        time = System.currentTimeMillis();
        try {
            result.put("phone",login.getPhone());
            data.put("header",RetrofitUtil.getInstance().getBaseHeader());
            data.put("dataEntity",result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        String dataAes = HMEncryptApi.encryptAESData(data.toString(), MyController.getInstance().getPayloadKey());
//        RequestBody body = RequestBody.create(okhttp3.MediaType.parse("application/json; charset=utf-8"),data.toString());

        HMApiService testService = RetrofitUtil.getInstance().getAPIService(HMApiService.class);
        md5Values = HMMD5Utils.MD5(data.toString() + time);
        pbkdf2Values = HMKeyGenerator.encryptPBKDF2(data.toString() + time, MyController.getInstance().getPayloadKey());
        Call<BaseResp<JSONObject>> call = testService.login(dataAes);

//        call.enqueue(new Callback<JSONObject>() {
//            @Override
//            public void onResponse(Call<JSONObject> call, Response<JSONObject> response) {
//                ILog.i("remind","code==>" + response.code());
//                ILog.i("remind","response==>" + response.body().toString());
//            }
//
//            @Override
//            public void onFailure(Call<JSONObject> call, Throwable t) {
//                ILog.i("remind","error==>" + t.toString());
//            }
//        });

        RetrofitUtil.getInstance().enqueueCall(call, new RetrofitUtil.RetrofitCallBack<JSONObject>() {
            @Override
            public void onSuccess(BaseResp<JSONObject> baseResp) {

            }

            @Override
            public void onFailure(String error) {

            }
        });
    }

}
