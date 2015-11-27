//
//  ConfigCGoodsTVC.m
//  qmhy
//  配置常用货物列表
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCGoodsTVC.h"
#import "AddGoodsVC.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "JSONModelConfigGGoods.h"
#import "ConfigCGoodsTableViewCell.h"
//

#import "EditGoodsVC.h"

@interface ConfigCGoodsTVC () <ConfigCGoodsTableViewCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组

@property (nonatomic, strong ) JSONModelConfigGGoods *jsonModelConfigGGoods;

@end

@implementation ConfigCGoodsTVC

- (void)viewWillAppear:(BOOL)animated {
    [self loadNewData];
}



- (void)configCGoodsTableViewCell:(ConfigCGoodsTableViewCell *)cell didEditJSONModelConfigCGoods:(JSONModelConfigGGoods *)model andClickBianJiLikeBtn:(UIButton *)likeBtn {
    EditGoodsVC *editConfigCGoodsViewController = [[EditGoodsVC alloc] init];
    editConfigCGoodsViewController.jsonModelConfigGGoods = model;
    [self.navigationController pushViewController:editConfigCGoodsViewController animated:YES];

}

- (void)configCGoodsTableViewCell:(ConfigCGoodsTableViewCell *)cell didRemoveJSONModelConfigCGoods:(JSONModelConfigGGoods *)model andClickShanChuLikeBtn:(UIButton *)likeBtn {
    self.jsonModelConfigGGoods = model;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)loadNewData {

    NSString *methodName = @"getgoods";
    NSString *params = @"&proName=%d";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];
        _dataArray = [JSONModelConfigGGoods objectArrayWithKeyValuesArray:_infoArray];
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

- (void)removeConfigCHuowu:(JSONModelConfigGGoods *)model  {
    [MBProgressHUD showMessage:@"正在添加中..." toView:self.view];
    NSString *methodName = @"settabCommonGoods";
    NSString *params = @"&proName=%d_%@_%d_%d";
    int uid = [model.uid intValue];
    NSString *name = model.name;
    int code = [model.code intValue];
    int setType = -1; // -1 为删除
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, name, code, setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
        [self removeConfigCHuowu:self.jsonModelConfigGGoods];
        
    } else {
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ConfigCGoodsTableViewCell";
    ConfigCGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCGoodsTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
