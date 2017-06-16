//
//  NSArray+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(HExt)

//获取值
-(NSString *)H_optString:(long)path;
-(NSString *)H_optString:(long)path withDefaultValue:(NSString *)value;


//获取值
-(int)H_optInt:(long)path;
-(int)H_optInt:(long)path withDefaultValue:(int)value;

//获取值
-(double)H_optDouble:(long)path;
-(double)H_optDouble:(long)path withDefaultValue:(double)value;

//获取值
-(BOOL)H_optBool:(long)path;
-(BOOL)H_optBool:(long)path withDefaultValue:(BOOL)value;

//获取值
-(long)H_optLong:(long)path;
-(long)H_optLong:(long)path withDefaultValue:(long)value;

//获取值
-(float)H_optFloat:(long)path withDefalutValue:(float)value;
-(float)H_optFloat:(long)path;

//获取值
-(NSArray *)H_optNSArray:(long)path;
-(NSMutableArray *)H_optNSMutableArray:(long)path;

//获取值
-(NSDictionary *)H_optNSDictionary:(long)path;
-(NSMutableDictionary *)H_optNSMutableDictionary:(long)path;

//JSON
+(NSArray *)H_ArrayFromJSONString:(NSString *)jsonString;
-(NSString *)H_toJSONString;
@end
