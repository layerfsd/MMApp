//
//  UIImage+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(HExt)

//获取图片内容
-(NSData *)getData;

//获取图片内容
-(NSData *)getData:(float) quality;

//保存图片
-(BOOL)saveImage:(NSString *)localPath;

//压缩图片
- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
