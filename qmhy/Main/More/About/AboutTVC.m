//
//  AboutTVC.m
//  qmhy
//  关于视图控制器
//  Created by lingsbb on 15-8-15.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AboutTVC.h"

@interface AboutTVC ()
//导航条目
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;


@end


@implementation AboutTVC


@synthesize navigationItem;//自己增加的navigationItem引用


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //维护UINavigationItem
    
    //重写左侧按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    //重写标题
    if (self.newtitle) {
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 144)];
        title.text=self.newtitle;
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor whiteColor];
        self.navigationItem.titleView=title;
        NSLog(@"setTitle");
    }
}

//点击返回按钮
-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
