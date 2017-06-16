//
//  HMAC SHA256.h
//  TestCPSSDK
//
//  Created by GPP on 15/8/24.
//  Copyright (c) 2015年 LLBT. All rights reserved.
//
/**
 *  HMAC SHA256 加密算法
 *
 */
#import <Foundation/Foundation.h>

@interface HMAC_SHA256 : NSObject
+(NSString *)HMAC_SHA256:(NSString *)key data:(NSString *)data;

//sha256  转成  16位
+(NSString *)HMAC_SHA256data_16:(NSString *)data;
@end
