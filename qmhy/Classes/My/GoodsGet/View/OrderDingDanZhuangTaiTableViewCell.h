//
//  OrderDingDanZhuangTaiTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/27.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelOrderDingDanZhuangTai.h"

@interface OrderDingDanZhuangTaiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *uidtypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameOrRemarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone2Label;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;



// cell加在数据
- (void)config:(JSONModelOrderDingDanZhuangTai *)model;

@end
