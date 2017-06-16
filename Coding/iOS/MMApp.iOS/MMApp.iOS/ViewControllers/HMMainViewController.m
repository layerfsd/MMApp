//
//  HMMainViewController.m
//  MMApp.iOS
//
//  Created by Sam Yu on 3/7/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMMainViewController.h"
#import "HMDeviceHelper.h"
#import "HMLocationHelper.h"
#import "HMSetGesturePwdVC.h"
#import "HMCheckGesturePwdVC.h"
#import "HThreadHelper.h"
#import "HMPreferences.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "HMSubViewController.h"
#import "HMSecurityHelper.h"
#import "HMPasswordTextField.h"
#import <AVFoundation/AVFoundation.h>
#import "HMQRCodeScanningVC.h"
#import "NSData+Base64.h"

#import "JSONKit.h"

@interface HMMainViewController () <HMLocationHelperDelegate, HMSetGesturePwdVCDelegate, HMCheckGesturePwdVCDelegate, UITextFieldDelegate, HMPasswordTextFieldDelegate, HMQRCodeScanningVCVCDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property WVJBResponseCallback responseCallback;
@property (nonatomic,strong) HMLocationHelper *locationHelper;
@property (nonatomic, strong) HMPasswordTextField *pwTextField;

//记录html输入框的Id，方便调用js接口反显文字
@property (nonatomic, strong) NSString *jsInputFieldId;
//记录密文输入框的数据
@property (nonatomic, strong) NSMutableDictionary *jsInputFieldDict;

//记录照片参数
@property (nonatomic, strong) NSString *imageType;
@property float compressionQuality;

@end

@implementation HMMainViewController

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
        responseCallback([HMDeviceHelper getDeviceId]);
    }];
    
    [self.bridge registerHandler:@"deviceIP" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMDeviceHelper getDeviceIP]);
    }];
    
    [self.bridge registerHandler:@"deviceOSVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMDeviceHelper getIOSVersion]);
    }];
    
    [self.bridge registerHandler:@"appVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMDeviceHelper getAppVersion]);
    }];
    
    [self.bridge registerHandler:@"currentLanguageCode" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMDeviceHelper getCurrentLanguageCode]);
    }];

    [self.bridge registerHandler:@"getIMEIFactor" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMSecurityHelper getEncIMEIFactor]);
    }];
    
    [self.bridge registerHandler:@"getTransportKey" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMSecurityHelper getEncTransportKey]);
    }];

    //取一次payloadKey，就会产生一次新的payloadKey
    [self.bridge registerHandler:@"getPayloadKey" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([HMSecurityHelper getEncPayloadKey]);
    }];

    //用payloadKey加密
    [self.bridge registerHandler:@"encryptWithPayloadKey" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = (NSDictionary *)data;
        NSString *source = dict[@"data"];
        NSString *encPayloadKey = dict[@"payloadKey"];
        responseCallback([HMSecurityHelper encryptString:source withEncPayloadKey:encPayloadKey]);
    }];
    
    //弹出密码键盘
    //传入参数: {id:  length:  type:}   id:密码输入框的id， length:密码长度 0:不固定长度  type:密码类型 default默认键盘（数字字母）  digit（数字键盘）
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"popSafeKeyboard" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        
        NSLog(@"data = %@", data);
        NSDictionary *dict = (NSDictionary *)data;
        
        if(self.pwTextField == nil){
            self.pwTextField = [[HMPasswordTextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            self.pwTextField.hmDelegate = self;
            self.pwTextField.delegate = self;
            [self.view addSubview:self.pwTextField];
        }
        self.pwTextField.textMaxLength = [dict[@"length"] intValue];
        if ([dict[@"type"] compare:@"digit"]==0) {
            [self.pwTextField setKeyBoardType:KeyBoradTypeNumber];
        }
        else {
            [self.pwTextField setKeyBoardType:KeyBoradTypeDefault];
        }
        
        //记录输入框的ID
        self.jsInputFieldId = [data objectForKey:@"id"];
        //清空文本内容
        [self.bridge callHandler:@"setJsInputFieldValue" data:[@{@"id":self.jsInputFieldId, @"text":@""} JSONString]];
        
        //弹出键盘
        [self.pwTextField becomeFirstResponder];
        
        self.responseCallback(@{ @"ret":@"0" });
        
    }];
    
    //取密码键盘输入的密码（已用PBKDF2加密）
    //传入参数: {id:  }   id:密码输入框的id
    //传出参数: {ret: value: salt: rounds:}  value:密文数据   salt:盐值  rounds:迭代次数
    //
    [self.bridge registerHandler:@"getEncryptedInput" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        //记录输入框的ID
        NSString *inputId = [data objectForKey:@"id"];
        
        NSDictionary *dict = [self getInputField:inputId];
        
        if(dict != nil){
            self.responseCallback(@{ @"ret":@"0", @"value":dict[@"value"], @"salt":dict[@"salt"], @"rounds":dict[@"rounds"]});
        }else{
            self.responseCallback(@{ @"ret":@"-1"});
        }
    
    }];
    
    //取当前经纬度及地址
    //返回： {ret: longitude: latitude: address: }
    //ret: 0 成功，其它失败
    //longitude: 经度
    //latitude: 纬度
    //address: 地址
    [self.bridge registerHandler:@"getLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        self.locationHelper = [[HMLocationHelper alloc]init];
        self.locationHelper.delegate = self;
        [self.locationHelper startGetLocation];
    }];
    
    //设置手势密码
    //传入参数: {retryLimit:}
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"setGesturePassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        HMSetGesturePwdVC *vc = [[HMSetGesturePwdVC alloc]init];
        vc.delegate=self;
        vc.retryLimit = [dict[@"retryLimit"] intValue];
        [self pushViewController:vc animated:YES];
    }];
    
    //验证手势密码
    //传入参数: { }
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"checkGesturePassword" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        HMCheckGesturePwdVC *vc = [[HMCheckGesturePwdVC alloc] init];
        vc.delegate=self;
        [self pushViewController:vc animated:YES];
    }];
    
    //在新页面打开url
    //传入参数: {url: }
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"newPageWithURL" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        HMSubViewController *vc = [[HMSubViewController alloc]initWithUrl:dict[@"url"]];
        [self pushViewController:vc animated:YES];
        self.responseCallback(@{ @"ret":@"0" });
        
    }];
    
    //关闭当前页面
    //传入参数: {}
    //传出参数: {ret: }
    //
    [self.bridge registerHandler:@"closePage" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        if ([self isKindOfClass:[HMSubViewController class]]) {
            [self popViewControllerAnimated:YES];
        }
        self.responseCallback(@{ @"ret":@"0" });
        
    }];
    
    
    //是否支持沉浸式状态栏
    [self.bridge registerHandler:@"supportTranslucentStatus" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"true");
    }];
    //取状态栏高度(px)
    [self.bridge registerHandler:@"getStatusHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"20");
    }];

    //设置沉浸式状态栏字体颜色为深色
    //传出参数: {ret: }
    [self.bridge registerHandler:@"setStatusStyleBlack" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self setStatusBarStyleBlack];
        responseCallback(@{ @"ret":@"0"});
    }];

    //设置沉浸式状态栏字体颜色为浅色
    //传出参数: {ret: }
    [self.bridge registerHandler:@"setStatusStyleLight" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self setStatusBarStyleLight];
        responseCallback(@{ @"ret":@"0"});
    }];
    
    //扫描二维码
    //传入参数: {canScanPhoto: }  是否允许扫描相片
    //传出参数: {ret: qrcode:}  qrcode为二维码的值
    //
    [self.bridge registerHandler:@"scanQRCode" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        bool canScanPhoto = [dict[@"canScanPhoto"] boolValue];

        [self scanQRCode:canScanPhoto];
    }];
    
    //访问照片库
    //传入参数: {imageType: compressionQuality: }  imageType: png或jpg  compressionQuality: jpg的压缩比，默认是0.7
    //传出参数: {ret: base64Encoded:}  base64Encoded为图片的base64码
    //
    [self.bridge registerHandler:@"pickPhotoFromLibrary" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        NSString *imageType = @"jpg";
        if (dict[@"imageType"]!=nil)
            imageType = dict[@"imageType"];
        float compressionQuality = 0.7;
        if (dict[@"compressionQuality"]!=nil)
            compressionQuality = [dict[@"compressionQuality"] floatValue];
        
        [self pickPhotoFromLibrary:imageType compressionQuality:compressionQuality];
    }];
    
    //拍照片
    //传入参数: {imageType: compressionQuality: }  imageType: png或jpg  compressionQuality: jpg的压缩比，默认是0.7
    //传出参数: {ret: base64Encoded:}  base64Encoded为图片的base64码
    //
    [self.bridge registerHandler:@"takePhoto" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.responseCallback = responseCallback;
        NSDictionary *dict = (NSDictionary *)data;
        NSString *imageType = @"jpg";
        if (dict[@"imageType"]!=nil)
            imageType = dict[@"imageType"];
        float compressionQuality = 0.7;
        if (dict[@"compressionQuality"]!=nil)
            compressionQuality = [dict[@"compressionQuality"] floatValue];
        
        [self takePhoto:imageType compressionQuality:compressionQuality];
    }];
    

}

//启动web页面
- (void)loadWebPage:(UIWebView*)webView
{
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"dist/appmerchant" ofType:@"html"];
//    [self loadRemotePage:webView remoteURLStr:htmlPath];
//    [self loadLocalPage:webView pageName:@"appmerchant" ofType:@"html"];
    [self loadRemotePage:webView remoteURLStr:@"http://192.168.1.157:8088/appmerchant.html#"];
//    [self loadRemotePage:webView remoteURLStr:@"http://192.168.43.153:8080/appdemo.html#/"];
}

//取密码密文数据
- (NSDictionary *)getInputField:(NSString *)fieldId
{
    if(self.jsInputFieldDict != nil){
        return [self.jsInputFieldDict objectForKey:fieldId];
    }
    return nil;
}

//记录密码密文数据，支持多个
- (void)saveInputField:(NSString *)fieldId value:(NSString *)value
{
    if(self.jsInputFieldDict == nil){
        self.jsInputFieldDict = [NSMutableDictionary dictionary];
    }
    
    NSString *encStr;
    
    //用transportKey加密
//    encStr = [HMSecurityHelper encryptString:value];
    
    NSString *salt = [HMSecurityHelper generateSalt256];
    int rounds = 512; //迭代次数，越大时间越长
    encStr = [HMSecurityHelper encryptPassword:value salt:salt rounds:rounds];

    [self.jsInputFieldDict setValue:@{@"value":encStr, @"salt":salt, @"rounds":[NSNumber numberWithInt:rounds]} forKey:fieldId];
}

//删除密码密文数据
- (void)deleteInputField:(NSString *)fieldId
{
    if(self.jsInputFieldDict != nil){
        [self.jsInputFieldDict removeObjectForKey:fieldId];
    }
}

//扫描二维码
- (void)scanQRCode:(bool)canScanPhoto
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        HMQRCodeScanningVC *vc = [[HMQRCodeScanningVC alloc] init];
                        vc.delegate = self;
                        vc.canScanPhoto = canScanPhoto;
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    // 用户第一次同意了访问相机权限
                } else {
                    // 用户第一次拒绝了访问相机权限
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            HMQRCodeScanningVC *vc = [[HMQRCodeScanningVC alloc] init];
            vc.delegate = self;
            vc.canScanPhoto = canScanPhoto;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            //返回失败
            self.responseCallback(@{ @"ret":@"-1", @"message":@"Denied access camera" });
            
        } else if (status == AVAuthorizationStatusRestricted) {
            //返回失败
            self.responseCallback(@{ @"ret":@"-1", @"message":@"Can not access photo album" });
        }
    } else {
        //返回失败
        self.responseCallback(@{ @"ret":@"-1", @"message":@"Can not find camera" });
    }
}

//从照片库选择照片
- (void)pickPhotoFromLibrary:(NSString *)imageType compressionQuality:(float)compressionQuality
{
    UIImagePickerControllerSourceType sourceType;
    //检测设备是否支持照相机,如果不支持sourceType直接赋值为UIImagePickerControllerSourceTypePhotoLibrary
    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.imageType = imageType;
    self.compressionQuality = compressionQuality;
    //[self startIndicatorWithMessage:@"" andCancelCallBack:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:nil];
            //[self stopIndicator];
        });
    });
}

//拍照片
- (void)takePhoto:(NSString *)imageType compressionQuality:(float)compressionQuality
{
    UIImagePickerControllerSourceType sourceType;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        self.responseCallback(@{ @"ret":@"-1", @"message":@"不支持摄像头" });
        //不支持摄像头
        return;
    }
    
    self.imageType = imageType;
    self.compressionQuality = compressionQuality;
    //[self startIndicatorWithMessage:@"" andCancelCallBack:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:picker animated:YES completion:nil];
            //[self stopIndicator];
        });
    });
}

#pragma -mark 密码键盘回调函数
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    //当开始编辑的时候删除对应密码密文数据
    [self deleteInputField:self.jsInputFieldId];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    
    //当完成的时候，需要记录密文密码
    [self saveInputField:self.jsInputFieldId value:textField.text];
}

#pragma -mark HMPasswordTextFieldDelegate
- (void)passwordTextField:(HMPasswordTextField *)textField
           textHasChanged:(NSString *)value
{
    //替换成·
    NSMutableString *encStr = [NSMutableString string];
    for(int i = 0; i < value.length; i++){
        [encStr appendString:@"*"];
    }
    //Android回传值时JSON字符串，所以回传值为字符串
    [self.bridge callHandler:@"setJsInputFieldValue" data:[@{@"id":self.jsInputFieldId, @"text":encStr} JSONString]];
    
}


#pragma -mark JGLocationHelperDelegate
- (void)locationHelper:(HMLocationHelper *)helper
    didGetlocationLong:(NSString *)locationLong locationLat:(NSString *)locationLat address:(NSDictionary *)address
{
    //返回
    self.responseCallback(@{ @"ret":@"0", @"longitude":locationLong, @"latitude":locationLat, @"address":address });
    
}

- (void)locationHelper:(HMLocationHelper *)helper
      didFailWithError:(NSError *)error
{
    //返回失败
    self.responseCallback(@{ @"ret":@"-1" });
    
}

#pragma -mark SetGesturePwdVCDelegate
-(void)setGesturePwdVC:(HMSetGesturePwdVC *)setGesturePwdVC result:(BOOL)result
                passwd:(NSString *)passwd
{
    if (!result) {
        //返回失败
        self.responseCallback(@{ @"ret":@"-1" });
        return;
    }
    //返回
    self.responseCallback(@{ @"ret":@"0"});
}

#pragma mark --CheckGesturePwdVCDelegate
-(void)checkGesturePwdVC:(HMCheckGesturePwdVC *)checkGesturePwdVC didFinishWithResult:(BOOL)result password:(NSString *)password
{
    if (result) {
        self.responseCallback(@{ @"ret":@"0"});
    }else{
        self.responseCallback(@{ @"ret":@"-1"});
    }
    [checkGesturePwdVC popViewControllerAnimated:YES];
    
}

-(void)checkGesturePwdVCChangeToPwdLogin:(HMCheckGesturePwdVC *)checkGesturePwdVC
{
    //返回选择密码登录
    self.responseCallback(@{ @"ret":@"2", @"message":@"选择密码登陆" });
    
}

-(void)checkGesturePwdVCReturn:(HMCheckGesturePwdVC *)checkGesturePwdVC
{
    //返回失败
    self.responseCallback(@{ @"ret":@"-1", @"message":@"取消手势密码验证" });
    
}

#pragma mark --HMQRCodeScanningVCDelegate
-(void)qrCodeScanningVC:(HMQRCodeScanningVC *)qrCodeScanningVC didFinishWithResult:(NSString *)result
{
    //返回
    self.responseCallback(@{ @"ret":@"0", @"qrcode":result });
    [qrCodeScanningVC popViewControllerAnimated:YES];
}

-(void)qrCodeScanningVCReturn:(HMQRCodeScanningVC *)qrCodeScanningVC
{
    //返回失败
    self.responseCallback(@{ @"ret":@"-1", @"message":@"Cancelled Scanning QR code" });
    
}

#pragma mark - imagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    以下代码用来保存头像到本地
    NSData *imageData;
    
    if ([self.imageType isEqualToString:@"png"]) {
        imageData = UIImagePNGRepresentation(image);
    }
    else {
        imageData = UIImageJPEGRepresentation(image, self.compressionQuality);
    }
    
    self.responseCallback(@{ @"ret":@"0", @"base64Encoded":[imageData base64EncodedString]});

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.responseCallback(@{ @"ret":@"-1", @"message":@"Cancelled" });
}

@end
