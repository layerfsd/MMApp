'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/authentication',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity: {
	            	customerStatus: '0' //0未激活 1已激活
	            }
	        });
	     }, WAIT_MS);
    }
};
