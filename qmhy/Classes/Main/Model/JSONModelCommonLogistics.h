//
//  JSONModelCommonLogistics.h
//  qmhy
//  JSON个人常用物流
//  Created by lingsbb on 15/9/6.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//


/** 设置个人常用物流 */


#import <Foundation/Foundation.h>

@interface JSONModelCommonLogistics : NSObject
@property (nonatomic, copy) NSString *uid; // 用户UID
@property (nonatomic, copy) NSString *name; // 物流名称
@property (nonatomic, copy) NSString *code; // 主键
@property (nonatomic, copy) NSString *setType; // 设置类型 0为更新，1为插入，-1为删除

@end
