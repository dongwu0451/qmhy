//
//  MyTVC.m
//  qmhy
//  我的视图控制器
//  Created by wushuyu on 15-08-14.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MyTVC.h"

@interface MyTVC ()

@end

@implementation MyTVC

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



//分组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

//分组行数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else{
        return 1;
    }
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        return 77.;
    }else{
        return 49.;
    }
}

//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

//组脚高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

//行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    NSLog(@"Wealth didSelectRowAtIndexPath:%d,%d",section,row);
    if (section==1 && row==0){//我的取件
        [self performSegueWithIdentifier:@"showMyGoodsGet" sender:nil];
    }
    if (section==1 && row==1){//邀请
        [self performSegueWithIdentifier:@"showQy" sender:nil];
    }
    if (section==2 && row==0){//我的消息
        [self performSegueWithIdentifier:@"showMyNotify" sender:nil];
    }
    if (section==3 && row==0){//投诉和建议
        [self performSegueWithIdentifier:@"showTousu" sender:nil];
    }
    //    if (section==4 && row==0){//检测新版本
    //        //[self performSegueWithIdentifier:@"showConfigCPassword" sender:nil];
    //    }
}

//行绘制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id id_subTitle id_rightDetail
    
    //判断在哪个section，设置不同cellid
    NSString *cellid;;
    if (indexPath.section==0) {
        cellid = @"id_subTitle";
    }
    else{
        cellid=@"id_rightDetail";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (indexPath.section==0) {//第0个区块，设置用户头像等
        cell.imageView.image=[UIImage imageNamed:@"Wea_avatar"];
        [cell.textLabel setText:@"王师傅"];
        [cell.detailTextLabel setText:@""];//"余额0分  积分12分"];
    }
    else if(indexPath.section==1 && indexPath.row==0){//1.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
        [cell.textLabel setText:@"我的取件"];
        [cell.detailTextLabel setText:@""];//[NSString stringWithFormat:@"%.2f",0.0]];
    }else if(indexPath.section==1 && indexPath.row==1){//1.1
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodeyinhangka"];
        [cell.textLabel setText:@"邀请"];
        [cell.detailTextLabel setText:@""];//[NSString stringWithFormat:@"%d张",0]];
    }else if (indexPath.section==2){//2.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"我的消息"];
        [cell.detailTextLabel setText:@""];
    }else if (indexPath.section==3){//3.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"投诉和建议"];
        [cell.detailTextLabel setText:@""];
    }else{
//        //4.0
//        cell.imageView.image=[UIImage imageNamed:@"Wea_aixinjuanzeng"];
//        [cell.textLabel setText:@"检测新版本"];
//        [cell.detailTextLabel setText:@""];不要了 跟更多重复了 没有必要加这个  用户会奇怪
    }
    return  cell;
}


@end
