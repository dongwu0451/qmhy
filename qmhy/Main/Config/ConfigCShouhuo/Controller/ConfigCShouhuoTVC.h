//
//  ConfigCShouhuoModelTVC.h
//  qmhy
//  配置常用收货联系人
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouhuoModel.h"


@class ConfigCShouhuoTVC;

//定义代理协议
@protocol ConfigCShouhuoTVCDelegate <NSObject>
- (void)selectedConfigCShouhuoTVC:(ConfigCShouhuoTVC *)hvc didInputReturnShouhuo:(ShouhuoModel *)shouhuo;
@end


@interface ConfigCShouhuoTVC : UITableViewController
//- (IBAction)addShouhuo:(id)sender; 2015/08/29 注释说不要弹出框
//声明代理
@property (weak, nonatomic) id<ConfigCShouhuoTVCDelegate> delegate;
@end
