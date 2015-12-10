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
#import "QConfig.h"
#import "MakeOrderTotalCell.h"
#import "MakeOrderFahuoCell.h"
#import "MakeOrderBzCell.h"
#import "JSONModelConfigCShouhuo.h"
#import "MakeOrderJSDZViewController.h"
#import "MakeOrderOKViewController.h"

#import "MJExtension.h"
#import "ConfigCFahuoTableViewCell.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "JSONModelConfigFahuo.h"
#import "MBProgressHUD+HM.h"
#import "ECCFHViewController.h"

//===========================  这下面都是以前的import可能会删除 ========================================

#import "ConfigCShouhuoTVC.h"
#import "ConfigCommonTVC.h"
#import "MakeOrderShouhuoCell.h"
#import "SelectGoodsVC.h"
#import "MakeOrderGoodsCell.h"
#import "ConfigCQuhuoTVC.h"


// 要实现二个页面的代理委托
@interface MakeOrderTVC () <ConfigCShouhuoTVCDelegate, AddSelectGoodsVCDelegate, MakeOrderJSDZViewControllerDelegate, UITextFieldDelegate>



@property (strong, nonatomic) JSONModelConfigCShouhuo *shouhuoren; // 收货人


@property (strong, nonatomic) NSMutableArray *goods;//货物类（批量）

@property (copy, nonatomic) NSString *beizhu;
@property (copy, nonatomic) NSString *zongjianshu;
@property (copy, nonatomic) NSString *daishoukuan;
@property (copy, nonatomic) NSString *goodstype;


@property (nonatomic, strong) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) JSONModelConfigFahuo *jsonModelConfigFahuo;

@end

@implementation MakeOrderTVC

// 初始化
- (NSMutableArray *)goods {
    if (!_goods) {
        _goods = [NSMutableArray array];
    }
    return _goods;
}

- (void)addGoodsVC:(SelectGoodsVC *)addVc saveReturnGoods:(BigAndSmallGoodsModel *)goods {
    NSLog(@"addGoodsVC-----------------");
    self.daishoukuan = [NSString stringWithFormat:@"%.2f",[self.daishoukuan floatValue] + [goods.bigCollectionCharges floatValue] + [goods.smailCollectionCharges floatValue]];
    self.zongjianshu = [NSString stringWithFormat:@"%d",[self.zongjianshu intValue] + [goods.bigNumber intValue] + [goods.smailNumber intValue]];
//    NSString *stringFloat = [NSString stringWithFormat:@"%f",intString];
    [self.goods addObject:goods];
    
    [self.tableView reloadData];
}

// 接收配置常用收货人列表页面给的代理请求
- (void)selectedConfigCShouhuoTVC:(ConfigCShouhuoTVC *)hvc didInputReturnJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)shouhuo {
    self.shouhuoren = shouhuo;
    
    [self.tableView reloadData];
}

- (void)makeOrderJSDZViewController:(MakeOrderJSDZViewController *)bvc didInputReturnMessage:(NSString *)msg {
    self.goodstype = msg;
    NSLog(@"%@", self.goodstype);
}

- (IBAction)xiayibuBtn:(UIBarButtonItem *)sender {
 
    if (self.dataArray.count == 0) {
        NSLog(@"1");
        return;
    }
    if (self.shouhuoren.x_id.length == 0) {
        NSLog(@"2");
        return;
    }
    if (self.goods.count == 0) {
        NSLog(@"3");
        return;
    }
    if (self.beizhu.length == 0) {
        NSLog(@"4");
        return;
    }
    NSLog(@"%@",self.beizhu);
    MakeOrderOKViewController *vc = [[MakeOrderOKViewController alloc] init];
    vc.beizhu =  self.beizhu;
    vc.zongjianshu = self.zongjianshu;
    vc.daishoukuan = self.daishoukuan;
    vc.goodstype = self.goodstype;
    vc.shouhuoren = self.shouhuoren;
    vc.goods = self.goods;
    vc.jsonModelConfigFahuo = self.jsonModelConfigFahuo;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)sdgsdg {
    for (int i = 0; i < self.dataArray.count; i++) {
        JSONModelConfigFahuo *a = self.dataArray[i];
        if ([a.orderid isEqualToString:@"0"]) {
            self.jsonModelConfigFahuo = a;
        }
    }
}


- (void)loadNewData {
    [MBProgressHUD showMessage:@"请等待..." toView:self.view];
    // 请求参数
    NSString *methodName = @"getTabCommonPickupInfo";
    NSString *params = @"&proName=%@_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int isOnly = 0;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, isOnly] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelConfigFahuo objectArrayWithKeyValuesArray:_infoArray];
        if (_dataArray.count > 0) {
            [self sdgsdg];
        }
        
//        NSLog(@"%@", _dataArray);
        
//        JSONModelConfigFahuo *a = _dataArray[0];
//        NSLog(@"%@", a.contact);
        [MBProgressHUD hideHUDForView:self.view];
        [self.tableView reloadData];
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
    }];
}


//初始化显示
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
//    [self sdgsdg];
    self.daishoukuan = @"0.00";
    self.zongjianshu = @"0";
    self.goodstype = @"0";
    // 注册统计栏的自定义单元格  改为统计信息
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderTotalCell" bundle:nil] forCellReuseIdentifier:@"makeorder_top"];
    // 注册统计栏的自定义单元格  改为发货人
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderFahuoCell" bundle:nil] forCellReuseIdentifier:@"makeorder_fahuo"];
    // 注册选择收货信息的自定义单元格  改为收货人
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderShouhuoCell" bundle:nil] forCellReuseIdentifier:@"makeoredershouhuo_main"];
    // 注册选择货物信息的自定义单元格  改为货物
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderGoodsCell" bundle:nil] forCellReuseIdentifier:@"makeoredergoods_main"];
    //即时到账不用
    //备注
    [self.tableView registerNib:[UINib nibWithNibName:@"MakeOrderBzCell" bundle:nil] forCellReuseIdentifier:@"makeoreder_bz"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;//统计、收货人（批量）、货物（批量）、车辆、取货人
    //改为 统计信息 发货人 收货人 货物 即时到帐 备注
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) { //第1组 统计 改为 统计信息
        return 1;
    }
    else if (section==1) { //第1组 统计 改为 发货人
        return 1;
    }
    else if(section==2) { //第2组 收货人（批量）  改为 收货人
        
        if (NULL==_shouhuoren)
            return 1;
        else
            return 2;
        
        
    } else if(section==3) { //第3组 货物（批量）  改为 货物
        return _goods.count + 1;
    } else {  //改为 即时到帐和备注
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断在哪个section，设置不同cellid
    NSString *cellid;//cellid在前文注册过
    if (indexPath.section==0) {
        cellid = @"makeorder_top";
    }
    if (indexPath.section==1) {
        cellid = @"makeorder_fahuo";
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeoredershouhuo_main";
            
        }
    }
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            cellid = @"makeoreder_detail";//右箭头单元格
        }
        else {
            cellid = @"makeoredergoods_main";
        }
    }
    
    if (indexPath.section==4) {//即时到账
        cellid = @"makeoreder_detail";//右箭头单元格
    }
    if (indexPath.section==5) {//备注
        cellid = @"makeoreder_bz";//右箭头单元格
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    //统计信息
    if (indexPath.section==0 && indexPath.row==0) {//1.0
        cell = (MakeOrderTotalCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {//这行好像没有用了
            cell = [[MakeOrderTotalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        MakeOrderTotalCell *myCell = (MakeOrderTotalCell *)cell;
        myCell.lbl_allcount.text = self.zongjianshu;
        myCell.lbl_daishoukuan.text = self.daishoukuan;
    }
    
    //备注
    if (indexPath.section==1 && indexPath.row==0) {//1.0 备注
        cell = (MakeOrderFahuoCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {//这行好像没有用了
            cell = [[MakeOrderFahuoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        MakeOrderFahuoCell *myCell = (MakeOrderFahuoCell *)cell;
        
        if (self.dataArray > 0) {
            myCell.fahuorenLabel.text = self.jsonModelConfigFahuo.contact;
            //        NSLog(@"%@",c.phone2);
            myCell.fhrdianhuaLabel.text = self.jsonModelConfigFahuo.tel;
            if (self.jsonModelConfigFahuo.Province.length == 0) {
                self.jsonModelConfigFahuo.Province = @"";
            }
            if (self.jsonModelConfigFahuo.city == 0) {
                self.jsonModelConfigFahuo.city = @"";
            }
            if (self.jsonModelConfigFahuo.area.length == 0) {
                self.jsonModelConfigFahuo.area = @"";
            }
            myCell.fhrdizhiLabel.text = [NSString stringWithFormat:@"%@%@%@", self.jsonModelConfigFahuo.Province, self.jsonModelConfigFahuo.city, self.jsonModelConfigFahuo.area];
            //        myCell.fahuorenLabel.text = c.username;
            //        NSLog(@"%@",c.phone2);
            //        myCell.fhrdianhuaLabel.text = c.phone2;
            //        myCell.fhrdizhiLabel.text = @"";
        } else {
            myCell.fahuorenLabel.text = @"请到常用配置中设置";
        }
        
       
    }
    
    //收货人
    if (indexPath.section==2 && indexPath.row==0) {//2.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_zhanghuyue"];
        [cell.textLabel setText:@"收货人"];
        [cell.detailTextLabel setText:@"请选择收货人"];
    } else if (indexPath.section==2 && indexPath.row > 0) {//收货联系人
        cell = (MakeOrderShouhuoCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        MakeOrderShouhuoCell *mycell=(MakeOrderShouhuoCell *)cell;
        mycell.shouhuo = self.shouhuoren;
    }
    
    //货物选择
    if (indexPath.section==3 && indexPath.row==0) {//3.0
        //cell.imageView.image=[UIImage imageNamed:@"Wea_yuebao"];
        [cell.textLabel setText:@"货物"];
        [cell.detailTextLabel setText:@"请选择货物类型"];
        
    } else if(indexPath.section==3 && indexPath.row > 0) {//货物选择
        cell = (MakeOrderGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {//这行好像没有用了
            cell = [[MakeOrderGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        MakeOrderGoodsCell *myCell = (MakeOrderGoodsCell *)cell;
        myCell.goods = _goods[indexPath.row - 1]; // 将商品模型传递给Cell，cell内部自己配置 自己封装
    }
    
    //即使到账
    if (indexPath.section==4 && indexPath.row==0) {//4.0 即使到账
        //cell.imageView.image=[UIImage imageNamed:@"Wea_wodebaozhang"];
        [cell.textLabel setText:@"即使到账"];
        [cell.detailTextLabel setText:@"未开通代收货款预先支付服务"];
    }
    
    //备注
    if (indexPath.section==5 && indexPath.row==0) {//5.0 备注
        cell = (MakeOrderBzCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {//这行好像没有用了
            cell = [[MakeOrderBzCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        MakeOrderBzCell *myCell = (MakeOrderBzCell *)cell;
        [myCell.beizhuTextField addTarget:self action:@selector(textFieldDidChangeAction:) forControlEvents:UIControlEventEditingChanged];
        myCell.beizhuTextField.text = self.beizhu;
    }
    
    return  cell;
}

- (void)textFieldDidChangeAction:(UITextField *)textField {
    NSLog(@"%@", textField);
    self.beizhu = textField.text;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 70;
    }
    else if (indexPath.section==1) {
        return 70;
    }else {
        if (indexPath.row==0) {
            return 40;
        } else {
            return 70;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.section==2) {//收货联系人，有箭头的
        if (indexPath.row==0) {
            ConfigCShouhuoTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDConfigCShouhuoTVC"];
            tvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
    if (indexPath.section==3) {//货物，有箭头的
        if (indexPath.row==0) {
            SelectGoodsVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDSelectGoodsVC"];
            tvc.delegate = self;//本类处理代理
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
    if (indexPath.section == 4) {
        MakeOrderJSDZViewController *vc = [[MakeOrderJSDZViewController alloc] init];
        vc.daishoukuan = self.daishoukuan;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

//设置编辑模式方式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // 做判断
    //    if ( indexPath.section == 1 && indexPath.row > 0) return YES;//收货联系人可以删除
    //    if ( indexPath.section == 2 && indexPath.row > 0) return YES;//货物可以删除
    return NO;
}

// 设置相应编辑模式下的对应操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    // 判断在收获人单元格内，且编辑样式为删除时
    //    if (editingStyle  == UITableViewCellEditingStyleDelete){
    //        if (indexPath.section == 1 && indexPath.row > 0) {
    //            // 删除收货人，刷新表格
    //            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //        }
    //        if (indexPath.section == 2 && indexPath.row > 0) {
    //            // 删除货物，刷新表格
    //            [self.goods removeObject:self.goods[indexPath.row - 1]];
    //            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //        }
    //    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
