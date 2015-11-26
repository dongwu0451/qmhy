//
//  GoodsGetTVC.m
//  qmhy
//  我的取件 视图控制器
//  Created by lingsbb on 15-8-22.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderGetTVC.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "OrderGetTableViewCell.h"
#import "JSONModelOrderGet.h"


@interface OrderGetTVC ()
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组

@end

@implementation OrderGetTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
}

- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"getConsigneeorder";
    NSString *params = @"&proName=%@_%d_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int start = 1;
    int end = 10;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, start, end] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelOrderGet objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"OrderGetTableViewCell";
    OrderGetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderGetTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    return cell;
    
}

//行高度 标准高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}


@end
