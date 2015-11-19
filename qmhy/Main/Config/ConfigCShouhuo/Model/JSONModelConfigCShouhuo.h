//
//  JSONModelConfigCShouhuo.h
//  qmhy
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModelConfigCShouhuo : NSObject

//前提一: 属性必须和服务器返回的key一模一样
//前提二: 服务器返回的key不能包含任何关键词(description)
//如果不满足第二个前提, 就必须重写- (void)setValue:(id)value forUndefinedKey:(NSString *)key方法

@property (nonatomic, copy) NSString *x_id; // 175
@property (nonatomic, copy) NSString *uid; // 201
@property (nonatomic, copy) NSString *contact; //曾庆欣手机
@property (nonatomic, copy) NSString *tel; // 13104073815
@property (nonatomic, copy) NSString *Province; // 黑龙江省
@property (nonatomic, copy) NSString *city; // 哈尔滨市
@property (nonatomic, copy) NSString *area; // 香坊区
@property (nonatomic, copy) NSString *addressCode; // 45.725672-126.674406
@property (nonatomic, copy) NSString *Address; // 中山路34
@property (nonatomic, copy) NSString *status; // N
@property (nonatomic, copy) NSString *orderid; // 0
@property (nonatomic, copy) NSString *createtime; // 2015-11-09 18:33:02.323
@property (nonatomic, copy) NSString *createby; // 曾庆欣手机


@end
