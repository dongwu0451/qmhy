//
//  ConfigCGoodsTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelConfigGGoods.h"

@class ConfigCGoodsTableViewCell; // ①声明 类名（代理才能识别这个类，不然会报错）
@protocol ConfigCGoodsTableViewCellDelegate <NSObject> // ②写协议，协议名在类名后加上delegate

// ③协议方法，以类名开头，去掉前缀，后面跟上传参likeBtn
- (void)configCGoodsTableViewCell:(ConfigCGoodsTableViewCell *)cell didClickBianJiLikeBtn:(UIButton *)likeBtn;
- (void)configCGoodsTableViewCell:(ConfigCGoodsTableViewCell *)cell didClickShanChuLikeBtn:(UIButton *)likeBtn;


@end


@interface ConfigCGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *huowuNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shanchuBtn;

@property (nonatomic, strong) JSONModelConfigGGoods *jsonModelConfigGGoods;

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;



@property (nonatomic, weak) id<ConfigCGoodsTableViewCellDelegate> delegate; // ④声明一个代理属性

// cell加在数据
- (void)config:(JSONModelConfigGGoods *)model;

@end
