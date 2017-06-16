//
//  NSDictionary+HExt.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "NSDictionary+HExt.h"

@implementation NSDictionary(HExt)
//是否有某个值
-(BOOL)H_hasKey:(id)key{
    return [self objectForKey:key] !=nil;
}
-(BOOL)H_hasKeyNotNull:(id)key{
    id value=[self objectForKey:key];
    if (value==nil) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return ((NSString *)value).length>0;
    }
    return value!=nil;
}

//获取值
-(int)H_optInt:(id)key withDefaultValue:(int)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).intValue;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return ((NSString *)ret).intValue;
    }
    return value;
}

//获取值
-(int)H_optInt:(NSString *)key{
    return [self H_optInt:key withDefaultValue:0];
}

//获取值
-(NSString *)H_optString:(id)key withDefaultValue:(NSString *)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",ret];
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return  ret;
    }
    return value;
}

//获取值
-(NSString *)H_optString:(id)key{
    return [self H_optString:key withDefaultValue:@""];
}

//获取值
-(long)H_optLong:(id)key withDefaultValue:(long)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return (long)((NSNumber *)ret).longLongValue;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return  (long)((NSString *)ret).longLongValue;
    }
    return value;
}

//获取值
-(long)H_optLong:(id)key{
    return [self H_optLong:key withDefaultValue:0];
}

//获取值
-(double) H_optDouble:(id)key withDefalutValue:(double)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).doubleValue;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return  ((NSString *)ret).doubleValue;
    }
    return value;
}
//获取值
-(double)H_optDouble:(id)key{
    return [self H_optDouble:key withDefalutValue:0];
}

//获取值
-(BOOL)H_optBool:(id)key withDefalutValue:(BOOL)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).longLongValue>0;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return  ((NSString *)ret).boolValue;
    }
    return value;
}
//取值
-(BOOL)H_optBool:(id)key{
    return [self H_optBool:key withDefalutValue:NO];
}

//获取值
-(float)H_optFloat:(id)key withDefalutValue:(float)value{
    id ret=[self objectForKey:key];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).floatValue;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return  ((NSString *)ret).floatValue;
    }
    return value;
    
}
-(float)H_optFloat:(id)key{
    return [self H_optFloat:key withDefalutValue:0];
}


//获取值
-(NSArray *)H_optNSArray:(id)key{
    id ret=[self objectForKey:key];
    if ([ret isKindOfClass:[NSArray class]] || [ret isKindOfClass:[NSMutableArray class]]) {
        return ret;
    }
    return nil;
}
-(NSMutableArray *)H_optNSMutableArray:(id)key{
    id ret=[self objectForKey:key];
    if ([ret isKindOfClass:[NSArray class]]) {
        return [ret mutableCopy];
    }
    //    if ([ret isKindOfClass:[NSArray class]]) {
    //        NSMutableArray *array=[[NSMutableArray alloc]init];
    //        NSArray * a=(NSArray*)ret;
    //        for (int i=0; i<a.count; i++) {
    //            [array addObject:[a objectAtIndex:i]];
    //        }
    //        return array;
    //    }
    return nil;
}

//获取值
-(NSDictionary *)H_optNSDictionary:(id)key{
    id ret=[self objectForKey:key];
    if ([ret isKindOfClass:[NSDictionary class]] || [ret isKindOfClass:[NSMutableDictionary class]]) {
        return ret;
    }
    return nil;
}
-(NSMutableDictionary *)H_optNSMutableDictionary:(id)key{
    id ret=[self objectForKey:key];
    if ([ret isKindOfClass:[NSDictionary class]]) {
        return [ret mutableCopy];
    }
    //    if ([ret isKindOfClass:[NSDictionary class]]) {
    //        NSMutableDictionary *array=[[NSMutableDictionary alloc]init];
    //        NSDictionary * a=(NSDictionary*)ret;
    //        NSArray *keys=[a allKeys];
    //        for (NSString *key in keys) {
    //            [array setObject:[a objectForKey:key] forKey:key];
    //        }
    //        return array;
    //    }
    return nil;
}

//JSON
+(NSDictionary *)H_DictionaryFromJSONString:(NSString *)jsonString{
    NSError *error;
    id ret=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    if ([ret isKindOfClass:[NSDictionary class]]) {
        return ret;
    }
    return nil;
}

-(NSString *)H_toJSONString{
    NSError *error;
    NSData *data= [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return [NSString stringWithUTF8String:data.bytes];
}
@end
