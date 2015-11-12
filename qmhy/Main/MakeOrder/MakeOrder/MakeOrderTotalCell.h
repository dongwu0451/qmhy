//
//  MakeOrderTotalCell.h
//  qmhy
//  自定义单元格 发货人 总件数 代收款
//  Created by lingsbb on 15/8/28.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeOrderTotalCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_shouhuoren;//发货人
@property (strong, nonatomic) IBOutlet UILabel *lbl_allcount;//总件数
@property (strong, nonatomic) IBOutlet UILabel *lbl_daishoukuan;//代收款

@end
