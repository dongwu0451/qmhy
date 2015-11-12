//
//  AddGoodsVC.h
//  qmhy
//  添加货物名称
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigAndSmallGoodsModel.h"


@class AddGoodsVC;

//定义委托
@protocol AddGoodsVCDelegate <NSObject>
- (void)addGoodsVC:(AddGoodsVC *)addVc endEditingReturnGoods:(BigAndSmallGoodsModel *)goodsModel;
@end


@interface AddGoodsVC : UIViewController
//声明委托实现
@property (weak, nonatomic) id<AddGoodsVCDelegate> delegate;
@end
