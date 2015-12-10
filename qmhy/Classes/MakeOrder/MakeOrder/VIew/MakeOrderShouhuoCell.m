//
//  MakeOrderMainCell.m
//  qmhy
//  常用收获信息自定义单元格
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderShouhuoCell.h"


@implementation MakeOrderShouhuoCell

- (void)setShouhuo:(JSONModelConfigCShouhuo *)shouhuo {
    _shouhuo = shouhuo;
    self.mainTitle.text = shouhuo.contact;
    self.subTitle.text = shouhuo.tel;
    self.detailedContent.text = [NSString stringWithFormat:@"%@%@%@", shouhuo.Province, shouhuo.city, shouhuo.area];
}

@end
