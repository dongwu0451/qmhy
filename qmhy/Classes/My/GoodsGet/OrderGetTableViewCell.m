//
//  OrderGetTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderGetTableViewCell.h"

@implementation OrderGetTableViewCell

- (void)config:(JSONModelOrderGet *)model {
    self.bendikaifaLabel.text = model.logisticsName;
    self.dizhiyiLabel.text = model.pickupAddress;
    self.dizhierLabel.text = model.city;
    self.huowuLabel.text = [NSString stringWithFormat:@"%@ x%@", model.goodsName, model.num];
    self.dingdanhaoLabel.text = model.code;
    self.fahuorenLabel.text = model.pickupcontact;
    float sum = [model.freightPrice floatValue] + [model.logisticsPrice floatValue] + [model.logisticsPrice floatValue];
    self.shifukuanLabel.text = [NSString stringWithFormat:@"%.2f",sum];

}

@end
