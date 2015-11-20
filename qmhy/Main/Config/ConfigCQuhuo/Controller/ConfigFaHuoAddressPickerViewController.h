//
//  ConfigFaHuoAddressPickerViewController.h
//  qmhy
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ConfigFaHuoAddressPickerViewControllerDelegate<NSObject>

- (void)sureBtn:(NSString *)str andProvinceStr:(NSString *)provinceStr andCityStr:(NSString *)cityStr andDistrictStr:(NSString *)districtStr andAddressCode:(NSString *)addressCode; // 把选择的值穿过去的方法

@end


@interface ConfigFaHuoAddressPickerViewController : UIViewController

@property (nonatomic, assign)id<ConfigFaHuoAddressPickerViewControllerDelegate>delegate;

@end
