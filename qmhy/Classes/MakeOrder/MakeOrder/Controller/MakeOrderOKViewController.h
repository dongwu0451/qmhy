//
//  MakeOrderOKViewController.h
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigCShouhuo.h"
#import "JSONModelConfigFahuo.h"

@interface MakeOrderOKViewController : UIViewController
@property (nonatomic, copy) NSString *beizhu;
@property (copy, nonatomic) NSString *zongjianshu; // 7 件数
@property (copy, nonatomic) NSString *daishoukuan;
@property (copy, nonatomic) NSString *goodstype;
@property (nonatomic, strong) JSONModelConfigCShouhuo *shouhuoren;

@property (strong, nonatomic) NSArray *goods;

@property (nonatomic, strong) JSONModelConfigFahuo *jsonModelConfigFahuo;
@end
