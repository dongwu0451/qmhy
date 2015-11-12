//
//  SelectGoodsVC.h
//  qmhy
//  选择货物页面
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigAndSmallGoodsModel.h"
#import "AddGoodsVC.h"

@class SelectGoodsVC;

//定义委托给下单首页列表页面
@protocol AddSelectGoodsVCDelegate <NSObject>
- (void)addGoodsVC:(SelectGoodsVC *)addVc saveReturnGoods:(BigAndSmallGoodsModel *)goods;
@end

@interface SelectGoodsVC : UIViewController
//声明委托实现
@property (weak, nonatomic) id<AddSelectGoodsVCDelegate> delegate;
@end
