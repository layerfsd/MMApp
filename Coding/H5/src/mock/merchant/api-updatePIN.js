'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/updatePIN',
    response: function (req, res) {
    	console.log(req.body.dataEntity);
    	let sessionToken = req.body.dataEntity.sessionToken; //sessionToken
    	let intitialPIN = req.body.dataEntity.intitialPIN; //旧PIN
    	let newPIN = req.body.dataEntity.newPIN; //新PIN
    	if(sessionToken=='12345678abcd'){
	    	if(intitialPIN == '111111' &&newPIN=='111111') {
		    	setTimeout(function() {
			        res.json({
			        	ret_code: '999999',
			        	ret_msg: '新旧PIN码不能相同',
			            data_entity: {
			            	resetPINFlag: '2' //失败
			            }
			        });
			     }, WAIT_MS);
	    	} else if(intitialPIN == '111111' &&newPIN=='222222') {
		    	setTimeout(function() {
			        res.json({
			        	ret_code: '10000',
			        	ret_msg: '请求成功',
			            data_entity: {
			            	resetPINFlag: '1' //成功
			            }
			        });
			     }, WAIT_MS);
	    	}else {
	    		setTimeout(function() {
			        res.json({
			        	ret_code: '999999',
			        	ret_msg: '系统错误',
			            data_entity: {}
			        });
			     }, WAIT_MS);
    		}      
    	}else{
    		setTimeout(function() {
		        res.json({
		        	ret_code: '999999',
		        	ret_msg: '系统错误(用户唯一标识错误)',
		            data_entity: {}
		        });
		    }, WAIT_MS);
    	}
    }
};
