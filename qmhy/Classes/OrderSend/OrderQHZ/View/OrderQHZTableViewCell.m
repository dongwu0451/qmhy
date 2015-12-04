//
//  OrderQHZTableViewCell.m
//  qmhy
//
//  Created by mac on 15/12/3.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "OrderQHZTableViewCell.h"

@implementation OrderQHZTableViewCell

- (void)config:(JSONModelOrderQHZ *)model {
    if (model.carname.length == 0 || model.carname == nil || [model.carname isEqual: @""]) {
        self.carnameLabel.text = @"无";
    } else {
        self.carnameLabel.text = model.carname;
    }
    
    if ([model.commentcount isEqualToString:@"1"]) {
        [self.commentcount1Label setImage:[UIImage imageNamed:@"full_star"]];
    }
    if ([model.commentcount isEqualToString:@"2"]) {
        [self.commentcount1Label setImage:[UIImage imageNamed:@"full_star"]];
        [self.commentcount2Label setImage:[UIImage imageNamed:@"full_star"]];
    }
    if ([model.commentcount isEqualToString:@"3"]) {
        [self.commentcount1Label setImage:[UIImage imageNamed:@"full_star"]];
        [self.commentcount2Label setImage:[UIImage imageNamed:@"full_star"]];
        [self.commentcount3Label setImage:[UIImage imageNamed:@"full_star"]];
    }
    if ([model.commentcount isEqualToString:@"4"]) {
        [self.commentcount1Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount2Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount3Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount4Label setImage:[UIImage imageNamed:@"full_star"] ];
    }
    if ([model.commentcount isEqualToString:@"5"]) {
        [self.commentcount1Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount2Label setImage:[UIImage imageNamed:@"full_star"]];
        [self.commentcount3Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount4Label setImage:[UIImage imageNamed:@"full_star"] ];
        [self.commentcount5Label setImage:[UIImage imageNamed:@"full_star"] ];
    }
    
    if (model.successnum.length == 0 || model.successnum == nil || [model.successnum isEqual: @""]) {
        self.successnumLabel.text = @"成功接单0单";
    } else {
        self.successnumLabel.text = [NSString stringWithFormat:@"成功接单%@单", model.successnum];
    }
    
    if (model.logisticsname.length == 0 || model.logisticsname == nil || [model.logisticsname isEqual: @""]) {
        self.logisticsNameLabel.text = @"无";
    } else {
        self.logisticsNameLabel.text = model.logisticsname;
    }
    
    if (model.stime.length == 0 || model.stime == nil || [model.stime isEqual: @""]) {
        self.stimeLabel.text = @"无";
    } else {
        self.stimeLabel.text = model.stime;
    }
    // 发货地 -》目的地  pickupaddress -》city
    if (model.city.length == 0 || model.city == nil || [model.city  isEqual: @""] || model.pickupaddress.length == 0 || model.pickupaddress == nil || [model.pickupaddress  isEqual: @""]) {
        self.pickupaddressAndCityLabel.text = @"无";
    } else {
        NSArray *arr1 = [model.pickupaddress componentsSeparatedByString:@"-"];
        NSArray *arr = [model.city componentsSeparatedByString:@"-"];
        if (arr.count >= 3 && arr1.count >=3) { //
            self.pickupaddressAndCityLabel.text = [NSString stringWithFormat:@"%@->%@", arr1[2], arr[2]];
        } else {
            self.pickupaddressAndCityLabel.text = @"无";
        }
    }
    
    if (model.goodsname.length == 0 || model.goodsname == nil || [model.goodsname isEqual: @""]) {
        self.goodsnameLabel.text = @"无";
    } else {
        self.goodsnameLabel.text = model.goodsname;
    }
    
    if (model.num.length == 0 || model.num == nil || [model.num isEqual: @""]) {
        self.numLabel.text = @"无";
    } else {
        self.numLabel.text = model.num;
    }
    
    if (model.consigneename.length == 0 || model.consigneename == nil || [model.consigneename isEqual: @""]) {
        self.consigneeNameLabel.text = @"无";
    } else {
        self.consigneeNameLabel.text = model.consigneename;
    }
    
    if (model.consigneephone.length == 0 || model.consigneephone == nil || [model.consigneephone isEqual: @""]) {
        self.consigneePhoneLabel.text = @"无";
    } else {
        self.consigneePhoneLabel.text = model.consigneephone;
    }

}

- (IBAction)kfPhoneBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderQHZTableViewCell:didClickLikeKfPhoneBtn:AndCarphone:)]) {
        [self.delegate orderQHZTableViewCell:self didClickLikeKfPhoneBtn:sender AndCarphone:self.carphone];
    }
}
- (IBAction)ewmBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderQHZTableViewCell:didClickLikeEwmBtn:AndCode:)]) {
        [self.delegate orderQHZTableViewCell:self didClickLikeEwmBtn:sender AndCode:self.code];
    }
}
@end
