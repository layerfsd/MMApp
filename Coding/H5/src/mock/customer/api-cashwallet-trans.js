'use strict';
const WAIT_MS = 2000;

const cashwalletTrans = [
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-02',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-03',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-04',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-06',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-07',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-08',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-09',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-10',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-02',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-03',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-04',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-06',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-07',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-08',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-09',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-10',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-02',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-03',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-04',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-06',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-07',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-08',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-09',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-10',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-02',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-03',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-04',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-06',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-07',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-08',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-09',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2015',
					week: 'Friday',
					date: '01-10',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				},
				{
					month:'January',
					year: '2020',
					week: 'Friday',
					date: '01-20',
					src: '',
					money: '$21.20',
					merchant: '7-Eleven'
				}
			];

module.exports = {
    api: '/api/cashwallet/trans',
    response: function (req, res) {
    	console.log(req.body);
	    let start = req.body.dataEntity.start;
	    let last = start + req.body.dataEntity.limit;

    	setTimeout(function() {
	        res.json({
	        	ret_code: '10000',
	        	ret_msg: '请求成功',
	            data_entity:
		    	{
		    		result: cashwalletTrans.slice(start, last)
		    	}
	        });
	     }, WAIT_MS);
    }
}
