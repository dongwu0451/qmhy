//
//  MyEvaluationViewController.m
//  qmhy
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "DXStarRatingView.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "AFNetworkTool.h"
#import "UniformResourceLocator.h"
#import "JSONModelMyEvaluation.h"
#import "QConfig.h"
#import "MBProgressHUD+HM.h"


@interface MyEvaluationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *logisticsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingTHRYView;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingSHSSView;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingFWTDView;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingWLFHSDView;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingWLFKSDView;
@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingWLRYTDView;
@property (weak, nonatomic) IBOutlet UITextView *pingjiaTextView;

@property (nonatomic, copy) NSString *starRatingTHRYValue;
@property (nonatomic, copy) NSString *starRatingSHSSValue;
@property (nonatomic, copy) NSString *starRatingFWTDValue;
@property (nonatomic, copy) NSString *starRatingWLFHSDValue;
@property (nonatomic, copy) NSString *starRatingWLFKSDValue;
@property (nonatomic, copy) NSString *starRatingWLRYTDValue;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.starRatingTHRYValue = @"5";
    self.starRatingSHSSValue = @"5";
    self.starRatingFWTDValue = @"5";
    self.starRatingWLFHSDValue = @"5";
    self.starRatingWLFKSDValue = @"5";
    self.starRatingWLRYTDValue = @"5";
    
    [self.starRatingTHRYView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingTHRYValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingTHRYValue);
    }];
    
    [self.starRatingSHSSView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingSHSSValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingSHSSValue);
    }];
    
    [self.starRatingFWTDView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingFWTDValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingSHSSValue);
    }];
    
    [self.starRatingWLFHSDView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingWLFHSDValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingWLFHSDValue);
    }];
    
    [self.starRatingWLFKSDView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingWLFKSDValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingWLFKSDValue);
    }];
    
    [self.starRatingWLRYTDView setStars:5 callbackBlock:^(NSNumber *newRating) {
        self.starRatingWLRYTDValue = [newRating stringValue];
        NSLog(@"+++++%@", self.starRatingWLRYTDValue);
    }];
    
    self.consigneeNameLabel.text = self.consigneeName;
    self.consigneePhoneLabel.text = self.consigneePhone;
    if (self.pickupaddress.length == 0 || self.pickupaddress == nil || [self.pickupaddress  isEqual: @""]) {
        self.pickupaddressLabel.text = @"无";
    } else {
        NSArray *arr = [self.pickupaddress componentsSeparatedByString:@"-"];
       
        if (arr.count >= 3 ) { //
            self.pickupaddressLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.pickupaddressLabel.text = @"无";
        }
    }
    
    if (self.city.length == 0 || self.city == nil || [self.city  isEqual: @""]) {
        self.cityLabel.text = @"无";
    } else {
        NSArray *arr = [self.city componentsSeparatedByString:@"-"];
        
        if (arr.count >= 3 ) { //
            self.cityLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.cityLabel.text = @"无";
        }
    }
    self.logisticsnameLabel.text = self.logisticsname;
    self.numLabel.text = self.num;
    self.goodsnameLabel.text = self.goodsname;
    
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)submitEvaluationBtnClick:(UIButton *)sender {
    NSString *methodName = @"settabcomment";
    NSString *params = @"&proName=%d_%@_%@_%d_%d_%d_%d_%@_%d_%d_%d_%d_%@";
    QConfig *config = [[QConfig alloc] init];
    int uid = [config.uid intValue];
    NSString *code = self.code;
    NSString *carid = self.thsjid;
    int car1 = [self.starRatingTHRYValue intValue];
    int car2 = [self.starRatingSHSSValue intValue];
    int car3 = [self.starRatingFWTDValue intValue];
    int car4 = 5;
    NSString *logisticsid = self.logisticsid;
    int logistics1 = [self.starRatingWLFHSDValue intValue];
    int logistics2 = [self.starRatingWLFKSDValue intValue];
    int logistics3 = [self.starRatingWLRYTDValue intValue];
    int logistics4 = 5;
    NSString *remark = self.pingjiaTextView.text;
    NSString *URL = [[NSString stringWithFormat:[UniformResourceLocatorURL stringByAppendingString:params], methodName, uid, code, carid, car1, car2, car3, car4, logisticsid, logistics1, logistics2, logistics3, logistics4, remark] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", URL);
    // 发送请求
    [AFNetworkTool postJSONWithUrl:URL parameters:nil success:^(id responseObject) {
        NSError *error = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
         NSArray *infoArray = [dic objectForKey:@"rs"];
        NSString *success = infoArray[0][@"result"];
        if ([success isEqualToString:@"ok"]) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"评论成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"评论失败！"];
        }

        NSLog(@"%@", infoArray);
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"评论失败！"];
    }];
}

@end
