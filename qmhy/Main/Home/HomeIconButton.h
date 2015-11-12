//
//  HomeIconButton.h
//  自定义主页图标式按钮
//
//  Created by lingsbb on 15-08-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//消费者的实现协议 重点是这里
@protocol HomeIconButtonDataSource <NSObject>
-(NSString *)setIconTitle;
-(UIImage * )setIcon;
-(void)onClicked:(NSString*)str;
@end

@interface HomeIconButton : UIButton//从button继承

@end
