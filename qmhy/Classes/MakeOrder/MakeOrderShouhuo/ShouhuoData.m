//
//  AllShouhuo.m
//  qmhy
//  收货信息造数
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ShouhuoData.h"
#import "ShouhuoModel.h"

@implementation ShouhuoData

- (NSMutableArray *)allShouhuo {
    if (!_allShouhuo) {
        // 假数据用于测试使用
        ShouhuoModel *hTestOne = [ShouhuoModel new];
        hTestOne.consigneeName = @"张三";
        hTestOne.mobilePhoneNumber = @"123456789";
        hTestOne.area = @"黑龙江省";
        hTestOne.detailedAddress = @"哈尔滨市科技创新城";
        
        ShouhuoModel *hTestTwo = [ShouhuoModel new];
        hTestTwo.consigneeName = @"李四";
        hTestTwo.mobilePhoneNumber = @"987654321";
        hTestTwo.area = @"北京市";
        hTestTwo.detailedAddress = @"呵呵";
        
        ShouhuoModel *hTestThree = [ShouhuoModel new];
        hTestThree.consigneeName = @"王五";
        hTestThree.mobilePhoneNumber = @"010456789";
        hTestThree.area = @"上海";
        hTestThree.detailedAddress = @"哈哈";
        
        _allShouhuo = [NSMutableArray arrayWithObjects:hTestOne, hTestTwo, hTestThree, nil];
    }
    return _allShouhuo;
}

@end
