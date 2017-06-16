//
//  Preferences.m
//  CCBGJJ.iOS
//  须保存在本地的数据
//
//  Created by Sam Yu on 2/20/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "JGPreferences.h"
#import "HKeyChain.h"

#define PREF_DEVICE_ID  @"pref_device_id"
#define PREF_GESTURE_PASSWORD  @"pref_gesture_password"
#define PREF_FINGERPRINT_STATE  @"pref_fingerprint_state_data"

@implementation JGPreferences

+ (NSString *)getDeviceId
{
    NSString *deviceId=[[HKeyChain getInstance]H_get:PREF_DEVICE_ID];
    return deviceId;
}

+ (void)setDeviceId:(NSString *)deviceId
{
    [[HKeyChain getInstance]H_put:PREF_DEVICE_ID withValue:deviceId];
}

+ (NSString *)getGesturePassword
{
    NSString *password=[[HKeyChain getInstance]H_get:PREF_GESTURE_PASSWORD];
    return password;
}

+ (void)setGesturePassword:(NSString *)password
{
    [[HKeyChain getInstance]H_put:PREF_GESTURE_PASSWORD withValue:password];
}

+ (NSData *)getFingerprintStateData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:PREF_FINGERPRINT_STATE];
    
}

+ (void)setFingerprintStateData:(NSData *)stateData
{
    [[NSUserDefaults standardUserDefaults] setObject:stateData forKey:PREF_FINGERPRINT_STATE];
    
}

@end
