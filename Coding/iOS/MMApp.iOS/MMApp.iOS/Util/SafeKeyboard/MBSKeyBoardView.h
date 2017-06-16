//
//  KeyBoardView.h
//  PasswordKeyBorad
//
//  Created by lori on 12-9-11.
//  Copyright (c) 2012年 LLBT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSKeyButtons.h"
typedef enum{
    NUMBER      = 0,//数字
    UPCHARS     = 1,//大写
    LOWCHARS    = 2,//小写
    SPECIALCHAR = 3,//特殊字符
}MBSKeyBoardType;

typedef enum{
    BEFORESHOW = 0,//show之前
    SHOWING    = 1,//show ing
    AFTERSHOW  = 2,//show之后
}MBSKeyBoardShowState;

@protocol KeyBoardViewDelegate <NSObject>
- (void)didSelectKeyButton:(NSString *)keyValue;
- (void)didHiddenKeyBoard;
- (void)didCancelKeyBoard;
- (void)changeToSystemBoard;

@end

@interface MBSKeyBoardView : UIView<KeyBoardDelegate>
{
    UIView *m_numberKeyView;
    UIView *m_letterKeyView;
    UIView *m_signKeyView;
    
    UIView *m_currentView;
    
    NSMutableArray *m_letterBtnsArray;
    NSMutableArray *m_signBtnsArray;
    NSMutableArray *m_numBtnsArray;
    
    NSArray *m_upcharArray;
    NSArray *m_lowcharArray;
    NSMutableArray *m_numArray;
    NSMutableArray *m_specialCharArray;
    
    NSInteger currentKeyType;
    
    __unsafe_unretained NSObject <KeyBoardViewDelegate> *m_delegate;
    
    UIButton *zoomBtn;
    
    UIButton *m_charBtn;
}

@property (nonatomic,assign) NSObject <KeyBoardViewDelegate> *m_delegate;
- (void)initKeyBoard;
- (void)changeKeyType:(MBSKeyBoardType)keyType;

@end
