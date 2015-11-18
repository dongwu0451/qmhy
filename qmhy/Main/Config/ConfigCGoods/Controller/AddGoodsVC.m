//
//  AddGoodsVC.m
//  qmhy
//  添加货物名称
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AddGoodsVC.h"
#import "AFNetworkTool.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"
#import "UniformResourceLocator.h"

@interface AddGoodsVC ()

@property (strong, nonatomic) IBOutlet UITextField *goodsField;
@end

@implementation AddGoodsVC

//保存按钮
- (IBAction)saveGoods:(id)sender {
    if (self.goodsField.text == 0) {
        [MBProgressHUD showError:@"请输入货物名称"];
        return;
    }
    
    NSString *methodName = @"settabCommonGoods";
    NSString *params = @"&proName=%d_%@_%@_%d";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *name = self.goodsField.text;
    NSString *code = @"";
    int setType = 1; // 1为添加
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, name, code, setType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [MBProgressHUD showMessage:@"正在添加中..." toView:self.view];
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"添加成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"添加失败！"];
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"添加失败！"];
    }];

    
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
