//
//  BaseWebVC.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "BaseWebVC.h"

@interface BaseWebVC () <UIWebViewDelegate>
@property WVJBResponseCallback responseCallback;
@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

//注册JavaScript可调用的函数
- (void)registerNativeHandles
{

}

//启动web页面
- (void)loadWebPage:(UIWebView*)webView
{
    //[self loadLocalPage:webView pageName:@"index" ofType:@"html"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    //注册JavaScript可调用的函数
    [self registerNativeHandles];
    
    //[_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
    [self loadWebPage:webView];
}

//加载本地网页
- (void)loadLocalPage:(UIWebView*)webView pageName:(nullable NSString *)pageName ofType:(nullable NSString *)ofType
{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:pageName ofType:ofType];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

//加载远程网页
- (void)loadRemotePage:(UIWebView*)webView remoteURLStr:(nullable NSString *)remoteURLStr
{
    NSURL *url = [NSURL URLWithString:remoteURLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}


@end
