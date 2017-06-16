'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/forgotPassword',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity: {}
	        });
	     }, WAIT_MS);
    }
};
