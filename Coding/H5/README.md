# MMApp

> 华为MMApp project

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

http://localhost:8080/appcustomer.html
http://localhost:8080/appmerchant.html

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

# 国际化
包含message，复数的国际化
https://kazupon.github.io/vue-i18n/started.html

# 日期格式化
http://momentjs.com/docs/#/parsing/string/
format格式：
LL: 2017年3月14日
LLL: 2017年3月14日下午2点18分
LLLL: 2017年3月14日星期二下午2点19分
locales
zh-cn: 简体
zh-hk: 繁体

#安装node-sass
SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/ npm install node-sass --save-dev


# 解决跨域问题
1.config/index.js里设置proxyTable，如果请求的url是/api/user/requestAPI, 会转成http://192.168.1.176:8080/user/requestAPI

``` bash
proxyTable: {
        '/api': {
            target: 'http://192.168.1.145:8080',
            changeOrigin: true,
            pathRewrite: {
              '^/api': '/'
            }
       }

    },
```

# REM说明
1.视觉稿按750px设计，px转换成rem，1rem=75px, 25px=0.333rem
2.字体不需要用rem，字体在base.less里统一定义，其它地方引用，字体定义如下：
``` javascript
@hm-font-size-xxs:               11px;    //小三号
@hm-font-size-xs:                13px;    //小二号
@hm-font-size-sm:                15px;    //小一号
@hm-font-size-base:              17px;    //正常
@hm-font-size-lg:                20px;    //大一号
@hm-font-size-xl:                24px;    //大二号
@hm-font-size-xxl:               32px;    //大三号
```
3.需要根据屏幕尺寸进行拉伸的，如图片，margin等，需要用rem

# 无限滚动infinite-scroll
1.参考pages/cash-wallet/cash.vue
2.数据通过调用server-api.js里的接口实现，模拟数据在mock/service-api.js里
3.如果要用mock，需要把config/index.js里的proxyTable注释掉

# 关于session
1.在store里保存了session，内容{token:  , expired: }, 目前没有对expired进行判断。token是服务端在登录时返回的，返回后记录在store里，同时会记录到localStorage里
2.在router.beforeEach里，每一次跳转，会检查session，如果token为空，则表示session无法，会跳转到login页面。
3.在调用server-api接口时，会对session产生影响，如果服务端返回session无效（CODE_INVALIDE_SESSION_TOKEN），则会清除本地的session值
4.调用server-api时，如果发现session无效，会跳转到login页面，login成功后，会跳转回home页面
5.调用server-api的接口说明：
```javascript
apiFunc(data, option, callback);

data: 请求数据
option: {
toLoginIfInvalidSession:    session无效是否要跳转到login，默认值True
returnToPage:               login成功后再跳转回的页面，默认是/home    
}
callback: function(error, dataEntity, wentLogin)
error: {
    code:   错误码，如果是CODE_INVALIDE_SESSION_TOKEN，表示session无效
    message:  错误信息
}
dataEntity: 响应的数据
wentLogin:  是否已经跳转到login页面，如果是true，表示已经跳转到login页面
```
例子参见：me.vue

# 关于页面状态保持
1. 每一个page模版，要有一个name
2. 要beforeCreate里，要调用store将页面添加到缓存里，例子如下：
```javascript
export default {
    name: 'my-qr-code',
    components: {
        NavHeader
    },
    //创建之前
    beforeCreate(){
        //添加到缓冲机制中
        this.$store.dispatch('pushKeepAlive', 'my-qr-code');
    }
};
```
3. 页面返回是会删除缓存，已经在nav-header导航模版里处理了。
4. 如果要在程序里进行页面返回处理，可以参见qr-pay/set-amount.vue里的例子
    goBack(){
        //消除多余的页面缓存
        this.$store.dispatch('popKeepAliveTo', "my-qr-code");
        //如果不知道回退多少级，就用这条语句
        //this.$router.replace({path:'/my-qr-code'});
        //如果知道回退多少级，就用这条语句
        this.$router.go(-2);
    }, 


# 关于页面不缓存问题
1. 在deactivated方法里把data置空

# 关于沉浸式状态问题
1. 在nav-header里已经进行了处理，如果支持沉浸式状态，预留了状态栏的高度。没有用nav-header的页面，要自己加。可参考home.vue
```javascript
v-bind:class="{ 'top-status': this.$root.supportTranslucentStatus}"
```

2. 设置状态栏文字的颜色，有两种：浅色和深色，在activated和beforeMount里加。
```javascript
        activated: function () {
            //设置沉浸式状态栏
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleLight();
            }
        },
        beforeMount: function () {
            //设置沉浸式状态栏
            if (this.$root.supportTranslucentStatus) {
                this.$root.setStatusStyleLight();
            }
        },
```
3. 浏览器模式下this.$root.supportTranslucentStatus的默认值为true

# 关于通过router-link传参数的方法：
1.通过router-link传参数的方法：
```javascript
<router-link :to="{path: '/Electricity', query: {bill_type: 'electric'}}" slot="right">
```
2.访问传入参数的方法：
```javascript
this.$route.query.bill_type
```

# 关于打包
1. 只打包一个app，需要修改以下文件：
webpack.base.conf.js
var entries = getEntry('./src/apps/*/*.js'); // 获得入口js文件
改为：
var entries = getEntry('./src/apps/*/applocal.js'); // 获得入口js文件

webpack.prod.conf.js
var pages = getEntry('./src/apps/*/*.html');
改为
var pages = getEntry('./src/apps/*/applocal.html');

2. 将img低于50Kb的文件转换为base64
webpack.base.conf.js
    {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url-loader',
        query: {
          limit: 50000,
          name: utils.assetsPath('img/[name].[hash:7].[ext]')
        }
    },
改为
    {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url-loader',
        query: {
          limit: 30000,
          name: utils.assetsPath('img/[name].[hash:7].[ext]')
        }
    },
3. config/index.js里
```javascript
assetsPublicPath: '/'
改为
assetsPublicPath: './'
```
