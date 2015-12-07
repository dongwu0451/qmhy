//
//  OrderDLWTableViewCell.h
//  qmhy
//
//  Created by mac on 15/12/7.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelOrderDLW.h"

@interface OrderDLWTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *logisticsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneeName;
@property (weak, nonatomic) IBOutlet UILabel *consigneePhone;

- (void)config:(JSONModelOrderDLW *)model;

@end
