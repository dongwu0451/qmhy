//
//  OrderDLWTableViewCell.m
//  qmhy
//
//  Created by mac on 15/12/7.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderDLWTableViewCell.h"

@implementation OrderDLWTableViewCell

- (void)config:(JSONModelOrderDLW *)model {
    self.logisticsnameLabel.text = model.logisticsname;
    self.goodsnameLabel.text = model.goodsname;
    self.numLabel.text = model.num;
    self.consigneeName.text = model.consigneename;
    self.consigneePhone.text = model.consigneephone;
    
    
    if (model.pickupaddress.length == 0 || model.pickupaddress == nil || [model.pickupaddress  isEqual: @""]) {
        self.pickupaddressLabel.text = @"无";
    } else {
        NSArray *arr = [model.pickupaddress componentsSeparatedByString:@"-"];
        if (arr.count >= 3 && arr.count >=3) { //
            self.pickupaddressLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.pickupaddressLabel.text = @"无";
        }
    }
    
    if (model.city.length == 0 || model.city == nil || [model.city  isEqual: @""]) {
        self.cityLabel.text = @"无";
    } else {
        NSArray *arr = [model.city componentsSeparatedByString:@"-"];
        if (arr.count >= 3 && arr.count >=3) { //
            self.cityLabel.text = [NSString stringWithFormat:@"%@", arr[2]];
        } else {
            self.cityLabel.text = @"无";
        }
    }

    
}



@end
