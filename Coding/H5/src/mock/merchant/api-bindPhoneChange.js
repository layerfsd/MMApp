'use strict';
const WAIT_MS = 2000;

module.exports = {
    api: '/api/merchant/bindPhoneChange',
    response: function (req, res) {
    	let reqData = req.body.dataEntity;
    	console.log(reqData);
    	let phone = reqData.phone; //手机号
    	let imei = reqData.imei; //设备号
    	let phoneModel = reqData.phoneModel //机型
    	let phoneSystem = reqData.phoneSystem //操作系统
    	let pushToken = reqData.pushToken //

    	if (imei === 'iphone6s') {
	        /*
	        	手机号：13544284625
	        	设备号：iphone5
	        	状态：已激活
	         */

            setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        adminStatus: '1', //0未激活 1已激活
                        sessionToken: '12345678abcd'
                    }
                });
            }, WAIT_MS);

        }else if (imei === 'iphone6s') {
	        /*
	        	手机号：13544284626
	        	设备号：iphone6s
	        	状态：未激活
	         */

            setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        customerStatus: '0', //0未激活 1已激活
                    }
                });
            }, WAIT_MS);

        }else {
    		//异常
    		setTimeout(function() {
		        res.json({
		        	ret_code: '-000000',
		        	ret_msg: '网络异常',
		            data_entity: {}
		        });
		     }, WAIT_MS);
    	}
    }
};
