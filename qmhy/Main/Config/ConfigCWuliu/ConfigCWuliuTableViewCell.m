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
    self.uid = model.uid;
    self.name = model.name;
    self.code = model.code;
}

- (IBAction)bianJiBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCWuliuTableViewCell:didClickBianJiLikeBtn:)]) {
        [self.delegate configCWuliuTableViewCell:self didClickBianJiLikeBtn:sender];
    }
    


}

- (IBAction)shanChuBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(configCWuliuTableViewCell:didClickShanChuLikeBtn:)]) {
        [self.delegate configCWuliuTableViewCell:self didClickShanChuLikeBtn:sender];
    }
    

}


@end
