//
//  HMAC SHA256.m
//  TestCPSSDK
//
//  Created by GPP on 15/8/24.
//  Copyright (c) 2015年 LLBT. All rights reserved.
//

#import "HMAC SHA256.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSString+Base64.h"
//#import "CPSConstant.h"
//#import "CPSLog.h"

@implementation HMAC_SHA256
+(NSString *)HMAC_SHA256:(NSString *)key data:(NSString *)data{
//    NSData *bytes = [key dataUsingEncoding:NSUTF8StringEncoding];
//    Byte   *myByte = (Byte *)[bytes bytes];
//    CPSDebugLog(@"myByte = %s",myByte);
    
    Byte cKey[32] = {0x65,0xc3,0xd2,0x62,0x3a,0x72,0x1e,0x97,0x00,0x34,0x14,0xd7,0x32,0x6d,0x85,0x15,0x0a,0x4b,0xc3,0xe3,0xed,0x7b,0xb4,0x30,0xab,0xa3,0xcd,0xc5,0xc7,0x03,0x5e,0x55};
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //    const char *cData = [[data dataUsingEncoding:NSUTF8StringEncoding] bytes];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, sizeof(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString* s = [self base64forData:hash];
    return s;
}

+(NSString *)HMAC_SHA256data_16:(NSString *)data{
    Byte cKey[32] = {0x65,0xc3,0xd2,0x62,0x3a,0x72,0x1e,0x97,0x00,0x34,0x14,0xd7,0x32,0x6d,0x85,0x15,0x0a,0x4b,0xc3,0xe3,0xed,0x7b,0xb4,0x30,0xab,0xa3,0xcd,0xc5,0xc7,0x03,0x5e,0x55};
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[8];
    CCHmac(kCCHmacAlgSHA256, cKey, sizeof(cKey), cData, strlen(cData), cHMAC);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:16];
    for(NSInteger count = 0; count < 8; count++){
        [outputString appendFormat:@"%02x",cHMAC[count]];//16进制输出
    }
    return outputString;
}



+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {  value |= (0xFF & input[j]);  }  }  NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end
