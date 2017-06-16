//
//  Preferences.h
//
//  Created by Sam Yu on 2/20/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMPreferences : NSObject

/**
 *  @brief 取设备Id
 *  @return 设备Id
 */
+ (NSString *)getDeviceId;

/**
 *  @brief 保存设备Id
 *  @param deviceId 设备Id
 */
+ (void)setDeviceId:(NSString *)deviceId;

/**
 *  @brief 取手势密码
 *  @return 手势密码
 */
+ (NSString *)getGesturePassword;

/**
 *  @brief 保存手势密码
 *  @param password 手势密码
 */
+ (void)setGesturePassword:(NSString *)password;

/**
 *  @brief 取手势密码最大失败次数
 *  @return 手势密码最大失败次数
 */
+ (int)getGesturePasswordRetryLimit;

/**
 *  @brief 保存手势密码最大失败次数
 *  @param retryLimit 手势密码最大失败次数
 */
+ (void)setGesturePasswordRetryLimit:(int)retryLimit;


/**
 *  @brief 取指纹状态数据
 *  @return 指纹状态数据
 */
+ (NSData *)getFingerprintStateData;

/**
 *  @brief 保存指纹状态数据
 *  @param stateData 指纹状态数据
 */
+ (void)setFingerprintStateData:(NSData *)stateData;

@end
