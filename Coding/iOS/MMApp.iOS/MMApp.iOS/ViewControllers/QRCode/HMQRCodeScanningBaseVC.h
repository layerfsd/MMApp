//
//  HMQRCodeScanningVC.h
//  MMApp.iOS
//
//  Created by Sam Yu on 4/12/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVC.h"

/** 从相册里得到的二维码信息 */
#define HMQRCodeInformationFromeAlbum @"HMQRCodeInformationFromeAlbum"
/** 扫描得到的二维码信息 */
#define HMQRCodeInformationFromeScanning @"HMQRCodeInformationFromeScanning"


@interface HMQRCodeScanningBaseVC : HVC
@property bool canScanPhoto;  //允许扫描照片
@end


