//
//  NotifyYHHDViewController.m
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyYHHDViewController.h"

@interface NotifyYHHDViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation NotifyYHHDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.129.26.164:8090/yhhd/index.html"]];
    [self.webView loadRequest:request];
}

@end
