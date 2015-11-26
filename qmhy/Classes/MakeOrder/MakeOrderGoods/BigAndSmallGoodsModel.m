//
//  BigAndSmallGoodsModel.m
//  qmhy
//  货物模型
//  Created by mac on 15/9/4.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "BigAndSmallGoodsModel.h"

@implementation BigAndSmallGoodsModel

+ (NSMutableArray *)allBigAndSmallGoodsFakeData {
    
    BigAndSmallGoodsModel *smallName1 = [BigAndSmallGoodsModel new];
    smallName1.smailGoodsName = @"苹果";
    BigAndSmallGoodsModel *smallName2 = [BigAndSmallGoodsModel new];
    smallName2.smailGoodsName = @"西瓜";
    BigAndSmallGoodsModel *smallName3 = [BigAndSmallGoodsModel new];
    smallName3.smailGoodsName = @"土豆";
    BigAndSmallGoodsModel *smallName4 = [BigAndSmallGoodsModel new];
    smallName4.smailGoodsName = @"鸭梨";
    NSMutableArray *allBigAndSmallGoodsModel = [NSMutableArray arrayWithObjects:smallName1, smallName2, smallName3, smallName4, nil];
    
    return allBigAndSmallGoodsModel;
}

@end
