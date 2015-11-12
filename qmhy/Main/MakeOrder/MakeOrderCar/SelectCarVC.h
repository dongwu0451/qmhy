//
//  ConfigCarVC.h
//  qmhy
//  选择车辆界面
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@class SelectCarVC;
//定义代理协议 下单主页面使用该协议接收代理请求
@protocol ConfigCarVCDelegate <NSObject>
- (void)ConfigCarVC:(SelectCarVC *)configVc didPassCar:(CarModel *)carModel;
@end


@interface SelectCarVC : UIViewController
//定义代理 下单主页面使用该协议接收代理请求
@property (weak, nonatomic) id<ConfigCarVCDelegate> delegate;

@end
