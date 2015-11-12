//
//  WidgetsVC.m
//  qmhy
//  登录视图控制器
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

//本demo，默认用户名user00，密码00user，只会输入一次，
//以后只需要验证手势密码，想要再显示登陆窗只能重新安装！

#import "LoginVC.h"
#import "RegisterTVC.h"
#import "JSONModelLogin.h"//登录实体
#import "AFNetworkTool.h"//httppost类
#import "MJExtension.h"//JSON与模型转换类

@interface LoginVC ()

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    //判断显示那个view
    if ([self.whichViewToPresent isEqualToString:@"loginView"]) {
        [self showLoginView];
    }else{ //以后添加
        return ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示登录界面
-(void)showLoginView{
    ////注册按钮点击事件loginview
    self.view=self.loginView;
    //绑定事件
    [self.textField_username addTarget:self action:@selector(resignFirstResponder4textField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.textField_password addTarget:self action:@selector(resignFirstResponder4textField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.loginView addTarget:self action:@selector(resignFirstResponder4LoginView) forControlEvents:UIControlEventTouchDown];
    //隐藏label
    self.label_detail.text=@"";
}

//=======================
//登录按钮点击事件
//=======================
- (IBAction)login:(id)sender {
    NSString *username=self.textField_username.text;
    NSString *password=self.textField_password.text;
    NSString *url=[NSString stringWithFormat:@"%@?methodName=%@&proName=%@_%@_%@", QUrl, @"login",username, password, @"consignor"];
    [AFNetworkTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"login:%@", responseStr);
        BOOL b=[AppDelegate isBlankString:responseStr];
        NSLog(@"login:%@", @"isBlankString");
        if (b){
            NSLog(@"login:%@", @"网络故障，执行失败！");
            self.label_detail.text=@"网络故障，执行失败！";
            //[AppDelegate showAlert:@"网络故障，执行失败！"];
            return;
        }
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSDictionary *nd = [infoArray objectAtIndex:0];
        JSONModelLogin *obj =[JSONModelLogin objectWithKeyValues:nd];
        //NSString *str = [NSString stringWithFormat:@"今天是%@",[nd objectForKey:@"phone1"]];
        NSLog(@"login:%@", obj.uid);
        NSString *uid=obj.uid;
        if ([uid isEqualToString:@"0"]){
            NSLog(@"login:%@", @"账号或密码错误，请重新输入");
            self.label_detail.text=@"账号或密码错误，请重新输入";
            //[AppDelegate showAlert:@"用户名称或者密码错误！"];
            return;
        }
        else if ([uid isEqualToString:@"-1"]){
            NSLog(@"login:%@", @"客服正在审核！");
            self.label_detail.text=@"客服正在审核！";
            //[AppDelegate showAlert:@"客服正在审核！"];
            return;
        }
        else//显示结果
        {
            self.label_detail.text=@"输入正确";
            //NSLog(@"login:%@", @"输入正确");
            QLog(@"login:%@", @"输入正确!");
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key_isLogined"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            QConfig *config = [[QConfig alloc] init];
            config.uid=obj.uid;
            [self.delegate LoginVC:self loginOK:nil];//设置回调  向来源触发事件委托
        }
    } fail:^{
        NSLog(@"失败");
    }];
//    if ([username isEqualToString:@"a"] && [password isEqualToString:@"a"]) {
//        self.label_detail.text=@"输入正确";
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key_isLogined"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [self.delegate LoginVC:self loginOK:nil];//设置回调  向来源触发事件委托
//    }else{
//        self.label_detail.text=@"账号或密码错误，请重新输入";
//    }
}

//隐藏键盘
-(void)resignFirstResponder4textField:(id)sender{
    [sender resignFirstResponder];
}
//隐藏键盘
-(void)resignFirstResponder4LoginView{
    [self.textField_password resignFirstResponder];
    [self.textField_username resignFirstResponder];
}

//注册按钮点击事件 显示注册界面
- (IBAction)showRegister:(id)sender {
    RegisterTVC *vc=[[RegisterTVC alloc]initWithNibName:@"RegisterTVC" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
