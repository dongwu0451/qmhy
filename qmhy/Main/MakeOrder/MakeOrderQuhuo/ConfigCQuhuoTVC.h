//
//  ConfigCQuhuoTVC.h
//  qmhy
//  配置常用取货信息 列表界面
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuhuoModel.h"

@class ConfigCQuhuoTVC;


@protocol ConfigCQuhuoTVCDelegate <NSObject>
- (void)selectedConfigCQuhuoTVC:(ConfigCQuhuoTVC *)hvc didInputReturnQuhuoModel:(QuhuoModel *)quhuoModel;
@end


@interface ConfigCQuhuoTVC : UITableViewController
//实现委托代理
@property (weak, nonatomic) id<ConfigCQuhuoTVCDelegate> delegate;

@end
