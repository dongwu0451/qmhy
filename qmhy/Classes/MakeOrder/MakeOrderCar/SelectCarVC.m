//
//  ConfigCarVC.m
//  qmhy
//  选择车辆界面
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "SelectCarVC.h"
#import "CarModel.h"

@interface SelectCarVC ()
//@property (weak, nonatomic) IBOutlet UITextField *carCategoryTextField;
//箱货微面选择控件
@property (weak, nonatomic) IBOutlet UISegmentedControl *carCategorySegmentedC;
//车辆模型类
@property (strong, nonatomic) CarModel *carModel;
@end

@implementation SelectCarVC

//初始化
- (CarModel *)carModel {
    if (!_carModel) {
        _carModel = [[CarModel alloc] init];
        if (self.carCategorySegmentedC.selectedSegmentIndex == 0) {
            _carModel.carCategory = @"箱货";
        }else {
            _carModel.carCategory = @"微面";
        }
//        _carModel.carCategory = self.carCategoryTextField.text;
    }
    return _carModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//点击完成按钮 选择车辆 保存 按钮事件
- (IBAction)addCarCategory:(UIButton *)sender {
    [self.delegate ConfigCarVC:self didPassCar:self.carModel];//触发代理传值
    [self.navigationController popViewControllerAnimated:YES];//关闭
}

@end
