//
//  RegisterTVC.m
//  qmhy
//  注册视图控制器
//  Created by lingsbb on 15-8-23.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "RegisterTVC.h"
#import "LoginVC.h"
#import "MBProgressHUD+HM.h"
#import "AFNetworkTool.h"//httppost类
#import "MJExtension.h"//JSON与模型转换类
#import "AFNetworking.h"
#import "UniformResourceLocator.h"

@interface RegisterTVC ()

{
    NSTimer* _timer2; // 验证码显示时间
}

@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *recommendedCode;
@property (weak, nonatomic) IBOutlet UIButton *SMSVerificationCodeBtn;
@property (nonatomic, copy) NSString *randomNumber; // 随机生成的验证码

@end

static int count = 0;

@implementation RegisterTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

//单击注册按钮
- (IBAction)clickReg:(id)sender {
    
    if (self.tel.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.verificationCode.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    if (![self.verificationCode.text isEqualToString:self.randomNumber]) { // 判断输入的是不是正确的验证码如果不是return
        NSLog(@"%@======", self.randomNumber);
        [MBProgressHUD showError:@"请输入正确验证码"];
        return;
    }
    if (self.password.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    if (self.recommendedCode.text.length > 0) {
        BOOL isMatch = [self isValidateRecommendedCode:self.recommendedCode.text];
        if (isMatch == 0) { // 如果不正确
            [MBProgressHUD showError:@"请输入正确推荐码"];
            return;
        }
    }
    
    [MBProgressHUD showMessage:@"正在注册中..." toView:self.view];
    NSString *methodName = @"addtelreg";
    NSString *params = @"&proName=%@_%@_%@_%@";
    NSString *memid = self.tel.text;
    NSString *password = self.password.text;
    NSString *flag = @WLLIUGONGSI;
    NSString *recommendedCode = self.recommendedCode.text;
    if (recommendedCode.length == 0) {
        recommendedCode = @"";
    }
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, memid, password, flag, recommendedCode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // 判断字符串是不是空
        //        NSLog(@"login:%@", responseStr);
        BOOL b = [AppDelegate isBlankString:responseStr];
        NSLog(@"login:%@", @"isBlankString");
        if (b){
            [MBProgressHUD hideHUDForView:self.view];
            return;
        }
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        NSArray *infoArray = [dic objectForKey:@"rs"];
        NSLog(@"infoArray ))))))   %@", infoArray);
        NSString *success = infoArray[0][@"result"];
        NSLog(@"success131312313123123  %@", success);
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"注册成功！"];
            [self dismissViewControllerAnimated:YES completion:nil];//关闭自己
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"注册失败！"];
            [self dismissViewControllerAnimated:YES completion:nil];//关闭自己
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"注册失败！"];
        [self dismissViewControllerAnimated:YES completion:nil];//关闭自己
    }];
}


// 点击获取验证码按钮
- (IBAction)SMSVerificationCodeBtn:(UIButton *)sender {
    BOOL isMatch = [self isValidateMobile:self.tel.text];
    if (isMatch == 0) {
        [MBProgressHUD showError:@"请输入正确的手机号格式"];
        return;
    } else if (isMatch == 1) {
        [MBProgressHUD showMessage:@"正在发送验证码..." toView:self.view];
        
        NSString *strRandom = [self randomNumberSix];
        NSString *tel = self.tel.text;
        NSString *soapMessage =
        [NSString stringWithFormat:
         @"<?xml version=\"1.0\" encoding=\"utf-8\"?> \n"
         "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
         "<soap12:Body>"
         "<regTelmess xmlns=\"http://tempuri.org/\">"
         "<strTel>%@</strTel>"
         "<strCode>%@</strCode>"
         "</regTelmess>"
         "</soap12:Body>"
         "</soap12:Envelope>",tel,strRandom];
        NSString *soapLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
            return soapMessage;
        }];
        [manager POST:@"http://139.129.26.164:8090/tlandroidService.asmx" parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"operation++++++++++++++++++++%@", operation);
            NSLog(@"response+++++++++++++++++++++%@", response);
#warning 这不知道这么判断行不行  这个怎么解析出xml啊？ 我都醉了。 据说afn有解析xml的 不会用 这个有时间最好改了 判断这么写不好
            // iOS 判断字符串中含有某个字符串 rangeOfString
            if([response rangeOfString:@"<regTelmessResult>OK</regTelmessResult>"].location !=NSNotFound) { //_roaldSearchText
                self.randomNumber = strRandom; // 如果发送成功就给判断随机数的变量复制
                [_timer2 invalidate];
                count = 0;
                NSTimer* timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
                _timer2 = timer2;
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"验证码发送成功"];
                NSLog(@"yes");
            } else if ([response rangeOfString:@"<regTelmessResult>No</regTelmessResult>"].location !=NSNotFound) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"您的手机号已经注册过"];
            } else {
                self.randomNumber = @"";
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"验证码发送失败"];
                NSLog(@"no");
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.randomNumber = @"";
            NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"验证码发送失败"];
            NSLog(@"operation---------------------%@", operation);
            NSLog(@"error-------------------------%@", error);
        }];}
}

// 随机生成6位验证码
- (NSString *)randomNumberSix {
    NSString *strRandom = @"";
    for(int i = 0; i < 6; i++) {
        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    self.randomNumber = strRandom;
    NSLog(@"随机数: %@", strRandom);
    NSLog(@"sdfafadf %@",self.randomNumber);
    return strRandom;
}


// 更新倒计时时间方法
- (void)updateTime {
    count++;
    if (count >= 60) {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    NSString *str = [NSString stringWithFormat:@"%@%i%@",NSLocalizedString(@"", nil),60-count,NSLocalizedString(@"", nil)];
    [self.SMSVerificationCodeBtn setTitle:str forState:UIControlStateNormal];
    self.SMSVerificationCodeBtn.userInteractionEnabled = NO;
    
    if (count == 59) {
        self.SMSVerificationCodeBtn.userInteractionEnabled = YES;
        [self.SMSVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }
}

/* 手机号码验证 MODIFIED BY HELENSONG */
- (BOOL) isValidateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,5-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

/* 推荐码验证 */
- (BOOL) isValidateRecommendedCode:(NSString *)recommendedCode {
    NSString *recommendedCodeRegex = @"^[a-iz]{6}$";
    NSPredicate *recommendedCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",recommendedCodeRegex];
    return [recommendedCodeTest evaluateWithObject:recommendedCode];
}

// 返回登录页
- (IBAction)returnToTheLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击空白处关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
