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
    if (model.pickupAddress.length == 0 || model.pickupAddress == nil || [model.pickupAddress  isEqual: @""]) {
        
        self.dizhiyiLabel.text = @"";
    } else {
        NSArray *arr = [model.pickupAddress componentsSeparatedByString:@"-"];
        if (arr.count >= 3) {
            self.dizhiyiLabel.text = arr[2];
        } else {
            self.dizhiyiLabel.text = @"";
        }
    }
//    self.dizhiyiLabel.text = model.pickupAddress;
    if (model.city.length == 0 || model.city == nil || [model.city  isEqual: @""]) {
        
        self.dizhierLabel.text = @"";
    } else {
        NSArray *arr = [model.city componentsSeparatedByString:@"-"];
        if (arr.count >= 3) {
            self.dizhierLabel.text = arr[2];
        } else {
            self.dizhierLabel.text = @"";
        }
    }

//    self.dizhierLabel.text = model.city;
    self.huowuLabel.text = [NSString stringWithFormat:@"%@ x%@", model.goodsName, model.num];
    self.dingdanhaoLabel.text = model.code;
    self.fahuorenLabel.text = model.pickupcontact;
    float sum = [model.freightPrice floatValue] + [model.logisticsPrice floatValue] + [model.logisticsPrice floatValue];
    self.shifukuanLabel.text = [NSString stringWithFormat:@"%.2f",sum];

}

@end
