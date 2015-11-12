//
//  AddShouhuoVC.m
//  qmhy
//  添加常用收获信息
//  Created by lingsbb on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AddShouhuoVC.h"
#import "ConfigCShouhuoTVC.h"


@interface AddShouhuoVC ()
@property (strong, nonatomic) ShouhuoModel *shouhuo;

@property (strong, nonatomic) IBOutlet UITextField *consigneeName;//联系人
@property (strong, nonatomic) IBOutlet UITextField *mobilePhoneNumber;//电话
@property (strong, nonatomic) IBOutlet UITextField *area;//所在地区
@property (strong, nonatomic) IBOutlet UITextField *detailedAddress;//详细地址
@property (strong, nonatomic) IBOutlet UIButton *btn;

@end

@implementation AddShouhuoVC

//收货模型 属性 初始化
- (ShouhuoModel *)shouhuo {
    if (!_shouhuo) {
        _shouhuo = [[ShouhuoModel alloc] init];
    }
    return _shouhuo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存按钮事件
- (IBAction)saveShouhuo:(UIButton *)sender {
    
    //输入了数据
    if (self.consigneeName.text.length > 0 &&
        self.mobilePhoneNumber.text.length > 0 &&
        self.area.text.length > 0 &&
        self.detailedAddress.text.length>0) {
        
        self.shouhuo.consigneeName = self.consigneeName.text;
        self.shouhuo.mobilePhoneNumber = self.mobilePhoneNumber.text;
        self.shouhuo.area = self.area.text;
        self.shouhuo.detailedAddress = self.detailedAddress.text;
        [self.delegate addShouhuoVC:self didInputReturnShouhuo:self.shouhuo];
        [self.navigationController popViewControllerAnimated:YES];
    } else {//没有输入数据
        // delegate 可设为nil 表示不响应事件 需按钮响应时必须要设置delegate 并实现下面方法；
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];//        [alert release];
    }
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
