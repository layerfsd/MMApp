'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/register',
    response: function (req, res) {
    	let reqData = req.body.dataEntity;
    	let phone = reqData.phone;//手机号
    	let password = reqData.password; //密码
    	let imei = reqData.imei; //设备号
    	let phoneModel = reqData.phoneModel; //机型
    	let phoneSystem = reqData.phoneSystem; //手机系统
    	let pushToken = reqData.pushToken; //
    	let satefyProblem = reqData.satefyProblem;//密保问题
    	let answer = reqData.answer;//密保答案
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity:
		    	{
		    		status:  '0', //0: 未注册  1：已注册
		    	}
	        });
	    }, WAIT_MS);
    }
};
