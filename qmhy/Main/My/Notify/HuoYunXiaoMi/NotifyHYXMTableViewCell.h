//
//  NotifyHYXMTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/24.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelNotifyHYXM.h"

@interface NotifyHYXMTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hyxmTitle;
@property (weak, nonatomic) IBOutlet UILabel *hyxmMessage;
@property (weak, nonatomic) IBOutlet UILabel *hyxmTime;

// cell加在数据
- (void)config:(JSONModelNotifyHYXM *)model;

@end
