//
//  ConfigCShouhuoTVC.m
//  qmhy
//  配置常用收货联系人
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCShouhuoTVC.h"
#import "ConfigCShouhuoTableViewCell.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "JSONModelConfigCShouhuo.h"
#import "MBProgressHUD+HM.h"
#import "EditConfigCShouhuoViewController.h"

@interface ConfigCShouhuoTVC () <ConfigCShouhuoTableViewCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组

@property (nonatomic, strong) JSONModelConfigCShouhuo *jsonModelConfigCShouhuo;

@end

@implementation ConfigCShouhuoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadNewData];
}

- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didEditJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickBianJiLikeBtn:(UIButton *)likeBtn {
    EditConfigCShouhuoViewController *editConfigCShouhuoViewController = [[EditConfigCShouhuoViewController alloc] init];
    editConfigCShouhuoViewController.jsonModelConfigCShouhuo = model;
    [self.navigationController pushViewController:editConfigCShouhuoViewController animated:YES];

}

- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didRemoveJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickShanChuLikeBtn:(UIButton *)likeBtn {
    self.jsonModelConfigCShouhuo = model;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"gettabcommonconsigneeinfo";
    NSString *params = @"&proName=%@_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int isOnly = 0;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, isOnly] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelConfigCShouhuo objectArrayWithKeyValuesArray:_infoArray];
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

// 删除方法
- (void)removeConfigCShouhuo:(JSONModelConfigCShouhuo *)model  {
    [MBProgressHUD showMessage:@"正在添加中..." toView:self.view];
    NSString *methodName = @"updatetabcommonconsigneeinfo";
    NSString *params = @"&proName=%d_%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%d_%d";
    int x_id = [model.x_id intValue];
    int uid = [model.uid intValue];
    NSString *contant = model.contact;
    NSString *tel = model.tel;
    NSString *province = model.Province;
    NSString *city = model.city;
    NSString *area = model.area;
    NSString *addressCode = model.addressCode;
    NSString *Address = model.Address;
    NSString *status = model.status;
    NSString *createby = model.createby;
    int isOnly = 1;
    int setType = -1;
    
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, x_id,uid,contant,tel,province,city,area,addressCode,Address,status,createby,isOnly,setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
            [self loadNewData];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"删除失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"添加失败！"];
    }];
}

//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
//        [self removeConfigCShouhuo:self.jsonModelConfigCShouhuo];
        NSLog(@"确定");
    } else {
        NSLog(@"取消");
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 可重用标识符
    static NSString *ID = @"ConfigCShouhuoTableViewCell";
    // 2. tableView查询可重用Cell
    ConfigCShouhuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCShouhuoTableViewCell" owner:nil options:nil] lastObject];
    }
    //获取模型
    [cell config:_dataArray[indexPath.row]];
    //    JSONModelConfigCWuLiu *jsonModelConfigCWuLiu = _dataArray[indexPath.row];
    //    cell.wuLiuNameLabel.text = jsonModelConfigCWuLiu.name;
    // ⑥在创建cell的时候设置自己为代理
    cell.delegate = self;
    return cell;}

//行高度 标准高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}


@end
