//
//  HVC.m
//
//  Created by hyc on 16/12/12.
//  Copyright © 2016年 LLBT. All rights reserved.
//

#import "HVC.h"
#import "HCoreComm.h"
#import "UIColor+HExt.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "HThreadHelper.h"
@interface HVC ()
@property (nonatomic, strong) UILabel *msgLabel;
@end

@implementation HVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
}

//添加NaViagationBar
-(void) addNavigationBar{
    _mNavigationBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UIView *split=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
    [split setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]];
    split.tag=100;
    [self.view addSubview:_mNavigationBar];
    [_mNavigationBar addSubview:split];
    //[_mNavigationBar setBackgroundColor:[UIColor blueColor]];
}

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withTitileColor:(UIColor*)titleColor{
    [self addNavigationBar];
    [self setNavigationTitle:title witColor:titleColor];
}

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withBack:(BOOL)back withTitileColor:(UIColor*)titleColor{
    [self addNavigationBar];
    [self setNavigationTitle:title witColor:titleColor];
    if (back) {
        [self setLeftButton:@"icon_back"];
    }
}

//设置NavigationBar背景颜色
-(void) setNavigationBgColor:(UIColor *)bgcolor{
    if (_mNavigationBar) {
        [_mNavigationBar setBackgroundColor:bgcolor];
    }
}

//设置标题
-(void)setNavigationTitle:(NSString *)title witColor:(UIColor *)color{
    UILabel *titleView=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 20, SCREEN_WIDTH/2, 42)];
    [titleView setText:title];
    [titleView setTextAlignment:NSTextAlignmentCenter];
    [titleView setTextColor:color];
    [titleView setBackgroundColor:[UIColor clearColor]];
    [titleView setFont:[UIFont systemFontOfSize:18]];
    if (_mNavigationBar) {
        [_mNavigationBar addSubview:titleView];
    }
    
}
//设置标题
-(void)setNavigationTitle:(NSString *)title{
    [self setNavigationTitle:title witColor:[UIColor blackColor]];
}

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title{
    [self addNavigationBar:title withBack:NO];
}

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withBack:(BOOL)back{
    [self addNavigationBar];
    [self setNavigationTitle:title];
    if (back) {
        [self setLeftButton:@"icon_back"];
    }
}

//设置NavigationBar左边按钮
-(void)setLeftButton:(NSString *)localPicPath{
    UIButton *leftButton= [[UIButton alloc]initWithFrame:CGRectMake(10, 2+20, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:localPicPath] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onLeftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_mNavigationBar addSubview:leftButton];
}
//设置NavigationBar右边按钮
-(void)setRightButton:(NSString *)localPicPath{
    UIButton *leftButton= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-42, 2+20, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:localPicPath] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:localPicPath] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(onRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_mNavigationBar addSubview:leftButton];
}


//设置分割线的颜色
-(void)setSplitColor:(UIColor *)splitColor;
{
    UIView *splitView=[_mNavigationBar viewWithTag:100];
    if (splitView) {
        [splitView setBackgroundColor:splitColor];
    }
}


//获取字体高度
-(CGFloat)getTextHeight:(NSString *)str withFont:(UIFont *)font withW:(CGFloat)w{
    CGSize size = CGSizeMake(w  , 29999);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

//显示提示
-(void)showToast:(NSString *)str{
    if (_toastView) {
        [HThreadHelper H_enqueueMainThreadPool:^{
            [_toastView removeFromSuperview];
            _toastView = nil;
        }];
    }
    int with=SCREEN_WIDTH *2/3;
    [self.msgLabel setText:str];
    CGFloat  msgH=[self getTextHeight:str withFont:[UIFont systemFontOfSize:20]  withW:with-10]+4;
    int heigth=msgH+30;
    _msgLabel.frame = CGRectMake(5, 15, with-10, msgH);
    int x=SCREEN_WIDTH/6;
    int y=self.view.frame.size.height/4-20;
    self.toastView=[[UIView alloc]initWithFrame:CGRectMake(x, y, SCREEN_WIDTH *2/3, heigth)];
    [_toastView setBackgroundColor:[UIColor H_stringColor:@"0000"]];
    [_toastView addSubview:_msgLabel];
    _toastView.layer.cornerRadius=8;
    _toastView.layer.masksToBounds=YES;
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).window addSubview:_toastView];
    [HThreadHelper H_enqueueMainThreadPoolWithDelay:^{
        [_toastView removeFromSuperview];
        _toastView = nil;
    } delay:1500];
}

- (UILabel *)msgLabel{
    if (_msgLabel == nil) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.numberOfLines=0;
        _msgLabel.textAlignment=NSTextAlignmentCenter;
        [_msgLabel setFont:[UIFont systemFontOfSize:16]];
        [_msgLabel setTextColor:[UIColor H_stringColor:@"ff0000"]];
    }
    return _msgLabel;
}

//设置右边文字按钮
-(void)setRightButtonText:(NSString *)text withColor:(UIColor *)color{
    UIButton *rightView=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10+20, 50, 24)];
    [rightView setTitle:text forState:UIControlStateNormal];
    [rightView.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [rightView setTitleColor:color forState:UIControlStateNormal];
    [rightView.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [rightView addTarget:self action:@selector(onRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    rightView.layer.borderWidth=1.0f;
//    rightView.layer.borderColor=[color CGColor];
//    rightView.layer.cornerRadius=12;
//    rightView.layer.masksToBounds=YES;
    [_mNavigationBar addSubview:rightView];
}

//左边按钮点击事件
-(void)onLeftButtonClick{
    [self popViewControllerAnimated:YES];
}
//右边按钮点击事件
-(void)onRightButtonClick{
    
}

//获取ViewController
+(instancetype)getController{
    return [[self class] new];
}


//
-(void) dealloc{
    unsigned int count=0;
    objc_property_t *pp= class_copyPropertyList([self class], &count);
    for(int i=0;i<count;i++){
        NSString *name=[NSString stringWithFormat:@"_%s",property_getName(pp[i])];
        Ivar ivar = class_getInstanceVariable([self class], [name UTF8String]);
        if(ivar){
            object_setIvar(self,ivar,nil);
        }
    }
    free(pp);
}


-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated{
    [self.view endEditing:YES];
    [self.navigationController pushViewController:controller animated:animated];
}


-(void)popViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:YES];
    [self removeChildView:self.view.subviews];
    [self.navigationController popViewControllerAnimated:YES];
    //self.view=nil;
}

-(void)removeChildView:(NSArray *)views{
    for (UIView *item in views) {
        NSArray *subVies=item.subviews;
        if (subVies && subVies.count>0) {
            [self removeChildView:subVies];
        }
        [item.layer removeAllAnimations];
        [item removeFromSuperview];
    }
}



@end
