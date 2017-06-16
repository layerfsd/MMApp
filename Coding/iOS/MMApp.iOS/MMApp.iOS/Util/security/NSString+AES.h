//
//  NSString+AES.h
//  MBSiPhone
//
//  Created by GengPengpeng on 14-4-29.
//  Copyright (c) 2014年 China M-World Co.,Ltd. All rights reserved.
//

//AES加密

#import <Foundation/Foundation.h>

@interface NSString (AES)
//加密
- (NSString *)AES128EncryptWithKey:(NSString *)key;
//解密
- (NSString *)AES128DecryptWithKey:(NSString *)key;
@end
