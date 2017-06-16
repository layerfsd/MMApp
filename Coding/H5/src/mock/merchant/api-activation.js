'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/activation',
    response: function (req, res) {
    	setTimeout(function() {
	        res.json({
	        	ret_code: '000000',
	        	ret_msg: '请求成功',
	            data_entity:
		    	{
		    		sessionToken: {}
		    	}
	        });
	     }, WAIT_MS);
    }
};
