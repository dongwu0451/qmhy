//
//  MyEvaluationXQTableViewController.m
//  qmhy
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationXQTableViewController.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "JSONModelMyEvaluationXQ.h"
#import "CustonCell.h"
#import "MyEvaluationEVMViewController.h"
#import "MyEvaluationSJXXTableViewController.h"


#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HIGHT [[UIScreen mainScreen]bounds].size.height

@interface MyEvaluationXQTableViewController () <UIAlertViewDelegate>

{
    UITableView *userTabel;//存放数据的table
    
    NSArray *arr1;//存储订单数据数组
    NSArray *arr2;
    NSArray *arr3;
    NSArray *arr4;
    NSArray *textArr1;//测试数据
    NSArray *textArr2;//测试数据
    NSArray *textArr3;//测试数据
    NSArray *textArr4;//测试数据
    
    JSONModelMyEvaluationXQ *model;
}

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *infoArray;//第一次数据
@end

@implementation MyEvaluationXQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    model = [[JSONModelMyEvaluationXQ alloc] init];
    
    /*头部视图*/
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 47)];
    titleView.backgroundColor = [UIColor yellowColor];
    titleView.alpha = 1;
    [self.view addSubview:titleView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
    self.titleLabel.text = @"订单状态";
    self.titleLabel.backgroundColor = [UIColor yellowColor];
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:self.titleLabel];
    
    
    /*底部的按钮视图*/
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HIGHT-50, SCREEN_WIDTH, 50)];
    btnView.backgroundColor = [UIColor grayColor];
    btnView.alpha = 1;
    [self.view addSubview:btnView];
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*(SCREEN_WIDTH/2), 0, SCREEN_WIDTH/2, 50)];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Arial" size:15]];
        if (i == 0) {
            [btn setTitle:@"查看时间信息" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        } else {
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [btnView addSubview:btn];
    }
    
    //初始化数据  用来显示界面  确保当服务器没有返回值或数据访问失败   界面能正常显示
    [self initData:0];
    //数据初始化成功  使用初始数据来显示界面
    [self initMianView];
    //服务器请求   请求成功后进行第二次数据初始化  添加数据为服务器的返回值   数据添加成功后刷新列表  确保显示的为服务器数据
//    [self loadNewData];
}

#pragma mark UI界面
/*主界面*/
- (void)initMianView {
    /*显示订单数据的列表*/
    userTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, SCREEN_HIGHT-160)];
    userTabel.delegate = self;
    userTabel.dataSource = self;
    [self.view addSubview:userTabel];
}


#pragma mark 设置cell的章节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/*设置每个章节显示的字符串*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

/*设置每个章节节头的大小*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 25;
    }
}

/*设置每个章节内cell的个数*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return arr1.count;
    } else if (section == 1) {
        return arr2.count;
    } else if (section == 2) {
        return arr3.count;
    } else if (section == 3) {
        return arr4.count;
    }else
        return 0;
}

/*cell的创建*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*定义个静态的字符串*/
    static NSString *Cell = @"GroupCell";
    
    /*给每个cell初始化一个值*/
    CustonCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"GroupCell%d%d",(int)indexPath.section,(int)indexPath.row]];
    if (cell == nil) {
        cell = [[CustonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
    }
    
    /*设置每个章节内的第一个cell的label显示为正中*/
    if (indexPath.row == 0) {
        cell.leftLabel.textAlignment = NSTextAlignmentCenter;
//        cell.leftLabel.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 45);
        
    }
    
    /*给cell添加数据*/
    if (indexPath.section == 0) {
        cell.leftLabel.text = arr1[indexPath.row];
        if (indexPath.row>=2) {
            cell.rightLabel.text = textArr1[indexPath.row-2];
        }
    } else if (indexPath.section == 1) {
        cell.leftLabel.text = arr2[indexPath.row];
        if (indexPath.row >= 1) {
            cell.rightLabel.text = textArr2[indexPath.row-1];
        }
    } else if (indexPath.section == 2) {
        cell.leftLabel.text = arr3[indexPath.row];
        if (indexPath.row >= 1) {
            cell.rightLabel.text = textArr3[indexPath.row-1];
        }
    } else if (indexPath.section == 3) {
        cell.leftLabel.text = arr4[indexPath.row];
        if (indexPath.row >= 1) {
            cell.rightLabel.text = textArr4[indexPath.row-1];
        }
    }
    return cell;
}

#pragma mark 自定义提示窗口以及设置标记状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        MyEvaluationEVMViewController *vc = [[MyEvaluationEVMViewController alloc] init];
        vc.code = model.code;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


#pragma mark 按钮的点击事件
- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 10) {
        NSLog(@"查看时间信息");
        MyEvaluationSJXXTableViewController *tvc = [[MyEvaluationSJXXTableViewController alloc] init];
        tvc.code = model.code;
        tvc.labelOne = @"查看货物的";
        tvc.labelTwo = @"各个节点的时间状态";
        [self.navigationController pushViewController:tvc animated:YES];
    } else if (sender.tag == 11) {
        NSLog(@"删除");
        if ([model.code intValue] >= 30) {
            [MBProgressHUD showError:@"不能删除！"];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}


// 删除方法
- (void)removeHEHE:(JSONModelMyEvaluationXQ *)model  {
    [MBProgressHUD showMessage:@"正在删除中..." toView:self.view];
    NSString *methodName = @"deltaborder";
    NSString *params = @"&proName=%@_%@";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
//    NSString *uid = model.uid;
    NSString *code = model.code;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, code] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"删除成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"删除失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"删除失败！"];
    }];
}

//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self removeHEHE:model];
        NSLog(@"确定");
    } else {
        NSLog(@"取消");
    }
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 显示当前用户的个人信息
    model = [[JSONModelMyEvaluationXQ alloc] init];
        [self loadNewData];
}


- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"GetTabOrderCode";
    NSString *params = @"&proName=%@";
    NSString *code = self.code;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, code] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        //NSLog(@"%@", _infoArray);
        _dataArray = [JSONModelMyEvaluationXQ objectArrayWithKeyValuesArray:_infoArray];
        model = _dataArray[0];
        [self initData:1];
    } fail:^{
        
    }];
    
}

- (void)initData:(int)type {
    //0为初始数据  1为服务器返回数据
    if (type == 0) {
        arr1 = [[NSArray alloc] initWithObjects:@"订单信息",@"点击查看二维码",
                @"订单号:",@"时间:",
                @"物流:",@"发往城市:",
                @"货物名称:",@"描述:",
                @"件数:",@"规格:",
                @"短途运费:",@"代收款:",
                @"物流运费:",@"备注:",nil];
        textArr1 = [[NSArray alloc] initWithObjects:@"",@"",
                    @"",@"",
                    @"",@"",
                    @"",
                    @"",@"",
                    @"",@"",@"",nil];
        
        arr2 = [[NSArray alloc] initWithObjects:@"发货人信息",@"发货联系人:",
                @"发货地点:",@"发货人电话:",nil];
        textArr2 = [[NSArray alloc] initWithObjects:@"",@"",
                    @"",nil];
        
        arr3 = [[NSArray alloc] initWithObjects:@"收货人信息",@"收货联系人:",
                @"收货人地点:",@"收货人电话:",nil];
        textArr3 = [[NSArray alloc] initWithObjects:@"",@"",
                    @"",nil];
        
        arr4 = [[NSArray alloc] initWithObjects:@"司机信息",@"司机:",
                @"司机电话:",@"提货司机:",@"提货司机电话:",@"司机抢单时间:",@"提货时间:",nil];
        textArr4 = [[NSArray alloc] initWithObjects:@"",@"",
                    @"",@"",@"",@"",nil];
    } else {
        
        if (model.city.length == 0 || model.city == nil || [model.city  isEqual: @""]) {
            model.city = @"无";
        } else {
            NSArray *arr = [model.city componentsSeparatedByString:@"-"];
            if (arr.count >= 3 ) { //
                model.city = [NSString stringWithFormat:@"%@", arr[2]];
            } else {
                model.city = @"无";
            }
        }
        
        if (model.pickupaddress.length == 0 || model.pickupaddress == nil || [model.pickupaddress  isEqual: @""]) {
            model.pickupaddress = @"无";
        } else {
            NSArray *arr = [model.pickupaddress componentsSeparatedByString:@"-"];
            if (arr.count >= 3 ) { //
                model.pickupaddress = [NSString stringWithFormat:@"%@", arr[2]];
            } else {
                model.pickupaddress = @"无";
            }
        }
        
        
        arr1 = [[NSArray alloc] initWithObjects:@"订单信息",@"点击查看二维码",
                @"订单号:",@"时间:",
                @"物流:",@"发往城市:",
                @"货物名称:",@"描述:",
                @"件数:",@"规格:",
                @"短途运费:",@"代收款:",
                @"物流运费:",@"备注:",nil];
        
        
        
        textArr1 = [[NSArray alloc] initWithObjects:model.code,model.stime,
                    model.logisticsname,model.city,
                    model.goodsname,model.gooddescribe,
                    model.num,
                    model.standard,model.freightprice,
                    model.collectionprice,model.logisticsprice,model.remark ,nil];
        
        
        arr2 = [[NSArray alloc] initWithObjects:@"发货人信息",@"发货联系人:",
                @"发货地点:",@"发货人电话:",nil];
        textArr2 = [[NSArray alloc] initWithObjects:model.pickupcontact,model.pickupaddress,
                    model.pickupphone,nil];
        
        arr3 = [[NSArray alloc] initWithObjects:@"收货人信息",@"收货联系人:",
                @"收货人地点:",@"收货人电话:",nil];
        textArr3 = [[NSArray alloc] initWithObjects:model.consigneename,model.city,
                    model.consigneephone,nil];
        
        arr4 = [[NSArray alloc] initWithObjects:@"司机信息",@"司机:",
                @"司机电话:",@"提货司机:",@"提货司机电话:",@"司机抢单时间:",@"提货时间:",nil];
        textArr4 = [[NSArray alloc] initWithObjects:model.sjname,model.sjtel,
                    model.thsjname,model.thsjtel,model.sjtime,model.thsjtime,nil];

        if (model.status != 0) {
            switch ([model.status intValue]) {
                case 10:
                    self.titleLabel.text = @"订单正在审核";
                    break;
                case 20:
                    self.titleLabel.text = @"订单审核完毕";
                    break;
                case 22:
                    self.titleLabel.text = @"订单审核完毕";
                    break;
                case 25:
                    self.titleLabel.text = @"订单已被司机抢单";
                    break;
                case 30:
                    self.titleLabel.text = @"正在配送物流";
                    break;
                case 40:
                    self.titleLabel.text = @"物流已签收";
                    break;
                case 45:
                    self.titleLabel.text = @"货物已经开票";
                    break;
                case 50:
                    self.titleLabel.text = @"货物已经装车";
                    break;
                case 60:
                    self.titleLabel.text = @"货物已经到达目的地";
                    break;
                case 70:
                    self.titleLabel.text = @"";
                    break;
                case 80:
                    self.titleLabel.text = @"货物已送达";
                    break;
                case 90:
                    self.titleLabel.text = @"货款己经发放";
                    break;
                case 0:
                    self.titleLabel.text = @"订单获取状态失败";
                    break;
                default:
                    self.titleLabel.text = @"订单获取状态失败";
                    break;
            }
        }
        //数据添加成功后刷新列表
        [userTabel reloadData];
    }
}



@end

