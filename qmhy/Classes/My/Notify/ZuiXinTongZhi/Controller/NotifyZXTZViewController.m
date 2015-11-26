//
//  NotifyZXTZViewController.m
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyZXTZViewController.h"

@interface NotifyZXTZViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NotifyZXTZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.129.26.164:8090/zxtz/index.html"]];
    [self.webView loadRequest:request];
}


@end
