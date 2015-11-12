//
//  OrderSendButton.m
//  qmhy
//  发件模块的 最上面的四个带彩色图标的自定义按钮
//  Created by lingsbb on 15-11-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderSendButton.h"
@interface OrderSendButton ()

//-(void)pressed;
-(void)touchUp;
@property (nonatomic,strong) NSString * titleBelowIcon;
@property (nonatomic, assign) IBOutlet id <OrderSendButtonDataSource> dataSource;
@property (nonatomic,assign) BOOL initialized;

@end


@implementation OrderSendButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.initialized=NO;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
//重写drawRect
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if (self.initialized) {
        return;
    }
    //IB中没有title，在这setTitle反而导致图片位置异常，所以注释掉。
//    [self setTitle:@"" forState:UIControlStateNormal];
//    [self setTitle:@"" forState:UIControlStateHighlighted];
    //显示自己添加的的title
    UILabel * l=[[UILabel alloc]initWithFrame:CGRectMake(0, 68, self.bounds.size.width ,22)];
    l.text=[self.dataSource setIconTitle:self];
    l.textAlignment=NSTextAlignmentCenter;
    l.font = [UIFont fontWithName:@"Arial" size:12];
    l.textColor=[UIColor colorWithRed:150./255 green:150./255 blue:150./255 alpha:1];
    [self addSubview:l];

    //设置insets
    self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    self.contentEdgeInsets=UIEdgeInsetsMake(-11, 0, 0, 0);
    //响应事件
    //    [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchDown];
    //    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    //    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    self.initialized=YES;
}

-(void)touchUp{
    self.backgroundColor=[UIColor whiteColor];
}

@end
