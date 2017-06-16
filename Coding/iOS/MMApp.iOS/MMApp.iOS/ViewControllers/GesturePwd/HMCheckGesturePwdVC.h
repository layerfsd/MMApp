//
//  CheckGesturePwdVC.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/22/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HVC.h"

@class HMCheckGesturePwdVC;
@protocol HMCheckGesturePwdVCDelegate<NSObject>

@optional
-(void)checkGesturePwdVC:(HMCheckGesturePwdVC *)checkGesturePwdVC didFinishWithResult:(BOOL)result password:(NSString *)password;
-(void)checkGesturePwdVCChangeToPwdLogin:(HMCheckGesturePwdVC *)checkGesturePwdVC;
-(void)checkGesturePwdVCReturn:(HMCheckGesturePwdVC *)checkGesturePwdVC;

@end

@interface HMCheckGesturePwdVC : HVC
@property (nonatomic, weak) id<HMCheckGesturePwdVCDelegate> delegate;

@end
