//
//  ShouhuoModel.h
//  qmhy
//  常用收获信息模型
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ShouhuoModel : NSObject
@property (nonatomic, strong) NSString *consigneeName; // 收货人
@property (nonatomic, strong) NSString *mobilePhoneNumber; // 手机号码
@property (nonatomic, strong) NSString *area; // 所在地区
@property (nonatomic, strong) NSString *detailedAddress; // 详细地址

@end
