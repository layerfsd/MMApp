//
//  CPSPasswordTextField.m
//  CPS_SDK
//
//  Created by GPP on 15/8/13.
//  Copyright (c) 2015年 LLBT. All rights reserved.
//

#import "HMPasswordTextField.h"
#import "MBSKeyBoardView.h"
#import "HMConstants.h"

#define cps_kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define cps_kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface HMPasswordTextField ()<KeyBoardViewDelegate>
{
    MBSKeyBoardView *mKeyBoardView;//自定义键盘
}
@end

@implementation HMPasswordTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mKeyBoardView = [[MBSKeyBoardView alloc] initWithFrame:CGRectMake(0, cps_kScreenHeight-240, cps_kScreenWidth, 230)];
        mKeyBoardView.m_delegate = self;
        self.inputView = mKeyBoardView;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}
- (void)returnKeyboard
{
    [self resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //密码输入框  不允许输入空格
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ( _textMaxLength > 0 && text.length > _textMaxLength )
    {
        return NO;
    }
    return YES;
    
}


-(void)setKeyBoardType:(HMKeyBoardType)keyBoardType{
    switch (keyBoardType) {
        case KeyBoradTypeDefault:
        {
            [mKeyBoardView changeKeyType:LOWCHARS];
        }
            break;
        case KeyBoradTypeNumber:
        {
            [mKeyBoardView changeKeyType:NUMBER];
        }
            
        default:
            break;
    }
}
#pragma mark -
- (void)didSelectKeyButton:(NSString *)keyValue{
    if ([keyValue isEqualToString:@""]&& self.text.length != 0 )
    {
        self.text = [self.text substringToIndex:self.text.length-1];
    }else if([keyValue isEqualToString:@""] && self.text.length == 0) {
        //如果m_textField中没有内容，单击删除键时，我们什么也不做
    }else {
        if ([self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:keyValue]) {
            NSString *value = [NSString stringWithFormat:@"%@%@",self.text,keyValue];
            self.text = value;
        }
    }
    [self.hmDelegate passwordTextField:self textHasChanged:self.text];
}
- (void)didHiddenKeyBoard{
    [self returnKeyboard];
}

- (void)didCancelKeyBoard{
    [self returnKeyboard];
}

- (void)changeToSystemBoard{
}

@end
