//
//  Config.m
//  qmhy
//  系统配置类
//  Created by lingsbb on 15/10/10.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "QConfig.h"

@implementation QConfig

//获取用户id
- (NSString *)uid {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s = [userDef objectForKey:@"uid"];
    return s;
}

//设置用户id
- (void)setUid:(NSString *)uid {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:uid forKey:@"uid"];
    [userDef synchronize];
}

- (NSString *)phone2 {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s = [userDef objectForKey:@"phone2"];
    return s;
}

- (void)setPhone2:(NSString *)phone2 {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:phone2 forKey:@"phone2"];
    [userDef synchronize];
}

// 余额
- (NSString *)balance {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s = [userDef objectForKey:@"balance"];
    return s;
}

- (void)setBalance:(NSString *)balance {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:balance forKey:@"balance"];
    [userDef synchronize];
}

// 获取注册名
- (NSString *)mem_id {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s = [userDef objectForKey:@"mem_id"];
    return s;
}

// 设置注册名
- (void)setMem_id:(NSString *)mem_id {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:mem_id forKey:@"mem_id"];
    [userDef synchronize];
}

//获取用户
- (NSString *)username {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s = [userDef objectForKey:@"username"];
    return s;
}

//设置用户
- (void)setUsername:(NSString *)username {
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:username forKey:@"username"];
    [userDef synchronize];
}

//获取密码
- (NSString *)password {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s= [userDef objectForKey:@"password"];
    return s;
}

//设置密码
- (void)setPassword:(NSString *)password {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:password forKey:@"password"];
    [userDef synchronize];
}

//获取是否第一次
- (NSString *)isFirst {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s= [userDef objectForKey:@"isFirst"];
    return s;
}

//设置是否第一次
- (void)setIsFirst:(NSString *)isFirst {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:isFirst forKey:@"isFirst"];
    [userDef synchronize];
}

//获取是否登陆成功
- (NSString *)isLogined {
    NSString *s;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    s= [userDef objectForKey:@"isLogined"];
    return s;
}

//设置是否登陆成功
- (void)setIsLogined:(NSString *)isLogined {
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:isLogined forKey:@"isLogined"];
    [userDef synchronize];
}

@end
