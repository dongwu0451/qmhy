//
//  GoodsSendTVC.m
//  qmhy
//  发件订单列表
//  Created by lingsbb on 15-8-22.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderSendListTVC.h"

@interface OrderSendListTVC ()

@end

@implementation OrderSendListTVC

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

    //维护UINavigationItem
    
    //重写左侧按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    //重写标题
    if (self.newtitle) {
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 144)];
        title.text=self.newtitle;
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor whiteColor];
        self.navigationItem.titleView=title;
        NSLog(@"setTitle");
    }
}

//返回按钮
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
