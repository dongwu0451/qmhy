//
//  MakeOrderJSDZViewController.m
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderJSDZViewController.h"

@interface MakeOrderJSDZViewController ()
@property (weak, nonatomic) IBOutlet UIButton *staticBtn;

@end

@implementation MakeOrderJSDZViewController

- (IBAction)staticBtnClick:(UIButton *)sender {
    NSLog(@"呵呵");
}
- (IBAction)bukaitongBtnClick:(UIButton *)sender {
    NSLog(@"不开通");
}
- (IBAction)kaitongBtnClick:(UIButton *)sender {
    NSLog(@"开通");
}


@end
