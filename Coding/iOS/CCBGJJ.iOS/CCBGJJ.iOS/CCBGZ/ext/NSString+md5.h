//
//  NSString+md5.h
//  BBank
//
//  Created by 钟健 on 2017/1/16.
//  Copyright © 2017年 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)
- (NSString *)stringToMD5:(NSString *)str;
//获取文件的md5加密码
+(NSString*)fileMD5:(NSString*)path;
@end
