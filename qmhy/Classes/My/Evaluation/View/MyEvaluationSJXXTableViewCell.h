//
//  MyEvaluationSJXXTableViewCell.h
//  qmhy
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelMyEvaluationSJXX.h"

@interface MyEvaluationSJXXTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *uidtypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameOrRemarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone2Label;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;



- (void)config:(JSONModelMyEvaluationSJXX *)model;


@end
