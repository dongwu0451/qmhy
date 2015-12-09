//
//  MakeOrderJSDZViewController.h
//  qmhy
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MakeOrderJSDZViewControllerDelegate <NSObject>

- (void)asd;

@end


@interface MakeOrderJSDZViewController : UIViewController

@property (nonatomic, assign)id<MakeOrderJSDZViewControllerDelegate>delegate;

@end
