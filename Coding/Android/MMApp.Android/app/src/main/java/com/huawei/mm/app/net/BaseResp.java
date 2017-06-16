package com.huawei.mm.app.net;

import java.io.Serializable;

/**
 * 返回数据基类
 * 
 * @author Remind.jiang
 * 
 */
public class BaseResp<T> {
	private T data;
	private Head head;

	public Head getHead() {
		return head;
	}

	public void setHead(Head head) {
		this.head = head;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	class Head implements Serializable {
		private String msg;
		private String success;

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

		public String getSuccess() {
			return success;
		}

		public void setSuccess(String success) {
			this.success = success;
		}

		@Override
		public String toString() {
			final StringBuffer sb = new StringBuffer("Head{");
			sb.append("msg='").append(msg).append('\'');
			sb.append(", success='").append(success).append('\'');
			sb.append('}');
			return sb.toString();
		}
	}

	@Override
	public String toString() {
		final StringBuffer sb = new StringBuffer("BaseResp{");
		sb.append("data=").append(data);
		sb.append(", head=").append(head);
		sb.append('}');
		return sb.toString();
	}
}
