//
//  MoreNVC.m
//  qmhy
//  更多 导航器
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MoreNVC.h"

@interface MoreNVC ()

@end

@implementation MoreNVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置图片
    if (!self.tabbarItemImagePath) { //如果没有设置过图片则设置
        self.tabbarItemImagePath=@"tabbed_icon.bundle/gd更多";
        [self setTabBarImage];
    }else{
        return; 
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
