//
//  ConfigShouHuoAddressPickerViewController.m
//  qmhy
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigShouHuoAddressPickerViewController.h"
#import "AddConfigCShouhuoViewController.h"
#import "XMLDictionary.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2


@interface ConfigShouHuoAddressPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *yesBtn;

@property (nonatomic, strong) NSDictionary *areaDic;
@property (nonatomic, strong) NSMutableArray *province;
@property (nonatomic, strong) NSMutableArray *city;
@property (nonatomic, strong) NSMutableArray *district;
@property (nonatomic, strong) NSMutableArray *lanlog;
@property (nonatomic, strong) NSDictionary *xmlDoc;
@property (nonatomic, copy) NSString *selectedProvince;

@end

@implementation ConfigShouHuoAddressPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"province_data"ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    _xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
   
    
    
    [self initprovince];
    [self initCity:0];
    [self initdistrict:_city[0]];
    //[self initData:_xmlDoc indexTag:0 name:@""];
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
//    _areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //NSLog(@"_areaDic = %@",_areaDic);
    //_areaDic = xmlDoc;
    
//    NSArray *components = [_areaDic allKeys];
//    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
//        
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    }];
//    
//    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
//    for (int i=0; i<[sortedArray count]; i++) {
//        NSString *index = [sortedArray objectAtIndex:i];
//        NSArray *tmp = [[_areaDic objectForKey: index] allKeys];
//        [provinceTmp addObject: [tmp objectAtIndex:0]];
//    }
//    _province = [[NSArray alloc] initWithArray: provinceTmp];
//    NSString *index = [sortedArray objectAtIndex:0];
//    NSString *selected = [_province objectAtIndex:0];
//    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[_areaDic objectForKey:index]objectForKey:selected]];
//    
//    NSArray *cityArray = [dic allKeys];
//    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
//    _city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
//    
//    
    //NSString *selectedCity = [_city objectAtIndex: 0];
    //_district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.dataSource = self;
    _picker.delegate = self;
    _picker.showsSelectionIndicator = YES;
    [_picker selectRow: 0 inComponent: 0 animated: YES];
    _selectedProvince = [_province objectAtIndex: 0];
//
     //NSLog(@"_province = %@, CITY = %@ DIC = %@ lan = %@",_province,_city,_district, _lanlog);

}

//初始化省份
-(void)initprovince
{
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
-(void)initCity:(int)indexTag
{
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
