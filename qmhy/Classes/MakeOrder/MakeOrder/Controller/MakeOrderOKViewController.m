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

@interface MakeOrderOKViewController () <TLTagsControlDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
//TLTags控件
@property (strong, nonatomic) TLTagsControl *smailEveCargoScrollView;
@property (strong, nonatomic) NSMutableArray *allTags;

@property (weak, nonatomic) IBOutlet UITextField *smailNameTextField;  // 物流名称 textfield 4 物流名称 ps:这个参数就是这个页面上的输入框的值
@property (weak, nonatomic) IBOutlet UIButton *shanchuzhaopian;

// addgoodslist and addorderlist
@property (nonatomic, copy) NSString *addgoodslistAndAddorderlist_uid; // 0 用户id
@property (nonatomic, copy) NSString *addgoodslistAndAddorderlist_code; // 1 订单发货码

// addgoodslist
@property (nonatomic, copy) NSString *addgoodslist_name; // 2
@property (nonatomic, copy) NSString *addgoodslist_type; // 3
@property (nonatomic, copy) NSString *addgoodslist_longs; // 4
@property (nonatomic, copy) NSString *addgoodslist_width; // 5
@property (nonatomic, copy) NSString *addgoodslist_height; // 6
@property (nonatomic, copy) NSString *addgoodslist_weight; // 7
@property (nonatomic, copy) NSString *addgoodslist_count; // 8
@property (nonatomic, copy) NSString *addgoodslist_ishuizhi; // 9
@property (nonatomic, copy) NSString *addgoodslist_insurance; // 10
@property (nonatomic, copy) NSString *addgoodslist_sendgoods; // 11
@property (nonatomic, copy) NSString *addgoodslist_collectionprice; // 12
@property (nonatomic, copy) NSString *addgoodslist_volume; // 13
@property (nonatomic, copy) NSString *addgoodslist_sumnum; // 14


// addorderlist
@property (nonatomic, copy) NSString *addorderlist_consigneeName; // 2 收货人姓名
@property (nonatomic, copy) NSString *addorderlist_consigneePhone; // 3 收货人电话
@property (nonatomic, copy) NSString *addorderlist_city; // 5 城市
@property (nonatomic, copy) NSString *addorderlist_goodsName; // 6 货物名称
//@property (nonatomic, copy) NSString *addorderlist_standard; // 8 规格 写死的值，箱货
//@property (nonatomic, copy) NSString *addorderlist_goodDescribe; // 9 货物描述 写死的无
@property (nonatomic, copy) NSString *addorderlist_freightPrice; // 10 短途运费 对，所有货物的送货费的总和
@property (nonatomic, copy) NSString *addorderlist_collectionPrice; // 11 代收款
//@property (nonatomic, copy) NSString *addorderlist_logisticsPrice; // 12 理想物流运费价格 传的话 传0 ，没传就算了 不知道啊 文档上写的又这个 就写死 0吧
@property (nonatomic, copy) NSString *addorderlist_pickupContact; // 13 取货联系人
@property (nonatomic, copy) NSString *addorderlist_pickupAddress; // 14 取货地址
@property (nonatomic, copy) NSString *addorderlist_pickupPhone; // 15 取货联系人电话
@property (nonatomic, copy) NSString *addorderlist_remark; // 16 备注
@property (nonatomic, copy) NSString *addorderlist_image; // 17 图片
//@property (nonatomic, copy) NSString *addorderlist_status; // 18 状态口 10-－－90
@property (nonatomic, copy) NSString *addorderlist_startpoint; // 19 起始点经纬度
@property (nonatomic, copy) NSString *addorderlist_endpoint; // 20 结束点经纬度
@property (nonatomic, copy) NSString *addorderlist_goodtype; // 21

@end

@implementation MakeOrderOKViewController

-(void)viewDidLoad {
    QConfig *config = [[QConfig alloc] init];
    _addgoodslistAndAddorderlist_uid = config.uid;
    _addorderlist_goodsName = @"";
    _addorderlist_freightPrice = @"0.00";
    _addorderlist_collectionPrice = @"0.00";
    _addgoodslist_name = @"";
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
        BigAndSmallGoodsModel *bigAndSmallGoodsModel = self.goods[i];
        NSLog(@"goods%d-bigCategory---%@", i, bigAndSmallGoodsModel.bigCategory);
        NSLog(@"goods%d-bigName---%@", i, bigAndSmallGoodsModel.bigName);
        NSLog(@"goods%d-bigLong---%@", i, bigAndSmallGoodsModel.bigLong);
        NSLog(@"goods%d-bigWide---%@", i, bigAndSmallGoodsModel.bigWide);
        NSLog(@"goods%d-bigHigh---%@", i, bigAndSmallGoodsModel.bigHigh);
        NSLog(@"goods%d-bigHeavy---%@", i, bigAndSmallGoodsModel.bigHeavy);
        NSLog(@"goods%d-bigReceipt---%@", i, bigAndSmallGoodsModel.bigReceipt);
        NSLog(@"goods%d-bigProtectionMoney---%@", i, bigAndSmallGoodsModel.bigProtectionMoney);
        NSLog(@"goods%d-bigDeliveryCharges---%@", i, bigAndSmallGoodsModel.bigDeliveryCharges);
        NSLog(@"goods%d-bigCollectionCharges---%@", i, bigAndSmallGoodsModel.bigCollectionCharges);
        NSLog(@"goods%d-bigNumber---%@", i, bigAndSmallGoodsModel.bigNumber);
        NSLog(@"goods%d-smailGoodsName---%@", i, bigAndSmallGoodsModel.smailGoodsName);
        NSLog(@"goods%d-smailNumber---%@", i, bigAndSmallGoodsModel.smailNumber);
        NSLog(@"goods%d-smailReceipt---%@", i, bigAndSmallGoodsModel.smailReceipt);
        NSLog(@"goods%d-smailValuationFee---%@", i, bigAndSmallGoodsModel.smailValuationFee);
        NSLog(@"goods%d-smailDeliveryCharges---%@", i, bigAndSmallGoodsModel.smailDeliveryCharges);
        NSLog(@"goods%d-smailCollectionCharges---%@", i, bigAndSmallGoodsModel.smailCollectionCharges);
        NSLog(@"goods%d-smailCategory---%@", i, bigAndSmallGoodsModel.smailCategory);
        NSLog(@"=======================================");
        
        // addorderlist 货物名 addorderlist_goodsName 6
        if ([bigAndSmallGoodsModel.bigCategory isEqualToString:@"大件"]){
            _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString:bigAndSmallGoodsModel.bigCategory];
            _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString:@"货物"];
            _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString:bigAndSmallGoodsModel.bigNumber];
        } else {
            _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString: [self newStr:bigAndSmallGoodsModel.smailGoodsName]];
            if (self.goods.count > 1) {
                _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString:bigAndSmallGoodsModel.smailNumber];
            }
            
        }
        if (i < self.goods.count - 1) {
            _addorderlist_goodsName = [_addorderlist_goodsName stringByAppendingString:@","];
        }
        
        //  addorderlist 短途运费 addorderlist_freightPrice 10 ps:送货费总和
        if (bigAndSmallGoodsModel.bigDeliveryCharges.length == 0) {
            bigAndSmallGoodsModel.bigDeliveryCharges = @"0";
        }
        if (bigAndSmallGoodsModel.smailDeliveryCharges.length == 0) {
            bigAndSmallGoodsModel.smailDeliveryCharges = @"0";
        }
        _addorderlist_freightPrice =  [NSString stringWithFormat:@"%f", [_addorderlist_freightPrice floatValue] + [bigAndSmallGoodsModel.bigDeliveryCharges floatValue] + [bigAndSmallGoodsModel.smailDeliveryCharges floatValue]];
        
        
        //  addorderlist 短途运费 addorderlist_collectionPrice 11
        if (bigAndSmallGoodsModel.bigCollectionCharges.length == 0) {
            bigAndSmallGoodsModel.bigCollectionCharges = @"0";
        }
        if (bigAndSmallGoodsModel.smailCollectionCharges.length == 0) {
            bigAndSmallGoodsModel.smailCollectionCharges = @"0";
        }
        _addorderlist_collectionPrice =  [NSString stringWithFormat:@"%f", [_addorderlist_collectionPrice floatValue] + [bigAndSmallGoodsModel.bigCollectionCharges floatValue] + [bigAndSmallGoodsModel.smailCollectionCharges floatValue]];
        
        
        //        // addgoodslist addgoodslist_name 2
        //        if ([bigAndSmallGoodsModel.bigCategory isEqualToString:@"大件"]) {
        //            _addgoodslist_name = [_addgoodslist_name stringByAppendingString:@"大件货物"];
        //        } else {
        //            _addgoodslist_name = [_addgoodslist_name stringByAppendingString:[self newStr:bigAndSmallGoodsModel.smailGoodsName]];
        //        }
        //        if (i < self.goods.count - 1) {
        //            _addgoodslist_name = [_addgoodslist_name stringByAppendingString:@"-"];
        //        }
        
        
    }
    
    // addorderlist 收货人姓名 addorderlist_consigneeName 2
    _addorderlist_consigneeName = [self newStr:self.shouhuoren.contact];
    
    // addorderlist 收货人电话 addorderlist_consigneePhone 3
    _addorderlist_consigneePhone = [self newStr:self.shouhuoren.tel];
    
    // addorderlist 城市 addorderlist_city 5
    //    [self newStr:self.shouhuoren.Province];
    //    [self newStr:self.shouhuoren.city];
    //    [self newStr:self.shouhuoren.area];
    //    [self newStr:self.shouhuoren.Address];
    _addorderlist_city = [NSString stringWithFormat:@"%@-%@-%@-%@", [self newStr:self.shouhuoren.Province], [self newStr:self.shouhuoren.city], [self newStr:self.shouhuoren.area], [self newStr:self.shouhuoren.Address]];
    
    // addorderlist 取货联系人 _addorderlist_pickupContact 13  取货联系人是发货人
    _addorderlist_pickupContact = [self newStr:self.jsonModelConfigFahuo.contact];
    
    // addorderlist addorderlist_pickupAddress 14 取货地址
    _addorderlist_pickupAddress = [NSString stringWithFormat:@"%@-%@-%@-%@", [self newStr:self.jsonModelConfigFahuo.Province], [self newStr:self.jsonModelConfigFahuo.city], [self newStr:self.jsonModelConfigFahuo.area], [self newStr:self.jsonModelConfigFahuo.Address]];
    // addorderlist addorderlist_pickupPhone 15 取货联系人电话
    _addorderlist_pickupPhone = [self newStr:self.jsonModelConfigFahuo.tel];
    
    
    // addorderlist addorderlist_remark 16 备注
    _addorderlist_remark = [self newStr:self.beizhu];
    
    // addorderlist addorderlist_startpoint 19 startpoint 都说了是 起点 当然是发货人啊，endpoint是收货人
    _addorderlist_startpoint = [self newStr:self.jsonModelConfigFahuo.addressCode];
    // addorderlist addorderlist_endpoint 20
    _addorderlist_endpoint = [self newStr:self.shouhuoren.addressCode];
    
    _addorderlist_goodtype = [self newStr:  self.goodstype];
    
    NSLog(@"即时到账:=======================================");
    NSLog(@"goodstype---%@", self.goodstype);
    
    
    NSLog(@"备注:=======================================");
    NSLog(@"beizhu---%@", self.beizhu);
    
    [self addgoodslist];
    
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

- (void)addgoodslist {
    
    // 模拟
    [self hehehecode];
    NSLog(@"A-addgoodslistAndAddorderlist_uid---%@", self.addgoodslistAndAddorderlist_uid);
    NSLog(@"A-addgoodslistAndAddorderlist_code---%@", self.addgoodslistAndAddorderlist_code);
    NSLog(@"addgoodslist_name---%@", self.addgoodslist_name);
    NSLog(@"addgoodslist_type---%@", self.addgoodslist_type);
    NSLog(@"addgoodslist_longs---%@", self.addgoodslist_longs);
    NSLog(@"addgoodslist_width---%@", self.addgoodslist_width);
    NSLog(@"addgoodslist_height---%@", self.addgoodslist_height);
    NSLog(@"addgoodslist_weight---%@", self.addgoodslist_weight);
    NSLog(@"addgoodslist_count---%@", self.addgoodslist_count);
    NSLog(@"addgoodslist_ishuizhi---%@", self.addgoodslist_ishuizhi);
    NSLog(@"addgoodslist_insurance---%@", self.addgoodslist_insurance);
    NSLog(@"addgoodslist_sendgoods---%@", self.addgoodslist_sendgoods);
    NSLog(@"addgoodslist_collectionprice---%@", self.addgoodslist_collectionprice);
    NSLog(@"addgoodslist_volume---%@", self.addgoodslist_volume);
    NSLog(@"addgoodslist_sumnum---%@", self.addgoodslist_sumnum);
    
    NSString *methodName = @"addgoodslist";
    NSString *params = @"&proName=%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@";
    NSString *uid = self.addgoodslistAndAddorderlist_uid;
    NSString *code = self.addgoodslistAndAddorderlist_code;
    NSString *name = self.addgoodslist_name;
    NSString *type = self.addgoodslist_type;
    NSString *longs = self.addgoodslist_longs;
    NSString *width = self.addgoodslist_width;
    NSString *height = self.addgoodslist_height;
    NSString *weight = self.addgoodslist_weight;
    NSString *count = self.addgoodslist_count;
    NSString *ishuizhi = self.addgoodslist_ishuizhi;
    NSString *insurance = self.addgoodslist_insurance;
    NSString *sendgoods = self.addgoodslist_sendgoods;
    NSString *collectionprice = self.addgoodslist_collectionprice;
    NSString *volume = self.addgoodslist_volume;
    NSString *sumnum = self.addgoodslist_sumnum;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, code, name, type, longs, width, height, weight, count, ishuizhi, insurance, sendgoods, collectionprice, volume, sumnum] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"A-%@", URL);
    //    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
    //        NSError *error = nil;
    //        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //        NSArray *array = [dic objectForKey:@"rs"];
    //#warning 呵呵
    //
    //    } fail:^{
    //
    //    }];
    [self addorderlist];
}

- (void)addorderlist {
    // 模拟
    
    NSString *addorderlist_freightPrice = [NSString stringWithFormat:@"%.2f", [_addorderlist_freightPrice floatValue]];
    NSString *addorderlist_collectionPrice = [NSString stringWithFormat:@"%.2f", [_addorderlist_collectionPrice floatValue]];
    NSLog(@"B-addgoodslistAndAddorderlist_uid---%@", self.addgoodslistAndAddorderlist_uid);
    NSLog(@"B-addgoodslistAndAddorderlist_code---%@", self.addgoodslistAndAddorderlist_code);
    NSLog(@"addorderlist_consigneeName---%@", self.addorderlist_consigneeName);
    NSLog(@"addorderlist_consigneePhone---%@", self.addorderlist_consigneePhone);
    NSLog(@"smailNameTextField.text---%@", self.smailNameTextField.text);
    NSLog(@"addorderlist_city---%@", self.addorderlist_city);
    NSLog(@"addorderlist_goodsName---%@", self.addorderlist_goodsName);
    NSLog(@"addorderlist_num---%@", self.zongjianshu);
    NSLog(@"addorderlist_standard---%@", @"箱货");
    NSLog(@"addorderlist_goodDescribe---%@", @"无");
    NSLog(@"addorderlist_freightPrice---%@", self.addorderlist_freightPrice);
    NSLog(@"addorderlist_collectionPrice---%@", self.addorderlist_collectionPrice);
    NSLog(@"addorderlist_logisticsPrice---%@", @"0");
    NSLog(@"addorderlist_pickupContact---%@", self.addorderlist_pickupContact);
    NSLog(@"addorderlist_pickupAddress---%@", self.addorderlist_pickupAddress);
    NSLog(@"addorderlist_pickupPhone---%@", self.addorderlist_pickupPhone);
    NSLog(@"addorderlist_remark---%@", self.addorderlist_remark);
    NSLog(@"addorderlist_image---%@", self.addorderlist_image);
    NSLog(@"addorderlist_status---%@", @"10");
    NSLog(@"addorderlist_startpoint---%@", self.addorderlist_startpoint);
    NSLog(@"addorderlist_endpoint---%@", self.addorderlist_endpoint);
    NSLog(@"addorderlist_goodtype---%@", self.addorderlist_goodtype);
    
    NSString *methodName = @"addorderlist";
    NSString *params = @"&proName=%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@_%@";
    NSString *uid = self.addgoodslistAndAddorderlist_uid;
    NSString *code = self.addgoodslistAndAddorderlist_code;
    NSString *consigneeName = self.addorderlist_consigneeName;
    NSString *consigneePhone = self.addorderlist_consigneePhone;
    NSString *logisticsName = self.smailNameTextField.text;
    NSString *city = self.addorderlist_city;
    NSString *goodsName = self.addorderlist_goodsName;
    NSString *num = self.zongjianshu;
    NSString *standard = @"箱货";
    NSString *goodDescribe = @"无";
    NSString *freightPrice = addorderlist_freightPrice;
    NSString *collectionPrice = addorderlist_collectionPrice;
    NSString *logisticsPrice = @"0";
    NSString *pickupContact = self.addorderlist_pickupContact;
    NSString *pickupAddress = self.addorderlist_pickupAddress;
    NSString *pickupPhone = self.addorderlist_pickupPhone;
    NSString *remark = self.addorderlist_remark;
    NSString *image = self.addorderlist_image;
    NSString *status = @"10";
    NSString *startpoint = self.addorderlist_startpoint;
    NSString *endpoint = self.addorderlist_endpoint;
    NSString *goodtype = self.addorderlist_goodtype;
    
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, code, consigneeName, consigneePhone, logisticsName, city, goodsName, num, standard, goodDescribe, freightPrice, collectionPrice, logisticsPrice, pickupContact, pickupAddress, pickupPhone, remark, image, status, startpoint, endpoint, goodtype] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"B-%@", URL);
    //    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
    //        NSError *error = nil;
    //        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    //        NSArray *array = [dic objectForKey:@"rs"];
    //#warning 呵呵
    //
    //    } fail:^{
    //
    //    }];
}


- (void)hehehecode {
    // uid = uid
    // code = 月 时 分 日 秒
    // cindex = 00-99的随机数
    QConfig *c = [[QConfig alloc] init];
    NSString *asd = c.uid;
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat: @"MMHHmmddss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    //1、获取一个随机整数范围在：[0,100)包括0，不包括100
    // int x = arc4random() % 100;
    int x = (arc4random() % 80 ) + 11;
    NSString *str = [NSString stringWithFormat:@"%d", x];
    NSString *asdasd = [NSString stringWithFormat:@"%@%@%@", asd, locationString, str];
    //    NSLog(@"%@", asdasd);
    self.addgoodslistAndAddorderlist_code = asdasd;
}



- (NSString *)newStr:(NSString *)str {
    if (str.length <= 0) {
        return @"";
    } else {
        return str;
    }
}


- (IBAction)shangchuanzhaopianBtnClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
}

#pragma mark - actionSheet的代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePicker.delegate = self;
    // 允许编辑
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) { // 拍照
        // 如果用户第一次选择 NO  以后的用户主动打开 所以如果是NO 就直接返回
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        // 设置图片来源
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    if (buttonIndex == 1) { // 相册
        // 如果用户第一次选择 NO  以后的用户主动打开 所以如果是NO 就直接返回
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        // 设置图片来源
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if (buttonIndex == 2) { // 取消
        return;
    }
    // 显示控制器
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 获得图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.shanchuzhaopian setImage:image forState:UIControlStateNormal];
    self.shanchuzhaopian.imageView.image = image;
    // 隐藏模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 上传图片方法
- (void)upLoadImage {
    if (self.shanchuzhaopian.imageView.image == nil) {
        return;
    }
    [MBProgressHUD showMessage:@"正在更换头像..." toView:self.view];
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 1.1.设置请求格式
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    // 1.2.设置返回格式
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.请求地址
    NSString *url = @"";
    [mgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *fileData = UIImageJPEGRepresentation(self.shanchuzhaopian.imageView.image, 1.0);
        //        NSData *fileData = UIImagePNGRepresentation(self.headImageView.image);
        // FileURL:需要上传的文件的具体数据 name:服务器那边接收文件用的参数名 fileName:(告诉服务器所上传的文件名) mimeType:所上传的文件类型
        [formData appendPartWithFileData:fileData name:@"myfile" fileName:[self qmhySetImageName] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSString *result = [dic[@"result"] stringValue];
        if ([result isEqualToString:@"1"]) {
            NSLog(@"上传成功");
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"更换头像失败" toView:self.view];
            NSLog(@"failure上传失败");
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"更换头像失败" toView:self.view];
        NSLog(@"failure上传失败");
    }];
}

// 设置图片名
- (NSString *)qmhySetImageName {
    //    XXCConfig *config = [[XXCConfig alloc] init];
    //    NSString *uid = config.uid;
    //    NSDate *senddate=[NSDate date];
    //    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [dateformatter setDateFormat:@"YYYYMMdd_HHmmss"];
    //    NSString *locationString=[dateformatter stringFromDate:senddate];
    //    NSString *str1 = @"USER%@%@%@%@";
    //    NSString *str2 = @"_JPEG_";
    //    NSString *str3 = @"_.jpg";
    //    NSString *imageName = [NSString stringWithFormat:str1, uid, str2, locationString, str3];
    //    _headImageName = imageName;
    //    //    NSLog(@"locationString:%@",imageName);
    //    return imageName;
    return @"";
}


- (IBAction)tijiaodingdanBtnClick:(UIButton *)sender {
    NSLog(@"12341");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
