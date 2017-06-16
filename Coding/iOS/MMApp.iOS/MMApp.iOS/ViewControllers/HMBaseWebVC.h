//
//  HMBaseWebVC.h
//  MMApp.iOS
//
//  Created by Sam Yu on 3/7/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HVC.h"
#import "WebViewJavascriptBridge.h"

@interface HMBaseWebVC : HVC
@property WebViewJavascriptBridge* bridge;

//注册JavaScript可调用的函数
- (void)registerNativeHandles;
//启动web页面
- (void)loadWebPage:(UIWebView*)webView;

//加载本地网页
- (void)loadLocalPage:(UIWebView*)webView pageName:(nullable NSString *)pageName ofType:(nullable NSString *)ofType;
//加载远程网页
- (void)loadRemotePage:(UIWebView*)webView remoteURLStr:(nullable NSString *)remoteURLStr;

//设置状态栏的字体颜色为深色
- (void)setStatusBarStyleBlack;
//设置状态栏的字体颜色为浅色
- (void)setStatusBarStyleLight;


@end
