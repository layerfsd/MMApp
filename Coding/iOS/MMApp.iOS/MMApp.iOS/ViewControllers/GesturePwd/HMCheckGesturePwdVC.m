//
//  CheckGesturePwdVC.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/22/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HMCheckGesturePwdVC.h"
#import "YLSwipeLockView.h"
#import "UIColor+HExt.h"
#import "HMPreferences.h"
#import "HThreadHelper.h"

@interface HMCheckGesturePwdVC () <YLSwipeLockViewDelegate>
@property(nonatomic,strong)YLSwipeLockView *lockView;
@property(nonatomic,strong)NSString *passwd;
@property(nonatomic,assign)int tryCount;
@end

@implementation HMCheckGesturePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBgColor:[UIColor H_stringColor:@"#4FBFFB"]];
    [self addNavigationBar:@"验证手势" withBack:YES];
    [self setSplitColor:[UIColor clearColor]];
    
    _passwd = [HMPreferences getGesturePassword];
    _tryCount= [HMPreferences getGesturePasswordRetryLimit];
    if (_tryCount <=0) {
        [_delegate checkGesturePwdVC:self didFinishWithResult:NO password:nil];
    }

    //添加按钮
    [self addChangeStateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChangeStateButton{
    UIButton *stateBtn = [[UIButton alloc] init];
    [stateBtn addTarget:self action:@selector(clickPwdLoginButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:stateBtn];
    [stateBtn setTitle:@"密码登陆" forState:UIControlStateNormal];
    stateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [stateBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    stateBtn.backgroundColor = [UIColor clearColor];
    
    //约束
    stateBtn.translatesAutoresizingMaskIntoConstraints = NO;
    //中心x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:stateBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    //中心y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:stateBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:(-80)]];
}

- (void)clickPwdLoginButton{
    [self popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(checkGesturePwdVCChangeToPwdLogin:)]){
        [_delegate checkGesturePwdVCChangeToPwdLogin:self];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initView];
}

-(void)initView{
    self.view.backgroundColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1];
    _lockView=[[YLSwipeLockView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH)/2+20, SCREEN_WIDTH, SCREEN_WIDTH)];
    [self.view addSubview:_lockView];
    _lockView.delegate=self;
}

-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password{
    if(password.length<6){
        [self showToast:@"手势长度不小于6"];
        return YLSwipeLockViewStateNormal;
    }
    if ([password isEqualToString:_passwd]) {
        if(_delegate){
            [_delegate checkGesturePwdVC:self didFinishWithResult:YES password:_passwd];
        }
        [self popViewControllerAnimated:YES];
        return YLSwipeLockViewStateNormal;
    }else{
        _tryCount--;
        [HMPreferences setGesturePasswordRetryLimit:_tryCount];
        if (_tryCount == 0) {
            if(_delegate){
                [_delegate checkGesturePwdVC:self didFinishWithResult:NO password:nil];
            }
        }else {
            [self showToast:[NSString stringWithFormat:@"您还有%d次机会",_tryCount]];
        }
        return YLSwipeLockViewStateWarning;
    }
}

- (void)dealloc{
    [self.toastView removeFromSuperview];
    self.toastView = nil;
}

@end
