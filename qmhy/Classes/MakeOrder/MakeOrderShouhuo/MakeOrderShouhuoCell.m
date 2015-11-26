//
//  MakeOrderMainCell.m
//  qmhy
//  常用收获信息自定义单元格
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderShouhuoCell.h"


@implementation MakeOrderShouhuoCell


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setShouhuo:(ShouhuoModel *)shouhuo {
    _shouhuo = shouhuo;
//    NSString* string1;
//    string1= [NSString stringWithFormat:@"%@%@%@%@", shouhuo.consigneeName, @"(",shouhuo.area,@")" ];
    self.mainTitle.text = shouhuo.consigneeName;
    self.subTitle.text = shouhuo.mobilePhoneNumber;
    self.detailedContent.text = shouhuo.detailedAddress;
}

@end
