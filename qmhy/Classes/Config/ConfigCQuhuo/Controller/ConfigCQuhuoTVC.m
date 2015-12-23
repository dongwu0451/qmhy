//
//  ConfigCQuhuoTVC.m
//  qmhy
//  配置常用取货信息 列表界面
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCQuhuoTVC.h"


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
#import "AddConfigCFahuoViewController.h"
@interface ConfigCQuhuoTVC () <ConfigCFahuoTableViewCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) JSONModelConfigFahuo *jsonModelConfigFahuo;

@end

@implementation ConfigCQuhuoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadNewData];
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
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];//第一次数据
        _dataArray = [JSONModelConfigFahuo objectArrayWithKeyValuesArray:_infoArray];
        NSLog(@"%@", _dataArray);
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

- (void)removeConfigCFahuo:(JSONModelConfigFahuo *)model  {
    [MBProgressHUD showMessage:@"正在删除中..." toView:self.view];
    NSString *methodName = @"updateTabCommonPickupInfo";
    NSString *params = @"&proName=%d_%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%d_%d";
    int x_id = [model.x_id intValue];
    NSLog(@"%d", x_id);
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate selectedConfigCQuhuoTVC:self didInputReturnJSONModelConfigFahuo:self.dataArray[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[AddConfigCFahuoViewController class]]) {
        AddConfigCFahuoViewController *updateVC = destVC;
        updateVC.zhuangtaiye = self.zhuangtaiye;
    }
}

@end
