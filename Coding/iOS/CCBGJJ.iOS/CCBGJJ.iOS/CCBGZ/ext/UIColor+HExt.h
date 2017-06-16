//
//  UIColor+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(HExt)

/**
 *  @name           stringColor
 *  @time           2015-07-12 13:41
 *  @athor          goodluckus
 *  @description    讲字符类型转化为颜色
 *  @param          color (可以是＃开头的6位或者8位)
 *  @return         UIColor
 */
+(UIColor*)H_stringColor:(NSString *)color;

//随机颜色
+(UIColor *)H_randomColor;
@end
