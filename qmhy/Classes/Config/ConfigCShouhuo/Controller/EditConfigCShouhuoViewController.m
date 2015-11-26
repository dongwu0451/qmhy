//
//  EditConfigCShouhuoViewController.m
//  qmhy
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "EditConfigCShouhuoViewController.h"
#import "AFNetworkTool.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "UniformResourceLocator.h"
#import "ConfigShouHuoAddressPickerViewController.h"

@interface EditConfigCShouhuoViewController () <ConfigShouHuoAddressPickerViewControllerDelegate>

@property (nonatomic, strong) ConfigShouHuoAddressPickerViewController *pickerVC;

@property (weak, nonatomic) IBOutlet UITextField *shouhuorenTextField;
@property (weak, nonatomic) IBOutlet UITextField *shoujihaomaTextField;
@property (weak, nonatomic) IBOutlet UITextView *suozaidiquTextView;
@property (weak, nonatomic) IBOutlet UITextView *xiangxidizhiTextView;

@property (nonatomic, copy) NSString *province; // 省
@property (nonatomic, copy) NSString *city; // 市
@property (nonatomic, copy) NSString *area; // 区
@property (nonatomic, copy) NSString *addressCode; // 经纬度


@end

@implementation EditConfigCShouhuoViewController

- (ConfigShouHuoAddressPickerViewController *)pickerVC {
    if (!_pickerVC) {
        self.pickerVC = [[ConfigShouHuoAddressPickerViewController alloc] init];
        self.pickerVC.view.frame = CGRectMake(0, 80, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height * 0.7);
        self.pickerVC.delegate = self;
    }
    return _pickerVC;
    
}


- (void)viewDidLoad {
    self.shouhuorenTextField.text = self.jsonModelConfigCShouhuo.contact;
    self.shoujihaomaTextField.text = self.jsonModelConfigCShouhuo.tel;
    self.suozaidiquTextView.text = [NSString stringWithFormat: @"%@%@%@", self.jsonModelConfigCShouhuo.Province, self.jsonModelConfigCShouhuo.city, self.jsonModelConfigCShouhuo.area];
    self.xiangxidizhiTextView.text = self.jsonModelConfigCShouhuo.Address;
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUIPickerView)];
    [tapGesturRecognizer setNumberOfTapsRequired:1];
    [self.suozaidiquTextView addGestureRecognizer:tapGesturRecognizer];
    
}

// 点击显示UIPickerView
- (void)showUIPickerView {
    [self.view addSubview:self.pickerVC.view];
}

// 把传回来的值显示到页面上
- (void)sureBtn:(NSString *)str andProvinceStr:(NSString *)provinceStr andCityStr:(NSString *)cityStr andDistrictStr:(NSString *)districtStr andAddressCode:(NSString *)addressCode {
    self.suozaidiquTextView.text = str;
    self.province = provinceStr;
    self.city = cityStr;
    self.area = districtStr;
    self.addressCode = addressCode;
}


- (IBAction)updateShouhuo:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在修改中..." toView:self.view];
    NSString *methodName = @"updatetabcommonconsigneeinfo";
    NSString *params = @"&proName=%d_%d_%@_%@_%@_%@_%@_%@_%@_%@_%@_%d_%d";
    int x_id = [self.jsonModelConfigCShouhuo.x_id intValue];
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *contant = self.shouhuorenTextField.text;
    NSString *tel = self.shoujihaomaTextField.text;
    NSString *province = self.province;
    NSString *city = self.city;
    NSString *area = self.area;
    NSString *addressCode = self.addressCode;
    NSString *Address = self.xiangxidizhiTextView.text;
    NSString *status = self.jsonModelConfigCShouhuo.status;
    NSString *createby = self.jsonModelConfigCShouhuo.createby;
    int isOnly = 1;
    int setType = 0;
    
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName,x_id,uid,contant,tel,province,city,area,addressCode,Address,status,createby,isOnly,setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"修改成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"修改失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"修改失败！"];
    }];

}

@end
