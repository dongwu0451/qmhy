//
//  MyEvaluationTableViewController.m
//  qmhy
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationTableViewController.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "MyEvaluationTableViewCell.h"
#import "JSONModelMyEvaluation.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"

@interface MyEvaluationTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据

@property (nonatomic, assign) CGRect oneLabelFrame;
@property (nonatomic, assign) CGRect twoLabelFrame;

@property (nonatomic, assign) BOOL isLoadFinished;//是否有更多数据

@property (assign, nonatomic) int pageStart; // 启示条
@property (assign, nonatomic) int pegeEnd;// 结束条

@end

@implementation MyEvaluationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageStart = 1;
    self.pegeEnd = 5;
    [self xxcHeadView];
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


- (void)loadNewData {
    
}

- (void)loadMoreData {

}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)xxcHeadView {
    UIView *head =[[UIView alloc ]init];
    head.backgroundColor = [UIColor blueColor];
    head.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 100);
    UILabel *labelOne = [[UILabel alloc] init];
    labelOne.text = @"评价订单,您的评价是我们";
    labelOne.textColor = [UIColor whiteColor];
    labelOne.frame = self.oneLabelFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2 -96, 20, 192 , 21);
    [head addSubview:labelOne];
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"前进的动力";
    labelTwo.textColor = [UIColor whiteColor];
    labelTwo.frame = self.twoLabelFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2 -43, 50, 85 , 21);
    [head addSubview:labelTwo];
    self.tableView.tableHeaderView = head;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 可重用标识符
    static NSString *ID = @"MyEvaluationTableViewCell";
    // 2. tableView查询可重用Cell
    MyEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyEvaluationTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

@end
