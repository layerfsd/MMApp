//
//  NSString+Md5Addtion.m
//  MBSiPhone
//
//  Created by GengPengpeng on 14-1-11.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import "NSString+Md5Addtion.h"
#import <CommonCrypto/CommonDigest.h>
//#import "CPSConstant.h"


@implementation NSString (Md5Addtion)

- (NSString *)MD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(value, strlen(value), outputBuffer);
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

/**
 *  @brief 返回32位的MD5值
 *
 *  @param string_type 大小写选择
 */
-(NSString *)MD5_32:(String_upper_lower)string_type{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    if (string_type == uppercase_type) {
        return [outputString uppercaseString];
    }
    
    if (string_type == lowercase_type) {
        return [outputString lowercaseString];
    }
    
    return [outputString capitalizedString];
}

/**
 *  返回16位的MD5值  其实就是32位的MD5去掉前8位后8位
 *
 *  @param string_type 大小写选择
 */
-(NSString *)MD5_16:(String_upper_lower)string_type{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    //去掉前8后8
    outputString = (NSMutableString *)[outputString substringWithRange:NSMakeRange(8, 16)];
    
    if (string_type == uppercase_type) {
        return [outputString uppercaseString];
    }
    
    if (string_type == lowercase_type) {
        return [outputString lowercaseString];
    }
    
    return [outputString capitalizedString];
}

@end
