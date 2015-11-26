//
//  ConfigCommonTVC.m
//  qmhy
//
//  Created by lingsbb on 15-8-17.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCommonTVC.h"

@interface ConfigCommonTVC ()

@end

@implementation ConfigCommonTVC

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //维护UINavigationItem
    //左
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
}
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0){
//        return 49.;
//    }else{
//        return 49.;
//    }
    return 49.;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellid;;
    cellid=@"id_rightDetail";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(indexPath.section==0 && indexPath.row==0){
        //0.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
        [cell.textLabel setText:@"修改密码"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",@""]];
    }else if(indexPath.section==0 && indexPath.row==1){
        //0.1
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodeyinhangka"];
        [cell.textLabel setText:@"银行卡"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",@""]];
    }else if (indexPath.section==1 && indexPath.row==0){
        //1.0
        cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"配置常用物流"];
        [cell.detailTextLabel setText:@""];
    }else if (indexPath.section==1 && indexPath.row==1){
        //1.1
        cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"配置常用货物"];
        [cell.detailTextLabel setText:@""];
    } else if (indexPath.section==1 && indexPath.row==2){
        //1.3
        cell.imageView.image=[UIImage imageNamed:@"Wea_aixinjuanzeng"];
        [cell.textLabel setText:@"配置常用发货信息"]; // 据说改成发货
        [cell.detailTextLabel setText:@""];
    }else if (indexPath.section==1 && indexPath.row==3){
        //1.4
        cell.imageView.image=[UIImage imageNamed:@"Wea_aixinjuanzeng"];
        [cell.textLabel setText:@"配置常用收货信息"];
        [cell.detailTextLabel setText:@""];
    }
    return  cell;
}


//行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath:%d",indexPath.row);
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    if (section==0 && row==0){//修改密码
        [self performSegueWithIdentifier:@"showConfigCPassword" sender:nil];
        NSLog(@"showConfigCPassword");
    }
    if (section==0 && row==1){//银行卡
        [self performSegueWithIdentifier:@"showConfigCBank" sender:nil];
        NSLog(@"showConfigCBank");
    }
    if (section==1 && row==0){//配置常用物流
        [self performSegueWithIdentifier:@"showConfigCWuliu" sender:nil];
        
        NSLog(@"showConfigCWuliu");
    }
    if (section==1 && row==1){//配置常用货物
        [self performSegueWithIdentifier:@"showConfigCGoods" sender:nil];
        NSLog(@"showConfigCGoods");
    }
    if (section==1 && row==2){//配置常用取货信息  据说改成发货
        [self performSegueWithIdentifier:@"showConfigCQuhuo" sender:nil];
        NSLog(@"showConfigCQuhuo");
    }
    if (section==1 && row==3){//配置常用收货信息
        [self performSegueWithIdentifier:@"showConfigCShouhuo" sender:nil];
        NSLog(@"showConfigCShouhuo");
    }
}


@end
