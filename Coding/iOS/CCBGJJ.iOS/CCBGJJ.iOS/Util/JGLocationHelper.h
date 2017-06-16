//
//  JGLocationHelper.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JGLocationHelper;
@protocol JGLocationHelperDelegate <NSObject>

- (void)locationHelper:(JGLocationHelper *)helper
    didGetlocationLong:(NSString *)locationLong locationLat:(NSString *)locationLat address:(NSString *)address;

- (void)locationHelper:(JGLocationHelper *)helper
    didFailWithError:(NSError *)error;

@end

@interface JGLocationHelper : NSObject
@property (assign) id<JGLocationHelperDelegate> delegate;

//定位
-(void)startGetLocation;

@end
