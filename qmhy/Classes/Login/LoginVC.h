//
//  WidgetsVC.h
//  qmhy
//  登录视图控制器
//  Created by wushuyu on 14-11-12.
//  Copyright (c) 2014年 wsy.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginVC;



//Widgets需要用到的代理
@protocol LoginVCDelegate <NSObject>
//LoginView专用
-(void)LoginVC:(LoginVC *)loginVC loginOK:(id)nilplaceholder;
@end





//======================  正式开始 =================================
@interface LoginVC : UIViewController

//一个falg，用于判断显示哪个view
@property (weak,nonatomic) NSString * whichViewToPresent;

//LoginView
-(void)showLoginView;//
@property (strong, nonatomic) IBOutlet UIControl *loginView;//视图本身
@property (weak, nonatomic) IBOutlet UITextField *textField_username;//用户名称文本框
@property (weak, nonatomic) IBOutlet UITextField *textField_password;//用户密码文本框
@property (weak, nonatomic) IBOutlet UILabel *label_detail;//登录结果详情说明
@property (weak,nonatomic) id<LoginVCDelegate> delegate;//委托
- (IBAction)login:(id)sender;//登录按钮点击事件
-(void)resignFirstResponder4textField:(id)sender;//离开编辑框事件
-(void)resignFirstResponder4LoginView;//视图触摸事件

- (IBAction)showRegister:(id)sender;//注册按钮点击事件


@end



