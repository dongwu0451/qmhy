//
//  NotifyHYXMTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/24.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "NotifyHYXMTableViewCell.h"

@implementation NotifyHYXMTableViewCell

- (void)config:(JSONModelNotifyHYXM *)model {
    self.hyxmTitle.text = model.title;
    self.hyxmMessage.text = model.mess;
    self.hyxmTitle.text = model.createtime;
}

@end
