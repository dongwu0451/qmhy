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


@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.starRatingTHRYView setStars:4 callbackBlock:^(NSNumber *newRating) {
        NSLog(@"didChangeRating: %@",newRating);
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


//- (void)didChangeRating:(NSNumber*)newRating
//{
//    NSLog(@"didChangeRating: %@",newRating);
//}

- (IBAction)submitEvaluationBtnClick:(UIButton *)sender {
    
}

@end
