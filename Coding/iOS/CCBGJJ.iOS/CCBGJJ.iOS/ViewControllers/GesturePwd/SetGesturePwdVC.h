//
//  SetGesturePwdVC.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HVC.h"

@class SetGesturePwdVC;
@protocol SetGesturePwdVCDelegate<NSObject>

@optional
-(void)setGesturePwdVC:(SetGesturePwdVC *)setGesturePwdVC result:(BOOL)result
                passwd:(NSString *)passwd;
@end

@interface SetGesturePwdVC : HVC

//- (instancetype)initWithPhoneNum:(NSString *)phoneNum;
@property (nonatomic, weak) id<SetGesturePwdVCDelegate> delegate;

@end
