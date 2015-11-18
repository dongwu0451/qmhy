//
//  JSONModelConfigFahuo.h
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModelConfigFahuo : NSObject

//前提一: 属性必须和服务器返回的key一模一样
//前提二: 服务器返回的key不能包含任何关键词
//如果不满足第二个前提, 就必须重写- (void)setValue:(id)value forUndefinedKey:(NSString *)key方法

@property (nonatomic, copy) NSString *x_id; // id 字段
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *Province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *addressCode;
@property (nonatomic, copy) NSString *Address;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *createby;



@end
