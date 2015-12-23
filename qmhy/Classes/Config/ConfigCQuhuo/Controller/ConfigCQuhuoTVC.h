//
//  ConfigCQuhuoTVC.h
//  qmhy
//  配置常用取货信息 列表界面
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigFahuo.h"

@class ConfigCQuhuoTVC;

@protocol ConfigCQuhuoTVCDelegate <NSObject>

- (void)selectedConfigCQuhuoTVC:(ConfigCQuhuoTVC *)hvc didInputReturnJSONModelConfigFahuo:(JSONModelConfigFahuo *)fahuo;

@end


@interface ConfigCQuhuoTVC : UITableViewController

@property (weak, nonatomic) id<ConfigCQuhuoTVCDelegate> delegate;

@property (copy, nonatomic) NSString *zhuangtaiye;// 1为下单 2为常用配置

@end
