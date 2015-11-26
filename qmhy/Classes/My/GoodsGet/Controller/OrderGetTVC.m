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
@property (assign, nonatomic) int pageIndex; // 启示条
@property (assign, nonatomic) int pegeEnd;// 结束条

@property (nonatomic, assign) BOOL isLoadFinished;//是否有更多数据

@end

@implementation OrderGetTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    self.pegeEnd = 5;
    [self setupRefresh];
}


// 设置刷新
- (void)setupRefresh {
    // 1.添加刷新空间
    //    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
    // 下啦刷新 添加头部刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    // 上拉刷新 尾部刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        // 判断结束刷新方式
        if(!_isLoadFinished){
            [self.tableView.footer endRefreshing];
        } else {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
    }];
    
    // 2.马上进入刷新状态(仅仅是显示刷新状态,并不会触发UIControlEventValueChanged事件)
    //    [control beginRefreshing];
    // 3.马上加载数据
    // 一进来就刷新
    [self.tableView.header beginRefreshing];
}


- (void)loadMoreData {
    self.pageIndex += 5;
    self.pegeEnd += 5;
    // 请求参数
    NSString *methodName = @"getConsigneeorder";
    NSString *params = @"&proName=%@_%d_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int start = self.pageIndex;
    int end = self.pegeEnd;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, start, end] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *moreInfoArray = [dic objectForKey:@"rs"];//第一次数据
        NSLog(@"+++%@", moreInfoArray);
        if (moreInfoArray != nil) {
            [_infoArray addObjectsFromArray:moreInfoArray];//叠加的数据
            _dataArray = [JSONModelOrderGet objectArrayWithKeyValuesArray:_infoArray];
        } else {
            _isLoadFinished = YES;//当返回数据为空
        }
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];

}

- (void)loadNewData {
    self.pageIndex = 1;
    self.pegeEnd = 5;
    // 请求参数
    NSString *methodName = @"getConsigneeorder";
    NSString *params = @"&proName=%@_%d_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int start = 1;
    int end = 5;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}


@end
