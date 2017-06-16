// 判断输入的两个值是否相等
export function isEqual(val1, val2) {
    if (val1 === val2) {
        return true;
    }
    return false;
}

//判断是否6位密码
export function checkLength(len1, len2) {
    var reg = /^\d{6}$/;
    if (reg.test(len1) && reg.test(len2)) {
        return true;
    }
    return false;
}

// 日期检查
export function checkBirthday(birthday) {

    //birthday为空或者不为数值
    if (!birthday || isNaN(birthday)) {
        return false;
    }

    // 获取年份
    let year = birthday.substr(0, 2);

    // 获取月份
    let month = birthday.substr(2, 2);

    // 获取天数
    let days = birthday.substr(4, 2);

    // 检查年份
    if (year < 0) {
        return false;
    }

    // 检查月份
    if (month < 0 || month > 12) {
        return false;
    }

    // 检查天数
    if (days < 0 || days > 31) {
        return false;
    }

    // 获取一个时间对象
    let date = new Date();

    // 获取今年年份的后两位
    let thisYear = String(date.getFullYear()).slice(-2);

    // 将year组成一个四位格式的年份
    year = birthday.substr(0, 2) < (+thisYear) ? (String(date.getFullYear()).substr(0, 2) + year) : ((String(date.getFullYear()).substr(0, 1) * 1000 - 100) + (+year)) + '';

    // 将birthday拼成一个yyyy-mm-dd日期格式
    birthday = year + '-' + month + '-' + days;

    console.log('生日:' + birthday);

    // 检查日期是否合法
    return checkDate(birthday);




}


// 检查日期是否合法
// 支持 yyyy-M-d、yyyy-MM-dd、yyyy/M/d、yyyy/MM/dd 四种输入格式。
function checkDate(strInputDate) {
    if (strInputDate == "") return false;
    strInputDate = strInputDate.replace(/-/g, "/");
    var d = new Date(strInputDate);
    if (isNaN(d)) return false;
    var arr = strInputDate.split("/");
    return ((parseInt(arr[0], 10) == d.getFullYear()) && (parseInt(arr[1], 10) == (d.getMonth() + 1)) && (parseInt(arr[2], 10) == d.getDate()));
}

// 检查邮箱
export function checkEmail(email) {

    // 邮箱的正则表达式
    let reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;

    // 检查输入邮箱是否合法
    if (!reg.test(email)) {
        return false;
    }

    return true;
}

// 返回系统当前日期
export function getCurrentDate() {

    let date = new Date();

    //年份
    let year = date.getFullYear();

    // 月份
    let month = date.getMonth() + 1;

    month < 10 && (month = '0' + month);

    // 日期
    let days = date.getDate();

    days < 10 && (days = '0' + days);

    return month + '-' + days + '-' + year;
}

