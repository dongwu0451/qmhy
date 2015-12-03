//
//  OrderDidNotConfirmTableViewCell.h
//  qmhy
//
//  Created by mac on 15/12/3.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelOrderDidNotConfirm.h"


@interface OrderDidNotConfirmTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *logsticsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *stimeLabel;


- (void)config:(JSONModelOrderDidNotConfirm *)model;

@end
