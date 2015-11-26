//
//  JSONModelCommonCity.h
//  qmhy
//  JSON常用城市
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModelCommonCity : NSObject
@property (nonatomic, copy) NSString *uid; // 用户UID
@property (nonatomic, copy) NSString *name; // 物流名称
@property (nonatomic, copy) NSString *code; // 主键
@property (nonatomic, copy) NSString *setType; // 设置类型 0为更新，1为插入，-1为删除

@end
