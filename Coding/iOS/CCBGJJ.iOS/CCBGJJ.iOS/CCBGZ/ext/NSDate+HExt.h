//
//  NSDate+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(HExt)

//将时间转换为字符
+ (NSString *)H_stringFromDate:(NSDate *)date withFormat:(NSString *)string;
//将时间转换为字符，默认格式yyyy-MM-dd HH:mm:ss
+ (NSString *)H_stringFromDate:(NSDate *)date;
@end
