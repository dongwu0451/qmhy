//
//  EditGoodsVC.m
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "EditGoodsVC.h"
#import "MBProgressHUD+HM.h"
#import "UniformResourceLocator.h"
#import "AFNetworkTool.h"

@interface EditGoodsVC ()
@property (weak, nonatomic) IBOutlet UITextField *huowuTextField;

@end

@implementation EditGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.huowuTextField.text = self.jsonModelConfigGGoods.name;
}

- (IBAction)editHuowuBtnClick:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在修改中..." toView:self.view];
    NSString *methodName = @"settabCommonGoods";
    NSString *params = @"&proName=%d_%@_%d_%d";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
//    int uid = [self.jsonModelConfigGGoods.uid intValue];
    NSString *name = self.huowuTextField.text;
    int code = [self.jsonModelConfigGGoods.code intValue];
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


//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
