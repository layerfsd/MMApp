//
//  CheckGesturePwdVC.h
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/22/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HVC.h"

@class CheckGesturePwdVC;
@protocol CheckGesturePwdVCDelegate<NSObject>

@optional
-(void)checkGesturePwdVC:(CheckGesturePwdVC *)checkGesturePwdVC didFinishWithResult:(BOOL)result password:(NSString *)password;
-(void)checkGesturePwdVCChangeToPwdLogin:(CheckGesturePwdVC *)checkGesturePwdVC;
-(void)checkGesturePwdVCReturn:(CheckGesturePwdVC *)checkGesturePwdVC;

@end

@interface CheckGesturePwdVC : HVC
@property (nonatomic, weak) id<CheckGesturePwdVCDelegate> delegate;

@end
