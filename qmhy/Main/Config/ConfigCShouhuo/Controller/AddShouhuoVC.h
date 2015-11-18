//
//  AddShouhuoVC.h
//  qmhy
//  添加常用收获信息
//  Created by lingsbb on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouhuoModel.h"

@class AddShouhuoVC;

//定义代理
@protocol AddShouhuoVCDelegate <NSObject>
- (void)addShouhuoVC:(AddShouhuoVC *)hvc didInputReturnShouhuo:(ShouhuoModel *)shouhuo;
@end


@interface AddShouhuoVC : UIViewController
//声明代理
@property (strong, nonatomic) id<AddShouhuoVCDelegate> delegate;
@end
