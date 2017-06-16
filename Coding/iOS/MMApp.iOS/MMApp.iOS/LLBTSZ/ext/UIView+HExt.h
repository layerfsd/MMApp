//
//  UIView+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(HExt)

//x
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;


//设置圆角
- (void)H_setCornerRadius:(CGFloat)cornerRadius;
//设置边框
- (void)H_setBorderWidth:(CGFloat)width andColor:(UIColor *)color;
//转换为图片
- (UIImage *)H_convertViewToImage;

@end
