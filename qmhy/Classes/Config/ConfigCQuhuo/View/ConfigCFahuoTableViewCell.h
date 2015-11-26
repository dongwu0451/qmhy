//
//  ConfigCFahuoTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigFahuo.h"

@class ConfigCFahuoTableViewCell;
@protocol ConfigCFahuoTableViewCellDelegate <NSObject>
- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didEditJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickBianJiLikeBtn:(UIButton *)likeBtn;

- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didRemoveJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickShanChuLikeBtn:(UIButton *)likeBtn;

- (void)configCFahuoTableViewCell:(ConfigCFahuoTableViewCell *)cell didMoRenJSONModelConfigFahuo:(JSONModelConfigFahuo *)model andClickMoRenLikeBtn:(UIButton *)likeBtn;

@end


@interface ConfigCFahuoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fahuoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fahuoPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *fahuoAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;
@property (weak, nonatomic) IBOutlet UIButton *sheweimorenBtn;
@property (weak, nonatomic) IBOutlet UIImageView *morenImage;


@property (strong, nonatomic) JSONModelConfigFahuo *jsonModelConfigFahuo;


@property (nonatomic, weak) id<ConfigCFahuoTableViewCellDelegate> delegate; // ④声明一个代理属性

// cell加在数据
- (void)config:(JSONModelConfigFahuo *)model;



@end
