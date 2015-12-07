//
//  MoreTVC.m
//  qmhy
//  更多 视图控制器
//  Created by lingsbb on 15-8-15.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "MoreTVC.h"
#import "AboutTVC.h"
#import "HelpVC.h"
#import "PriceTableVC.h"
#import "UserProtocolVC.h"
#import "QConfig.h"
#import "AppDelegate.h"
#import "LoginVC.h"

@interface MoreTVC () <UIAlertViewDelegate>

@property (nonatomic,strong) NSArray * servicesPlistArray; //存储plist数组

@property (strong, nonatomic) UIWebView *webview; //打电话

@end

@implementation MoreTVC

@synthesize webview; //自己增加的webview引用 后台的 没有界面的

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载plist
    NSString * s=[[NSBundle mainBundle] pathForResource:@"More.bundle/Services" ofType:@"plist"];
    if (s) {
        self.servicesPlistArray=[NSArray arrayWithContentsOfFile:s];
    }
    [self getStringsdsfgfdsgd];
}

//组内的行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.servicesPlistArray.count;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53.;
}

//绘制单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //有两个id ，一个 id_subTitle, 一个 id_basic. Diction的key有iconFileName title detail
    //设置cellid
    NSDictionary * d=self.servicesPlistArray[indexPath.row];
    NSString * detail=d[@"detail"];
    NSString * cellid;
    if ([detail compare:@""]==NSOrderedSame) {
        cellid=@"id_basic";
    } else {
        cellid=@"id_subTitle";
    }
    //获取cellid
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    //设置图片
    NSString * imagePath = [NSString stringWithFormat:@"More.bundle/%@",d[@"iconFileName"]];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    //设置title
    NSString *title = d[@"title"];
    [cell.textLabel setText:title];
    //判断字符串是否相等
    if([title compare:@"我的邀请码"]==NSOrderedSame) {
        [cell.detailTextLabel setText:[self getStringsdsfgfdsgd]];//邀请码写死
    } else {
        [cell.detailTextLabel setText:d[@"detail"]];
    }
    return cell;
}

//行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath:%ld", indexPath.row);
    NSInteger i=indexPath.row;
    if (i == 0) {
        [self showDialog];
    }
    if ( i==1 ) { //客服热线
        //        NSString *phoneNum=@"4000560013";
        
        //        NSURL *phoneURL=[NSURL URLWithString:[ NSString stringWithFormat:@"tel:%@",phoneNum ]];
        //        if (!webview){
        //            NSLog(@"jjjjjjj");
        //            webview=[[UIWebView alloc] initWithFrame:CGRectZero];
        //        }
        //        [webview loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        //        [[UIApplication sharedApplication] openURL:phoneURL];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要拨打电话吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 123434;
        [alert show];
    }
    if (i == 2) {//帮助
        [self performSegueWithIdentifier:@"showDetailHelp" sender:nil];// 自带连接线
    }
    if (i == 3){//用户协议
        [self performSegueWithIdentifier:@"showDetailUserProtocol" sender:nil];// 自带连接线
    }
    if (i == 4){//软件版本
        //[self onCheckVersion];
    }
    if (i == 5){//关于
        [self performSegueWithIdentifier:@"showDetailAbout" sender:nil];// 自带连接线
    }
    if (i == 6){//价格表
        [self performSegueWithIdentifier:@"showDetailPriceTable" sender:nil];// 自带连接线
    }
    if (i == 7) {//注销
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"确定要退出吗？"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 123435;
        [alert show];
    }
}


//准备前往下一个界面跳转之前发生的处理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //显示关于界面
    if ([segue.identifier isEqualToString:@"showDetailAbout"]) {
        AboutTVC *aboutTVC= segue.destinationViewController;
        aboutTVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
        aboutTVC.navigationItem.title=@"a";
        aboutTVC.newtitle=@"关于";
        //[self performSegueWithIdentifier:@"showAboutDetail" sender:nil];
        
        
        //        NSIndexPath *indexPath = [self.theTableView indexPathForSelectedRow];
        //        RecipeDetailViewController *destViewController = segue.destinationViewController;
        //        destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
    }
    
    //===============隐藏底部导航栏===============
    if ([segue.identifier isEqualToString:@"showDetailHelp"]) {
        HelpVC *helpVC= segue.destinationViewController;
        helpVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
    if ([segue.identifier isEqualToString:@"showDetailPriceTable"]) {
        PriceTableVC *priceTableVC= segue.destinationViewController;
        priceTableVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
    if ([segue.identifier isEqualToString:@"showDetailUserProtocol"]) {
        UserProtocolVC *userProtocolVC= segue.destinationViewController;
        userProtocolVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
}

//显示邀请码
- (void)showDialog {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:[@"您的邀请码是:" stringByAppendingString :[self getStringsdsfgfdsgd]]delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

//检查更新
-(void)onCheckVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSString *URL = @"http://itunes.apple.com/lookup?id=你的应用程序的ID";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[results dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    if([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        if(![lastVersion isEqualToString:currentVersion]) {
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？"delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            alert.tag= 10000;
            [alert show];//弹出窗口的回调函数 前往appstore更新
        } else {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本"delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
            alert.tag= 10001;
            [alert show];
        }
    }
}

//弹出窗口的回调函数 前往appstore更新
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==10000) {
        if(buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
    if (alertView.tag == 123434) {
        if (buttonIndex == 1) {
#warning 这个事测试手机号 到时候得改
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15546680574"]];
        } else {
            
        }
    }
    if (alertView.tag == 123435) {
        if (buttonIndex == 1) {
            NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
            [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
            [([UIApplication sharedApplication].delegate) performSelector:@selector(showLoginVC)];
            
            //        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
            //        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
            //        for(NSString* key in [dictionary allKeys]){
            //            [userDefatluts removeObjectForKey:key];
            //            [userDefatluts synchronize];
            //        }
            //        LoginVC *tvc = [[LoginVC alloc] init];
            //        [self presentViewController:tvc animated:YES completion:^{
            //
            //        }];
            //         [self.delegate LoginVC:self loginOK:nil];//设置回调  向来源触发事件委托
            //        UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            //        RootTabBarController * tabVC=[mainsb instantiateInitialViewController];
            //        //    tabVC.selectedIndex=2;
            //        self.window.rootViewController=tabVC;
        } else {
            
        }
    }
}

/**
 * zqx是否为正确的 纯数字字符串
 * @param params
 * @return
 */
- (BOOL)isTrueNums :(NSString*)mobile{
    NSString *matches = @"^[0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matches];
    int isMatch = [phoneTest evaluateWithObject:mobile];
    if (isMatch == 1 && mobile.length == 6) {
        return 1;
    }
    return 0;
}

/**
 * zqx根据数字字符串得到对应的字母字符串
 * @param params 6位0-9数字字符串
 * @return
 */
- (NSString *)getStringsdsfgfdsgd {
    NSArray *array = @[@"z", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i"];
    NSMutableString *finalString = @"";
    QConfig *config = [[QConfig alloc] init];
    if (config.mem_id.length >= 11) {
        NSString *six = [config.mem_id substringFromIndex:config.mem_id.length-6];
        if ([self isTrueNums:six] == 1) {
            for (int i = 0; i < six.length; i++) {
                int hehe = [[six substringWithRange:NSMakeRange(i, 1)] intValue];
                finalString = [finalString stringByAppendingString:array[hehe]];
            }
        } else {
            NSLog(@"格式粗欧文");
        }
    } else {
        finalString = @"无";
    }
    
    return finalString;
}

@end
