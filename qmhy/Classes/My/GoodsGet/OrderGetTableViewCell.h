//
//  OrderGetTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/25.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelOrderGet.h"


@interface OrderGetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bendikaifaLabel;
@property (weak, nonatomic) IBOutlet UILabel *dizhiyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dizhierLabel;
@property (weak, nonatomic) IBOutlet UILabel *huowuLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingdanhaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fahuorenLabel;
@property (weak, nonatomic) IBOutlet UILabel *shifukuanLabel;

// cell加在数据
- (void)config:(JSONModelOrderGet *)model;

@end
