//
//  ConfigCPasswordVC.m
//  qmhy
//
//  Created by mac on 15/11/23.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCPasswordVC.h"
#import "AFNetworkTool.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "UniformResourceLocator.h"

@interface ConfigCPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *xinPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *querenxinPasswordTextField;


@end

@implementation ConfigCPasswordVC

- (IBAction)yesBtnClick:(UIButton *)sender {
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *password = config.password;
    NSString *mem = config.mem_id;
    NSString *type = @"consignor";
    if (![password isEqualToString:self.oldPasswordTextField.text]) {
        [MBProgressHUD showError:@"输入的旧密码不正确！"];
        return;
    }
    if (![self.xinPasswordTextField.text isEqualToString:self.querenxinPasswordTextField.text]) {
        [MBProgressHUD showError:@"两次密码输入不一致！"];
        return;
    }
    [MBProgressHUD showMessage:@"正在修改密码中..." toView:self.view];
    NSString *methodName = @"updatepassword";
    NSString *params = @"&proName=%d_%@_%@_%@_%@";
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName,uid,mem,password,type,self.xinPasswordTextField.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            config.password = self.xinPasswordTextField.text; // 把userdefo的改掉
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"修改密码成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"修改密码失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"修改密码失败！"];
    }];

}





@end
