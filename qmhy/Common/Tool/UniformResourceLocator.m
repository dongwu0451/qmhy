//
//  UniformResourceLocator.m
//  qmhy
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "UniformResourceLocator.h"

@implementation UniformResourceLocator

+ (NSString *)getURL {
    NSString *URL = @"http://139.129.26.164:8080/adminappios/WebAppController/json.html?methodName=%@";
    return URL;
}

//+ (NSString *)sendVerificationCode {
//    NSString *url = @"http://139.129.26.164:8090/tlandroidService.asmx";
//    return url;
//}


@end
