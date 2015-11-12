//
//  JSONModelLogin.h
//  qmhy
//  JSON登录信息
//  Created by lingsbb on 15-9-3.
//  Copyright (c) 2015年 wxxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModelLogin : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mem_id;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone1;
@property (nonatomic, copy) NSString *phone2;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *integral;

@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *domain_id;
@property (nonatomic, copy) NSString *organization_id;
@property (nonatomic, copy) NSString *is_deleted;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *member_grade;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *consignor;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *areaid;

@end
