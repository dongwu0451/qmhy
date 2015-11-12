//
//  AddGoodsVC.m
//  qmhy
//  添加货物名称
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AddGoodsVC.h"

@interface AddGoodsVC ()

@property (strong, nonatomic) IBOutlet UITextField *goodsField;
@end

@implementation AddGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//保存按钮
- (IBAction)saveGoods:(id)sender {
    // 当输入框中没有文字，直接弹框提示并返回
    if (!self.goodsField.text.length){
        //AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        [AppDelegate showAlert:@"请输入货物名称"];
        return;
    }
    // 输入框中有值
    if ([self.delegate respondsToSelector:@selector(addGoodsVC:endEditingReturnGoods:)]) {
        // 如果有代理相应代理方法
        BigAndSmallGoodsModel *goodsModel = [[BigAndSmallGoodsModel alloc] init];
        goodsModel.smailGoodsName = self.goodsField.text;
        //调用代理方法给代理传值
        [self.delegate addGoodsVC:self endEditingReturnGoods:goodsModel];
    }
    
//    // 保存货物名称时发送通知，传参：货物名 跟代理是重复的
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"smallGoodsName" object:nil userInfo:@{@"goodsName" : self.goodsField.text}];
    
    //关闭
    [self.navigationController popViewControllerAnimated:YES];
    
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
