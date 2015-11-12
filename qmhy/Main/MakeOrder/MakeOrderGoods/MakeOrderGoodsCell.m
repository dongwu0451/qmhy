//
//  CargoCell.m
//  qmhy
//  自定义货物单元格
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MakeOrderGoodsCell.h"

@interface MakeOrderGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;

@end

@implementation MakeOrderGoodsCell

//初始化
- (void)setGoods:(BigAndSmallGoodsModel *)goods {
    _goods = goods;
    
    if (goods.smailCategory) { // 当小货物名称有值，则返回的是小货物，对相应的控件赋值
        _goodsNameLabel.text = goods.smailGoodsName;
        _goodsCountLabel.text = [NSString stringWithFormat:@"%@件", goods.smailNumber];
        _goodsCategoryLabel.text = goods.smailCategory;
    }else if (goods.bigCategory) { // 大货物---
        _goodsNameLabel.text = [NSString stringWithFormat:@"长%@ 宽%@ 高%@ 重%@", goods.bigLong, goods.bigWide, goods.bigHigh, goods.bigHeavy];
        _goodsCategoryLabel.text = goods.bigCategory;
        _goodsCountLabel.text = @"";
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
