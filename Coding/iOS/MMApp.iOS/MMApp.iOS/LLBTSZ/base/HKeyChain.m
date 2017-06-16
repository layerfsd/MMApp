//
//  HKeyChain.m
//  OSChina
//
//  Created by hyc on 15/6/7.
//  Copyright (c) 2015年 LLBT. All rights reserved.
//

#import "HKeyChain.h"
#import <Security/Security.h>
@implementation HKeyChain


DEF_SINGLETON(HKeyChain)


-(NSMutableDictionary *)getKeychainQuery:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,key, (__bridge id)kSecAttrService,key, (__bridge id)kSecAttrAccount,(__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,nil];
    
}



/**
 *  @name           H_getSize
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    获取缓存大小
 *  @return         int
 */
-(int)H_getSize{
    return 0;
}



/**
 *  @name           H_put:withValue
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    向缓存中设置值
 *  @return         bool
 */
-(BOOL)H_put:(NSString *) key withValue:(id)value{
    if (!key || !value) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(__bridge id)kSecValueData];
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    return YES;
}


/**
 *  @name           H_get
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    从缓存中取值
 *  @return         id
 */

-(id)H_get:(NSString *)key{
    if(!key){
        return nil;
    }
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id ret;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
            
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}


/**
 *  @name           H_remove
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    从缓存中删除
 *  @return         id
 */

-(id)H_remove:(NSString *) key{
    if(!key){
        return nil;
    }
    id value=[self H_get:key];
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    return value;
}


/**
 *  @name           H_removeAll
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    从缓存中删除所有数据
 */
-(void )H_removeAll{
    //TODO 未实现
}

/**
 *  @name           H_isContain
 *  @time           2015-06-07 10:36
 *  @athor          goodluckus
 *  @description    缓存是否存在某个值
 *  @return         bool
 */

-(BOOL)H_isContain:(id)key{
    if(!key){
        return NO;
    }
    id value=[self H_get:key];
    return  value!=nil;
}


@end
