//
//  ConfigCGoodsTVC.m
//  qmhy
//  配置常用货物列表
//  Created by lingsbb on 15-8-18.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "ConfigCGoodsTVC.h"
#import "AddGoodsVC.h"

@interface ConfigCGoodsTVC () <AddGoodsVCDelegate>
@property (nonatomic, strong) NSMutableArray *goodsArrayM;
@end

@implementation ConfigCGoodsTVC

//初始化货物数组 造假数
- (NSMutableArray *)goodsArrayM {
    if (!_goodsArrayM) {
        _goodsArrayM = [BigAndSmallGoodsModel allBigAndSmallGoodsFakeData];
    }
    return _goodsArrayM;
}

//初始化
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现代理：添加货物界面返回的代理请求
-(void)addGoodsVC:(AddGoodsVC *)addVc endEditingReturnGoods:(BigAndSmallGoodsModel *)goodsModel {
    // 1. 将值保存到数组中
    [self.goodsArrayM addObject:goodsModel];
    // 2. 刷新表格
    [self.tableView reloadData];
    // 3. 如果有能够代理响应代理方法，则调用代理方法再次给代理传值
    if ([self.delegate respondsToSelector:@selector(configCGoodsTVC:didChooseGoods:)]) {
        //再次将 AddGoodsVC 传回的值传递给 ConfigCGoodsTVC 让其添加标签
        [self.delegate configCGoodsTVC:self didChooseGoods:goodsModel];
    }
}

//组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.goodsArrayM.count;
}

//重绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //设置单元格文本
    cell.textLabel.text = [self.goodsArrayM[indexPath.row] smailGoodsName];
    
    return cell;
}
//选中行事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选中一行，传递选中的值
    if ([self.delegate respondsToSelector:@selector(configCGoodsTVC:didChooseGoods:)]) {
        //触发代理给选择货物页面
        [self.delegate configCGoodsTVC:self didChooseGoods:self.goodsArrayM[indexPath.row]];
    }
    //关闭
    [self.navigationController popViewControllerAnimated:YES];
}

//设置本页面是添加货物界面的代理者  本页面 右上角添加按钮是连接线做的
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddGoodsVC *addVc = (AddGoodsVC *)segue.destinationViewController;
    addVc.delegate = self;
}
@end
