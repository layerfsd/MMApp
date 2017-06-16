'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/checkVerificationCode',
    response: function (req, res) {
    	console.log(req.body.dataEntity)
    	let verificationCode = req.body.dataEntity.verificationCode; //验证码
    	if(verificationCode == '111111') {
    		// 验证码通过
	    	setTimeout(function() {
		        res.json({
		        	ret_code: '000000',
		        	ret_msg: '请求成功',
		            data_entity: {
		            	
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
