//
//  CustonCell.m
//  tabelViewDemo
//
//  Created by Apple-PC on 15/12/1.
//  Copyright © 2015年 qingjingling. All rights reserved.
//

#import "CustonCell.h"

@implementation CustonCell


/*
 重新实现自定义cell的构造函数
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 45)];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 45)];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ([UIScreen mainScreen].bounds.size.width-20)/2, 45)];
//        self.leftLabel.textAlignment = NSTextAlignmentLeft;
//        [self.contentView addSubview:self.leftLabel];
//        
//        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-20)/2, 0, ([UIScreen mainScreen].bounds.size.width)/2, 45)];
//        self.rightLabel.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:self.rightLabel];
//    }
//    return self;
//}

@end
