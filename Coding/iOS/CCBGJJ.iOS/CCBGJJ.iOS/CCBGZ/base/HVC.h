//
//  HVC.h
//  BBank
//
//  Created by hyc on 16/12/12.
//  Copyright © 2016年 CCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVC : UIViewController

@property(nonatomic,strong)UIView *mNavigationBar;
@property (nonatomic, strong) UIView *toastView;
//添加NaViagationBar
-(void) addNavigationBar;

//设置NavigationBar背景颜色
-(void) setNavigationBgColor:(UIColor *)bgcolor;

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title;

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withTitileColor:(UIColor*)titleColor;

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withBack:(BOOL)back;

//添加NavigationBar
-(void) addNavigationBar:(NSString*)title withBack:(BOOL)back withTitileColor:(UIColor*)titleColor;

//设置标题
-(void)setNavigationTitle:(NSString *)title witColor:(UIColor *)color;

//设置标题
-(void)setNavigationTitle:(NSString *)title;

//设置NavigationBar左边按钮
-(void)setLeftButton:(NSString *)localPicPath;
//设置NavigationBar右边按钮
-(void)setRightButton:(NSString *)localPicPath;
//设置分割线的颜色
-(void)setSplitColor:(UIColor *)splitColor;

//设置右边文字按钮
-(void)setRightButtonText:(NSString *)text withColor:(UIColor *)color;


//左边按钮点击事件(默认退出当前界面)
-(void)onLeftButtonClick;
//右边按钮点击事件
-(void)onRightButtonClick;

//显示提示
-(void)showToast:(NSString *)str;

+(instancetype)getController;

-(void)popViewControllerAnimated:(BOOL)animated;
-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
@end
