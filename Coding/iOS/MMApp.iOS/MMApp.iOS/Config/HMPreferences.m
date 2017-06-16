//
//  Preferences.m
//  须保存在本地的数据
//
//  Created by Sam Yu on 2/20/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMPreferences.h"
#import "HKeyChain.h"

#define PREF_DEVICE_ID  @"pref_device_id"
#define PREF_GESTURE_PASSWORD  @"pref_gesture_password"
#define PREF_GESTURE_PASSWORD_RETRY_LIMIT @"pref_gesture_password_retry_limit"
#define PREF_FINGERPRINT_STATE  @"pref_fingerprint_state_data"

@implementation HMPreferences

/**
 *  @brief 取设备Id
 *  @return 设备Id
 */
+ (NSString *)getDeviceId
{
    NSString *deviceId=[[HKeyChain getInstance]H_get:PREF_DEVICE_ID];
    return deviceId;
}

/**
 *  @brief 保存设备Id
 *  @param deviceId 设备Id
 */
+ (void)setDeviceId:(NSString *)deviceId
{
    [[HKeyChain getInstance]H_put:PREF_DEVICE_ID withValue:deviceId];
}

/**
 *  @brief 取手势密码
 *  @return 手势密码
 */
+ (NSString *)getGesturePassword
{
    NSString *password=[[HKeyChain getInstance]H_get:PREF_GESTURE_PASSWORD];
    return password;
}

/**
 *  @brief 保存手势密码
 *  @param password 手势密码
 */
+ (void)setGesturePassword:(NSString *)password
{
    [[HKeyChain getInstance]H_put:PREF_GESTURE_PASSWORD withValue:password];
}

/**
 *  @brief 取手势密码最大失败次数
 *  @return 手势密码最大失败次数
 */
+ (int)getGesturePasswordRetryLimit
{
    NSNumber *retryLimit=[[HKeyChain getInstance]H_get:PREF_GESTURE_PASSWORD_RETRY_LIMIT];
    return [retryLimit intValue];
}

/**
 *  @brief 保存手势密码最大失败次数
 *  @param retryLimit 手势密码最大失败次数
 */
+ (void)setGesturePasswordRetryLimit:(int)retryLimit
{
    [[HKeyChain getInstance]H_put:PREF_GESTURE_PASSWORD_RETRY_LIMIT withValue:[NSNumber numberWithInt:retryLimit]];
}


/**
 *  @brief 取指纹状态数据
 *  @return 指纹状态数据
 */
+ (NSData *)getFingerprintStateData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:PREF_FINGERPRINT_STATE];
    
}

/**
 *  @brief 保存指纹状态数据
 *  @param stateData 指纹状态数据
 */
+ (void)setFingerprintStateData:(NSData *)stateData
{
    [[NSUserDefaults standardUserDefaults] setObject:stateData forKey:PREF_FINGERPRINT_STATE];
    
}

@end
