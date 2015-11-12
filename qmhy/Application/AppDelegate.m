//
//  AppDelegate.m
//  qmhy
//  应用程序入口
//
//  Created by lingsbb on 2015-08.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //service更多  wealth我的  home主页  discovery订单
    
    //支付宝思路：共有三个可选的rootVC loginVC、gestureVC、tabbarVC
    /*先判断是否已登陆.
     Q1:nsuserdefaults是否已登录？
        Q1true:显示gestureVC。设置完手势密码。显示tabbarVC
        Q1false：显示loginVC。loginVC输入正确了，再显示gestureVC。再显示tabbarVC
     */
    QConfig *config=[[QConfig alloc] init];
    NSString *isLogined=config.isLogined;
    //读取用户信息
    //BOOL isLogined=[[NSUserDefaults standardUserDefaults] boolForKey:@"key_isLogined"];
    if ([isLogined isEqualToString:@"1"] ) {//登录过了
        //NSLog(@"aaa");
        //NSLog(@"aaa%d",1);
        //[self showTabbarVC];
     }else{
        //WidgetsVC是一个库，可以创建很多不同的view，这里指使用
//        [self showWidgetsLoginVC];
         //config.isLogined=@"1";
         //[self showLoginVC];//
    }
    [self showLoginVC];
    
    
    //================================显示封面方法================================
    //刚进入的时候还没有view呢！
    [self.window addSubview:self.window.rootViewController.view];
    //设置splashVC，显示splashVC.view。不使用其他splashVC的功能
    self.splashViewController=[[UIViewController alloc]init];
    NSString * splashImageName=@"splash.jpg";//位于resources目录
    if(self.window.bounds.size.height>480){
        splashImageName=@"splashR4.jpg";
    }
    //设置封面页面的背景图片
    self.splashViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:splashImageName]];
    //把splashVC添加进去
    [self.window addSubview:self.splashViewController.view];
    //让splashimage显示2s，让用户看一眼得了。
    [self performSelector:@selector(splashAnimate:) withObject:@0.0 afterDelay:2.0];
    return YES; 
}

//显示封面动画
-(void) splashAnimate:(NSNumber *)alpha{
    //只能用UIViewAnimationOptionCurveEaseInOut和ViewAnimationOptionTransitionNone两种效果
    UIView * splashView=self.splashViewController.view;
    [UIView animateWithDuration:1.0 animations:^{
        splashView.transform=CGAffineTransformScale(splashView.transform, 1.5, 1.5);
        splashView.alpha=alpha.floatValue;
    } completion:^(BOOL finished) {
        //ARC通过赋值nil释放内存，动画中不能removeFromSuperview.
        [splashView removeFromSuperview];
        self.splashViewController=nil;
    }];
}
//==========================================================
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//==========================================================
//显示登录界面
-(void)showLoginVC{
    LoginVC * loginVC=[[LoginVC alloc]initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
    loginVC.delegate=self;
    loginVC.whichViewToPresent=@"loginView";
    self.window.rootViewController=loginVC;
}

//显示密码手势界面
-(void)showGestureVC{
    GesturePasswordController * passwordC=[[GesturePasswordController alloc]init];
    passwordC.delegate=self;
    self.window.rootViewController=passwordC;
}

//显示tabbar主页界面
-(void)showTabbarVC{
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RootTabBarController * tabVC=[mainsb instantiateInitialViewController];
//    tabVC.selectedIndex=2;
    self.window.rootViewController=tabVC;
}
//==========================================================
//实现委托loginOK    收到登录界面的事件委托
-(void)LoginVC:(LoginVC *)loginVC loginOK:(id)nilplaceholder{
    [self showTabbarVC];
     //showGestureVC];
}

//实现委托verifyOK  验证完手势密码进入tabbarVC
-(void)GesturePasswordController:(GesturePasswordController *)passController verifyOK:(id)nilplaceholder{
    NSLog(@"验证完手势密码进入tabbarVC");
    [self showTabbarVC];
}
//实现委托resetOK   设置完手势密码进入tabbarVC
-(void)GesturePasswordController:(GesturePasswordController *)passController resetOK:(id)nilplaceholder{
    NSLog(@"设置完手势密码进入tabbarVC2");
    [self showTabbarVC];
}
//==========================================================
//全局函数 弹出提示框
+(void)showAlert:(NSString *)str{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提醒信息" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
//字符串 是否空
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
