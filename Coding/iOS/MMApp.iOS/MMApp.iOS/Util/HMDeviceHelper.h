//
//  DeviceHelper.h
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDeviceHelper : NSObject
/**
 *  @brief 取设备UUID
 *  @return 设备UUID
 */
+(NSString *)getDeviceId;

/**
 *  @brief 获取设备IP地址
 *  @return 设备IP地址
 */
+(NSString*)getDeviceIP;

/**
 *  @brief 获取iOS当前版本号
 *  @return iOS当前版本号
 */
+(NSString *)getIOSVersion;

/**
 *  @brief 获取App当前版本号
 *  @return App当前版本号
 */
+ (NSString *)getAppVersion;

/**
 *  @brief 获取当前语言
 *  @return 当前语言
 */
+ (NSString *)getCurrentLanguageCode;

@end
