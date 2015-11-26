//
//  MyNVC.m
//  qmhy
//  我的 导航器
//  Created by wushuyu on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MyNVC.h"

@interface MyNVC ()

@end

@implementation MyNVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置图片
    self.tabbarItemImagePath=@"tabbed_icon.bundle/wd我的";
    [self setTabBarImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
