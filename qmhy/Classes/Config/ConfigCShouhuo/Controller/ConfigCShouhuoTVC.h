//
//  ConfigCShouhuoModelTVC.h
//  qmhy
//  配置常用收货联系人
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSONModelConfigCShouhuo.h"

@class ConfigCShouhuoTVC;

@protocol ConfigCShouhuoTVCDelegate <NSObject>

- (void)selectedConfigCShouhuoTVC:(ConfigCShouhuoTVC *)hvc didInputReturnJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)shouhuo;

@end


@interface ConfigCShouhuoTVC : UITableViewController

@property (weak, nonatomic) id<ConfigCShouhuoTVCDelegate> delegate;

@end
