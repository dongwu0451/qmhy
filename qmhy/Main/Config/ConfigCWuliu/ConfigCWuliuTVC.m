//
//  ConfigCWuliuTVC.m
//  qmhy
//
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCWuliuTVC.h"
#import "ConfigCWuliuTableViewCell.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "JSONModelConfigCWuLiu.h"
#import "MBProgressHUD+HM.h"
#import "ConfigCWuliuTableViewCell.h"
#import "EditConfigCWuliuViewController.h"

// ⑦遵循代理协议
@interface ConfigCWuliuTVC () <ConfigCWuliuTableViewCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组
@property (nonatomic, strong) ConfigCWuliuTableViewCell *configCWuliuTableViewCell;


@property (nonatomic, strong) JSONModelConfigCWuLiu *jsonModelConfigCWuLiu;




@end

@implementation ConfigCWuliuTVC

- (void)viewDidLoad
{

    [super viewDidLoad];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [self loadNewData];
}

- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"getlogistics";
    NSString *params = @"&proName=%d";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelConfigCWuLiu objectArrayWithKeyValuesArray:_infoArray];
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}


// ⑧ 实现代理的方法
- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didClickBianJiLikeBtn:(UIButton *)likeBtn {
    EditConfigCWuliuViewController *editConfigCWuliuViewController = [[EditConfigCWuliuViewController alloc] init];
    editConfigCWuliuViewController.configCWuliuTableViewCell = cell;
    [self.navigationController pushViewController:editConfigCWuliuViewController animated:YES];



}

//- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didRemoveJSONModelConfigCWuLiu:(JSONModelConfigCWuLiu *)model  andClickShanChuLikeBtn:(UIButton *)likeBtn {
//    NSLog(@"%@", model.name);
//    NSLog(@"%@", model.uid);
//    NSLog(@"%@", model.code);
////    self.jsonModelConfigCWuLiu = model;
//}


// ⑧ 实现代理的方法
- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didClickShanChuLikeBtn:(UIButton *)likeBtn {
    self.configCWuliuTableViewCell = cell;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


// 删除方法
- (void)removeConfigCWuliu:(ConfigCWuliuTableViewCell *)cell  {
    [MBProgressHUD showMessage:@"正在添加中..." toView:self.view];
        NSString *methodName = @"settabCommonLogistics";
        NSString *params = @"&proName=%d_%@_%d_%d";
        int uid = [cell.uid intValue];
        NSString *name = cell.name;
        int code = [cell.code intValue];
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
//                // 刷新数据
//                [self.tableView reloadData];
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
        [self removeConfigCWuliu:self.configCWuliuTableViewCell];
        NSLog(@"确定");
    } else {
        NSLog(@"取消");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 可重用标识符
    static NSString *ID = @"ConfigCWuliuTableViewCell";
    // 2. tableView查询可重用Cell
    ConfigCWuliuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCWuliuTableViewCell" owner:nil options:nil] lastObject];
    }
    //获取模型
    [cell config:_dataArray[indexPath.row]];
//    JSONModelConfigCWuLiu *jsonModelConfigCWuLiu = _dataArray[indexPath.row];
//    cell.wuLiuNameLabel.text = jsonModelConfigCWuLiu.name;
    // ⑥在创建cell的时候设置自己为代理
    cell.delegate = self;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100; //此处返回cell的高度
}


//添加常用物流
- (IBAction)addWuliu:(id)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"您的邀请码是12345678"delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"知道了", nil];
//    [alert show];
}
@end
