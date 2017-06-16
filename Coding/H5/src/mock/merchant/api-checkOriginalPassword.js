'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/queryOriginalPassword',
    response: function (req, res) {
    	console.log(req.body.dataEntity)
    	let initialPassword = req.body.dataEntity.initialPassword; //验证码
    	if(initialPassword == '111111') {
    		// 验证码通过
	    	setTimeout(function() {
		        res.json({
		        	ret_code: '000000',
		        	ret_msg: '请求成功',
		            data_entity: {
		            	successfulFlag: '1' //成功
		            }
		        });
		     }, WAIT_MS);
    	} else {
    		// 验证码不通过
    		setTimeout(function() {
		        res.json({
		        	ret_code: '999999',
		        	ret_msg: '验证码错误',
		            data_entity: {}
		        });
		     }, WAIT_MS);
    	}                                                      
    }
};