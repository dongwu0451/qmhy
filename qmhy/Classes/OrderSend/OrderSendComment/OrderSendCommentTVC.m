//
//  OrderSendCommentTVC.m
//  qmhy
//  发件订单 待评价列表
//  Created by lingsbb on 15-8-22.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "OrderSendCommentTVC.h"

@interface OrderSendCommentTVC ()

@end

@implementation OrderSendCommentTVC

//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

//绘制Cell 发件订单 待评价列表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置cellid
    NSString * cellid=@"id_subTitle";
    //获取cellid
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    //设置title
    NSString *title=@"aaa";
    [cell.textLabel setText:title];
    //判断字符串是否相等
    if([title compare:@"aaa"]==NSOrderedSame)
        [cell.detailTextLabel setText:@"12345678"];
    else
        [cell.detailTextLabel setText:@"999"];
    
    return cell;
    
}

@end
