//
//  JSONModelConfigCShouhuo.m
//  qmhy
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "JSONModelConfigCShouhuo.h"

@implementation JSONModelConfigCShouhuo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"])
        self.x_id = value;
}

@end
