//
//  NSDate+HExt.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "NSDate+HExt.h"

@implementation NSDate(HExt)

//将时间转换为字符
+ (NSString *)H_stringFromDate:(NSDate *)date withFormat:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:string];
    return  [formatter stringFromDate:date];
}
//将时间转换为字符，默认格式yyyy-MM-dd HH:mm:ss
+ (NSString *)H_stringFromDate:(NSDate *)date{
    return [self H_stringFromDate:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end
