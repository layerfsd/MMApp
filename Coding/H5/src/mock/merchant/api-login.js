'use strict';
const WAIT_MS = 1000;

module.exports = {
    api: '/api/merchant/login',
    response: function(req, res) {
        let reqData = req.body.dataEntity; //请求数据
        let phone = reqData.phone; //手机号
        let password = reqData.password; //密码
        let imei = reqData.imei //设备号
        if (phone === '1' && password === '1' && imei === 'iphone6s') {
	        /*
	        	手机号：18712344321
	        	密码：111111
	        	设备号：abc123
	        	状态：已激活，绑定状态一致
	         */

            setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        isActivate: '1', //0未激活 1已激活
                        bindState: '0', //是否换设备0 否 1 是
                        sessionToken: '12345678abcd'
                    }
                });
            }, WAIT_MS);

        }else if (phone === '2' && password === '1' && imei === 'iphone6s') {
	        /*
	        	手机号：18712344321
	        	密码：111111
	        	设备号：abc123
	        	状态：已激活，绑定状态不一致
	         */

            setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        isActivate: '1', //0未激活 1已激活
                        bindState: '1', //是否换设备0 否 1 是
                        sessionToken: '12345678abcd'
                    }
                });
            }, WAIT_MS);

        }else if(phone === '3' && password === '1' && imei === 'iphone6s'){
        	/*
	        	手机号：13544284627
	        	密码：111111
	        	设备号：abc123
	        	状态：未激活，绑定状态一致
	        */
	        
	        setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        isActivate: '0', //0未激活 1已激活
                        bindState: '0', //是否换设备0 否 1 是
                    }
                });
            }, WAIT_MS);

        }else if(phone === '4' && password === '1' && imei === 'iphone6s'){
        	/*
	        	手机号：13544284629
	        	密码：111111
	        	设备号：abc124
	        	状态：未激活，绑定状态不一致
	        */
	       
	       setTimeout(function() {
                res.json({
                    ret_code: '000000',
                    ret_msg: '请求成功',
                    data_entity: {
                        isActivate: '0', //0未激活 1已激活
                        bindState: '1', //是否换设备0 否 1 是
                    }
                });
            }, WAIT_MS);
        }else {
        	// 错误请求
        	setTimeout(function() {
                res.json({
                    ret_code: '999999',
                    ret_msg: '手机号或者密码错误',
                    data_entity: {}
                });
            }, WAIT_MS);
        }
    }
};
