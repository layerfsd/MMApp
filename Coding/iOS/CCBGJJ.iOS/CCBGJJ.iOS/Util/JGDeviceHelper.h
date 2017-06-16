//
//  DeviceHelper.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGDeviceHelper : NSObject
//获取设备ID
+(NSString *)getDeviceId;

//获取设备IP地址
+(NSString*)getDeviceIP;

//获取设备版本号
+(NSString *)getIOSVersion;

@end
