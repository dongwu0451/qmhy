//
//  MakeOrderOKViewController.m
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderOKViewController.h"
#import "TLTagsControl.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "JSONModelMakeOrderOK.h"
#import "BigAndSmallGoodsModel.h"

@interface MakeOrderOKViewController () <TLTagsControlDelegate>
//TLTags控件
@property (strong, nonatomic) TLTagsControl *smailEveCargoScrollView;
@property (strong, nonatomic) NSMutableArray *allTags;

@property (weak, nonatomic) IBOutlet UITextField *smailNameTextField;

@end

@implementation MakeOrderOKViewController

-(void)viewDidLoad {
    
    NSLog(@"总件数:=======================================");
    NSLog(@"zongjianshu---%@", self.zongjianshu);
    
    
    NSLog(@"代收款:=======================================");
    NSLog(@"daishoukuan---%@", self.daishoukuan);
    
    
    NSLog(@"发货人:=======================================");
    NSLog(@"fahuoren---%@", self.jsonModelConfigFahuo);
    NSLog(@"fahuoren-x_id---%@", self.jsonModelConfigFahuo.x_id);
    NSLog(@"fahuoren-uid---%@", self.jsonModelConfigFahuo.uid);
    NSLog(@"fahuoren-contact---%@", self.jsonModelConfigFahuo.contact);
    NSLog(@"fahuoren-tel---%@", self.jsonModelConfigFahuo.tel);
    NSLog(@"fahuoren-Province---%@", self.jsonModelConfigFahuo.Province);
    NSLog(@"fahuoren-city---%@", self.jsonModelConfigFahuo.city);
    NSLog(@"fahuoren-area---%@", self.jsonModelConfigFahuo.area);
    NSLog(@"fahuoren-addressCode---%@", self.jsonModelConfigFahuo.addressCode);
    NSLog(@"fahuoren-Address---%@", self.jsonModelConfigFahuo.Address);
    NSLog(@"fahuoren-status---%@", self.jsonModelConfigFahuo.status);
    NSLog(@"fahuoren-orderid---%@", self.jsonModelConfigFahuo.orderid);
    NSLog(@"fahuoren-createtime---%@", self.jsonModelConfigFahuo.createtime);
    NSLog(@"fahuoren-createby---%@", self.jsonModelConfigFahuo.createby);
    
    
    NSLog(@"收货人:=======================================");
    NSLog(@"shouhuoren---%@", self.shouhuoren);
    NSLog(@"shouhuoren-x_id---%@", self.shouhuoren.x_id);
    NSLog(@"shouhuoren-uid---%@", self.shouhuoren.uid);
    NSLog(@"shouhuoren-contact---%@", self.shouhuoren.contact);
    NSLog(@"shouhuoren-tel---%@", self.shouhuoren.tel);
    NSLog(@"shouhuoren-Province---%@", self.shouhuoren.Province);
    NSLog(@"shouhuoren-city---%@", self.shouhuoren.city);
    NSLog(@"shouhuoren-area---%@", self.shouhuoren.area);
    NSLog(@"shouhuoren-addressCode---%@", self.shouhuoren.addressCode);
    NSLog(@"shouhuoren-Address---%@", self.shouhuoren.Address);
    NSLog(@"shouhuoren-status---%@", self.shouhuoren.status);
    NSLog(@"shouhuoren-orderid---%@", self.shouhuoren.orderid);
    NSLog(@"shouhuoren-createtime---%@", self.shouhuoren.createtime);
    NSLog(@"shouhuoren-createby---%@", self.shouhuoren.createby);
    
    
    NSLog(@"货物:=======================================");
    NSLog(@"goods---%@", self.goods);
    for (int i = 0; i < self.goods.count; i++) {
        BigAndSmallGoodsModel *a = self.goods[i];
        NSLog(@"goods%d-bigCategory---%@", i, a.bigCategory);
        NSLog(@"goods%d-bigName---%@", i, a.bigName);
        NSLog(@"goods%d-bigLong---%@", i, a.bigLong);
        NSLog(@"goods%d-bigWide---%@", i, a.bigWide);
        NSLog(@"goods%d-bigHigh---%@", i, a.bigHigh);
        NSLog(@"goods%d-bigHeavy---%@", i, a.bigHeavy);
        NSLog(@"goods%d-bigReceipt---%@", i, a.bigReceipt);
        NSLog(@"goods%d-bigProtectionMoney---%@", i, a.bigProtectionMoney);
        NSLog(@"goods%d-bigDeliveryCharges---%@", i, a.bigDeliveryCharges);
        NSLog(@"goods%d-bigCollectionCharges---%@", i, a.bigCollectionCharges);
        NSLog(@"goods%d-bigNumber---%@", i, a.bigNumber);
        NSLog(@"goods%d-smailGoodsName---%@", i, a.smailGoodsName);
        NSLog(@"goods%d-smailNumber---%@", i, a.smailNumber);
        NSLog(@"goods%d-smailReceipt---%@", i, a.smailReceipt);
        NSLog(@"goods%d-smailValuationFee---%@", i, a.smailValuationFee);
        NSLog(@"goods%d-smailDeliveryCharges---%@", i, a.smailDeliveryCharges);
        NSLog(@"goods%d-smailCollectionCharges---%@", i, a.smailCollectionCharges);
        NSLog(@"goods%d-smailCategory---%@", i, a.smailCategory);
        NSLog(@"=======================================");
    }

    
    NSLog(@"即时到账:=======================================");
    NSLog(@"goodstype---%@", self.goodstype);
    
    
    NSLog(@"备注:=======================================");
    NSLog(@"beizhu---%@", self.beizhu);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadNewData];
    // 每次显示移除之前添加的标签
    static int i = 0;
    for (id smailEveCargoScrollView in self.view.subviews) {
        if ([smailEveCargoScrollView isMemberOfClass:[TLTagsControl class]]) {
            i++;
            NSLog(@"sum:%d----%@", i, smailEveCargoScrollView);
            [smailEveCargoScrollView removeFromSuperview];
        }
    }
}
// 初始化标签
- (void)setupSmall {
    CGRect frame = CGRectMake(8, 130, 300, 40);
//    NSLog(@"bb:%@", [_allTags[0] valueForKeyPath:@"uid"]);
    _smailEveCargoScrollView = [[TLTagsControl alloc] initWithFrame:frame andTags:[self.allTags valueForKeyPath:@"name"] withTagsControlMode:TLTagsControlModeList];
    UIColor *redBackgroundColor = [UIColor colorWithRed:233.0/255.0 green:70.0/255.0 blue:78.0/255.0 alpha:1];
    UIColor *whiteTextColor = [UIColor whiteColor];
    _smailEveCargoScrollView.tagsBackgroundColor = redBackgroundColor;
    _smailEveCargoScrollView.tagsTextColor = whiteTextColor;
    [_smailEveCargoScrollView reloadTagSubviews];
    _smailEveCargoScrollView.tapDelegate = self;
    [self.view addSubview:_smailEveCargoScrollView];
    _smailEveCargoScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index {
    self.smailNameTextField.text = tagsControl.tags[index];
    NSLog(@"Tag \"%@\" was tapped", tagsControl.tags[index]);
}

- (void)loadNewData {
    NSString *methodName = @"getlogistics";
    NSString *params = @"&proName=%d";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *array = [dic objectForKey:@"rs"];
        _allTags = [JSONModelMakeOrderOK objectArrayWithKeyValuesArray:array];
        // 2. 设置并添加标签(多次运行会多次添加)
        [self setupSmall];//初始化标签
    } fail:^{
        
    }];
}
- (IBAction)shangchuanzhaopianBtnClick:(UIButton *)sender {
    NSLog(@"123");
}

- (IBAction)tijiaodingdanBtnClick:(UIButton *)sender {
    NSLog(@"12341");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
