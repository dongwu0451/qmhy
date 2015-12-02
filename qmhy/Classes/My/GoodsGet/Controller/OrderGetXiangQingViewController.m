//
//  OrderGetXiangQingViewController.m
//  qmhy
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderGetXiangQingViewController.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "JSONModelOrderGetXiangQing.h"
#import "OrderDingDanZhuangTaiTableViewController.h"
#import "MyEvaluationTableViewController.h"

@interface OrderGetXiangQingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *statusButtton; // 订单状态
@property (weak, nonatomic) IBOutlet UILabel *codeLabel; // 订单号
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel; // 王世杰
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLabel; // 15545340016
@property (weak, nonatomic) IBOutlet UILabel *cityLabel; //  黑龙江省鸡西市鸡西管区红旗路18号
@property (weak, nonatomic) IBOutlet UILabel *logisticsNameLabel; // 本地开发
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressLabel; // 松北区
@property (weak, nonatomic) IBOutlet UILabel *goodsnameAndNum; // 大件货物 1件
@property (weak, nonatomic) IBOutlet UILabel *collectionprice; // 上面那个是Collectionprice 下面那个是 Collectionprice+Freightprice+logisticsprice
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel; // 备注
@property (weak, nonatomic) IBOutlet UILabel *pickupContactLabel; // 曲阳
@property (weak, nonatomic) IBOutlet UILabel *stimeLabel; // 11-13 12:20
@property (weak, nonatomic) IBOutlet UILabel *freightPriceAndCollectionPriceAndLogisticsPriceLabel; // 运费 +代收款 +物流运费
@property (weak, nonatomic) IBOutlet UILabel *freightPriceLabel; // 运费
@property (weak, nonatomic) IBOutlet UILabel *collectionPriceLabel; // 代收款
@property (weak, nonatomic) IBOutlet UILabel *logisticsPriceLabel; // 物流运费

@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组


@end

@implementation OrderGetXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)loadNewData {
    // GetTabOrderCode
    // 请求参数
    NSString *methodName = @"GetTabOrderCode";
    NSString *params = @"&proName=%@";
    QConfig *config = [[QConfig alloc] init];
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, self.code] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"+++++++%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelOrderGetXiangQing objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        if (_dataArray.count > 0) {
            JSONModelOrderGetXiangQing * jsonModelOrderGetXiangQing = _dataArray.firstObject;
            switch ([jsonModelOrderGetXiangQing.status intValue]) {
                case 10:
                    self.statusButtton.titleLabel.text = @"订单正在审核";
                    break;
                case 20:
                    self.statusButtton.titleLabel.text = @"订单审核完毕";
                    break;
                case 22:
                    self.statusButtton.titleLabel.text = @"订单审核完毕";
                    break;
                case 25:
                    self.statusButtton.titleLabel.text = @"订单已被司机抢单";
                    break;
                case 30:
                    self.statusButtton.titleLabel.text = @"正在配送物流";
                    break;
                case 40:
                    self.statusButtton.titleLabel.text = @"物流已签收";
                    break;
                case 45:
                    self.statusButtton.titleLabel.text = @"货物已经开票";
                    break;
                case 50:
                    self.statusButtton.titleLabel.text = @"货物已经装车";
                    break;
                case 60:
                    self.statusButtton.titleLabel.text = @"货物已经到达目的地";
                    break;
                case 70:
                    self.statusButtton.titleLabel.text = @"";
                    break;
                case 80:
                    self.statusButtton.titleLabel.text = @"货物已送达";
                    break;
                case 90:
                    self.statusButtton.titleLabel.text = @"货款己经发放";
                    break;
                case 0:
                    self.statusButtton.titleLabel.text = @"订单获取状态失败";
                    break;
                default:
                    self.statusButtton.titleLabel.text = @"订单获取状态失败";
                    break;
            }
            self.codeLabel.text = jsonModelOrderGetXiangQing.code;
            self.consigneeNameLabel.text = jsonModelOrderGetXiangQing.consigneename;
            self.consigneePhoneLabel.text = jsonModelOrderGetXiangQing.consigneephone;
            self.cityLabel.text = jsonModelOrderGetXiangQing.city;
            self.logisticsNameLabel.text = jsonModelOrderGetXiangQing.logisticsname;
            if (jsonModelOrderGetXiangQing.pickupaddress.length == 0 || jsonModelOrderGetXiangQing.pickupaddress == nil || [jsonModelOrderGetXiangQing.pickupaddress isEqual: @""]) {
                self.pickupaddressLabel.text = @"";
            } else {
                NSArray *arr = [jsonModelOrderGetXiangQing.pickupaddress
                    componentsSeparatedByString:@"-"];
                if (arr.count >= 3) {
                    self.pickupaddressLabel.text = arr[2];
                } else {
                    self.pickupaddressLabel.text = @"";
                }
            }
            self.goodsnameAndNum.text = [NSString stringWithFormat:@"%@,%@件", jsonModelOrderGetXiangQing.goodsname, jsonModelOrderGetXiangQing.num];
            self.collectionprice.text = [NSString stringWithFormat:@"￥%@", jsonModelOrderGetXiangQing.collectionprice];
            self.pickupContactLabel.text = jsonModelOrderGetXiangQing.pickupcontact;
            self.stimeLabel.text = jsonModelOrderGetXiangQing.stime;
            self.freightPriceAndCollectionPriceAndLogisticsPriceLabel.text = [NSString stringWithFormat:@"%.2f",[jsonModelOrderGetXiangQing.collectionprice floatValue] + [jsonModelOrderGetXiangQing.freightprice floatValue] + [jsonModelOrderGetXiangQing.logisticprice floatValue]];
            self.collectionPriceLabel.text = jsonModelOrderGetXiangQing.collectionprice;
            self.freightPriceLabel.text = jsonModelOrderGetXiangQing.freightprice;
            self.logisticsPriceLabel.text = jsonModelOrderGetXiangQing.logisticprice;
            self.remarkLabel.text = jsonModelOrderGetXiangQing.remark;
        }
        
    } fail:^{
        
    }];

}

- (IBAction)removeDingDan:(UIButton *)sender {
    
}

- (IBAction)pingjiaDIngDan:(UIButton *)sender {
    MyEvaluationTableViewController *vc = [[MyEvaluationTableViewController alloc] init];
    vc.labelOne = @"评价订单,您的评价是我们";
    vc.labelTwo = @"前进的动力";
    [self.navigationController pushViewController:vc animated:YES];
                                
}

- (IBAction)dingdanzhuangtaiBtnClick:(UIButton *)sender {
    OrderDingDanZhuangTaiTableViewController *tvc = [[OrderDingDanZhuangTaiTableViewController alloc] init];
    tvc.code = self.code;
    tvc.labelOne = @"查看货物的";
    tvc.labelTwo = @"各个节点的时间状态";
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
