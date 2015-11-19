//
//  ConfigCShouhuoTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigCShouhuo.h"


@class ConfigCShouhuoTableViewCell;
@protocol ConfigCShouhuoTableViewCellDelegate <NSObject>
- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didEditJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickBianJiLikeBtn:(UIButton *)likeBtn;

- (void)configCShouhuoTableViewCell:(ConfigCShouhuoTableViewCell *)cell didRemoveJSONModelConfigCShouhuo:(JSONModelConfigCShouhuo *)model andClickShanChuLikeBtn:(UIButton *)likeBtn;


@end


@interface ConfigCShouhuoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shouhuoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouhuoAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;

@property (strong, nonatomic) JSONModelConfigCShouhuo *jsonModelConfigCShouhuo;


@property (nonatomic, weak) id<ConfigCShouhuoTableViewCellDelegate> delegate; // ④声明一个代理属性

// cell加在数据
- (void)config:(JSONModelConfigCShouhuo *)model;


@end
