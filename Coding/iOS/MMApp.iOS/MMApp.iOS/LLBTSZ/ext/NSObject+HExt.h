//
//  NSObject+HExt.h
//  HCore
//
//  Created by hyc on 16/11/5.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(HExt)



- (id)H_performSelector:(SEL)aSelector withObjects:(id)objects,... NS_REQUIRES_NIL_TERMINATION;




//设置实例属性，不通过KVO
-(void)H_setValues:(NSDictionary *)values;

//设置实例属性
-(void)H_setValues:(NSDictionary *)values isKVO:(BOOL)kvo;

//获取实例属性
-(NSMutableDictionary *)H_getValues;

@end
