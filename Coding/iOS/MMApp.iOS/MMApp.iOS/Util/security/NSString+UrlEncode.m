//
//  NSString+UrlEncode.m
//  MBSiPhone
//
//  Created by GengPengpeng on 14-4-29.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import "NSString+UrlEncode.h"

@implementation NSString (UrlEncode)
- (NSString *)urlencodeString:(NSStringEncoding)encoding
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}
@end
