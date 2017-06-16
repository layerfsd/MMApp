'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/changeLoginPassword',
    response: function (req, res) {

    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity: {
	            	successfulFlag: '1' //成功
	            }
	        });
	     }, WAIT_MS);
    }
};
