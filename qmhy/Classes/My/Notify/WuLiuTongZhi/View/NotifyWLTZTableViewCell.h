//
//  NotifyWLTZTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelNotifyWLTZ.h"

@interface NotifyWLTZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dingdanhaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *neirongLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

// cell加在数据
- (void)config:(JSONModelNotifyWLTZ *)model;

@end
