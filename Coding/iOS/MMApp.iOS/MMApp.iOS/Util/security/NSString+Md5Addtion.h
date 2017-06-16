//
//  NSString+Md5Addtion.h
//  MBSiPhone
//
//  Created by GengPengpeng on 14-1-11.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    uppercase_type = 0,
    lowercase_type = 1,
    capitalized_type = 2
}String_upper_lower;
@interface NSString (Md5Addtion)
- (NSString *) MD5;

/**
 *  @brief 返回32位的MD5值
 *
 *  @param string_type 大小写选择
 */
-(NSString *)MD5_32:(String_upper_lower)string_type;

/**
 *  返回16位的MD5值  其实就是32位的MD5去掉前8位后8位
 *
 *  @param string_type 大小写选择
 */
-(NSString *)MD5_16:(String_upper_lower)string_type;


@end
