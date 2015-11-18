//
//  ConfigCShouhuoTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigShouhuo.h"


@class ConfigCShouhuoTableViewCell;
@protocol ConfigCShouhuoTableViewCellDelegate <NSObject>
- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didClickBianJiLikeBtn:(UIButton *)likeBtn;
- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didClickShanChuLikeBtn:(UIButton *)likeBtn;


@end


@interface ConfigCShouhuoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shouhuoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;

@property (strong, nonatomic) JSONModelConfigShouhuo *jsonModelConfigShouhuo;

// cell加在数据
- (void)config:(JSONModelConfigShouhuo *)model;


@end
