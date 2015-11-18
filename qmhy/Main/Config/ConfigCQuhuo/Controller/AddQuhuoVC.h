//
//  AddQuhuoVC.h
//  qmhy
//  添加取货联系人
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuhuoModel.h"

@class AddQuhuoVC;

//定义代理
@protocol AddQuhuoVCDelegate <NSObject>
- (void)AddQuhuoVC:(AddQuhuoVC *)hvc didInputReturnQuhuo:(QuhuoModel *)quhuoModel;
@end


@interface AddQuhuoVC : UIViewController
//声明代理
@property (strong, nonatomic) id<AddQuhuoVCDelegate> delegate;
@end
