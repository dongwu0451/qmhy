//
//  RootTabBarController.m
//  qmhy
//  tabbar根视图控制器
//
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "RootTabBarController.h"
#import "GesturePasswordController.h"
#import "LoginVC.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 把它下面的viewcontroller都加载了,强制显示tabbarImage
    UIViewController * i;
    for (i in self.viewControllers) {
        [i viewDidLoad];
    }}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
