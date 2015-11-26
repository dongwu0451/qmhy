//
//  HomeNVC.m
//  qmhy
//  主页导航器：从SinglePageNVC派生
//
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "HomeNVC.h"

@interface HomeNVC ()

@end

@implementation HomeNVC

//利用父类完成图标填充
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置图片
    self.tabbarItemImagePath=@"tabbed_icon.bundle/zy主页";
    // 父类SinglePageNVC  定义setTabBarImage的tabbarItemImagePath
    [self setTabBarImage];
    self.tabBarController.view.backgroundColor=[UIColor whiteColor];
    
//    CGRect frame = CGRectMake(0, 0, 320, 49);
//    UIView *v = [[UIView alloc] initWithFrame:frame];
//    UIImage *img = [UIImage imageNamed:@"tabbar.png"];
//    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
//    v.backgroundColor = color;
//    [tabBarController.tabBar insertSubview:v atIndex:0];
//    tabBarController.tabBar.opaque = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
