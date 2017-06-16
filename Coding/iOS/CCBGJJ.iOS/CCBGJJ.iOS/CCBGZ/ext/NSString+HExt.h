//
//  NSString+HExt.h
//  HCore
//
//  Created by hyc on 16/11/5.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(HExt)

//转换为拼音
- (NSString*)H_pinyin;

//是否是数字
- (BOOL)H_isNumber;

//是否是空串
- (BOOL)H_isEmptyOrWhitespace;

//是否是邮箱
- (BOOL)H_isEmail;

//去掉首尾空格
-(NSString *)H_trim;

//是否包含字符
-(BOOL)H_isContainString:(NSString *)string;

//URL转码
- (NSString *)H_URLEncoding;

//URL解码
- (NSString *)H_URLDecoding;

//获取中英文字符长度
-(long)H_getUTF8Length;

//参数转码
+ (NSString *)escapedURLString:(NSString *)string;
@end
