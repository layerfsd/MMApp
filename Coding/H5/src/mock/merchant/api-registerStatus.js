'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/registerStatus',
    response: function (req, res) {
    	let reqData = req.body.dataEntity;
    	let phone = reqData.phone; //手机号
    	if(phone === '13544284627' || phone === '13544284628' || phone === '13544284629' || phone === '13544284630'){
    		//已注册
	    	setTimeout(function() {
		        res.json({
		        	ret_code: '000000',
		        	ret_msg: '请求成功',
		            data_entity:
			    	{
			    		status:  '1'//0：未注册  1：已注册
			    	}
		        });
		     }, WAIT_MS);
    	}else {
    		//未注册
    		setTimeout(function() {
		        res.json({
		        	ret_code: '000000',
		        	ret_msg: '请求成功',
		            data_entity:
			    	{
			    		status:  '0'//0：未注册  1：已注册
			    	}
		        });
		     }, WAIT_MS);
    	}
    }
};
