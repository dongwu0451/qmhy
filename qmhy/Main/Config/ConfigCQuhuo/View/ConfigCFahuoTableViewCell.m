//
//  ConfigCFahuoTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCFahuoTableViewCell.h"

@implementation ConfigCFahuoTableViewCell

- (void)config:(JSONModelConfigFahuo *)model {
    self.fahuoNameLabel.text = model.contact;
    self.fahuoPhoneLabel.text = model.tel;
    self.fahuoAddressLabel.text = [NSString stringWithFormat:@"%@%@%@", model.Province, model.city, model.area];
    self.jsonModelConfigFahuo = model;
}

- (IBAction)bianjiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCFahuoTableViewCell:didEditJSONModelConfigFahuo:andClickBianJiLikeBtn:)]) {
        [self.delegate configCFahuoTableViewCell:self didEditJSONModelConfigFahuo:self.jsonModelConfigFahuo andClickBianJiLikeBtn:sender];
    }
}

- (IBAction)shanchuBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCFahuoTableViewCell:didRemoveJSONModelConfigFahuo:andClickShanChuLikeBtn:)]) {
        [self.delegate configCFahuoTableViewCell:self didRemoveJSONModelConfigFahuo:self.jsonModelConfigFahuo andClickShanChuLikeBtn:sender];
    }
}

@end
