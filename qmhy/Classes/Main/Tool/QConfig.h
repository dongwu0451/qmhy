//
//  Config.h
//  qmhy
//  系统配置类
//  Created by lingsbb on 15/10/10.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QConfig : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username; // 用户名
@property (nonatomic, copy) NSString *password; // 密码
@property (nonatomic, copy) NSString *mem_id; // 注册名
@property (nonatomic, copy) NSString *balance; // 余额
@property (nonatomic, copy) NSString *phone2; // 下单时 发件人显示的电话


@property (nonatomic, copy) NSString *isFirst; // 是否是第一次登录
@property (nonatomic, copy) NSString *isLogined; // 是否是第一次登录
@end
