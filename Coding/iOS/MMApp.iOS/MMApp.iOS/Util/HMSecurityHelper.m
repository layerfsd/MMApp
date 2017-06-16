//
//  HMSecurityHelper.m
//  MMApp.iOS
//
//  Created by Sam Yu on 3/8/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import "HMSecurityHelper.h"
#import "HMDeviceHelper.h"
#import "SSKeychain.h"
#import "HMConstants.h"
#import "HMAC ShA256.h"
#import "RSA.h"
#import "NSString+BDUtilities.h"
#import "NSString+AES.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation HMSecurityHelper

/**
 *  @brief 取IMEIFactor
 *  @return IMEIFactor
 */
+(NSString *)getIMEIFactor
{
    //如果已经生成过，不必再生成一次
    NSString *savedIMEIFactor = [SSKeychain passwordForService:SSKeychain_Service account:SSKeychain_Account_IMEIFactor];
    if (savedIMEIFactor != nil)
        return savedIMEIFactor;
    
    //IMEI+timestamp+random(10)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate new]];
    NSMutableString *factor=[[NSMutableString alloc]initWithFormat:@"%@%@",[HMDeviceHelper getDeviceId], currentDateStr];
    for (int i=0; i<10; i++) {
        [factor appendFormat:@"%d",arc4random()%9];
    }
    [SSKeychain setPassword:factor forService:SSKeychain_Service account:SSKeychain_Account_IMEIFactor];
    return factor;
    
}

/**
 *  @brief 取TransportKey
 *  @return TransportKey
 */
+(NSString *)getTransportKey
{
    //如果已经生成过，不必再生成一次
    NSString *savedTransportKey = [SSKeychain passwordForService:SSKeychain_Service account:SSKeychain_Account_TransportKey];
    if (savedTransportKey != nil)
        return savedTransportKey;
    
    //HmacSHA256对IMEIfactor进行加密;
    //Transport Key = HmacSHA256截取16byte;
    NSString *factor = [self getIMEIFactor];
    NSString *transportKey = [HMAC_SHA256 HMAC_SHA256data_16:factor];
    [SSKeychain setPassword:factor forService:SSKeychain_Service account:SSKeychain_Account_TransportKey];
    return transportKey;
}

/**
 *  @brief 取加密后的TransportKey
 *  @return 加密后TransportKey
 */
+(NSString *)getEncTransportKey
{
    NSString *transportKey = [self getTransportKey];
    NSString *encTransportKey = [[RSA defaultRSA] encryptToString:transportKey];
    return encTransportKey;
}

/**
 *  @brief 取加密后的IMEIFactor
 *  @return 加密后IMEIFactor
 */
+(NSString *)getEncIMEIFactor
{
    NSString *factor = [self getIMEIFactor];
    NSString *encFactor = [[RSA defaultRSA] encryptToString:factor];
    return encFactor;
}


/**
 *  @brief 产生PayloadKey，用于加解密报文体，一次通信使用
 *  @return 加密后PayloadKey
 */
+(NSString *)getEncPayloadKey
{
    NSString *payloadKey = [NSString randomStringWithLength:16];
    NSString *transportKey = [self getTransportKey];
    NSString *encPayloadKey = [payloadKey AES128EncryptWithKey:transportKey];
    return encPayloadKey;
}

/**
 *  @brief 用PayloadKey加密
 *  @param source 须加密的string
 *  @param encPayloadKey 加密的PayloadKey
 *  @return 加密后的string
 */
+(NSString *)encryptString:(NSString *)source withEncPayloadKey:(NSString *)encPayloadKey
{
    NSString *transportKey = [self getTransportKey];
    NSString *payloadKey = [encPayloadKey AES128DecryptWithKey:transportKey];
    NSString *result = [source AES128EncryptWithKey:payloadKey];
    return result;
}

/**
 *  @brief 用TransportKey加密
 *  @param source 须加密的string
 *  @return 加密后的string
 */
+(NSString *)encryptString:(NSString *)source
{
    NSString *transportKey = [self getTransportKey];
    NSString *result = [source AES128EncryptWithKey:transportKey];
    return result;
}


/**
 *  @brief 产生盐值（随机数）
 *  @return 盐值 （Base64）
 */
+(NSString *)generateSalt256 {
    unsigned char salt[32];
    for (int i=0; i<32; i++) {
        salt[i] = (unsigned char)arc4random();
    }
    NSData* saltData = [NSData dataWithBytes:salt length:32];
    return [saltData base64EncodedString];
    
}

/**
 *  @brief PBKDF2加密Password
 *  @param password 须加密的password
 *  @param salt 盐值  （Base64）
 *  @param rounds 迭代次数
 *  @return 加密后的password （Base64）
 */
+(NSString *)encryptPassword:(NSString *)password salt:(NSString *)salt rounds:(int)rounds
{
    NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSData *saltData = [NSData dataWithBase64EncodedString:salt];
    
    // How many rounds to use so that it takes 0.1s ?
    // *rounds = CCCalibratePBKDF(kCCPBKDF2, passwordData.length, saltData.length, kCCPRFHmacAlgSHA256, 32, 100);
    
    unsigned char key[32];
    CCKeyDerivationPBKDF(kCCPBKDF2, passwordData.bytes, passwordData.length, saltData.bytes, saltData.length, kCCPRFHmacAlgSHA256, rounds, key, 32);
    
    return [[NSData dataWithBytes:key length:32] base64EncodedString];
    
}
@end
