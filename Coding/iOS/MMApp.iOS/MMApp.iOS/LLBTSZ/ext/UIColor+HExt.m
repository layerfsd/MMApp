//
//  UIColor+HExt.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "UIColor+HExt.h"

@implementation UIColor(HExt)

/**
 *  @name           stringColor
 *  @time           2015-07-12 13:41
 *  @athor          goodluckus
 *  @description    讲字符类型转化为颜色
 *  @param          color (可以是＃开头的6位或者8位)
 *  @return         UIColor
 */
+(UIColor*)H_stringColor:(NSString *)color{
    if (color==nil) {
        return [UIColor clearColor];
    }
    if ([color hasPrefix:@"#"]) {
        color=[color substringFromIndex:1];
    }
    CGFloat  blue=1.0f;
    CGFloat  green=1.0f;
    CGFloat  red=1.0f;
    CGFloat  alpha=1.0f;
    if (color.length==6) {
        red= strtoul([[color substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16)/255.0f;
        green= strtoul([[color substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16)/255.0f;
        blue= strtoul([[color substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16)/255.0f;
    }else if(color.length==8){
        alpha= strtoul([[color substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16)/255.0f;
        red= strtoul([[color substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16)/255.0f;
        green= strtoul([[color substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16)/255.0f;
        blue= strtoul([[color substringWithRange:NSMakeRange(6, 2)] UTF8String], 0, 16)/255.0f;
    }else{
        return [UIColor clearColor];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


//随机颜色
+(UIColor *)H_randomColor{
    UIColor *color=[UIColor colorWithRed:(1.0f*(arc4random() *1235%256)/255) green:(1.0f*(arc4random() *1235%256)/255) blue:(1.0f*(arc4random() *1235%256)/255) alpha:1];
    return color;
}
@end
