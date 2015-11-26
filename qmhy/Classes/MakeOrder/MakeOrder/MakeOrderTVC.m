//
//  MakeOrderTVC.m
//  qmhy
//  下单的第一个页面（收货和取货的添加是单独xib 没有放在故事板）
//  NSLog(@"订单跟踪===,%ld",tab.selectedIndex);
//  Created by lingsbb on 15-8-23.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.

//  copy string
//  assign 变量
//  weak  delegate 和 Outlet
//  strong、retain   相对weak

#import "MakeOrderTVC.h"
#import "MakeOrderTotalCell.h"
#import "ConfigCShouhuoTVC.h"
#import "ConfigCommonTVC.h"
#import "ShouhuoModel.h"
#import "MakeOrderShouhuoCell.h"
#import "SelectGoodsVC.h"
#import "MakeOrderGoodsCell.h"
#import "ConfigCQuhuoTVC.h"
#import "MakeOrderQuhuoCell.h"
#import "SelectCarVC.h"
#import "CarModel.h"
#import "MakeOrderCarCell.h"

//要实现四个页面的代理委托
@interface MakeOrderTVC () <ConfigCShouhuoTVCDelegate, AddSelectGoodsVCDelegate, ConfigCQuhuoTVCDelegate, ConfigCarVCDelegate>

@property (strong, nonatomic) NSMutableArray *allShouhuo;//收货类（批量）
@property (strong, nonatomic) NSMutableArray *goods;//货物类（批量）
@property (strong, nonatomic) QuhuoModel *quhuoModel;//取货类
@property (strong, nonatomic) CarModel *carModel;//车辆类

@end

@implementation MakeOrderTVC

//假数据：所有收货联系人
- (NSMutableArray *)allShouhuo {
    if (!_allShouhuo) {
        _allShouhuo = [NSMutableArray array];
    }
    return _allShouhuo;
}

//假数据：货物
- (NSMutableArray *)goods {
    if (!_goods) {
        _goods = [NSMutableArray array];
    }
    return _goods;
}

//初始化样式
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//初始化显示
- (void)viewDidLoad
{
    [super viewDidLoad];
    //在TableView向数据源请求数据之前使用-registerNib:forCellReuseIdentifier:方法为@“MY_CELL_ID”注册过nib的话，就可以省下每次判断并初始化cell的代码，要是在重用队列里没有可用的cell的话，runtime将自动帮我们生成并初始化一个可用的cell。
    
    // 注册统计栏的自定义单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderTotalCell" bundle:nil] forCellReuseIdentifier:@"makeorder_top"];
    // 注册选择收货信息的自定义单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderShouhuoCell" bundle:nil] forCellReuseIdentifier:@"makeoredershouhuo_main"];
    // 注册选择货物信息的自定义单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderGoodsCell" bundle:nil] forCellReuseIdentifier:@"makeoredergoods_main"];
    // 注册选择车辆信息的自定义单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderCarCell" bundle:nil] forCellReuseIdentifier:@"makeoredercar_main"];
    // 注册先择取货信息的自定义单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderQuhuoCell" bundle:nil] forCellReuseIdentifier:@"makeorederquhuo_main"];

}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    [self.tableView reloadData];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;//统计、收货人（批量）、货物（批量）、车辆、取货人
}

//设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){//第一组 统计栏
        return 82.;
    }else{                    //其他组
        if (indexPath.row==0)  //其他组第一行
            return 38.;
        else                   //其他组 其他行
            return 68.;
    }
}

//设置各组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0)//第1组 统计
    {
        return 1;
    }
    else if(section==1)//第2组 收货人（批量）
    {
        return self.allShouhuo.count + 1;
    }
    else if(section==2)//第3组 货物（批量）
    {
        return _goods.count + 1;
    }
    else if(section==3)//第4组 车辆
    {
        if (NULL==_carModel)
            return 1;
        else
            return 2;
    }
    else if(section==4)//第5组 取货人
    {
        if (NULL==_quhuoModel)
            return 1;
        else
            return 2;
    }
    else
    {
        return 1;
    }
}

//===========================  接收各个页面给的代理请求 start ========================================

//接收选择车辆页面的代理请求 选择车辆 完成按钮触发代理
- (void)ConfigCarVC:(SelectCarVC *)configVc didPassCar:(CarModel *)carModel {
    self.carModel = carModel;
    [self.tableView reloadData];//重新装数据
}

//接收配置常用取货人列表页面给的代理请求
- (void)selectedConfigCQuhuoTVC:(ConfigCQuhuoTVC *)hvc didInputReturnQuhuoModel:(QuhuoModel *)quhuoModel {
    NSLog(@"%@", quhuoModel.quhuoName);
    self.quhuoModel = quhuoModel;
    [self.tableView reloadData];
}

//接收配置常用收货人列表页面给的代理请求
- (void)selectedConfigCShouhuoTVC:(ConfigCShouhuoTVC *)hvc didInputReturnShouhuo:(ShouhuoModel *)shouhuo
{
    NSLog(@"allha------%@", self.allShouhuo);
    [self.allShouhuo addObject:shouhuo];
    [self.tableView reloadData];
}

//接收添加货物页面给的代理请求
- (void)addGoodsVC:(SelectGoodsVC *)addVc saveReturnGoods:(BigAndSmallGoodsModel *)goods {
    NSLog(@"addGoodsVC-----------------");
    [self.goods addObject:goods];
    [self.tableView reloadData];
}
//===========================  接收各个页面给的代理请求 end ========================================


//详细设置各单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断在哪个section，设置不同cellid
    NSString *cellid;//cellid在前文注册过
    if (indexPath.section==0) {
        cellid = @"makeorder_top";
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeoredershouhuo_main";
            
        }
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeoredergoods_main";
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeoredercar_main";
        }
    }
    if (indexPath.section==4) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeorederquhuo_main";
        }
    }
    
    //收货联系人
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(indexPath.section==1 && indexPath.row==0){//1.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
        [cell.textLabel setText:@"收货人"];
        [cell.detailTextLabel setText:@"请选择收货人"];
    }else if(indexPath.section==1 && indexPath.row > 0) {//收货联系人
        cell = (MakeOrderShouhuoCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        MakeOrderShouhuoCell *mycell=(MakeOrderShouhuoCell *)cell;
        mycell.shouhuo = self.allShouhuo[indexPath.row - 1];// 将收货联系人模型传递给Cell，cell内部自己配置自己封装
    }

    //货物选择
    if (indexPath.section==2 && indexPath.row==0){//2.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"货物"];
        [cell.detailTextLabel setText:@"请选择货物类型"];
        
    }else if(indexPath.section==2 && indexPath.row > 0) {//货物选择
        cell = (MakeOrderGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {//这行好像没有用了
            cell = [[MakeOrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        MakeOrderGoodsCell *myCell = (MakeOrderGoodsCell *)cell;
        myCell.goods = _goods[indexPath.row - 1]; // 将商品模型传递给Cell，cell内部自己配置 自己封装
    }
    
    //车辆
    if (indexPath.section==3 && indexPath.row==0){//3.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"车辆"];
        [cell.detailTextLabel setText:@"请选择车辆"];
    }else if(indexPath.section==3 && indexPath.row ==1){
        cell = (MakeOrderCarCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        MakeOrderCarCell *mycell = (MakeOrderCarCell *)cell;
        mycell.carModel=self.carModel;
        //mycell.carBox.text = self.carModel.carCategory;
    }
    
    //取货人
    if (indexPath.section==4 && indexPath.row==0){//4.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"取货人"];
        [cell.detailTextLabel setText:@"请选择取货人"];
    }else if(indexPath.section==4 && indexPath.row ==1){
        cell = (MakeOrderQuhuoCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        MakeOrderQuhuoCell *mycell = (MakeOrderQuhuoCell *)cell;
        mycell.quhuoModel=self.quhuoModel;// 将取货模型传递给Cell，cell内部自己配置 自己封装
        //NSLog(@"-------------------%@", self.quhuoModel.quhuoName);
        //mycell.quhuoName.text = self.quhuoModel.quhuoName;
        //mycell.quhuoTelephone.text = self.quhuoModel.quhuoTelephone;
        //mycell.quhuoAddress.text = self.quhuoModel.quhuoAddress;

        
    }
    return  cell;
}



// 表格选中了某一行，有箭头的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.section==1) {//收货联系人，有箭头的
        if (indexPath.row==0) {

            ConfigCShouhuoTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDConfigCShouhuoTVC"];
            tvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
    if (indexPath.section==2) {//货物，有箭头的
        if (indexPath.row==0) {
            SelectGoodsVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDSelectGoodsVC"];
            tvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
    if (indexPath.section==3) {//车辆，有箭头的
        if (indexPath.row==0) {
            SelectCarVC *cvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDSelectCarVC"];
            cvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:cvc animated:YES];
        }
    }

    if (indexPath.section==4) {//取货联系人，有箭头的
        if (indexPath.row==0) {
            ConfigCQuhuoTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDConfigCQuhuoTVC"];
            tvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:tvc animated:YES];
            
            
        }
    }

}

//设置编辑模式方式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // 做判断
    if ( indexPath.section == 1 && indexPath.row > 0) return YES;//收货联系人可以删除
    if ( indexPath.section == 2 && indexPath.row > 0) return YES;//货物可以删除
    return NO;
}

// 设置相应编辑模式下的对应操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 判断在收获人单元格内，且编辑样式为删除时
    if (editingStyle  == UITableViewCellEditingStyleDelete){
        if (indexPath.section == 1 && indexPath.row > 0) {
            // 删除收货人，刷新表格
            [self.allShouhuo removeObject:self.allShouhuo[indexPath.row - 1]];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        if (indexPath.section == 2 && indexPath.row > 0) {
            // 删除货物，刷新表格
            [self.goods removeObject:self.goods[indexPath.row - 1]];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

@end
