//
//  MyEvaluationSJXXTableViewController.m
//  qmhy
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationSJXXTableViewController.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "MyEvaluationSJXXTableViewCell.h"
#import "JSONModelMyEvaluationSJXX.h"


@interface MyEvaluationSJXXTableViewController ()
@property (nonatomic, assign) CGRect oneLabelFrame;
@property (nonatomic, assign) CGRect twoLabelFrame;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据

@end

@implementation MyEvaluationSJXXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载头部视图
    [self xxcHeadView];
    
    // 加载数据
    [self loadNewData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self loadNewData];
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
    labelOne.text = @"查看货物的";
    labelOne.textColor = [UIColor whiteColor];
    labelOne.frame = self.oneLabelFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2 -38, 20, 100 , 21);
    [head addSubview:labelOne];
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"各个节点的时间状态";
    labelTwo.textColor = [UIColor whiteColor];
    labelTwo.frame = self.twoLabelFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2 -77, 50, 154 , 21);
    [head addSubview:labelTwo];
    self.tableView.tableHeaderView = head;
}

- (void)loadNewData {
    NSString *methodName = @"gettaborderflow";
    NSString *params = @"&proName=%@";
    NSString *code = self.code;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, code] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelMyEvaluationSJXX objectArrayWithKeyValuesArray:_infoArray];
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 可重用标识符
    static NSString *ID = @"MyEvaluationSJXXTableViewCell";
    // 2. tableView查询可重用Cell
    MyEvaluationSJXXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyEvaluationSJXXTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    if (0 == indexPath.row) {
        cell.image.image = [UIImage imageNamed:@"logistics_arrive"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150; //此处返回cell的高度
}

@end
