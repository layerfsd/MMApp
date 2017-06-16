import {Indicator, MessageBox, Toast} from 'mint-ui'
export default{
    install(Vue){
        /**
         * 弹出提示框
         * @param  {String}   message  提示信息
         * @param  {Function} callback 点击按钮回调函数，index为 1
         * @param  {String}   okTitle  按钮文本，默认确定
         * @return 无
         */
        Vue.prototype.showAlert = function(message, callback, okTitle='Ok'){
            MessageBox({
                title: " ",
                message: message,
                confirmButtonText: okTitle,
            }).then(action =>{
                console.log('action', action);
                if(typeof callback === 'function'){
                    callback(1);
                }
            });
        },

        /**
         * 弹出确认取消框
         * @param  {String}   message     提示信息
         * @param  {Function} callback    回调函数，取消 0 确定 1
         * @param  {String}   okTitle     确定文本
         * @param  {String}   cancelTitle 取消文本
         * @return
         */
        Vue.prototype.showConfirm = function(message, callback, okTitle='action_弹窗按钮_确定', cancelTitle='action_弹窗按钮_取消'){
        	this.Vue=Vue;
            MessageBox({
                title: " ",
                message: message,
                confirmButtonText: this.Vue.t(okTitle),
                cancelButtonText: this.Vue.t(cancelTitle),
                showCancelButton: true,
            }).then(action =>{
                console.log('action', action);
                if(typeof callback === 'function'){
                    var index = 1;
                    if(action == 'cancel'){
                        index = 0;
                    }
                    callback(index);
                }
            });
        },
        
        /**
         * 显示等待框
         * @param  {String} text 提示文字，默认为空
         * @param  {String} type 提示框的样式  snake fading-circle double-bounce triple-bounce
         * @return 无
         */
        Vue.prototype.showIndicator = function(text, type ='snake'){
            Indicator.open({
              text: text,
              spinnerType: type,
            });
        },

        /**
         * 隐藏等待框
         * @return 无
         */
        Vue.prototype.hideIndicator = function(){
            Indicator.close();
        },

        Vue.prototype.showToast = function(message, position = 'middle', iconClass, duration='2000',className='toast'){
            let instance = Toast({
                message: message,
                position: position,
                iconClass: iconClass,
                duration: duration,
                className: className
            });
            return instance;
        }


    }
}