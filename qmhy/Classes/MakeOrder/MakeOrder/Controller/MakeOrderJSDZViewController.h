//
//  MakeOrderJSDZViewController.h
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MakeOrderJSDZViewController;
@protocol MakeOrderJSDZViewControllerDelegate <NSObject>

-(void)makeOrderJSDZViewController:(MakeOrderJSDZViewController *)bvc didInputReturnMessage:(NSString *)msg;

@end


@interface MakeOrderJSDZViewController : UIViewController
@property (nonatomic, copy) NSString *daishoukuan;


@property (nonatomic, assign)id<MakeOrderJSDZViewControllerDelegate>delegate;

@end
