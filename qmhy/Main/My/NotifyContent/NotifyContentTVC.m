//
//  NotifyContentTVC.m
//  qmhy
//  消息详情 视图控制器 支持上下拉
//  Created by lingsbb on 15-8-22.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyContentTVC.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 2.0;
/**
 * 随机数据 宏定义
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface NotifyContentTVC ()

/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation NotifyContentTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //维护UINavigationItem
    
    //重绘制左侧按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    
    //重写标题
    if (self.newtitle) {
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 144)];
        title.text=self.newtitle;
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor whiteColor];
        self.navigationItem.titleView=title;
        NSLog(@"setTitle");
    }
    //设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    //====================================================================
    //上下拉设置
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    /*// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];*/
}

//返回按钮
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

//组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

//重新绘制单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置cellid
    NSString * cellid=@"id_subTitle";
    //获取cellid
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

    //利用假数绘制
    NSString *title=@"aaa";
    [cell.textLabel setText:title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", indexPath.row % 2?@"push":@"modal", self.data[indexPath.row]];
    
    return cell;
}

// 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
    });
}

// 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}

/*#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.footer noticeNoMoreData];
    });
}

- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        self.tableView.footer.hidden = YES;
    });
}*/

//返回假数据
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
    }
    return _data;
}

@end
