//
//  OrderQHZTableViewCell.h
//  qmhy
//
//  Created by mac on 15/12/3.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelOrderQHZ.h"

@class OrderQHZTableViewCell;
@protocol OrderQHZTableViewCellDelegate <NSObject>

// ③协议方法，以类名开头，去掉前缀，后面跟上传参likeBtn
- (void)orderQHZTableViewCell:(OrderQHZTableViewCell *)cell didClickLikeKfPhoneBtn:(UIButton *)likeBtn AndCarphone:(NSString *)carphone;

- (void)orderQHZTableViewCell:(OrderQHZTableViewCell *)cell didClickLikeEwmBtn:(UIButton *)likeBtn AndCode:(NSString *)code;

@end


@interface OrderQHZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carnameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentcount1Label;
@property (weak, nonatomic) IBOutlet UIImageView *commentcount2Label;
@property (weak, nonatomic) IBOutlet UIImageView *commentcount3Label;
@property (weak, nonatomic) IBOutlet UIImageView *commentcount4Label;
@property (weak, nonatomic) IBOutlet UIImageView *commentcount5Label;
@property (weak, nonatomic) IBOutlet UILabel *successnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *logisticsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressAndCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *kfPhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *ewmBtn;

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *carphone;

@property (nonatomic, weak) id<OrderQHZTableViewCellDelegate> delegate; // ④声明一个代理属性

// cell加在数据
- (void)config:(JSONModelOrderQHZ *)model;


@end
