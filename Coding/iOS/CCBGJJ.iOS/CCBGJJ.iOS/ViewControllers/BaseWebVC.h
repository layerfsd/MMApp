//
//  BaseWebVC.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HVC.h"
#import "WebViewJavascriptBridge.h"

@interface BaseWebVC : HVC
@property WebViewJavascriptBridge* bridge;

//注册JavaScript可调用的函数
- (void)registerNativeHandles;
//启动web页面
- (void)loadWebPage:(UIWebView*)webView;

//加载本地网页
- (void)loadLocalPage:(UIWebView*)webView pageName:(nullable NSString *)pageName ofType:(nullable NSString *)ofType;
//加载远程网页
- (void)loadRemotePage:(UIWebView*)webView remoteURLStr:(nullable NSString *)remoteURLStr;

@end
