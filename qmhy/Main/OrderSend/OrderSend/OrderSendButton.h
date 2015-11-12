//
//  OrderSendButton.h
//  qmhy
//  发件模块的 最上面的四个带彩色图标的自定义按钮
//  Created by lingsbb on 15-11-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSendButtonDataSource <NSObject>
@required
-(NSString *)setIconTitle:(id)button;
//-(UIImage * )setIcon; 

@end

@interface OrderSendButton : UIButton

@end

