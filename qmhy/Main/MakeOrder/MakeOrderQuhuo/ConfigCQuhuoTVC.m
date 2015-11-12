//
//  ConfigCQuhuoTVC.m
//  qmhy
//  配置常用取货信息 列表界面
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCQuhuoTVC.h"
#import "AddQuhuoVC.h"
#import "QuhuoModel.h"
#import "MJExtension.h"
@interface ConfigCQuhuoTVC () <AddQuhuoVCDelegate>

@property (strong, nonatomic) NSMutableArray *quhuoModels; // 存对象的数组对象 给单元格用
@property (strong, nonatomic) NSMutableArray *dataS; //  存字典的数组 PLIST


@end

@implementation ConfigCQuhuoTVC

// 初始化
-(NSMutableArray *)dataS
{
    if (!_dataS) {
        _dataS =[NSMutableArray array];
    }
    return _dataS;
}
// 初始化
- (NSMutableArray *)quhuoModels
{
    if (!_quhuoModels) {
        _quhuoModels =[NSMutableArray array];
    }
    return _quhuoModels;
}


// 视图将要显示的时候会调用此方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    self.navigationController.toolbarHidden = YES;//隐藏下面toolbar
}


// 本页面是列表 点击右上角的添加常用取货信息按钮 添加取货信息到MakeOrderTVC 跳转到添加取货页面
- (IBAction)addQuhuoMessage:(UIBarButtonItem *)sender {
    //从xib来数据
    AddQuhuoVC *qhvc = [[AddQuhuoVC alloc] initWithNibName:@"AddQuhuoVC" bundle:nil];
    qhvc.delegate = self;//********必须要有这句话********  本类实现代理
    [self.navigationController pushViewController:qhvc animated:YES];//跳转到添加取货页面
}

//初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取绝对路径的
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //你要操作的路径
    NSString *path=[paths    objectAtIndex:0];
    //拼接路径 并创建plist文件
    NSString *filename=[path stringByAppendingPathComponent:@"quhuoModel.plist"];   //获取路径
    NSLog(@"%@",filename);
    // 从plist文件中读取数据
    self.dataS = [NSMutableArray arrayWithContentsOfFile:filename];
    // 将字典转化为对象存入到数组中
    self.quhuoModels = [[QuhuoModel objectArrayWithKeyValuesArray:self.dataS] mutableCopy];
}

// 代理传值 收到AddQuhuoVC来的数据
- (void)AddQuhuoVC:(AddQuhuoVC *)hvc didInputReturnQuhuo:(QuhuoModel *)quhuoModel {
    // 创建一个字典，把要添加的对象转化为字典
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"quhuoName"] =quhuoModel.quhuoName;
    dict[@"quhuoAddress"] =quhuoModel.quhuoAddress;
    dict[@"quhuoTelephone"] =quhuoModel.quhuoTelephone;
    // 获得plist文件路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"quhuoModel.plist"];
    // 将字典加入到plist数组中
    [self.dataS addObject:dict];
    // 将这个数组写如到plist
    [self.dataS writeToFile:filename atomically:YES];
    // 将对象添加到对象数组中
    [self.quhuoModels addObject:quhuoModel];
}


//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.quhuoModels.count;
}

//重绘制 cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //从故事取视图
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SIDConfigCQuhuoTVC"];//不自己带连接线 从故事取
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SIDConfigCQuhuoTVC"];
    }
    
    //从数组提取对象 赋指
    QuhuoModel *quhuomodel =self.quhuoModels[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@    %@",quhuomodel.quhuoName,quhuomodel.quhuoTelephone];
    cell.detailTextLabel.text =quhuomodel.quhuoAddress;
    
    return cell;
}

// 选中行事件处理函数 返回上级界面 选中之后返回MakeOrderTVC中的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate selectedConfigCQuhuoTVC:self didInputReturnQuhuoModel:self.quhuoModels[indexPath.row]];//调用代理 给最开始的下单第一个页面 列表页面
    [self.navigationController popViewControllerAnimated:YES];//关闭
}


// 删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除数组
    [self.dataS removeObjectAtIndex:indexPath.row];
    [self.quhuoModels removeObjectAtIndex:indexPath.row];
    //取plist
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"quhuoModel.plist"];
    //将删除完的数组写入plist
    [self.dataS writeToFile:filename atomically:YES];
    //重新装载
    [self.tableView reloadData];

}

@end
