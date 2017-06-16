'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/securityRecordRandom',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity: {
	            	satefyProblemNum: '1,2',
	            	resetSecurityFlag: '1' //修改密保开关 1 开 	2关
	            }
	        });
	     }, WAIT_MS);
    }
};
