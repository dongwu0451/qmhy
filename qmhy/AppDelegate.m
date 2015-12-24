//
//  AppDelegate.m
//  qmhy
//  应用程序入口
//
//  Created by lingsbb on 2015-08.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLDictionary.h"
#import "APService.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
//#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//人人SDK头文件
//#import <RennSDK/RennSDK.h>

//GooglePlus SDK头文件
//#import <GooglePlus/GooglePlus.h>
//GooglePlus SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            //                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            //                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            //                            @(SSDKPlatformTypeRenren),
                            //                            @(SSDKPlatformTypeGooglePlus)]
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 //                 break;
                 //             case SSDKPlatformTypeRenren:
                 //                 [ShareSDKConnector connectRenren:[RennClient class]];
                 //                 break;
                 //             case SSDKPlatformTypeGooglePlus:
                 //                 [ShareSDKConnector connectGooglePlus:[GPPSignIn class]
                 //                                           shareClass:[GPPShare class]];
                 //                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 //                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                 //                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                 //                                         redirectUri:@"http://www.sharesdk.cn"
                 //                                            authType:SSDKAuthTypeBoth];
                 //                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx45b931c1ba45fde2"
                                       appSecret:@"78a596bfc1c91f16eec2eb9619a946c5"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1104764562"
                                      appKey:@"LOB9jxnrg8iIJZSD"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 //             case SSDKPlatformTypeRenren:
                 //                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                 //                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                 //                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                 //                                               authType:SSDKAuthTypeBoth];
                 //                 break;
                 //             case SSDKPlatformTypeGooglePlus:
                 //                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                 //                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                 //                                            redirectUri:@"http://localhost"
                 //                                               authType:SSDKAuthTypeBoth];
                 //                 break;
             default:
                 break;
         }
     }];    //service更多  wealth我的  home主页  discovery订单
    
    //支付宝思路：共有三个可选的rootVC loginVC、gestureVC、tabbarVC
    /*先判断是否已登陆.
     Q1:nsuserdefaults是否已登录？
     Q1true:显示gestureVC。设置完手势密码。显示tabbarVC
     Q1false：显示loginVC。loginVC输入正确了，再显示gestureVC。再显示tabbarVC
     */
    QConfig *config=[[QConfig alloc] init];
    NSLog(@"%@", config.uid);
    NSLog(@"%@", config.username);
    NSLog(@"%@", config.mem_id);
    NSString *isLogined=config.isLogined;
    //读取用户信息
    //BOOL isLogined=[[NSUserDefaults standardUserDefaults] boolForKey:@"key_isLogined"];
    if ([isLogined isEqualToString:@"1"] ) {//登录过了
        //NSLog(@"aaa");
        //NSLog(@"aaa%d",1);
        [self showTabbarVC];
    }else{
        //WidgetsVC是一个库，可以创建很多不同的view，这里指使用
        //        [self showWidgetsLoginVC];
        //config.isLogined=@"1";
        [self showLoginVC];//
    }
    //[self showLoginVC];
    
    
    
    
    
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    } else {
        //categories nil
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             
                                             
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#else
         //categories nil
         categories:nil];
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#endif
         // Required
         categories:nil];
    }
    [APService setupWithOption:launchOptions];
    
    [APService setTags:nil alias:config.mem_id callbackSelector:@selector(asdasdd) object:nil];
    
    return YES;
}

- (void)asdasdd {
    NSLog(@"asdsadas");
}

//- (void)tagsAliasCallback:(int)iResCode
//                    tags:(NSSet*)tags
//                   alias:(NSString*)alias
//{
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//显示封面动画
- (void) splashAnimate:(NSNumber *)alpha {
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
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//==========================================================
//显示登录界面
- (void)showLoginVC {
    LoginVC * loginVC=[[LoginVC alloc]initWithNibName:@"LoginVC" bundle:[NSBundle mainBundle]];
    loginVC.delegate=self;
    loginVC.whichViewToPresent=@"loginView";
    self.window.rootViewController = loginVC;
}

//显示tabbar主页界面
- (void)showTabbarVC {
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RootTabBarController * tabVC=[mainsb instantiateInitialViewController];
    //    tabVC.selectedIndex=2;
    self.window.rootViewController=tabVC;
}
//==========================================================
//实现委托loginOK    收到登录界面的事件委托
- (void)LoginVC:(LoginVC *)loginVC loginOK:(id)nilplaceholder {
    [self showTabbarVC];
    //showGestureVC];
}


//==========================================================
// 全局函数 弹出提示框
+ (void)showAlert:(NSString *)str {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提醒信息" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

// 字符串 是否空
+ (BOOL) isBlankString:(NSString *)string {
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
