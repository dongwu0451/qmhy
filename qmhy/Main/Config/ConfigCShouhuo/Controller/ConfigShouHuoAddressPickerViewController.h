//
//  ConfigShouHuoAddressPickerViewController.h
//  qmhy
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfigShouHuoAddressPickerViewControllerDelegate <NSObject>
@required
- (void)sureBtn:(NSString *)str andProvinceStr:(NSString *)provinceStr andCityStr:(NSString *)cityStr andDistrictStr:(NSString *)districtStr andAddressCode:(NSString *)addressCode; // 把选择的值穿过去的方法

@end

@interface ConfigShouHuoAddressPickerViewController : UIViewController

@property (nonatomic, assign)id<ConfigShouHuoAddressPickerViewControllerDelegate>delegate;


@end
