//
//  AddQuhuoVC.m
//  qmhy
//  添加取货联系人
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AddQuhuoVC.h"
#import "ConfigCQuhuoTVC.h"

@interface AddQuhuoVC ()
@property (weak, nonatomic) IBOutlet UIButton *quhuoBtn;//
@property (weak, nonatomic) IBOutlet UITextField *quhuoName; // 取货名称
@property (weak, nonatomic) IBOutlet UITextField *quhuoTelephone; // 取货电话
@property (weak, nonatomic) IBOutlet UITextField *quhuoAddress; // 取货地址
@property (strong, nonatomic) QuhuoModel *quhuoModel;//取货模型
@end

@implementation AddQuhuoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// 初始化对象属性
- (QuhuoModel *)quhuoModel
{
    if (!_quhuoModel) {
        _quhuoModel = [[QuhuoModel alloc] init];
    }
    return _quhuoModel;
}

// 保存按钮
- (IBAction)saveQuhuoModel:(UIButton *)sender {
    //都填写了
    if (self.quhuoName.text.length > 0 &&
        self.quhuoTelephone.text.length > 0 &&
        self.quhuoAddress.text.length > 0) {
        
        self.quhuoModel.quhuoName = self.quhuoName.text;
        self.quhuoModel.quhuoTelephone = self.quhuoTelephone.text;
        self.quhuoModel.quhuoAddress = self.quhuoAddress.text;
        //启动委托代理
        [self.delegate AddQuhuoVC:self didInputReturnQuhuo:self.quhuoModel];
        //关闭页面
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        // delegate 可设为nil 表示不响应事件 需按钮响应时必须要设置delegate 并实现下面方法；
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        //[alert release];
    }
    
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
