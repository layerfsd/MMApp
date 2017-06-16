//
//  NSObject+HExt.m
//  HCore
//
//  Created by hyc on 16/11/5.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "NSObject+HExt.h"
#import <objc/runtime.h>
@implementation NSObject(HExt)


- (id)H_performSelector:(SEL)aSelector withObjects:(id)objects,...{
    NSMethodSignature * sig  = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    if (objects) {
        int index=2;
        id param=nil;
        [invocation setArgument:&objects atIndex:index];
        index++;
        va_list args;
        va_start(args, objects);
        while (1){
            param = va_arg(args, id);
            if(param == nil){
                break;
            }else{
                [invocation setArgument:&param atIndex:index];
                index++;
            }
        }
    va_end(args);
    [invocation retainArguments];
    }
    [invocation invoke];
    id __autoreleasing ret=nil;
    if (sig.methodReturnLength != 0) {
        [invocation getReturnValue:&ret];
    }
    return ret;
  }


//设置实例属性，通过KVO
-(void)H_setValues:(NSDictionary *)values{
    [self H_setValues:values isKVO:YES];
}

//设置实例属性
-(void)H_setValues:(NSDictionary *)values isKVO:(BOOL)kvo{
    if (!values) {
        return;
    }
    unsigned int propCount=0;
    objc_property_t *props= class_copyPropertyList([self class], &propCount);
    for (int i=0; i<propCount; i++) {
        objc_property_t itemp=props[i];
        const char* type= property_copyAttributeValue(itemp, "T");
        const char *itemNameChar= property_getName(itemp);
        NSString *itemName=  [NSString stringWithCString:itemNameChar encoding:NSUTF8StringEncoding];
        id itemValue= [values objectForKey:itemName];
        if (itemValue) {
            if (kvo) {
                [self setValue:itemValue forKey:itemName];
            }else{
               Ivar itemVar=  class_getInstanceVariable([self class], [NSString stringWithFormat:@"_%@",itemName].UTF8String);
                if (itemVar) {
                    if (type[0]==_C_ID) {
                        //NSObject对象
                         object_setIvar(self, itemVar, itemValue);
                    }else {
                        [self setValue:itemValue forKey:itemName];
                    }
                }
            }
        }
    }
    free(props);
}

//获取实例属性
-(NSMutableDictionary *)H_getValues{
    NSMutableDictionary *mdic=[NSMutableDictionary new];
    unsigned int propCount=0;
    objc_property_t *props= class_copyPropertyList([self class], &propCount);
    for (int i=0; i<propCount; i++) {
        objc_property_t itemp=props[i];
        const char *itemNameChar= property_getName(itemp);
        NSString *itemName=  [NSString stringWithCString:itemNameChar encoding:NSUTF8StringEncoding];
        id getValue=[self valueForKey:itemName];
        if (getValue) {
            [mdic setValue:getValue forKey:itemName];
        }
    }
    free(props);
    return mdic;
}
@end
