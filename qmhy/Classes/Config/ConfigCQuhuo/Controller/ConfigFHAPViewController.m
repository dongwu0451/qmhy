//
//  ConfigFHAPViewController.m
//  qmhy
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigFHAPViewController.h"
#import "XMLDictionary.h"


#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2


@interface ConfigFHAPViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;

@property (nonatomic, strong) NSDictionary *areaDic;
@property (nonatomic, strong) NSMutableArray *province;
@property (nonatomic, strong) NSMutableArray *city;
@property (nonatomic, strong) NSMutableArray *district;
@property (nonatomic, copy) NSString *selectedProvince;

@property (nonatomic, strong) NSMutableArray *lanlog;
@property (nonatomic, strong) NSDictionary *xmlDoc;

@end

@implementation ConfigFHAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"province_data"ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    _xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
    
    
    
    [self initprovince];
    [self initCity:0];
    [self initdistrict:_city[0]];
       _picker.backgroundColor = [UIColor whiteColor];
    _picker.dataSource = self;
    _picker.delegate = self;
    _picker.showsSelectionIndicator = YES;
    [_picker selectRow: 0 inComponent: 0 animated: YES];
    _selectedProvince = [_province objectAtIndex: 0];


    
}

//初始化省份
-(void)initprovince {
    _province = [[NSMutableArray alloc] init];
    NSArray *keyArr = [_xmlDoc allKeys];
    //取出总的城市列表
    NSArray *pri = [_xmlDoc valueForKey:keyArr[1]];
    int index = (int)pri.count;
    for (int i = 0; i<index; i++)
    {
        NSDictionary *dict = pri[i];
        //添加省份
        [_province addObject:[dict valueForKey:@"_name"]];
    }
    //NSLog(@"_province = %@",_province);
}

//根据省份初始化市
-(void)initCity:(int)indexTag {
    _city = [[NSMutableArray alloc] init];
    NSArray *keyArr = [_xmlDoc allKeys];
    //取出总的城市列表
    NSArray *pri = [_xmlDoc valueForKey:keyArr[1]];
    int index = (int)pri.count;
    for (int i = 0; i<index; i++)
    {
        NSDictionary *dict = pri[i];
        if (i == indexTag)
        {
            NSDictionary *cityDict = [dict valueForKey:@"city"];
            if (cityDict.count > 2)
            {
                for (NSDictionary *result in cityDict)
                {
                    [_city addObject:[result valueForKey:@"_name"]];
                }
            }else
            {
                [_city addObject:[cityDict valueForKey:@"_name"]];
            }
        }
    }
}

//根据市名查区和经纬度
-(void)initdistrict:(NSString *)cityName {
    _district = [[NSMutableArray alloc] init];
    _lanlog = [[NSMutableArray alloc] init];
    NSArray *keyArr = [_xmlDoc allKeys];
    //取出总的城市列表
    NSArray *pri = [_xmlDoc valueForKey:keyArr[1]];
    int index = (int)pri.count;
    for (int i = 0; i<index; i++)
    {
        NSDictionary *dict = pri[i];
        //取市区
        NSDictionary *cityDict = [dict valueForKey:@"city"];
        //当十的个数超过2个时  要对原数据进行拆分
        if (cityDict.count > 2)
        {
            //遍历元字典
            for (NSDictionary *result in cityDict)
            {
                //判断当前市是否是我们所选择的
                if ([[result valueForKey:@"_name"] isEqual:cityName])
                {
                    NSArray *diqu = [result valueForKey:@"district"];
                    for (int x = 0; x<diqu.count; x++)
                    {
                        NSDictionary *dict2 = diqu[x];
                        if (dict2.count > 2)
                        {
                            if ([[result valueForKey:@"_name"] isEqual:cityName])
                            {
                                for (NSDictionary *result22 in dict2)
                                {
                                    [_district addObject:[result22 valueForKey:@"_name"]];
                                    [_lanlog addObject:[result22 valueForKey:@"_lanlog"]];
                                }
                            }
                            
                        }else
                        {
                            [_district addObject:[dict2 valueForKey:@"_name"]];
                            [_lanlog addObject:[dict2 valueForKey:@"_lanlog"]];
                        }
                    }
                    
                }
                
            }
        }else
        {
            if ([[cityDict valueForKey:@"_name"] isEqual:cityName])
            {
                NSArray *diqu = [cityDict valueForKey:@"district"];
                for (int x = 0; x<diqu.count; x++)
                {
                    NSDictionary *dict2 = diqu[x];
                    if (dict2.count > 2)
                    {
                        for (NSDictionary *result in dict2)
                        {
                            [_district addObject:[result valueForKey:@"_name"]];
                            [_lanlog addObject:[result valueForKey:@"_lanlog"]];
                            
                        }
                    }else
                    {
                        [_district addObject:[dict2 valueForKey:@"_name"]];
                        [_lanlog addObject:[dict2 valueForKey:@"_lanlog"]];
                    }
                }
            }
            
        }
        
    }
}



- (IBAction)yesBtnClick:(UIButton *)sender {
    NSInteger provinceIndex = [_picker selectedRowInComponent: PROVINCE_COMPONENT];
    NSInteger cityIndex = [_picker selectedRowInComponent: CITY_COMPONENT];
    NSInteger districtIndex = [_picker selectedRowInComponent: DISTRICT_COMPONENT];
    
    NSString *provinceStr = [_province objectAtIndex: provinceIndex];
    NSString *cityStr = [_city objectAtIndex: cityIndex];
    NSString *districtStr = [_district objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }

    NSString *showMsg = [NSString stringWithFormat: @"%@,%@,%@", provinceStr, cityStr, districtStr];
    NSLog(@"%@", showMsg);
         NSLog(@"jingweidu = %@",_lanlog[districtIndex]);
    [self.delegate sureBtn:showMsg andProvinceStr:provinceStr andCityStr:cityStr andDistrictStr:districtStr andAddressCode:_lanlog[districtIndex]];
    //    [self.delegate sureBtn:showMsg];
    
    [self.view removeFromSuperview];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return [_province count];
    }
    else if (component == CITY_COMPONENT) {
        return [_city count];
    }
    else {
        return [_district count];
    }
}

#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return [_province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [_city objectAtIndex: row];
    }
    else {
        return [_district objectAtIndex: row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT)
    {
        [self initCity:(int)row];
        [self initdistrict:_city[0]];
        [_picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [_picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_picker reloadComponent: CITY_COMPONENT];
        [_picker reloadComponent: DISTRICT_COMPONENT];
        
        
    }
    else if (component == CITY_COMPONENT) {
        [self initdistrict:_city[row]];
        [_picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [_picker reloadComponent: DISTRICT_COMPONENT];
    }
    //NSLog(@"_district = %@",_district);

    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [_province objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [_city objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = UITextAlignmentCenter;
        myView.text = [_district objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}


@end
