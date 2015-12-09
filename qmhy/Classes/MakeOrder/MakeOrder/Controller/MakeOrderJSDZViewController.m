//
//  MakeOrderJSDZViewController.m
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderJSDZViewController.h"
#import "MBProgressHUD+HM.h"
#import "AFNetworkTool.h"//httppost类
#import "MJExtension.h"//JSON与模型转换类
#import "AFNetworking.h"
#import "UniformResourceLocator.h"
#import "QConfig.h"

@interface MakeOrderJSDZViewController ()
@property (weak, nonatomic) IBOutlet UIButton *staticBtn;

@property (copy, nonatomic) NSString *heheda;

@end

@implementation MakeOrderJSDZViewController


- (NSDictionary *)JsonToDict:(NSString *)result {
    if (result == nil) {
        return nil;
    } else {
        NSData *data= [result dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error)
        {
            NSLog(@"%@",error);
        }
        return jsonObject;
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


- (void)viewDidLoad {
    self.heheda = @"a";
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
    QConfig *c = [[QConfig alloc] init];
    NSString *soapMessage =
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?> \n"
     "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
     "<soap12:Body>"
     "<GetUidBalance xmlns=\"http://tempuri.org/\">"
     "<uid>%@</uid>"
     "<ds>%@</ds>"
     "</GetUidBalance>"
     "</soap12:Body>"
     "</soap12:Envelope>",c.uid,self.daishoukuan];
    NSString *soapLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    [manager POST:@"http://139.129.26.164:8090/tlandroidService.asmx" parameters:soapMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"response+++++++++++++++++++++%@", response);
        
        //        NSString *str = @"<GetUidBalanceResult>guanyu</GetUidBalanceResult>";
        NSRange range = [response rangeOfString:@"<GetUidBalanceResult>"];
        NSRange range2 = [response rangeOfString:@"</GetUidBalanceResult>"];
        NSInteger a = range.location;
        NSInteger lengtha = range.length;
        NSInteger b = range2.location;
        NSInteger lengthb = range2.length;
        NSRange rang = {a+lengtha, b-a-lengthb+1};
        NSString *subString = [response substringWithRange:rang];
        NSLog(@"+++++++++++++++++++++++++%@", subString);

        NSDictionary *dic =  [self dictionaryWithJsonString:subString];
        
        NSLog(@"dicdicdicdicdic%@",dic);
        NSString *a12311 = dic[@"result"];
        self.heheda = a12311;
        
        NSString *a111 = dic[@"message"];
        NSLog(@"a111a111a111a111%@", a111);
        //        NSDictionary *dic = [self JsonToDict:response];
        //        NSLog(@"dic%@", dic);
        //
        //        NSLog(@"operation++++++++++++++++++++%@", operation);
        //        NSLog(@"response+++++++++++++++++++++%@", response);
#warning 这不知道这么判断行不行  这个怎么解析出xml啊？ 我都醉了。 据说afn有解析xml的 不会用 这个有时间最好改了 判断这么写不好
        // iOS 判断字符串中含有某个字符串 rangeOfString
        if([response rangeOfString:@"<GetUidBalanceResult>{\"result\":\"1\","].location !=NSNotFound) {
            [self.staticBtn setTitle:@"" forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view];
        } else if ([response rangeOfString:@"<GetUidBalanceResult>{\"result\":\"-99998\","].location !=NSNotFound) {
            [self.staticBtn setTitle:@"提示:用户尚未绑定会员信息" forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view];
        } else if ([response rangeOfString:@"<GetUidBalanceResult>{\"result\":\"-99999\","].location !=NSNotFound) {
            [self.staticBtn setTitle:@"提示:您不是天龙会员,无法使用此功能" forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view];
        } else if ([response rangeOfString:@"<GetUidBalanceResult>{\"result\":\"-1\","].location !=NSNotFound) {
            [self.staticBtn setTitle:@"提示:读取会员额度信息失败" forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view];
        } else if ([response rangeOfString:@"<GetUidBalanceResult>{\"result\":\"0\","].location !=NSNotFound) {
            [self.staticBtn setTitle:a111 forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)[operation responseObject] encoding:NSUTF8StringEncoding];
        [MBProgressHUD hideHUDForView:self.view];
        
        //        NSLog(@"operation---------------------%@", operation);
        //        NSLog(@"error-------------------------%@", error);
    }];
}


- (IBAction)staticBtnClick:(UIButton *)sender {
    NSLog(@"呵呵");
}

- (IBAction)bukaitongBtnClick:(UIButton *)sender {
    [self.delegate makeOrderJSDZViewController:self didInputReturnMessage:@"0"];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)kaitongBtnClick:(UIButton *)sender {
    if (![self.heheda isEqualToString:@"1"]) {
        [MBProgressHUD showError:@"请注意红色信息"];
    } else {
        [self.delegate makeOrderJSDZViewController:self didInputReturnMessage:@"1"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"开通");
}


@end
