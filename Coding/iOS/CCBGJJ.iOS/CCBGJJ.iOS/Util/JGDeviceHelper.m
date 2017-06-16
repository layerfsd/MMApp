//
//  DeviceHelper.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "JGDeviceHelper.h"
#import "JGPreferences.h"
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation JGDeviceHelper

+(NSString *)getDeviceId{
    NSString *deviceId=[JGPreferences getDeviceId];
    if(deviceId){
        return deviceId;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate new]];
    NSMutableString *uuid=[[NSMutableString alloc]initWithFormat:@"999%@",currentDateStr];
    for (int i=0; i<12; i++) {
        [uuid appendFormat:@"%d",arc4random()%9];
    }
    [JGPreferences setDeviceId:uuid];
    return uuid;
}

//获取设备IP地址
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

//获取当前版本号
+ (NSString *)getIOSVersion{
    return [[UIDevice currentDevice] systemVersion];
}

@end
