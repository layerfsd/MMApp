import Vue from 'vue';

// 金额格式化
Vue.filter('formatMoney', function(value){
	value = parseFloat((value + "").replace(/[^\d\.-]/g, "")).toFixed(2) + "";
            var left = value.split(".")[0].split("").reverse(),
                right = value.split(".")[1],
            temp = "";
            for (var i = 0; i < left.length; i++) {
                temp += left[i] + ((i + 1) % 3 == 0 && (i + 1) != left.length ? "," : "");
            }
            return temp.split("").reverse().join("") + "." + right;
});

// 币种格式化
Vue.filter('formatCurrency', function(value){
	switch (value) {
        case '1': return '€';
        case '2': return '$';
        case '3': return '￥';
        case '4': return '£';
        case '5': return '₩';
        case '6': return 'NT$';
        case '7': return '฿';
        default: return '';
    }
})

// 格式化手机号码,证件号码,银行卡号,社保卡号
Vue.filter('formatNumber', function(value, num, split){
	if(!Number(num)) num = 4;
	split = split || '-'
	var result = [ ], counter = 0;
    value = (value || 0).toString().split('');
    for (var i = value.length - 1; i >= 0; i--) {
        counter++;
        result.unshift(value[i]);
        if (!(counter % num) && i != 0) { result.unshift(split); }
    }
    return result.join('');
});