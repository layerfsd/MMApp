//
//  MainViewController.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "MainViewController.h"
#import "JGDeviceHelper.h"
#import "JGLocationHelper.h"
#import "SetGesturePwdVC.h"
#import "CheckGesturePwdVC.h"
#import "JGDeviceHelper.h"
#import "HThreadHelper.h"
#import "JGPreferences.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "JGSubViewController.h"

@interface MainViewController () <JGLocationHelperDelegate, SetGesturePwdVCDelegate, CheckGesturePwdVCDelegate>
@property WVJBResponseCallback responseCallback;
@property (nonatomic,strong) JGLocationHelper *locationHelper;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//注册JavaScript可调用的函数
- (void)registerNativeHandles
{
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [self.bridge registerHandler:@"deviceModel" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"iOS");
    }];
    
    [self.bridge registerHandler:@"deviceId" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([JGDeviceHelper getDeviceId]);
    }];

    [self.bridge registerHandler:@"deviceIP" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([JGDeviceHelper getDeviceIP]);
    }];
    
    [self.bridge registerHandler:@"deviceOSVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([JGDeviceHelper getIOSVersion]);
    }];
    
    //取当前经纬度及地址
    //返回： {ret: longitude: latitude: address: }
    //ret: 0 成功，其它失败
    //longitude: 经度
    //latitude: 纬度
    //address: 地址
    [self.bridge registerHandler:@"getLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        self.locationHelper = [[JGLocationHelper alloc]init];
        self.locationHelper.delegate = self;
        [self.locationHelper startGetLocation];
    }];
    
    //设置手势密码
    //传入参数: {phone: }
    //传出参数: {ret: phone: device_id: guesture_pwd: }
    //
    [self.bridge registerHandler:@"setGesturePassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        //NSDictionary *dict = (NSDictionary *)data;
        SetGesturePwdVC *vc = [[SetGesturePwdVC alloc]init];
        vc.delegate=self;
        [self pushViewController:vc animated:YES];
    }];
    
    //验证手势密码
    //传入参数: { }
    //传出参数: {ret: device_id: guesture_pwd: }
    //
    [self.bridge registerHandler:@"checkGesturePassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        //NSDictionary *dict = (NSDictionary *)data;
        //SetGesturePwdVC *vc = [[SetGesturePwdVC alloc] initWithPhoneNum:dict[@"phone"]];
        SetGesturePwdVC *vc = [[SetGesturePwdVC alloc] init];
        vc.delegate=self;
        [self pushViewController:vc animated:YES];
    }];
    
    //验证手势密码
    //传入参数: { }
    //传出参数: {ret: message: guesture_pwd: }
    //ret: -1 失败
    //      2 选择密码登录
    //      0 成功
    //message: 失败原因
    [self.bridge registerHandler:@"checkGesturePassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        CheckGesturePwdVC *vc = [[CheckGesturePwdVC alloc] init];
        vc.delegate=self;
        [self pushViewController:vc animated:YES];
    }];
    
    //设置指纹
    //传入参数: { }
    //传出参数: {ret: message: device_id:}
    //ret: -1 失败
    //      0 成功
    //message: 失败原因
    [self.bridge registerHandler:@"setFingerprintPassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        [self setFingerprintPassword];
    }];
    
    //验证指纹
    //传入参数: { }
    //传出参数: {ret: message: device_id:}
    //ret: -1 失败
    //      0 成功
    //message: 失败原因
    [self.bridge registerHandler:@"checkFingerprintPassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        [self checkFingerprintPassword];
    }];
    
    
    //在新页面打开url
    //传入参数: {url: }
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"newPageWithURL" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        JGSubViewController *vc = [[JGSubViewController alloc]initWithUrl:dict[@"url"]];
        [self pushViewController:vc animated:YES];
        self.responseCallback(@{ @"ret":@"0" });
        
    }];
    
    //关闭当前页面
    //传入参数: {}
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"closePage" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        if ([self isKindOfClass:[JGSubViewController class]]) {
            [self popViewControllerAnimated:YES];
        }
        self.responseCallback(@{ @"ret":@"0" });
        
    }];

}


//启动web页面
- (void)loadWebPage:(UIWebView*)webView
{
    [self loadLocalPage:webView pageName:@"index" ofType:@"html"];
    //[self loadRemotePage:webView remoteURLStr:@"http://192.168.43.153:8080/modules/appserver.html"];
}


#pragma -mark JGLocationHelperDelegate
- (void)locationHelper:(JGLocationHelper *)helper
    didGetlocationLong:(NSString *)locationLong locationLat:(NSString *)locationLat address:(NSString *)address
{
    //返回
    self.responseCallback(@{ @"ret":@"0", @"longitude":locationLong, @"latitude":locationLat, @"address":address });

}

- (void)locationHelper:(JGLocationHelper *)helper
      didFailWithError:(NSError *)error
{
    //返回失败
    self.responseCallback(@{ @"ret":@"-1" });

}

#pragma -mark SetGesturePwdVCDelegate
-(void)setGesturePwdVC:(SetGesturePwdVC *)setGesturePwdVC result:(BOOL)result
                passwd:(NSString *)passwd
{
    if (!result) {
        //返回失败
        self.responseCallback(@{ @"ret":@"-1" });
        return;
    }
    //返回
    self.responseCallback(@{ @"ret":@"0", @"device_id":[JGDeviceHelper getDeviceId], @"guesture_pwd":passwd });
}

#pragma mark --CheckGesturePwdVCDelegate
-(void)checkGesturePwdVC:(CheckGesturePwdVC *)checkGesturePwdVC didFinishWithResult:(BOOL)result password:(NSString *)password
{
    if (result) {
        self.responseCallback(@{ @"ret":@"0", @"message":@"手势密码登陆成功", @"guesture_pwd": password});
    }else{
        self.responseCallback(@{ @"ret":@"-1", @"message":@"验证手势失败"});
    }
    [checkGesturePwdVC popViewControllerAnimated:YES];
    
}

-(void)checkGesturePwdVCChangeToPwdLogin:(CheckGesturePwdVC *)checkGesturePwdVC
{
    //返回选择密码登录
    self.responseCallback(@{ @"ret":@"2", @"message":@"选择密码登陆" });
    
}

-(void)checkGesturePwdVCReturn:(CheckGesturePwdVC *)checkGesturePwdVC
{
    //返回失败
    self.responseCallback(@{ @"ret":@"-1", @"message":@"取消手势密码验证" });
    
}


#pragma mark -- Fingerprint methods
//设置指纹
-(void)setFingerprintPassword
{
    LAContext *context = [LAContext new];
    NSError *error;
    context.localizedFallbackTitle = @"公积金安全验证";
    if ([[JGDeviceHelper getIOSVersion]floatValue] < 8.0) {
        self.responseCallback(@{ @"ret":@"-1", @"message":@"设备当前系统过低" });
    }else{
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:context.localizedFallbackTitle reply:^(BOOL success, NSError * _Nullable error) {
                NSString *deviceId = [JGDeviceHelper getDeviceId];
                if (success) {
                    [HThreadHelper H_enqueueMainThreadPool:^{
                        [JGPreferences setFingerprintStateData:context.evaluatedPolicyDomainState];
                        self.responseCallback(@{ @"ret":@"0", @"message":@"指纹验证成功", @"device_id": deviceId });
                    }];
                }else{
                    [HThreadHelper H_enqueueMainThreadPool:^{
                        NSInteger code=error.code;
                        if(code==LAErrorSystemCancel){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"系统取消授权"});
                        }else if(code==LAErrorUserCancel){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"用户取消授权"});
                        }else if(code==LAErrorPasscodeNotSet){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"未设置指纹"});
                        }else if(code==LAErrorTouchIDNotAvailable || code==LAErrorTouchIDNotEnrolled){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"设备指纹不可用"});
                        }else if (code == LAErrorAuthenticationFailed){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"指纹识别失败"});
                        }
                    }];
                }
            }];
        }else{
            self.responseCallback(@{ @"ret":@"-1", @"message":@"设备不支持TouchID"});
        }
    }
}

//验证指纹
-(void)checkFingerprintPassword
{
    LAContext *context = [LAContext new];
    NSError *error;
    context.localizedFallbackTitle = @"公积金安全验证";
    if ([[JGDeviceHelper getIOSVersion]floatValue] < 8.0) {
        self.responseCallback(@{ @"ret":@"-1", @"message":@"设备当前系统过低" });
    }else{
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
            //判断指纹库是否发生了改变
            NSData *oldStateData = [JGPreferences getFingerprintStateData];
            if (![context.evaluatedPolicyDomainState isEqualToData:oldStateData]) {
                self.responseCallback(@{ @"ret":@"1", @"message":@"指纹库发生改变，请重新登陆"});
            }else{
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:context.localizedFallbackTitle reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        //识别成功回到主线程更新UI
                        [HThreadHelper H_enqueueMainThreadPool:^{
                            self.responseCallback(@{ @"ret":@"0", @"message":@"指纹验证成功"});
                        }];
                    }else{
                        //识别失败
                        //完成后在回调给js
                        NSInteger code=error.code;
                        if(code==LAErrorSystemCancel){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"系统取消授权"});
                        }else if(code==LAErrorUserCancel){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"取消指纹设置"});
                        }else if(code==LAErrorPasscodeNotSet){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"未设置指纹"});
                        }else if(code==LAErrorTouchIDNotAvailable || code==LAErrorTouchIDNotEnrolled){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"设备指纹不可用"});
                        }else if(code == LAErrorAuthenticationFailed){
                            self.responseCallback(@{ @"ret":@"-1", @"message":@"指纹识别失败"});
                        }
                    }
                }];
            }
        }else{
            self.responseCallback(@{ @"ret":@"-1", @"message":@"设备不支持TouchID"});
        }
    }
}

@end
