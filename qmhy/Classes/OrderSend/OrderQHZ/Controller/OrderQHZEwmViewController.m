//
//  OrderQHZEwmViewController.m
//  qmhy
//
//  Created by mac on 15/12/4.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderQHZEwmViewController.h"

@interface OrderQHZEwmViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *codelabel;


@end

@implementation OrderQHZEwmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codelabel.text = self.code;
    
    
    //1.创建二维码的滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.恢复滤镜的初始设置
    [filter setDefaults];
    
    //3.将二维码中要存储的内容变成NSData
    NSData *data = [self.code dataUsingEncoding:NSUTF8StringEncoding];
    
    //4.通过kvo设置滤镜要存储的url地址
    //key value object
    //依据属性名做key,通过setValue:forKey的方法
    //为对象的某个属性赋值
    //比以前的  "点语法" 更强大
    //Student  *s1 = [Student new];
    //s1.name = @"xxx";
    //[s1 setName:@"xxxx"];
    //[s1 setValue:@"xxxx"  forKey:@"name"];
    [filter setValue:data forKey:@"inputMessage"];
    //5.生成二维码
    CIImage *outputImage = [filter outputImage];
    
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = image;
    
}



@end
