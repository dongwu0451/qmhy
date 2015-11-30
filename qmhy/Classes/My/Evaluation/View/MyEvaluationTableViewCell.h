//
//  MyEvaluationTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelMyEvaluation.h"

@class MyEvaluationTableViewCell;
@protocol MyEvaluationTableViewCellDelegate <NSObject>

- (void)myEvaluationTableViewCell:(MyEvaluationTableViewCell *)cell didClickLikeBtn:(UIButton *)likeBtn;

@end

@interface MyEvaluationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carnameLabel; // 司机姓名
@property (weak, nonatomic) IBOutlet UIButton *commentcount1Label; // 星星1
@property (weak, nonatomic) IBOutlet UIButton *commentcount2Label; // 星星2
@property (weak, nonatomic) IBOutlet UIButton *commentcount3Label; // 星星3
@property (weak, nonatomic) IBOutlet UIButton *commentcount4Label; // 星星4
@property (weak, nonatomic) IBOutlet UIButton *commentcount5Label; // 星星5
@property (weak, nonatomic) IBOutlet UILabel *successnumLabel; // 成功件数
@property (weak, nonatomic) IBOutlet UILabel *logisticsNameLabel; // 物流
@property (weak, nonatomic) IBOutlet UILabel *stimeLabel; // 时间
@property (weak, nonatomic) IBOutlet UILabel *pickupaddressAndCityLabel; // 地址
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel; // 货物名
@property (weak, nonatomic) IBOutlet UILabel *numLabel; // 件数
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel; // 收货人
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLabel; // 收货人电话

@property (nonatomic, weak) id<MyEvaluationTableViewCellDelegate> delegate;

- (void)config:(JSONModelMyEvaluation *)model;

@end
