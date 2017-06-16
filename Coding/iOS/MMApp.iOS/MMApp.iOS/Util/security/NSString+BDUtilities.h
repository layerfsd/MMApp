//
//  NSString+BDUtilities.h
//  CPSSDK
//
//  Created by GengPengpeng on 15/7/1.
//  Copyright (c) 2015年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BDUtilities)
//判断是否为空
+ (BOOL)isEmpty:(NSString *)string;

//生成随机数
+ (NSString *)randomStringWithLength:(NSInteger)length;

//判断是否包含某子字符串
- (BOOL)containsSubstring:(NSString *)substring;

@end
