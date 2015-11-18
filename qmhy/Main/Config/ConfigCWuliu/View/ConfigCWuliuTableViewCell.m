//
//  ConfigCWuliuTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCWuliuTableViewCell.h"
#import "JSONModelConfigCWuLiu.h"

@implementation ConfigCWuliuTableViewCell

- (void)config:(JSONModelConfigCWuLiu *)model {
    self.wuLiuNameLabel.text = model.name;
    self.jsonModelConfigCWuLiu = model;

}

- (IBAction)bianJiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCWuliuTableViewCell:didEditJSONModelConfigCWuLiu:andClickBianJiLikeBtn:)]) {
        [self.delegate configCWuliuTableViewCell:self didEditJSONModelConfigCWuLiu:self.jsonModelConfigCWuLiu andClickBianJiLikeBtn:sender];
    }
}

- (IBAction)shanChuBtnClick:(UIButton *)sender {    
    if ([self.delegate respondsToSelector:@selector(configCWuliuTableViewCell:didRemoveJSONModelConfigCWuLiu:andClickShanChuLikeBtn:)]) {
        [self.delegate configCWuliuTableViewCell:self didRemoveJSONModelConfigCWuLiu:self.jsonModelConfigCWuLiu andClickShanChuLikeBtn:sender];
    }

}


@end
