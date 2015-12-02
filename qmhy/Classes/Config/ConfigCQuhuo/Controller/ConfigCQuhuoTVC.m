//
//  ConfigCQuhuoTVC.m
//  qmhy
//  配置常用取货信息 列表界面
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCQuhuoTVC.h"

#import "QuhuoModel.h"
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
@interface ConfigCQuhuoTVC () <ConfigCFahuoTableViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *infoArray;//第一次数据
@property (strong, nonatomic) NSMutableArray *dataArray; // 数据数组

@property (nonatomic, strong) JSONModelConfigFahuo *jsonModelConfigFahuo;



@property (strong, nonatomic) NSMutableArray *quhuoModels; // 存对象的数组对象 给单元格用
@property (strong, nonatomic) NSMutableArray *dataS; //  存字典的数组 PLIST


@end

@implementation ConfigCQuhuoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadNewData];
}

//初始化
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadNewData];
//    //获取绝对路径的
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    //你要操作的路径
//    NSString *path=[paths    objectAtIndex:0];
//    //拼接路径 并创建plist文件
//    NSString *filename=[path stringByAppendingPathComponent:@"quhuoModel.plist"];   //获取路径
//    NSLog(@"%@",filename);
//    // 从plist文件中读取数据
//    self.dataS = [NSMutableArray arrayWithContentsOfFile:filename];
//    // 将字典转化为对象存入到数组中
//    self.quhuoModels = [[QuhuoModel objectArrayWithKeyValuesArray:self.dataS] mutableCopy];
}

- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didMoRenJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickMoRenLikeBtn:(UIButton *)likeBtn {
    NSLog(@"updatetabcommonpickupinfo");
    [MBProgressHUD showMessage:@"正在删除中..." toView:self.view];
    NSString *methodName = @"updateTabCommonPickupInfo";
    NSString *params = @"&proName=%d_%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%d_%d";
    int x_id = [model.x_id intValue];
    NSLog(@"%d", x_id);
    int uid = [model.uid intValue];
    NSString *contant = model.contact;
    NSString *tel = model.tel;
    NSString *province = model.Province;
    NSString *city = model.city;
    NSString *area = model.area;
    NSString *addressCode = model.addressCode;
    NSString *Address = model.Address;
    NSString *status = model.status;
    NSString *createby = model.createby;
    int isOnly = 0;
    int setType = 0;
    
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, x_id,uid,contant,tel,province,city,area,addressCode,Address,status,createby,isOnly,setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"设置默认成功！"];
            [self loadNewData];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"设置默认失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"设置默认失败！"];
    }];

}

- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didEditJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickBianJiLikeBtn:(UIButton *)likeBtn {
    ECCFHViewController *editConfigCFahuoViewController = [[ECCFHViewController alloc] init];
    editConfigCFahuoViewController.jsonModelConfigFahuo = model;
    [self.navigationController pushViewController:editConfigCFahuoViewController animated:YES];
}

- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didRemoveJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickShanChuLikeBtn:(UIButton *)likeBtn {
    self.jsonModelConfigFahuo = model;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


- (void)loadNewData {
    // 请求参数
    NSString *methodName = @"getTabCommonPickupInfo";
    NSString *params = @"&proName=%@_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int isOnly = 0;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, isOnly] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelConfigFahuo objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        // 刷新数据
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

// 删除方法
- (void)removeConfigCFahuo:(JSONModelConfigFahuo *)model  {
    [MBProgressHUD showMessage:@"正在删除中..." toView:self.view];
    NSString *methodName = @"updateTabCommonPickupInfo";
    NSString *params = @"&proName=%d_%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%d_%d";
    int x_id = [model.x_id intValue];
    NSLog(@"%d", x_id);
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
//    int uid = [model.uid intValue];
    NSString *contant = model.contact;
    NSString *tel = model.tel;
    NSString *province = model.Province;
    NSString *city = model.city;
    NSString *area = model.area;
    NSString *addressCode = model.addressCode;
    NSString *Address = model.Address;
    NSString *status = model.status;
    NSString *createby = model.createby;
    int isOnly = 1;
    int setType = -1;
    
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, x_id,uid,contant,tel,province,city,area,addressCode,Address,status,createby,isOnly,setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"删除成功！"];
            [self loadNewData];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"删除失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"删除失败！"];
    }];
}


//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self removeConfigCFahuo:self.jsonModelConfigFahuo];
        NSLog(@"确定");
    } else {
        NSLog(@"取消");
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ConfigCFahuoTableViewCell";
    ConfigCFahuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCFahuoTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}



//行高度 标准高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
























// 初始化
-(NSMutableArray *)dataS
{
    if (!_dataS) {
        _dataS =[NSMutableArray array];
    }
    return _dataS;
}
// 初始化
- (NSMutableArray *)quhuoModels
{
    if (!_quhuoModels) {
        _quhuoModels =[NSMutableArray array];
    }
    return _quhuoModels;
}


// 视图将要显示的时候会调用此方法
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    [self.tableView reloadData];
//    self.navigationController.toolbarHidden = YES;//隐藏下面toolbar
//}


// 选中行事件处理函数 返回上级界面 选中之后返回MakeOrderTVC中的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.delegate selectedConfigCQuhuoTVC:self didInputReturnQuhuoModel:self.quhuoModels[indexPath.row]];//调用代理 给最开始的下单第一个页面 列表页面
    [self.navigationController popViewControllerAnimated:YES];//关闭
}


// 删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    //删除数组
//    [self.dataS removeObjectAtIndex:indexPath.row];
//    [self.quhuoModels removeObjectAtIndex:indexPath.row];
//    //取plist
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *path=[paths objectAtIndex:0];
//    NSString *filename=[path stringByAppendingPathComponent:@"quhuoModel.plist"];
//    //将删除完的数组写入plist
//    [self.dataS writeToFile:filename atomically:YES];
//    //重新装载
//    [self.tableView reloadData];
    
}




@end
