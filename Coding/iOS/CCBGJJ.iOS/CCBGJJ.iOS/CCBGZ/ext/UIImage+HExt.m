//
//  UIImage+HExt.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "UIImage+HExt.h"
#import <ImageIO/ImageIO.h>
#import "HFileHelper.h"

@implementation UIImage(HExt)


//获取图片内容
-(NSData *)getData{
    return  UIImagePNGRepresentation(self);
}
//获取图片内容
-(NSData *)getData:(float) quality{
    return UIImageJPEGRepresentation(self, quality);
}

//保存图片
-(BOOL)saveImage:(NSString *)localPath{
    NSData *data= UIImagePNGRepresentation(self);
    return [data writeToFile:localPath atomically:NO];
}

//压缩图片
- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
