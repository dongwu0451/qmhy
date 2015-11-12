//
//  SelectGoodsVC.m
//  qmhy
//  选择货物页面
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "SelectGoodsVC.h"
#import "TLTagsControl.h"
#import "ConfigCGoodsTVC.h"
#import "ConfigCShouhuoTVC.h"

@interface SelectGoodsVC () <TLTagsControlDelegate, ConfigCGoodsTVCDelegate>
//货物模型
@property (strong, nonatomic) BigAndSmallGoodsModel *goods;
//TLTags控件
@property (strong, nonatomic) TLTagsControl *smailEveCargoScrollView;
//ScrlllView中的数组
@property (strong, nonatomic) NSMutableArray *allTags;

//导航控制器上的大小件货物选择器
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl; // 导航控制器上的大小件货物选择器
//大件货物
@property (strong, nonatomic) IBOutlet UIView *bigCargoView; // 大件货物View
@property (strong, nonatomic) IBOutlet UIImageView *bigUIImageView; // 大件货物图片
@property (strong, nonatomic) IBOutlet UITextField *bigLongTextField; // 大件货物长度文本框
@property (strong, nonatomic) IBOutlet UITextField *bigWideTextField; // 大件货物宽度文本框
@property (strong, nonatomic) IBOutlet UITextField *bigHighTextField; // 大件货物高度文本框
@property (strong, nonatomic) IBOutlet UITextField *bigHeavyTextField; // 大件货物重量文本框
@property (strong, nonatomic) IBOutlet UISwitch *bigReceiptSwitch; // 大件货物是否回执
@property (strong, nonatomic) IBOutlet UITextField *bigProtectionMoneyTextField; // 大件货物保护费文本框
@property (strong, nonatomic) IBOutlet UITextField *bigDeliveryChargesTextField; // 大件货物送货费文本框
@property (strong, nonatomic) IBOutlet UITextField *bigCollectionChargesTextField; // 大件货物代收费文本框
//小件货物
@property (strong, nonatomic) IBOutlet UIView *smailCargoView;
@property (weak, nonatomic) IBOutlet UITextField *smailNameTextField; // 小件货物名称
@property (weak, nonatomic) IBOutlet UITextField *smailNumberTextField; // 小件货物件数文本框
@property (weak, nonatomic) IBOutlet UIStepper *smailNumberStepper; // 小件货物件数按钮
@property (weak, nonatomic) IBOutlet UISwitch *smailReceiptSwitch;
@property (weak, nonatomic) IBOutlet UITextField *smailValuationFeeTextField; // 小件货物保价费
@property (weak, nonatomic) IBOutlet UITextField *smailDeliveryChargesTextField; // 小件货物送货费
@property (weak, nonatomic) IBOutlet UITextField *smailCollectionChargesTextField; // 小件货物代收费

//右边上面的按钮
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;


@end

@implementation SelectGoodsVC

//数据初始化
- (NSMutableArray *)allTags {
    if (!_allTags) {
        //        _allTags = [NSMutableArray array];
        _allTags = [BigAndSmallGoodsModel allBigAndSmallGoodsFakeData];
    }
    return _allTags;
}

// 当控制器本身被小会时注销监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc---------SelectGoodsVC");
}

//实现代理 配置常用货物传给选择货物页面
- (void)configCGoodsTVC:(ConfigCGoodsTVC *)configVc didChooseGoods:(BigAndSmallGoodsModel *)goods {
    _smailNameTextField.text = goods.smailGoodsName;
}
//========================================================================
///////////////标签代理方法，处理点击标签的事件//////////////////
//========================================================================
- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index {
    self.smailNameTextField.text = tagsControl.tags[index];
    NSLog(@"Tag \"%@\" was tapped", tagsControl.tags[index]);
}



//// 监听通知，接受小货物名  -----添加货物传给选择货物页面-----  应当写在配置常用货物页面？？？？
//// 监听方法：将接收到的货物名赋值给 货物 类的小货物名属性，并将货物加入到标签数组，更新标签
//- (void)receiveSmallGoodsName:(NSNotification *)notification {
//    BigAndSmallGoodsModel *goods = [[BigAndSmallGoodsModel alloc] init];
//    goods.smailGoodsName = notification.userInfo[@"goodsName"];
//    [self.allTags addObject:goods];
//    NSLog(@"%@", self.allTags);
//}

//初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.smailCargoView.hidden = YES;
    self.bigCargoView.hidden = NO;
    //[self setupSmall];
    // 监听通知，接受小货物名
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSmallGoodsName:) name:@"smallGoodsName" object:nil];
}
//初始化界面
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //隐藏右上面按钮
    _rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = nil;

    // 每次显示移除之前添加的标签
    static int i = 0;
    for (id smailEveCargoScrollView in _smailCargoView.subviews) {
        if ([smailEveCargoScrollView isMemberOfClass:[TLTagsControl class]]) {
            i++;
            NSLog(@"sum:%d----%@", i, smailEveCargoScrollView);
            [smailEveCargoScrollView removeFromSuperview];
        }
    }
    // 2. 设置并添加标签(多次运行会多次添加)
    [self setupSmall];//初始化标签
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//===================================
//右上角添加货物按钮
//===================================
- (IBAction)addGoods:(id)sender {
    ConfigCGoodsTVC *cgVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDGoods"];
    cgVc.delegate = self;
    [self.navigationController pushViewController:cgVc animated:YES];
}

//===================================
//添加数值控件  这个是steped但是么有找到方法吧他的值怎么给textfield
//===================================
- (IBAction)addNumber:(UIStepper *)sender {
    
    UIStepper *st = (UIStepper *)sender;
    int doubleZhuanInt = st.value;
    NSString *intZhuanString = [NSString stringWithFormat:@"%d",doubleZhuanInt];
    //    NSLog(@"***************%@", stringFloat);
    //    NSString*str = (NSString *)st;
    //    NSLog(@"%@", str);
    self.smailNumberTextField.text = intZhuanString;
    //
    //    NSLog(@"%@",stringFloat);
    //    NSLog(@"%f",st.value);
}

//===================================
//保存大件货物按钮事件
//===================================
- (IBAction)saveBigGoods:(UIButton *)sender {
    
    if (!_bigLongTextField.text.length || !_bigWideTextField.text.length || !_bigHighTextField.text.length || !_bigHeavyTextField.text.length || !_bigProtectionMoneyTextField.text.length || !_bigDeliveryChargesTextField.text.length || !_bigCollectionChargesTextField.text.length) {
        return;
    }
    _goods = [[BigAndSmallGoodsModel alloc] init];
    _goods.bigLong = _bigLongTextField.text;
    _goods.bigWide = _bigWideTextField.text;
    _goods.bigHigh = _bigHighTextField.text;
    _goods.bigHeavy = _bigHeavyTextField.text;
    _goods.bigProtectionMoney = _bigProtectionMoneyTextField.text;
    _goods.bigDeliveryCharges = _bigDeliveryChargesTextField.text;
    _goods.bigCollectionCharges = _bigCollectionChargesTextField.text;
    _goods.bigCategory = @"大件";
    _goods.bigReceipt = _bigReceiptSwitch.on;
    
    
    if ([self.delegate respondsToSelector:@selector(addGoodsVC:saveReturnGoods:)]) {
        [self.delegate addGoodsVC:self saveReturnGoods:_goods];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"保存小件货物按钮事件AAAAAAAA");
    
}
//===================================
//保存小件货物按钮事件
//===================================
- (IBAction)saveGoods:(id)sender {
    QLog(@"saveGoods");
    // 如果需要填写的内容没有填，则直接退出，点击保存不做任何操作
    if (!_smailNameTextField.text.length ||
        !_smailNumberTextField.text.length ||
        !_smailValuationFeeTextField.text.length ||
        !_smailDeliveryChargesTextField.text.length ||
        !_smailCollectionChargesTextField.text.length) {
        [AppDelegate showAlert:@"请选择货物名称"];
        return;
    }
    
    
    // 否则配置模型属性
    _goods = [[BigAndSmallGoodsModel alloc] init];
    _goods.smailGoodsName = _smailNameTextField.text;
    _goods.smailNumber = _smailNumberTextField.text;
    _goods.smailReceipt = _smailReceiptSwitch.on;
    _goods.smailValuationFee = _smailValuationFeeTextField.text;
    _goods.smailDeliveryCharges = _smailDeliveryChargesTextField.text;
    _goods.smailCollectionCharges = _smailCollectionChargesTextField.text;
    _goods.smailCategory = @"小件";
    
    // 传递模型
    if ([self.delegate respondsToSelector:@selector(addGoodsVC:saveReturnGoods:)]) {
        [self.delegate addGoodsVC:self saveReturnGoods:_goods];
    }
    
    // pop控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}
//===================================
//大货物 小货物 切换按钮
//===================================
- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.smailCargoView.hidden = YES;
        self.bigCargoView.hidden = NO;
        self.navigationItem.rightBarButtonItem = nil;
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.bigCargoView.hidden = YES;
        self.smailCargoView.hidden = NO;
        self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
    }
}

//初始化标签
- (void)setupSmall {
    CGRect frame = CGRectMake(8, 150, 304, 40);
    _smailEveCargoScrollView = [[TLTagsControl alloc] initWithFrame:frame andTags:[self.allTags valueForKeyPath:@"smailGoodsName"] withTagsControlMode:TLTagsControlModeList];
    //_smailEveCargoScrollView.tagPlaceholder = @"输入商品";
    //_smailEveCargoScrollView.mode = TLTagsControlModeList;
    UIColor *redBackgroundColor = [UIColor colorWithRed:233.0/255.0 green:70.0/255.0 blue:78.0/255.0 alpha:1];
    UIColor *whiteTextColor = [UIColor whiteColor];
    _smailEveCargoScrollView.tagsBackgroundColor = redBackgroundColor;
    _smailEveCargoScrollView.tagsTextColor = whiteTextColor;
    [_smailEveCargoScrollView reloadTagSubviews];
    _smailEveCargoScrollView.tapDelegate = self;
    //_smailEveCargoScrollView.backgroundColor = [UIColor blueColor];
    [self.smailCargoView addSubview:_smailEveCargoScrollView];
    _smailEveCargoScrollView.showsHorizontalScrollIndicator = NO;
}


@end
