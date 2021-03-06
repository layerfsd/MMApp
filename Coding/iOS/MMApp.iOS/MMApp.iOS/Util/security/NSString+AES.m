//
//  NSString+AES.m
//  MBSiPhone
//
//  Created by GengPengpeng on 14-4-29.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import "NSString+AES.h"
#import "NSData+AES.h"

@implementation NSString (AES)
- (NSString *)AES128EncryptWithKey:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES128EncryptWithKey:key];
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}

- (NSString *)AES128DecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES128DecryptWithKey:key];    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}


@end
