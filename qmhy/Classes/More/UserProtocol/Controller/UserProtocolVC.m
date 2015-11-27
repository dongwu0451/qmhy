//
//  UserProtocolVC.m
//  qmhy
//  用户协议 视图控制器
//  Created by lingsbb on 15-8-16.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "UserProtocolVC.h"

@interface UserProtocolVC ()

@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation UserProtocolVC
@synthesize webview;//自己增加的webview引用



- (void)viewDidLoad {
    [super viewDidLoad];

    //维护UINavigationItem
    
    //重写左侧按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    // 直接显示web页面内容
    // Do any additional setup after loading the view.
    //使用webview引用显示about.html
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"userprotocol.html" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webview loadRequest:request];
}

//点击返回按钮
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
