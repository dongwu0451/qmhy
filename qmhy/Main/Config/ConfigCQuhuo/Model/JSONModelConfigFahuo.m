//
//  JSONModelConfigFahuo.m
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "JSONModelConfigFahuo.h"

@implementation JSONModelConfigFahuo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"])
        self.x_id = value;
}

@end
