//
//  SinglePageNVC.h
//  qmhy
//  SinglePageNVC 是四个page的父类
//
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//SinglePageNVC 是四个page的父类
@interface SinglePageNVC : UINavigationController

@property (nonatomic,retain) NSString * tabbarItemImagePath;
-(void)setTabBarImage;


@end
