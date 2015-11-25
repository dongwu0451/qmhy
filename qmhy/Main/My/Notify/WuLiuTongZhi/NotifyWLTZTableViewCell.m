//
//  NotifyWLTZTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyWLTZTableViewCell.h"

@implementation NotifyWLTZTableViewCell

- (void)config:(JSONModelNotifyWLTZ *)model {
    self.timeLabel.text = model.createtime;
    self.dingdanhaoLabel.text = model.code;
    self.neirongLabel.text = model.mess;
}

@end
