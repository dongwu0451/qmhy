//
//  ConfigCGoodsTVC.h
//  qmhy
//  配置常用货物列表
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigAndSmallGoodsModel.h"

//定义委托给下单首页列表页面
@class ConfigCGoodsTVC;
@protocol ConfigCGoodsTVCDelegate <NSObject>
- (void)configCGoodsTVC:(ConfigCGoodsTVC *)configVc didChooseGoods:(BigAndSmallGoodsModel *)goods;
@end

@interface ConfigCGoodsTVC : UITableViewController
//声明委托实现
@property (weak, nonatomic) id<ConfigCGoodsTVCDelegate> delegate;
@end
