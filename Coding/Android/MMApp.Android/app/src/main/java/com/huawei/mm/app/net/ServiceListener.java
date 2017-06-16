package com.huawei.mm.app.net;


/**
 * 操作监听器,观察动作执行返回
 *
 * @author Remind
 */
public interface ServiceListener {

    /**
     * 执行回调标示
     */
    public enum ActionTypes {
    }

    /**
     * 执行动作成功
     *
     * @param action    当前操作
     * @param returnObj 返回对象
     */
    void serviceSuccess(ActionTypes action, Object bandObj, Object returnObj);

    /**
     * 执行动作失败
     *
     * @param action    当前操作
     * @param returnObj 返回对象
     */
    void serviceFailure(ActionTypes action, Object returnObj, String msg);

    /**
     * 处理非网络响应
     *
     * @param action
     * @param type
     * @param returnObj
     */
    void serviceCallback(ActionTypes action, int type, Object returnObj);

}
