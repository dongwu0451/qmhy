//
//  ConfigCCityTVC.m
//  qmhy
//  配置常用城市信息
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCCityTVC.h"
#import "ConfigCommonTVC.h"
@interface ConfigCCityTVC ()
//右上角的添加
- (IBAction)addCity:(id)sender;
@end

@implementation ConfigCCityTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

//右上角的添加
- (IBAction)addCity:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"您的邀请码是12345678"delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"知道了", nil];
    [alert show];
    //0 王师傅
    //1 配置常用信息
    //2 本身
    //[self.navigationController popToViewController:
    //[self.navigationController.viewControllers objectAtIndex:1] animated:YES ] ;
}
@end
