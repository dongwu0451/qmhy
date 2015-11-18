//
//  ConfigCShouhuoTVC.m
//  qmhy
//  配置常用收货联系人
//  Created by lingsbb on 15-8-19.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCShouhuoTVC.h"
#import "ShouhuoModel.h"
#import "ShouhuoData.h"
#import "AddShouhuoVC.h"



@interface ConfigCShouhuoTVC () <AddShouhuoVCDelegate>
//所有收货联系人
@property (strong, nonatomic) NSMutableArray *allShouhuo;
//选中的收货联系人
@property (strong, nonatomic) ShouhuoModel *selectedShouhuo;

@end

@implementation ConfigCShouhuoTVC

//接收对方代理  添加收货联系人界面传给本页面的数据
- (void)addShouhuoVC:(AddShouhuoVC *)hvc didInputReturnShouhuo:(ShouhuoModel *)shouhuo {
    [self.allShouhuo addObject:shouhuo];
}

//初始化 所有收货联系人
- (NSMutableArray *)allShouhuo
{
    if (!_allShouhuo) {
        ShouhuoData *ah = [[ShouhuoData alloc] init];
        NSLog(@"ConfigCShouhuoTVC allShouhuoData %@",ah.allShouhuo);
        _allShouhuo = ah.allShouhuo;
    }
    return _allShouhuo;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ShouhuoModel *h = self.allShouhuo[0];
    NSLog(@"ConfigCShouhuoTVC viewDidLoad %@",h.consigneeName);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//即将完成界面显示的事件
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //重新加载数据
    [self.tableView reloadData];
    //关闭
    self.navigationController.toolbarHidden = YES;
}

//组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allShouhuo.count;
}

//行高度 标准高度
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

//重新绘制单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SIDConfigCShouhuoTVC"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SIDConfigCShouhuoTVC"];
    }
    //获取模型
    ShouhuoModel *h = self.allShouhuo[indexPath.row];
    //给标准单元格赋值
//    NSString* string1;
//    string1= [NSString stringWithFormat:@"%@%@%@%@", h.consigneeName, @"(",h.area,@")" ];
    
    cell.textLabel.text = [[h.consigneeName stringByAppendingString:@"   "] stringByAppendingString:h.mobilePhoneNumber];
    cell.detailTextLabel.text = h.detailedAddress;
    return cell;

//    string = [NSString initWithFormat:@"%@,%@", string1, string2 ];
//    string = [string1 stringByAppendingString:string2];
//    string = [string stringByAppendingFormat:@"%@,%@",string1, string2];

}

//选中行事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ConfigCShouhuoTVC didSelectRowAtIndexPath%@",self.allShouhuo[indexPath.row]);
    //触发代理给下单页面
    [self.delegate selectedConfigCShouhuoTVC:self didInputReturnShouhuo:self.allShouhuo[indexPath.row]];
    //关闭
    [self.navigationController popViewControllerAnimated:YES];
}
//本页面是列表 点击右上角的添加按钮事件
- (IBAction)addShouhuo:(UIBarButtonItem *)sender {
    //从xib来数据
    AddShouhuoVC *hvc = [[AddShouhuoVC alloc] initWithNibName:@"AddShouhuoVC" bundle:nil];
    hvc.delegate = self;
    [self.navigationController pushViewController:hvc animated:YES];
    
    
}

// 删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除数组
    [self.allShouhuo removeObjectAtIndex:indexPath.row];
    //重新装载
    [self.tableView reloadData];
    
}

@end
