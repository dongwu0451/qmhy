//
//  ConfigCGoodsTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCGoodsTableViewCell.h"

@implementation ConfigCGoodsTableViewCell


- (void)config:(JSONModelConfigGGoods *)model {
    self.huowuNameLabel.text = model.name;
    self.uid = model.uid;
    self.name = model.name;
    self.code = model.code;
}


- (IBAction)bianjiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCGoodsTableViewCell:didClickBianJiLikeBtn:)]) {
        [self.delegate configCGoodsTableViewCell:self didClickBianJiLikeBtn:sender];
    }
}

- (IBAction)shanchuBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCGoodsTableViewCell:didClickShanChuLikeBtn:)]) {
        [self.delegate configCGoodsTableViewCell:self didClickShanChuLikeBtn:sender];
    }

}

@end
