//
//  HomeIconButton.m
//  自定义主页图标式按钮
//
//  Created by lingsbb on 15-08-13.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "HomeIconButton.h"
@interface HomeIconButton ()
-(void)pressed;
-(void)touchUp;
//必要的属性
@property (nonatomic,strong) NSString * titleBelowIcon;
@property (nonatomic, assign) IBOutlet id <HomeIconButtonDataSource> dataSource;
@property (nonatomic,assign) BOOL initialized;

@end



@implementation HomeIconButton




// 入口函数 override
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.initialized) {
        return;
    }
    
    //取消IB中的title
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    //显示自己添加的的title
        UILabel * l=[[UILabel alloc]initWithFrame:CGRectMake(0, 56, self.bounds.size.width ,22)];
        l.text=[self.dataSource setIconTitle];
    
        self.titleBelowIcon=l.text;
        l.textAlignment=NSTextAlignmentCenter;
        l.font = [UIFont fontWithName:@"Arial" size:12];
        l.textColor=[UIColor colorWithRed:150./255 green:150./255 blue:150./255 alpha:150./255];
        [self addSubview:l];
    //添加图片
    UIImage * img=[self.dataSource setIcon];
    [self setImage:img forState:UIControlStateNormal];
    [self setImage:img forState:UIControlStateHighlighted];
    //设置背景图片
    UIImage * bgimg=[UIImage imageNamed:@"HomeIcons.bundle/app_item_pressed_bg.png"];
    [self setBackgroundImage:bgimg forState:UIControlStateHighlighted];
    
    //设置insets
    self.contentEdgeInsets=UIEdgeInsetsMake(-11, 0, 0, 0);
    //响应事件
    [self addTarget:self action:@selector(pressed) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    self.initialized=YES;
}


//初始化frame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.initialized=NO;
    }
    return self;
}

//按下事件
-(void)pressed{
    
    self.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
}

//松开事件
-(void)touchUp{
    NSString *str=self.titleBelowIcon;
    /*if([str isEqualToString:@"消息"]){
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"消息功能未实现" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alert show];
    }*/
    //[self performSegueWithIdentifier:@"showConfigCPassword" sender:nil];
    [self.dataSource onClicked:str];//触发事件给消费者
    self.backgroundColor=[UIColor whiteColor];
}
@end
