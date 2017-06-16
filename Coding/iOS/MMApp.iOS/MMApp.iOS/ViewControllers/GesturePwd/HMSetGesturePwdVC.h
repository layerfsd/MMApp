//
//  SetGesturePwdVC.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HVC.h"

@class HMSetGesturePwdVC;
@protocol HMSetGesturePwdVCDelegate<NSObject>

@optional
-(void)setGesturePwdVC:(HMSetGesturePwdVC *)setGesturePwdVC result:(BOOL)result
                passwd:(NSString *)passwd;
@end

@interface HMSetGesturePwdVC : HVC

//- (instancetype)initWithPhoneNum:(NSString *)phoneNum;
@property (nonatomic, weak) id<HMSetGesturePwdVCDelegate> delegate;
@property int retryLimit;  //失败最大次数

@end
