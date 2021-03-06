//
//  OrderQHZTableViewController.m
//  qmhy
//
//  Created by mac on 15/12/3.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderQHZTableViewController.h"
#import "OrderQHZTableViewCell.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "JSONModelOrderQHZ.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "OrderQHZEwmViewController.h"
#import "MyEvaluationXQTableViewController.h"
#import "JSONModelOrderDidNotConfirm.h"

@interface OrderQHZTableViewController () <OrderQHZTableViewCellDelegate>
@property (nonatomic, assign) CGRect oneLabelFrame;
@property (nonatomic, assign) CGRect twoLabelFrame;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据

@property (nonatomic, assign) BOOL isLoadFinished;//是否有更多数据

@property (assign, nonatomic) int pageStart; // 启示条
@property (assign, nonatomic) int pegeEnd;// 结束条


@end

@implementation OrderQHZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageStart = 1;
    self.pegeEnd = 5;
    [self xxcHeadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 显示当前用户的个人信息
    [self setupRefresh];
}

- (void)xxcHeadView {
    UIView *head =[[UIView alloc ]init];
    head.backgroundColor = [UIColor blueColor];
    head.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 100);
    UILabel *labelOne = [[UILabel alloc] init];
    labelOne.text = self.labelOne;
    labelOne.textColor = [UIColor whiteColor];
    labelOne.textAlignment = NSTextAlignmentCenter;
    labelOne.frame = self.oneLabelFrame = CGRectMake(0, 20, [[UIScreen mainScreen]bounds].size.width , 21);
    [head addSubview:labelOne];
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = self.labelTwo;
    labelTwo.textColor = [UIColor whiteColor];
    labelTwo.textAlignment = NSTextAlignmentCenter;
    labelTwo.frame = self.twoLabelFrame = CGRectMake(0, 50, [[UIScreen mainScreen]bounds].size.width , 21);
    [head addSubview:labelTwo];
    self.tableView.tableHeaderView = head;
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

- (void)loadNewData {
    self.pageStart = 1;
    self.pegeEnd = 5;
    // 请求参数
    NSString *methodName = @"getcarMess";
    NSString *params = @"&proName=%@_%d_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int status = self.status;
    int start = 1;
    int end = 5;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, status, start, end] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelOrderQHZ objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

- (void)loadMoreData {
    self.pageStart += 5;
    self.pegeEnd += 5;
    // 请求参数
    NSString *methodName = @"getcarMess";
    NSString *params = @"&proName=%@_%d_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int status = self.status;
    int start = self.pageStart;
    int end = self.pegeEnd;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, status, start, end] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *moreInfoArray = [dic objectForKey:@"rs"];//第一次数据
        NSLog(@"+++%@", moreInfoArray);
        if (moreInfoArray != nil) {
            [_infoArray addObjectsFromArray:moreInfoArray];//叠加的数据
            _dataArray = [JSONModelOrderQHZ objectArrayWithKeyValuesArray:_infoArray];
        } else {
            _isLoadFinished = YES;//当返回数据为空
        }
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
    
}

- (void)orderQHZTableViewCell:(OrderQHZTableViewCell *)cell didClickLikeEwmBtn:(UIButton *)likeBtn AndCode:(NSString *)code {
    OrderQHZEwmViewController *vc= [[OrderQHZEwmViewController alloc] init];
    NSLog(@"%@", code);
    vc.code = code;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)orderQHZTableViewCell:(OrderQHZTableViewCell *)cell didClickLikeKfPhoneBtn:(UIButton *)likeBtn AndCarphone:(NSString *)carphone {
    NSLog(@"+++++++++++++%@", carphone);
    NSString *str = [NSString stringWithFormat:@"tel://%@", carphone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 可重用标识符
    static NSString *ID = @"OrderQHZTableViewCell";
    // 2. tableView查询可重用Cell
    OrderQHZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderQHZTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 235;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", _dataArray[indexPath.row]);
        MyEvaluationXQTableViewController *tvc = [[MyEvaluationXQTableViewController alloc] init];
        JSONModelOrderDidNotConfirm *model = _dataArray[indexPath.row];
        tvc.code = model.code;
        tvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tvc animated:YES];
    
    
}

@end
