//
//  NSArray+HExt.m
//  HCore
//
//  Created by hyc on 16/11/7.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "NSArray+HExt.h"

@implementation NSArray(HExt)
//获取值
-(NSString *)H_optString:(long)path{
    return [self H_optString:path withDefaultValue:@""];
}
-(NSString *)H_optString:(long)path withDefaultValue:(NSString *)value{
    id ret=[self objectAtIndex:path];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",ret];
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return (NSString *)ret;
    }
    return value;
}


//获取值
-(int)H_optInt:(long)path{
    return [self H_optInt:path withDefaultValue:0];
}
-(int)H_optInt:(long)path withDefaultValue:(int)value{
    id ret=[self objectAtIndex:path];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).intValue;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return ((NSString *)ret).intValue;
    }
    return value;
}


//获取值
-(double)H_optDouble:(long)path{
    return [self H_optDouble:path withDefaultValue:0];
}
-(double)H_optDouble:(long)path withDefaultValue:(double)value{
    id ret=[self objectAtIndex:path];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).doubleValue;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return ((NSString *)ret).doubleValue;
    }
    return value;
    
}

//获取值
-(BOOL)H_optBool:(long)path{
    return  [self H_optBool:path withDefaultValue:NO];
}

-(BOOL)H_optBool:(long)path withDefaultValue:(BOOL)value{
    id ret=[self objectAtIndex:path];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)ret).longLongValue>0;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return ((NSString *)ret).boolValue;
    }
    return value;
}

//获取值
-(long)H_optLong:(long)path{
    return [self H_optLong:path withDefaultValue:0];
}
-(long)H_optLong:(long)path withDefaultValue:(long)value{
    id ret=[self objectAtIndex:path];
    if (ret==nil) {
        return value;
    }
    if ([ret isKindOfClass:[NSNull class]]) {
        return value;
    }
    if ([ret isKindOfClass:[NSNumber class]]) {
        return (long)((NSNumber *)ret).longLongValue;
    }
    if ([ret isKindOfClass:[NSString class]]) {
        return (long)((NSString *)ret).longLongValue;
    }
    return value;
}


-(float)H_optFloat:(long)path withDefalutValue:(float)value{
    id ret=[self objectAtIndex:path];
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
-(float)H_optFloat:(long)path{
    return [self H_optFloat:path withDefalutValue:0];
}


//获取值
-(NSArray *)H_optNSArray:(long)path{
    id ret=[self objectAtIndex:path];
    if ([ret isKindOfClass:[NSArray class]] || [ret isKindOfClass:[NSMutableArray class]]) {
        return ret;
    }
    return nil;
}
-(NSMutableArray *)H_optNSMutableArray:(long)path{
    id ret=[self objectAtIndex:path];
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
-(NSDictionary *)H_optNSDictionary:(long)path{
    id ret=[self objectAtIndex:path];
    if ([ret isKindOfClass:[NSDictionary class]] || [ret isKindOfClass:[NSMutableDictionary class]]) {
        return ret;
    }
    return nil;
    
}
-(NSMutableDictionary *)H_optNSMutableDictionary:(long)path{
    id ret=[self objectAtIndex:path];
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
    //        return  array;
    //    }
    return nil;
}

//JSON
+(NSArray *)H_ArrayFromJSONString:(NSString *)jsonString{
    NSError *error;
    id ret=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    if ([ret isKindOfClass:[NSArray class]]) {
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
