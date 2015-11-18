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
    self.jsonModelConfigGGoods = model;

}


- (IBAction)bianjiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCGoodsTableViewCell:didEditJSONModelConfigCGoods:andClickBianJiLikeBtn:)]) {
        [self.delegate configCGoodsTableViewCell:self didEditJSONModelConfigCGoods:self.jsonModelConfigGGoods andClickBianJiLikeBtn:sender];
    }
}

- (IBAction)shanchuBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCGoodsTableViewCell:didRemoveJSONModelConfigCGoods:andClickShanChuLikeBtn:)]) {
        [self.delegate configCGoodsTableViewCell:self didRemoveJSONModelConfigCGoods:self.jsonModelConfigGGoods andClickShanChuLikeBtn:sender];
    }

}

@end
