//
//  BigAndSmallGoodsModel.h
//  qmhy
//  货物模型
//  Created by mac on 15/9/4.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigAndSmallGoodsModel : NSObject
@property (strong, nonatomic) NSString *bigCategory; // 大物件标记
@property (strong, nonatomic) NSString *bigName; //大物件没有名称 也不知道为什么
@property (strong, nonatomic) NSString *bigLong; // 大物件长度
@property (strong, nonatomic) NSString *bigWide; // 大物件宽度
@property (strong, nonatomic) NSString *bigHigh; // 大物件高度
@property (strong, nonatomic) NSString *bigHeavy; // 打物件重量
@property (assign, nonatomic) BOOL bigReceipt; // 大物件件是否回执
@property (strong, nonatomic) NSString *bigProtectionMoney; //大件货物保护费
@property (strong, nonatomic) NSString *bigDeliveryCharges; // 大物件送货费
@property (strong, nonatomic) NSString *bigCollectionCharges; // 大物件代收费

@property (strong, nonatomic) NSString *smailGoodsName; // 小件货物名称
@property (strong, nonatomic) NSString *smailNumber; // 小件件数
@property (assign, nonatomic) BOOL smailReceipt; // 小件是否回执
@property (strong, nonatomic) NSString *smailValuationFee; // 小件保价费
@property (strong, nonatomic) NSString *smailDeliveryCharges; // 小件送货费
@property (strong, nonatomic) NSString *smailCollectionCharges; // 小件代收费
@property (strong, nonatomic) NSString *smailCategory;





+ (NSMutableArray *)allBigAndSmallGoodsFakeData;

@end
