'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/queryMarchantInfo',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity:
		    	{
		    		headPortrait: ('/static/assets/images/tx1_2x.png'),//头像
		    		operatorName: 'James Harden', //姓名
		    		phone: '13890780821', //手机号
		    		modifyMerchantIconFlag: '1',//修改商户图标开关 1:开  2：关
		    		resetSecurityFlag: '1',//修改密保开关   1:开  2：关
		    		resetLoginPasswordFlag: '1',//修改登录密码开关   1:开  2：关
		    		resetPINFlag: '1',//修改PIN开关    1:开  2：关
		    		passwordFlag: '1',//password开关   1:开  2：关
		    		feedbackFlag: '1',//feedback开关   1:开  2：关
		    		modifyOperatorAvatarFlag: '1'//修改操作员头像开关   1:开  2：关
		    	}
	        });
	     }, WAIT_MS);
    }
};
