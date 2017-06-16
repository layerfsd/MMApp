'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/homeInfo',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity:
		    	{
		    		headPortrait: ('/static/assets/images/7-Eleven_3x.png'),//头像
		            income: '2900.00',
		            currency: '1', //币种
		            cardPayFlag: '1',
		            withdrawFlag: '1',
		            activationFlag: '1',
		            newsFlag: '1',
		            changePINFlag: '1',
		            registeredFlag: '1',
		            myAccountFlag: '1',
		            settingsFlag: '1',
		            cardPayStatus: '1',
		            activationStatus: '1',
		            messagesFlag: '1' //0 无新消息  1 有新消息

		    	}
	        });
	     }, WAIT_MS);
    }
};
