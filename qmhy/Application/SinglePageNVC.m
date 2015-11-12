//
//  SinglePageNVC.m
//  qmhy
//  SinglePageNVC 是四个page的父类
//
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "SinglePageNVC.h"

@interface SinglePageNVC ()

@end


@implementation SinglePageNVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//四个page页面通用的设置图片方法 复用
-(void)setTabBarImage{
    if (self.tabbarItemImagePath) {
        self.tabBarItem.image=[UIImage imageNamed: self.tabbarItemImagePath];
        NSString * selectedImagePath=[NSString stringWithFormat:@"%@_sel",self.tabbarItemImagePath];
        self.tabBarItem.selectedImage=[UIImage imageNamed:selectedImagePath];
    }

}
@end
