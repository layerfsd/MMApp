//
//  UIImage+HMHelper.h
//  MMApp.iOS
//
//  Created by Sam Yu on 4/12/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HMQRCodeHelper)
/** 返回一张不超过屏幕尺寸的 image */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

@end

