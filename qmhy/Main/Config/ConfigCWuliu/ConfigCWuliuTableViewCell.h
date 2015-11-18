//
//  ConfigCWuliuTableViewCell.h
//  qmhy
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>



@class JSONModelConfigCWuLiu;

@class ConfigCWuliuTableViewCell; // ①声明 类名（代理才能识别这个类，不然会报错）
@protocol ConfigCWuliuTableViewCellDelegate <NSObject> // ②写协议，协议名在类名后加上delegate

// ③协议方法，以类名开头，去掉前缀，后面跟上传参likeBtn
- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didClickBianJiLikeBtn:(UIButton *)likeBtn;
- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didClickShanChuLikeBtn:(UIButton *)likeBtn;

//- (void)configCWuliuTableViewCell:(ConfigCWuliuTableViewCell *)cell didRemoveJSONModelConfigCWuLiu:(JSONModelConfigCWuLiu *)model  andClickShanChuLikeBtn:(UIButton *)likeBtn;

@end

@interface ConfigCWuliuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *wuLiuNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *bianJiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shanChuBtn;

@property (strong, nonatomic) JSONModelConfigCWuLiu *jsonModelConfigCWuLiu;

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;



@property (nonatomic, weak) id<ConfigCWuliuTableViewCellDelegate> delegate; // ④声明一个代理属性

// cell加在数据
- (void)config:(JSONModelConfigCWuLiu *)model;


@end
