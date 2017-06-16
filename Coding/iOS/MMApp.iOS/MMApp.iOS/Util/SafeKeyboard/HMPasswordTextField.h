//
//  CPSPasswordTextField.h
//  CPS_SDK
//
//  Created by GPP on 15/8/13.
//  Copyright (c) 2015年 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KeyBoradTypeDefault = 0,//自定义键盘 默认模式
    KeyBoradTypeNumber = 1,//自定义键盘 数字模式
} HMKeyBoardType;

@class HMPasswordTextField;
@protocol HMPasswordTextFieldDelegate <NSObject>

- (void)passwordTextField:(HMPasswordTextField *)textField
    textHasChanged:(NSString *)value;

@end

@interface HMPasswordTextField : UITextField
@property (nonatomic,assign) HMKeyBoardType keyBoardType;//设置键盘模式
@property (nonatomic, assign) NSUInteger textMaxLength;//输入长度

@property (assign) id<HMPasswordTextFieldDelegate> hmDelegate;

@end
