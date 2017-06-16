//
//  HMBaseWebVC.m
//  MMApp.iOS
//
//  Created by Sam Yu on 3/7/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMBaseWebVC.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface HMBaseWebVC () <UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property WVJBResponseCallback responseCallback;
@end


@implementation HMBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //以下代码可以把statusbar的背景和view的背景合在一起
    //http://stackoverflow.com/questions/25964076/ios-8-top-layout-guide-auto-layout-problems
    
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    //在info.plist里设置UIViewControllerBasedStatusBarAppearance
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //self.automaticallyAdjustsScrollViewInsets=NO;
    
}


- (void)setStatusBarStyleBlack
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setStatusBarStyleLight
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

//不知道为啥没有调用到
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

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
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_webView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:@{@"webView":_webView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:@{@"webView":_webView, @"topGuide":self.topLayoutGuide}]];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    _webView.scrollView.bounces = NO; //不让webview上下滚动
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGFloat barY = navigationBarBounds.size.height - progressBarHeight;
    barY = [[UIApplication sharedApplication] statusBarFrame].size.height; //状态栏高度
    CGRect barFrame = CGRectMake(0, barY, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:_progressView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:_progressProxy];
    
    //注册JavaScript可调用的函数
    [self registerNativeHandles];
    
    //[_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
    [self loadWebPage:_webView];
    
//    [self setNeedsStatusBarAppearanceUpdate];

}

//加载本地网页
- (void)loadLocalPage:(UIWebView*)webView pageName:(nullable NSString *)pageName ofType:(nullable NSString *)ofType
{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:pageName ofType:ofType];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    
    [_progressView removeFromSuperview];
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


#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

@end
