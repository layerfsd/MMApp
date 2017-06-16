//
//  HKeyChain.h
//  OSChina
//
//  Created by hyc on 15/6/7.
//  Copyright (c) 2015年 hyc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HCoreComm.h"
@interface HKeyChain : NSObject

AS_SINGLETON(HKeyChain)

-(BOOL)H_put:(NSString *) key withValue:(id)value;
-(id)H_get:(NSString *)key;
-(id)H_remove:(NSString *) key;
-(BOOL)H_isContain:(id)key;


@end
