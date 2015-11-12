//
//  NotifyTVC.m
//  qmhy
//  我的消息 视图控制器
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyTVC.h"
#import "NotifyContentTVC.h"

@interface NotifyTVC ()

@end

@implementation NotifyTVC

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

//绘制行
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellid;;
    cellid=@"id_rightDetail";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(indexPath.section==0 && indexPath.row==0){
        //0.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
        [cell.textLabel setText:@"货运小秘"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",@"点击查看您与客服的会话记录"]];
    }else if(indexPath.section==0 && indexPath.row==1){
        //0.1
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodeyinhangka"];
        [cell.textLabel setText:@"物流通知"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",@"点击查看最新的物流情况"]];
    }else if (indexPath.section==0 && indexPath.row==2){
        //0.2
        cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"优惠活动"];
        [cell.detailTextLabel setText:@"点击查看最新的物流信息"];
    }else if (indexPath.section==0 && indexPath.row==3){
        //0.3
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"最新通知"];
        [cell.detailTextLabel setText:@"全民货运第一手信息"];
    }
    return  cell;
}

//动态修改子界面的标题  消息详情标题
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"prepareForSegue aaaaaaa");
    NSIndexPath *indexPath = [self.theTableview indexPathForSelectedRow];
    NSLog(@"row=====:%d",indexPath.row);
    //if([segue.identifier isEqualToString:@"showDetailAbout"]){
        NotifyContentTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
        //tvc.navigationItem.title=@"a";
        if (indexPath.row==0)
            tvc.newtitle=@"货运小秘";
    if (indexPath.row==1)
        tvc.newtitle=@"物流通知";
    if (indexPath.row==2)
        tvc.newtitle=@"优惠活动";
    if (indexPath.row==3)
        tvc.newtitle=@"最新通知";
}


@end
