//
//  AppDelegate.h
//  qmhy
//  应用程序入口
//
//  Created by lingsbb on 2015-08.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GesturePasswordController.h"
#import "RootTabBarController.h"
#import "LoginVC.h"
#import "HomeVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,LoginVCDelegate,GesturePasswordControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
//下面两个属性一个方法都是用来显示splash screen的
//封面视图控制器
@property (strong,nonatomic) UIViewController * splashViewController;
//封面的动画方法
-(void)splashAnimate:(NSNumber*)alpha;

#pragma 三个显示方法
//显示第一次显示登录框
-(void)showLoginVC;
//显示手势识别密码
-(void)showGestureVC;
//显示主页
-(void)showTabbarVC;
+(void)showAlert:(NSString *)str;
+(BOOL)isBlankString:(NSString *)string;
@end
