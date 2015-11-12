//
//  OrderSendTVC.m
//  qmhy
//  发件 视图控制器
//  Created by lingsbb on 15-08-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderSendTVC.h"
#import "OrderSendListTVC.h"

@interface OrderSendTVC ()

@end

@implementation OrderSendTVC

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
    //其实这个完全可以做成static tableview。

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//组内行数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 9;
    }
}

//行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 94.;
    }else if(indexPath.section==1){
        return 50.;
    }else{
        return 0.;
    }
}

//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 16;
    }else{
        return 21;
    }
}

//组脚高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//绘制cell 最后几行图标不够
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id id_fourbuttons id_rightDetail
    
    //判断在哪个section，设置不同cellid
    NSString *cellid;;
    if (indexPath.section==0) {
        cellid = @"id_fourbuttons";
    }else{
        cellid=@"id_rightDetail";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    //section==0时就不修改了（创建DiscoveryButton时内部维护），section==1时需要设置title和detail
    if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_movie"];
            [cell.textLabel setText:@"1-订单提交"];
            [cell.detailTextLabel setText:@"订单提交"];
        } else if (indexPath.row==1) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"2-分派提货人"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==2) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"3-取货途中"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==3) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"4-已开单"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==4) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"5-已到物流"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==5) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"6-配货物流途中"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==6) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"7-已装车"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==7) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"8-已到达"];
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==8) {
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.textLabel setText:@"9-已取货"];
            [cell.detailTextLabel setText:@""];
        }
        
    }
    
    return cell;
    
}

//实现自定义菜单 标题的委托
-(NSString *)setIconTitle:(id)button{
    UIButton * but=button;
    switch (but.tag) {
        case 1:
            return @"未到物流22";
            break;
        case 2:
            return @"未收票据";
            break;
        case 3:
            return @"取代收";
            break;
        case 4:
            return @"待评价";
            break;
        default:
            return @"";
            break;
    }
}


//行选择事件 ：订单提交（未到物流）已开单（未收票据）待评价等四个自定义菜单 直接用StoryBoard连线跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //订单提交（未到物流）已开单（未收票据）待评价等四个自定义菜单 直接用StoryBoard连线跳转
//    NSInteger row=indexPath.row;
//    NSInteger section=indexPath.section;
//    NSLog(@"Wealth didSelectRowAtIndexPath:%d,%d",section,row);
//    if (section==1 && row==0){//订单提交
//        [self performSegueWithIdentifier:@"showGoodsSend" sender:nil];
//    }
//    if (section==1 && row==1){//分派提货人
//        [self performSegueWithIdentifier:@"showGoodsSend" sender:nil];
//    }
//    if (section==1 && row==2){//取货途中
//        [self performSegueWithIdentifier:@"showGoodsSend" sender:nil];
//    }
//    if (section==1 && row==3){//已开单
//        [self performSegueWithIdentifier:@"showGoodsSend" sender:nil];
//    }
}

//准备跳转之前的事件
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.theTableview indexPathForSelectedRow];
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    
    NSLog(@"row=====:%d",indexPath.row);
    if([segue.identifier isEqualToString:@"showGoodsSend1"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
        tvc.newtitle=@"订单提交（未到物流）";
    }
    if([segue.identifier isEqualToString:@"showGoodsSend2"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
        tvc.newtitle=@"已开单（未收票据）";
    }
    //订单提交（未到物流）已开单（未收票据）待评价等四个自定义菜单 直接用StoryBoard连线跳转
    if([segue.identifier isEqualToString:@"showGoodsSend"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
        //tvc.navigationItem.title=@"a";
        //tvc.newtitle=@"SSSS";
//        if (section==0 && row==0)
//            tvc.newtitle=@"订单提交（未到物流）";
//        if (section==0 && row==1)
//            tvc.newtitle=@"已开单（未收票据）";
        
        if (section==1 && row==0)
            tvc.newtitle=@"订单提交";
        if (section==1 && row==1)
            tvc.newtitle=@"分派提货人";
        if (section==1 && row==2)
            tvc.newtitle=@"取货途中";
        if (section==1 && row==3)
            tvc.newtitle=@"已开单";
        
        if (section==1 && row==4)
            tvc.newtitle=@"已到物流";
        if (section==1 && row==5)
            tvc.newtitle=@"配货物流途中";
        if (section==1 && row==6)
            tvc.newtitle=@"已装车";
        if (section==1 && row==7)
            tvc.newtitle=@"已到达";
        if (section==1 && row==8)
            tvc.newtitle=@"已取货";
        
        //[self performSegueWithIdentifier:@"showAboutDetail" sender:nil];
        
        
        //        NSIndexPath *indexPath = [self.theTableView indexPathForSelectedRow];
        //        RecipeDetailViewController *destViewController = segue.destinationViewController;
        //        destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
    }
}
@end
