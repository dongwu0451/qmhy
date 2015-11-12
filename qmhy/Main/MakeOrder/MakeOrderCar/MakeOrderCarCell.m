//
//  CarCell.m
//  qmhy
//  自定义车辆单元格
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderCarCell.h"

@interface MakeOrderCarCell ()
@property (strong, nonatomic) IBOutlet UIImageView *carUIImageView;
@property (strong, nonatomic) IBOutlet UILabel *carBox;

@end

@implementation MakeOrderCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCarModel:(CarModel *)carModel {
    _carModel = carModel;
    self.carBox.text = carModel.carCategory;
}

@end
