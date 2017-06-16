package com.huawei.mm.app;

import com.huawei.mm.app.net.BaseResp;

import org.json.JSONObject;

import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Query;

/**
 * @author Remind.jiang
 *         date on 2017/3/8.
 */

public interface HMApiService {

    @GET("mGate/user/requestAPI.do")
    Call<BaseResp<String>> testTransportKey(@Query("transportKey") String transportKey, @Query("requestBoby") String requestBoby, @Query("requestIv") String requestIv);

    @GET("mGate/user/requestAPI.do")
    Call<BaseResp<String>> testContent(@Query("id") String content);

    @FormUrlEncoded
    @POST("mGate/user/requestAPI.do")
    Call<BaseResp<JSONObject>> login(@Field("body") String body);
}
