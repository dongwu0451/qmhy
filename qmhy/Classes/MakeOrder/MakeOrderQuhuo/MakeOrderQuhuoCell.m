//
//  MakeOrderQuhuoCell.m
//  qmhy
//  取货联系人自定义单元格
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderQuhuoCell.h"

@interface MakeOrderQuhuoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *quhuoImage;
@property (weak, nonatomic) IBOutlet UILabel *quhuoName;
@property (weak, nonatomic) IBOutlet UILabel *quhuoTelephone;
@property (weak, nonatomic) IBOutlet UILabel *quhuoAddress;
@end

@implementation MakeOrderQuhuoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setQuhuoModel:(QuhuoModel *)quhuoModel {
    _quhuoModel = quhuoModel;
    self.quhuoName.text = quhuoModel.quhuoName;
    self.quhuoTelephone.text = quhuoModel.quhuoTelephone;
    self.quhuoAddress.text = quhuoModel.quhuoAddress;
}

@end
