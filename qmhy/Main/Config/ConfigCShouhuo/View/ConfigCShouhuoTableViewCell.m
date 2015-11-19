//
//  ConfigCShouhuoTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCShouhuoTableViewCell.h"

@implementation ConfigCShouhuoTableViewCell

- (void)config:(JSONModelConfigCShouhuo *)model {
    self.shouhuoNameLabel.text = model.contact;
    self.shouhuoPhoneLabel.text = model.tel;
    self.shouhuoAddressLabel.text = [NSString stringWithFormat:@"%@%@%@", model.Province, model.city, model.area];
    self.jsonModelConfigCShouhuo = model;
    
}

- (IBAction)bianjiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCShouhuoTableViewCell:didEditJSONModelConfigCShouhuo:andClickBianJiLikeBtn:)]) {
        [self.delegate configCShouhuoTableViewCell:self didEditJSONModelConfigCShouhuo:self.jsonModelConfigCShouhuo andClickBianJiLikeBtn:sender];
    }
}

- (IBAction)shanchuBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCShouhuoTableViewCell:didRemoveJSONModelConfigCShouhuo:andClickShanChuLikeBtn:)]) {
        [self.delegate configCShouhuoTableViewCell:self didRemoveJSONModelConfigCShouhuo:self.jsonModelConfigCShouhuo andClickShanChuLikeBtn:sender];
    }
}

@end
