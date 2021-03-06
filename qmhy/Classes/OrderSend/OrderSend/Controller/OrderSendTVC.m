//
//  OrderSendTVC.m
//  qmhy
//  发件 视图控制器
//  Created by lingsbb on 15-08-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderSendTVC.h"
#import "OrderSendListTVC.h"
#import "OrderDidNotConfirmTableViewController.h"
#import "OrderQHZTableViewController.h"
#import "OrderDLWTableViewController.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "JSONModelTaborderstate.h"

@interface OrderSendTVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据

@end

@implementation OrderSendTVC

- (void)viewDidLoad {
    [self loadNewData];
}


- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"getTaborderstate";
    NSString *params = @"&proName=%@_%@";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, @"1"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        NSLog(@"%@", _infoArray);
        _dataArray = [JSONModelTaborderstate objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}


//组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//组内行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else{
        return 4;
    }
}

//行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 94.;
    }else if(indexPath.section==1){
        return 50.;
    }else{
        return 0.;
    }
}

// 组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 16;
    }else{
        return 21;
    }
}

// 组脚高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//绘制cell 最后几行图标不够
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        
        if (indexPath.row == 0) {
            if (_dataArray.count > 0) {
                for (int i = 0; i < _dataArray.count; i++) {
                    JSONModelTaborderstate *c = _dataArray[i];
                    if ([c.status isEqualToString:@"10"]) {
                        NSString *str = [NSString stringWithFormat:@"1-定单未确认 (%@)", c.sumnum];
                        [cell.textLabel setText:str];
                        break;
                    } else {
                        [cell.textLabel setText:@"1-定单未确认"];
                    }
                }
            }
            cell.imageView.image=[UIImage imageNamed:@"Disc_movie"];
            // 把订单提交换成定单未确认
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row == 1) {
            if (_dataArray.count > 0) {
                for (int i = 0; i < _dataArray.count; i++) {
                    JSONModelTaborderstate *c = _dataArray[i];
                    if ([c.status isEqualToString:@"20"]) {
                        NSString *str = [NSString stringWithFormat:@"2-分派提货人 (%@)", c.sumnum];
                        [cell.textLabel setText:str];
                        break;
                    } else {
                        [cell.textLabel setText:@"2-分派提货人"];
                    }
                }
            }
            
            
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==2) {
            if (_dataArray.count > 0) {
                for (int i = 0; i < _dataArray.count; i++) {
                    JSONModelTaborderstate *c = _dataArray[i];
                    if ([c.status isEqualToString:@"25"]) {
                        NSString *str = [NSString stringWithFormat:@"3-取货途中 (%@)", c.sumnum];
                        [cell.textLabel setText:str];
                        break;
                    } else {
                        [cell.textLabel setText:@"3-取货途中"];
                    }
                }
            }
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            
            [cell.detailTextLabel setText:@""];
        } else if (indexPath.row==3) {
            if (_dataArray.count > 0) {
                for (int i = 0; i < _dataArray.count; i++) {
                    JSONModelTaborderstate *c = _dataArray[i];
                    if ([c.status isEqualToString:@"30"]) {
                        NSString *str = [NSString stringWithFormat:@"4-已开单 (%@)", c.sumnum];
                        [cell.textLabel setText:str];
                        break;
                    } else {
                        [cell.textLabel setText:@"4-已开单"];
                    }
                }
            }
            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
            [cell.detailTextLabel setText:@""];
        }
//        else if (indexPath.row==4) {
//            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
//            [cell.textLabel setText:@"5-已到物流"];
//            [cell.detailTextLabel setText:@""];
//        } else if (indexPath.row==5) {
//            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
//            [cell.textLabel setText:@"6-配货物流途中"];
//            [cell.detailTextLabel setText:@""];
//        } else if (indexPath.row==6) {
//            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
//            [cell.textLabel setText:@"7-已装车"];
//            [cell.detailTextLabel setText:@""];
//        } else if (indexPath.row==7) {
//            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
//            [cell.textLabel setText:@"8-已到达"];
//            [cell.detailTextLabel setText:@""];
//        } else if (indexPath.row==8) {
//            cell.imageView.image=[UIImage imageNamed:@"Disc_taxi"];
//            [cell.textLabel setText:@"9-已取货"];
//            [cell.detailTextLabel setText:@""];
//        }
        
    }
    return cell;
}

//实现自定义菜单 标题的委托
- (NSString *)setIconTitle:(id)button {
    UIButton * but=button;
    switch (but.tag) {
        case 1:
            return @"订单汇总";
            break;
        case 2:
            return @"订单查询";
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==1 && indexPath.row==0) { // 1.订单未确认
        OrderDidNotConfirmTableViewController *tvc = [[OrderDidNotConfirmTableViewController alloc] init];
        tvc.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        tvc.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [tvc.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        tvc.labelOne = @"您提交的订单还没有";
        tvc.labelTwo = @"被客服审核请耐心等待";
        tvc.status = 10;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    if (indexPath.section==1 && indexPath.row==1) { // 2.分派提货人
        OrderDidNotConfirmTableViewController *tvc = [[OrderDidNotConfirmTableViewController alloc] init];
        tvc.labelOne = @"您提交的订单已经被客服审";
        tvc.labelTwo = @"核请耐心等待提货司机取货";
        tvc.status = 20;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    if (indexPath.section==1 && indexPath.row==2) { // 3.取货途中
        OrderQHZTableViewController *tvc = [[OrderQHZTableViewController alloc] init];
        tvc.labelOne = @"已经派司机进";
        tvc.labelTwo = @"行提货请耐心等待";
        tvc.status = 25;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    if (indexPath.section==1 && indexPath.row==3) { // 4.已开单    物流已经开单    正在装车中...
        OrderQHZTableViewController *tvc = [[OrderQHZTableViewController alloc] init];
        tvc.labelOne = @"物流已经开单";
        tvc.labelTwo = @"正在装车中...";
        tvc.status = 30;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
//    if (indexPath.section==1 && indexPath.row==4) { // 5.已到物流     货物已经送达   物流正在开票...
//        OrderQHZTableViewController *tvc = [[OrderQHZTableViewController alloc] init];
//        tvc.labelOne = @"货物已经送达";
//        tvc.labelTwo = @"物流正在开票...";
//        tvc.status = 40;
//        [self.navigationController pushViewController:tvc animated:YES];
//    }
//    
//    if (indexPath.section==1 && indexPath.row==5) { // 6.配货物流途中
//        OrderDLWTableViewController *tvc = [[OrderDLWTableViewController alloc] init];
//        tvc.labelOne = @"司机已经提完";
//        tvc.labelTwo = @"货正在送往物流";
//        tvc.status = 45;
//        [self.navigationController pushViewController:tvc animated:YES];
//    }
//    
//    if (indexPath.section==1 && indexPath.row==6) { // 7.已装车
//        OrderDLWTableViewController *tvc = [[OrderDLWTableViewController alloc] init];
//        tvc.labelOne = @"货物已经装车";
//        tvc.labelTwo = @"正在送往目的地...";
//        tvc.status = 50;
//        [self.navigationController pushViewController:tvc animated:YES];
//    }
//    
//    if (indexPath.section==1 && indexPath.row==7) { // 8.已到达
//        OrderDLWTableViewController *tvc = [[OrderDLWTableViewController alloc] init];
//        tvc.labelOne = @"物流已经送达";
//        tvc.labelTwo = @"正在派送途中...";
//        tvc.status = 60;
//        [self.navigationController pushViewController:tvc animated:YES];
//    }
//    
//    if (indexPath.section==1 && indexPath.row==8) { // 9.已取货
//        OrderDLWTableViewController *tvc = [[OrderDLWTableViewController alloc] init];
//        tvc.labelOne = @"您已签收货物，感谢您使";
//        tvc.labelTwo = @"用全民货运，欢饮再次光临";
//        tvc.status = 80;
//        [self.navigationController pushViewController:tvc animated:YES];
//    }
    
}

// 准备跳转之前的事件
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.theTableview indexPathForSelectedRow];
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    
    NSLog(@"row=====:%ld",indexPath.row);
    if([segue.identifier isEqualToString:@"showGoodsSend1"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;
        tvc.newtitle=@"订单提交（未到物流）";
    }
    if([segue.identifier isEqualToString:@"showGoodsSend2"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;
        tvc.newtitle=@"已开单（未收票据）";
    }
    //订单提交（未到物流）已开单（未收票据）待评价等四个自定义菜单 直接用StoryBoard连线跳转
    if([segue.identifier isEqualToString:@"showGoodsSend"]){
        OrderSendListTVC *tvc= segue.destinationViewController;
        tvc.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏

        if (section == 1 && row == 1) {
            tvc.newtitle = @"分派提货人";
        }
        
        if (section == 1 && row == 2) {
            tvc.newtitle = @"取货途中";
        }
        
        if (section == 1 && row == 3) {
            tvc.newtitle = @"已开单";
        }
        
//        if (section == 1 && row == 4) {
//            tvc.newtitle=@"已到物流";
//        }
//        
//        if (section == 1 && row == 5) {
//            tvc.newtitle=@"配货物流途中";
//        }
//        
//        if (section == 1 && row == 6) {
//            tvc.newtitle=@"已装车";
//        }
//        
//        if (section == 1 && row == 7) {
//            tvc.newtitle=@"已到达";
//        }
//        
//        if (section == 1 && row == 8) {
//            tvc.newtitle=@"已取货";
//        }
        
    }
    
}



@end
