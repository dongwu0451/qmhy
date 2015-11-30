//
//  MyEvaluationTableViewCell.m
//  qmhy
//
//  Created by mac on 15/11/30.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "MyEvaluationTableViewCell.h"

@implementation MyEvaluationTableViewCell

- (void)config:(JSONModelMyEvaluation *)model {
    self.carnameLabel.text = model.carname;
}

@end
