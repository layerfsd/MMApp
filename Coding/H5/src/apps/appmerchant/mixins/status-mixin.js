/*
 * 状态栏Mixin
 * @Date    : 2017-04-06
 * @Author  : samyu
 * @Version : V1.0
 *
 */
var statusMixin = {
  data() {
    return {
        supportTranslucentStatus: window.supportTranslucentStatus
    }
  },  
  methods: {
    //设置沉浸式状态栏字体颜色为深色
    //须调用原生接口
    setStatusStyleBlack: function () {
        //return;
        //调用原生接口
        console.log("setStatusStyleBlack");
        if (window.device) {
            window.device.setStatusStyleBlack(function(data){
            });
        }
    },
    //设置沉浸式状态栏字体颜色为浅色
    //须调用原生接口
    setStatusStyleLight: function () {
        //return;
        //调用原生接口
        console.log("setStatusStyleLight");
        if (window.device) {
        	window.device.setStatusStyleLight(function(data){
    	    });
        }
    },
  }
}

export default statusMixin