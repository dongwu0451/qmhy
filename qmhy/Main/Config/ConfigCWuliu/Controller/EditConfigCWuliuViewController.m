//
//  EditConfigCWuliuViewController.m
//  qmhy
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "EditConfigCWuliuViewController.h"
#import "MBProgressHUD+HM.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"


@interface EditConfigCWuliuViewController ()
@property (weak, nonatomic) IBOutlet UITextField *wuliuTextField;

@end

@implementation EditConfigCWuliuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wuliuTextField.text = self.jsonModelConfigCWuLiu.name;
}

- (IBAction)editWuliuBtnClick:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在修改中..." toView:self.view];
    NSString *methodName = @"settabCommonLogistics";
    NSString *params = @"&proName=%d_%@_%d_%d";
    int uid = [self.jsonModelConfigCWuLiu.uid intValue];
    NSString *name = self.wuliuTextField.text;
    int code = [self.jsonModelConfigCWuLiu.code intValue];
    int setType = 0; // 0 为更新

    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, name, code, setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
