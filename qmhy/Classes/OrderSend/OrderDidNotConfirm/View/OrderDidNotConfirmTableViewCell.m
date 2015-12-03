//
//  OrderDidNotConfirmTableViewCell.m
//  qmhy
//
//  Created by mac on 15/12/3.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderDidNotConfirmTableViewCell.h"

@implementation OrderDidNotConfirmTableViewCell

- (void)config:(JSONModelOrderDidNotConfirm *)model {
    // 发货地 -》目的地  pickupaddress -》city
    if (model.pickupaddress.length == 0 || model.pickupaddress == nil || [model.pickupaddress  isEqual: @""]) {
        self.pickupaddressLabel.text = @"无";
    } else {
        NSArray *arr = [model.pickupaddress componentsSeparatedByString:@"-"];
        if (arr.count >= 3) { //
            self.pickupaddressLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.pickupaddressLabel.text = @"无";
        }
    }

    if (model.city.length == 0 || model.city == nil || [model.city  isEqual: @""]) {
        self.cityLabel.text = @"无";
    } else {
        NSArray *arr = [model.city componentsSeparatedByString:@"-"];
        if (arr.count >= 3) { //
            self.cityLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.cityLabel.text = @"无";
        }
    }
    
//    
//    self.pickupaddressLabel.text = model.pickupaddress;
//    self.cityLabel.text = model.city;
    self.logsticsLabel.text = model.logisticsname;
    self.goodsnameLabel.text = model.goodsname;
    self.numLabel.text = model.num;
    self.consigneenameLabel.text = model.consigneename;
    self.consigneephoneLabel.text = model.consigneephone;
    self.stimeLabel.text = [model.stime substringWithRange:NSMakeRange(5,11)];
    NSLog(@"%@", model.stime);
}

@end
