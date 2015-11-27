//
//  NotifyHYXMTableViewController.m
//  qmhy
//
//  Created by mac on 15/11/24.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyHYXMTableViewController.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "JSONModelNotifyHYXM.h"
#import "NotifyHYXMTableViewCell.h"

@interface NotifyHYXMTableViewController ()
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组


@end

@implementation NotifyHYXMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
}

- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"gettabpushmess";
    NSString *params = @"&proName=%@_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int type = 1;
    int aid = -1;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, type, aid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelNotifyHYXM objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"NotifyHYXMTableViewCell";
    NotifyHYXMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotifyHYXMTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    return cell;
}

//行高度 标准高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

@end
