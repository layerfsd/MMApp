//
//  SetGesturePwdVC.m
//  CCBGJJ.iOS
//
//  Created by Sam Yu on 2/21/17.
//  Copyright © 2017 CCB. All rights reserved.
//

#import "HMSetGesturePwdVC.h"
#import "YLSwipeLockView.h"
#import "UIColor+HExt.h"
#import "HThreadHelper.h"
#import "HMPreferences.h"

@interface HMSetGesturePwdVC () <YLSwipeLockViewDelegate>

@property(nonatomic,strong)YLSwipeLockView *lockView;
@property(nonatomic,strong)NSString *passwd;
@property (nonatomic, strong) NSString *phone;

@end

@implementation HMSetGesturePwdVC

- (instancetype)initWithPhoneNum:(NSString *)phoneNum{
    if(self = [super init]){
        _phone = phoneNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBgColor:[UIColor H_stringColor:@"#4FBFFB"]];
    [self addNavigationBar:@"设置手势" withBack:YES withTitileColor:[UIColor H_stringColor:@"#FFFFFF"]];

    [self setSplitColor:[UIColor clearColor]];
}

-(void)onLeftButtonClick{
    [HThreadHelper H_enqueueMainThreadPool:^{
        [self popViewControllerAnimated:YES];
    }];
    if (_delegate) {
        [_delegate setGesturePwdVC:self result:NO passwd:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YLSwipeLockViewDelegate
-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password{
    if(password.length<6){
        [self showToast:@"手势长度不小于6"];
        return YLSwipeLockViewStateNormal;
    }
    if (_passwd == nil) {
        _passwd=[NSString stringWithString:password];
        return YLSwipeLockViewStateNormal;
    }
    else if ([_passwd isEqualToString:password]){
        [HMPreferences setGesturePassword:_passwd];
        [HMPreferences setGesturePasswordRetryLimit:self.retryLimit];
        if (_delegate) {
            [_delegate setGesturePwdVC:self result:YES passwd:password];
        }
        [HThreadHelper H_enqueueMainThreadPoolWithDelay:^{
            [self popViewControllerAnimated:YES];
        } delay:1];
        return YLSwipeLockViewStateSelected;
    }else{
        _passwd=nil;
        [self showToast:@"2次输入手势不一致,请重新输入"];
        return YLSwipeLockViewStateWarning;
    }
}


@end
