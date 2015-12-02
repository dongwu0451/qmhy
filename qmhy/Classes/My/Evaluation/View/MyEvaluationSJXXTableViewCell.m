//
//  MyEvaluationSJXXTableViewCell.m
//  qmhy
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationSJXXTableViewCell.h"

@implementation MyEvaluationSJXXTableViewCell

- (void)config:(JSONModelMyEvaluationSJXX *)model {
    self.uidtypeLabel.text = model.uidtype;
    switch ([model.status intValue]) {
        case 10:
            self.statusLabel.text = @"您已经提交订单，请耐心等待";
            break;
        case 20:
            self.statusLabel.text = @"客服已经审核";
            break;
        case 22:
            self.statusLabel.text = @"已制定派送员";
            break;
            
        case 25:
            self.statusLabel.text = @"司机已接单";
            break;
        case 29:
            self.statusLabel.text = @"取货异常";
            break;
            
        case 30:
            self.statusLabel.text = @"货物正在送往物流的途中";
            break;
        case 31:
            self.statusLabel.text = @"地址错误导致未送货";
            break;
        case 32:
            self.statusLabel.text = @"无人领取导致未送货";
            break;
        case 33:
            self.statusLabel.text = @"货物交接错误导致未送货";
            break;
        case 34:
            self.statusLabel.text = @"货物损坏导致未送货";
            break;
        case 35:
            self.statusLabel.text = @"送货超时";
            break;
        case 36:
            self.statusLabel.text = @"其他原因导致未送货";
            break;
        case 40:
            self.statusLabel.text = @"已到物流";
            break;
        case 45:
            self.statusLabel.text = @"物流已签收";
            break;
        case 50:
            self.statusLabel.text = @"已装车";
            break;
        case 60:
            self.statusLabel.text = @"已到目的地";
            break;
        case 70:
            self.statusLabel.text = @"货物已出库";
            break;
        case 80:
            self.statusLabel.text = @"货物已签收";
            break;
        case 75:
            self.statusLabel.text = @"货款已发放";
            break;
        default:
            self.statusLabel.text = @"NULL";
            break;
    }
    if (model.name.length > 0) {
        self.nameOrRemarkLabel.text = model.name;
    } else {
        self.nameOrRemarkLabel.text = model.remark;
    }
    self.phone2Label.text = model.phone2;
    self.createTimeLabel.text = model.createTime;
}

@end
