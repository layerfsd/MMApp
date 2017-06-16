//
//  HMLocationHelper.h
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 LLBT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMLocationHelper;
@protocol HMLocationHelperDelegate <NSObject>

//address: 如何进行本地化处理？ TBD
- (void)locationHelper:(HMLocationHelper *)helper
    didGetlocationLong:(NSString *)locationLong locationLat:(NSString *)locationLat address:(NSDictionary *)address;

- (void)locationHelper:(HMLocationHelper *)helper
    didFailWithError:(NSError *)error;

@end

@interface HMLocationHelper : NSObject
@property (assign) id<HMLocationHelperDelegate> delegate;

//定位
-(void)startGetLocation;

@end
