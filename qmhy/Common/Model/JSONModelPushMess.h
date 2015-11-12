//
//  JSONModelPushMess.h
//  qmhy
//  JSON推送消息
//  Created by mac on 15/9/6.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//


/** 获取推送消息 gettabpushmess */

#import <Foundation/Foundation.h>

@interface JSONModelPushMess : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *idxmess;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *mess;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *pushuid;
@property (nonatomic, copy) NSString *pushgroup;
@property (nonatomic, copy) NSString *stime;
@property (nonatomic, copy) NSString *etime;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *createperson;
@property (nonatomic, copy) NSString *webadress;
@property (nonatomic, copy) NSString *sendto;

@end
