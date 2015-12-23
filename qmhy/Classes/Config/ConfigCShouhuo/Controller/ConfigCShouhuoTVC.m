//
//  ConfigCShouhuoTVC.m
//  qmhy
//  配置常用收货联系人
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCShouhuoTVC.h"
#import "ConfigCShouhuoTableViewCell.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"
#import "MJExtension.h"
#import "MJRefreshFooter.h"
#import "MJRefresh.h"
#import "QConfig.h"
#import "JSONModelConfigCShouhuo.h"
#import "MBProgressHUD+HM.h"
#import "EditConfigCShouhuoViewController.h"
#import "AddConfigCShouhuoViewController.h"

@interface ConfigCShouhuoTVC () <ConfigCShouhuoTableViewCellDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) JSONModelConfigCShouhuo *jsonModelConfigCShouhuo;

@end
    
@implementation ConfigCShouhuoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏返回按钮为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"%@",self.zhuangtaiye);
    [self loadNewData];
}

- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didEditJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickBianJiLikeBtn:(UIButton *)likeBtn {
    EditConfigCShouhuoViewController *editConfigCShouhuoViewController = [[EditConfigCShouhuoViewController alloc] init];
    editConfigCShouhuoViewController.jsonModelConfigCShouhuo = model;
    [self.navigationController pushViewController:editConfigCShouhuoViewController animated:YES];
    
}

- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didRemoveJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickShanChuLikeBtn:(UIButton *)likeBtn {
    self.jsonModelConfigCShouhuo = model;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要删除吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)loadNewData {
    NSString *methodName = @"gettabcommonconsigneeinfo";
    NSString *params = @"&proName=%@_%d";
    QConfig *config = [[QConfig alloc] init];
    NSString *uid = config.uid;
    int isOnly = 0;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, isOnly] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        _infoArray = [dic objectForKey:@"rs"];
        _dataArray = [JSONModelConfigCShouhuo objectArrayWithKeyValuesArray:_infoArray];
        [self.tableView reloadData];
    } fail:^{
        
    }];
}

- (void)removeConfigCShouhuo:(JSONModelConfigCShouhuo *)model  {
    [MBProgressHUD showMessage:@"正在删除中..." toView:self.view];
    NSString *methodName = @"updatetabcommonconsigneeinfo";
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
        [self removeConfigCShouhuo:self.jsonModelConfigCShouhuo];
    } else {
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ConfigCShouhuoTableViewCell";
    ConfigCShouhuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ConfigCShouhuoTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell config:_dataArray[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate selectedConfigCShouhuoTVC:self didInputReturnJSONModelConfigCShouhuo:self.dataArray[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[AddConfigCShouhuoViewController class]]) {
        AddConfigCShouhuoViewController *updateVC = destVC;
        updateVC.zhuangtaiye = self.zhuangtaiye;
    }
}

@end
