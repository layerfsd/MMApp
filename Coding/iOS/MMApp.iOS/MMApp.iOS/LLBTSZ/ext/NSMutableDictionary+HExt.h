//
//  NSMutableDictionary+HExt.h
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(HExt)
//是否有某个值
-(BOOL)H_hasKey:(id)key;
-(BOOL)H_hasKeyNotNull:(id)key;
//获取值
-(int)H_optInt:(id)key withDefaultValue:(int)value;

//获取值
-(int)H_optInt:(NSString *)key ;

//获取值
-(NSString *)H_optString:(id)key withDefaultValue:(NSString *)value;

//获取值
-(NSString *)H_optString:(id)key;

//获取值
-(long)H_optLong:(id)key withDefaultValue:(long)value;

//获取值
-(long)H_optLong:(id)key;

//获取值
-(double)H_optDouble:(id)key withDefalutValue:(double)value;
//获取值
-(double)H_optDouble:(id)key;

//获取值
-(BOOL)H_optBool:(id)key withDefalutValue:(BOOL)value;
-(BOOL)H_optBool:(id)key;


//获取值
-(float)H_optFloat:(id)key withDefalutValue:(float)value;
-(float)H_optFloat:(id)key;

//获取值
-(NSArray *)H_optNSArray:(id)key;
-(NSMutableArray *)H_optNSMutableArray:(id)key;

//获取值
-(NSDictionary *)H_optNSDictionary:(id)key;
-(NSMutableDictionary *)H_optNSMutableDictionary:(id)key;

//JSON
+(NSMutableDictionary *)H_DictionaryFromJSONString:(NSString *)jsonString;
-(NSString *)H_toJSONString;
@end
