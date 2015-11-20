//
//  ConfigFHAPViewController.h
//  qmhy
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfigFHAPViewControllerDelegate <NSObject>

- (void)sureBtn:(NSString *)str andProvinceStr:(NSString *)provinceStr andCityStr:(NSString *)cityStr andDistrictStr:(NSString *)districtStr andAddressCode:(NSString *)addressCode; // 把选择的值穿过去的方法


@end


@interface ConfigFHAPViewController : UIViewController

@property (nonatomic, assign)id<ConfigFHAPViewControllerDelegate>delegate;


@end
