//
//  Preferences.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/20/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGPreferences : NSObject

+ (NSString *)getDeviceId;
+ (void)setDeviceId:(NSString *)deviceId;

+ (NSString *)getGesturePassword;
+ (void)setGesturePassword:(NSString *)password;

+ (NSData *)getFingerprintStateData;
+ (void)setFingerprintStateData:(NSData *)stateData;

@end
