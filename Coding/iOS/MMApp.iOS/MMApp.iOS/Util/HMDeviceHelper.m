//
//  DeviceHelper.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMDeviceHelper.h"
#import "HMPreferences.h"
#import "HCoreComm.h"
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation HMDeviceHelper

/**
 *  @brief 取设备UUID
 *  @return 设备UUID
 */
+(NSString *)getDeviceId{
    NSString *deviceId=[HMPreferences getDeviceId];
    if(deviceId){
        return deviceId;
    }
    //identifierForVendor:同一供应商的不同App,此值是不变的
    deviceId = [NSString stringWithFormat:@"iOS-%@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
//    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate new]];
//    NSMutableString *uuid=[[NSMutableString alloc]initWithFormat:@"999%@",currentDateStr];
//    for (int i=0; i<12; i++) {
//        [uuid appendFormat:@"%d",arc4random()%9];
//    }
    [HMPreferences setDeviceId:deviceId];
    return deviceId;
}

/**
 *  @brief 获取设备IP地址
 *  @return 设备IP地址
 */
+(NSString*)getDeviceIP{
    NSString *address =nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                NSString *netType=[NSString stringWithUTF8String:temp_addr->ifa_name];
                if([ netType isEqualToString:@"en0"]  || [netType isEqualToString:@"pdp_ip0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 *  @brief 获取iOS当前版本号
 *  @return iOS当前版本号
 */
+ (NSString *)getIOSVersion{
    return [[UIDevice currentDevice] systemVersion];
}

/**
 *  @brief 获取App当前版本号
 *  @return App当前版本号
 */
+ (NSString *)getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

/**
 *  @brief 获取当前语言
 *  @return 当前语言
 */
+ (NSString *)getCurrentLanguageCode{
    /*
     1:en
     2:fr
     3:de
     4:ja
     5:nl
     6:it
     7:es
     8:pt
     9:pt-PT
     10:da
     11:fi
     12:nb
     13:sv
     14:ko
     15:zh-Hans
     16:zh-Hant
     17:ru
     18:pl
     19:tr
     20:uk
     21:ar
     22:hr
     23:cs
     24:el
     25:he
     26:ro
     27:sk
     28:th
     29:id
     30:ms
     31:en-GB
     32:ca
     33:hu
     34:vi
     */
    NSString *languageCode = @"en";
    NSArray *languages = [NSLocale preferredLanguages];
    
    if ([languages count] > 0) {
        //languageCode = [languages objectAtIndex:0];
        NSString *firstLanguage = [languages firstObject];
        
        if (IS_IOS9_Above) {
            //on iOS 9.0 "<language code>-<region code>"
            //去掉最后的region code
            NSRange range = [firstLanguage rangeOfString:@"-" options:NSBackwardsSearch];
            firstLanguage = [firstLanguage substringToIndex:range.location];
        }
        //languageCode = [[firstLanguage componentsSeparatedByString:@"-"] firstObject];
        if ([firstLanguage isEqualToString:@"zh-Hans"])
            firstLanguage = @"zh-cn";
        else if ([firstLanguage isEqualToString:@"zh-Hant"])
            firstLanguage = @"zh-tw";
        languageCode = firstLanguage;
    }
    return languageCode;
}

@end
