//
//  OrderDingDanZhuangTaiTableViewController.m
//  qmhy
//
//  Created by mac on 15/11/27.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderDingDanZhuangTaiTableViewController.h"
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "OrderDingDanZhuangTaiTableViewCell.h"
#import "JSONModelOrderDingDanZhuangTai.h"

@interface OrderDingDanZhuangTaiTableViewController ()
@property (nonatomic, assign) CGRect oneLabelFrame;
@property (nonatomic, assign) CGRect twoLabelFrame;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@end

@implementation OrderDingDanZhuangTaiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载头部视图
    [self xxcHeadView];
    
    // 加载数据
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
    // @"查看货物的";
    labelOne.text = self.labelOne;
    labelOne.textColor = [UIColor whiteColor];
//    labelOne.frame = self.oneLabelFrame = CGRectMake([[UIScreen mainScreen]bounds].size.width/2 -38, 20, 100 , 21);
    labelOne.textAlignment = NSTextAlignmentCenter;
    labelOne.frame = self.oneLabelFrame = CGRectMake(0, 20, [[UIScreen mainScreen]bounds].size.width , 21);
    [head addSubview:labelOne];
    UILabel *labelTwo = [[UILabel alloc] init];
    // @"各个节点的时间状态";
    labelTwo.text = self.labelTwo;
    labelTwo.textColor = [UIColor whiteColor];
    labelTwo.textAlignment = NSTextAlignmentCenter;
    labelTwo.frame = self.twoLabelFrame = CGRectMake(0, 50, [[UIScreen mainScreen]bounds].size.width , 21);
    [head addSubview:labelTwo];
    self.tableView.tableHeaderView = head;
}

- (void)loadNewData {
    NSString *methodName = @"gettaborderflow";
    NSString *params = @"&proName=%@";
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, self.code] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelOrderDingDanZhuangTai objectArrayWithKeyValuesArray:_infoArray];
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
    // 1. 可重用标识符
    static NSString *ID = @"OrderDingDanZhuangTaiTableViewCell";
    // 2. tableView查询可重用Cell
    OrderDingDanZhuangTaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDingDanZhuangTaiTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    if (0 == indexPath.row) {
        cell.image.image = [UIImage imageNamed:@"logistics_arrive"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160; //此处返回cell的高度
}

@end
