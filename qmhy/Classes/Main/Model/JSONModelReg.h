//
//  JSONModelReg.h
//  qmhy
//  注册信息
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

/** 添加注册信息reg */

#import <Foundation/Foundation.h>

@interface JSONModelReg : NSObject
@property (nonatomic, copy) NSString *uid; // 用户表Memid
@property (nonatomic, copy) NSString *tel; // 电话
@property (nonatomic, copy) NSString *tel2; // 电话2
@property (nonatomic, copy) NSString *pas; // 密码
@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *type; // 用户类型
@property (nonatomic, copy) NSString *sourcegroup; // 用户组
@property (nonatomic, copy) NSString *carnum; // 车牌号
@property (nonatomic, copy) NSString *bank; // 银行类型
@property (nonatomic, copy) NSString *area; // 所属区域
@property (nonatomic, copy) NSString *remark; // 备注

@end
