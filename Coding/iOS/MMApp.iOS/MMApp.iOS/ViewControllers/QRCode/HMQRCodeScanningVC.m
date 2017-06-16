//
//  HMQRCodeScanningVC.m
//  MMApp.iOS
//
//  Created by Sam Yu on 4/12/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMQRCodeScanningVC.h"

@interface HMQRCodeScanningVC ()

@end

@implementation HMQRCodeScanningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QRCodeInformationFromeAlbum:) name:HMQRCodeInformationFromeAlbum object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QRCodeInformationFromeScanning:) name:HMQRCodeInformationFromeScanning object:nil];
}

- (void)QRCodeInformationFromeAlbum:(NSNotification *)noti {
    
    NSString *string = noti.object;
    NSLog(@"qrcode=%@", string);
    [_delegate qrCodeScanningVC:self didFinishWithResult:string];
}

- (void)QRCodeInformationFromeScanning:(NSNotification *)noti {
    NSString *string = noti.object;
    NSLog(@"qrcode=%@", string);
    [_delegate qrCodeScanningVC:self didFinishWithResult:string];
}

-(void)onLeftButtonClick{
    [self popViewControllerAnimated:YES];
    [_delegate qrCodeScanningVCReturn:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
