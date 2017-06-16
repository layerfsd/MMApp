//
//  HMSecurityHelper.h
//  MMApp.iOS
//
//  Created by Sam Yu on 3/8/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSecurityHelper : NSObject
/**
 *  @brief 取IMEIFactor
 *  @return IMEIFactor
 */
+(NSString *)getIMEIFactor;

/**
 *  @brief 取TransportKey
 *  @return TransportKey
 */
+(NSString *)getTransportKey;

/**
 *  @brief 取加密后的TransportKey
 *  @return 加密后TransportKey
 */
+(NSString *)getEncTransportKey;

/**
 *  @brief 取加密后的IMEIFactor
 *  @return 加密后IMEIFactor
 */
+(NSString *)getEncIMEIFactor;


/**
 *  @brief 产生PayloadKey，用于加解密报文体，一次通信使用
 *  @return 加密后PayloadKey
 */
+(NSString *)getEncPayloadKey;

/**
 *  @brief 用PayloadKey加密
 *  @param source 须加密的string
 *  @param encPayloadKey 加密的PayloadKey
 *  @return 加密后的string
 */
+(NSString *)encryptString:(NSString *)source withEncPayloadKey:(NSString *)encPayloadKey;

/**
 *  @brief 用TransportKey加密
 *  @param source 须加密的string
 *  @return 加密后的string
 */
+(NSString *)encryptString:(NSString *)source;

/**
 *  @brief 产生盐值（随机数）
 *  @return 盐值 （Base64）
 */
+(NSString *)generateSalt256;

/**
 *  @brief PBKDF2加密Password
 *  @param password 须加密的password
 *  @param salt 盐值  （Base64）
 *  @param rounds PBKDF2
 *  @return 加密后的password （Base64）
 */
+(NSString *)encryptPassword:(NSString *)password salt:(NSString *)salt rounds:(int)rounds;


@end
