//
//  MakeOrderMainCell.h
//  qmhy
//  常用收获信息自定义单元格
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouhuoModel.h"

@interface MakeOrderShouhuoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *UIImage;
@property (strong, nonatomic) IBOutlet UILabel *mainTitle;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *detailedContent;
@property (strong, nonatomic) IBOutlet UILabel *huowuMessage;

@property (nonatomic, strong) ShouhuoModel *shouhuo;

@end
