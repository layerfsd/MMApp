//
//  HMQRCodeScanningVC.h
//  MMApp.iOS
//
//  Created by Sam Yu on 4/12/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMQRCodeScanningBaseVC.h"

@class HMQRCodeScanningVC;
@protocol HMQRCodeScanningVCVCDelegate<NSObject>

@optional
-(void)qrCodeScanningVC:(HMQRCodeScanningVC *)qrCodeScanningVC didFinishWithResult:(NSString *)result;
-(void)qrCodeScanningVCReturn:(HMQRCodeScanningVC *)qrCodeScanningVC;

@end

@interface HMQRCodeScanningVC : HMQRCodeScanningBaseVC
@property (nonatomic, weak) id<HMQRCodeScanningVCVCDelegate> delegate;

@end
