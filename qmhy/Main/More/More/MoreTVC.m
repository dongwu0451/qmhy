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

@interface MoreTVC ()
//存储plist数组
@property (nonatomic,strong) NSArray * servicesPlistArray;
//打电话
@property (strong, nonatomic) UIWebView *webview;

@end

@implementation MoreTVC

@synthesize webview;//自己增加的webview引用 后台的 没有界面的

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载plist
    NSString * s=[[NSBundle mainBundle] pathForResource:@"More.bundle/Services" ofType:@"plist"];
    if (s) {
        self.servicesPlistArray=[NSArray arrayWithContentsOfFile:s];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//分组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//组内的行数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicesPlistArray.count;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53.;
}

//绘制单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //有两个id ，一个 id_subTitle, 一个 id_basic. Diction的key有iconFileName title detail
    //设置cellid
    NSDictionary * d=self.servicesPlistArray[indexPath.row];
    NSString * detail=d[@"detail"];
    NSString * cellid;
    if([detail compare:@""]==NSOrderedSame){
        cellid=@"id_basic";
    }else{
        cellid=@"id_subTitle";
    }
    //获取cellid
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    //设置图片
    NSString * imagePath=[NSString stringWithFormat:@"More.bundle/%@",d[@"iconFileName"]];
    cell.imageView.image=[UIImage imageNamed:imagePath];
    //设置title
    NSString *title=d[@"title"];
    [cell.textLabel setText:title];
    //判断字符串是否相等
    if([title compare:@"我的邀请码"]==NSOrderedSame)
        [cell.detailTextLabel setText:@"12345678"];//邀请码写死
    else
        [cell.detailTextLabel setText:d[@"detail"]];
    
    return cell;
    
}


//行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath:%d",indexPath.row);
    NSInteger i=indexPath.row;
    if (i==0){
        [self showDialog];
    }
    if (i==1){//客服热线
        NSString *phoneNum=@"4000560013";
        NSURL *phoneURL=[NSURL URLWithString:[ NSString stringWithFormat:@"tel:%@",phoneNum ]];
        if (!webview){
            NSLog(@"jjjjjjj");
            webview=[[UIWebView alloc] initWithFrame:CGRectZero];
        }
        [webview loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    if (i==2){//帮助
        [self performSegueWithIdentifier:@"showDetailHelp" sender:nil];// 自带连接线
        //NSLog(@"showAboutDetail AAAAAAA");
    }
    if (i==3){//用户协议
        [self performSegueWithIdentifier:@"showDetailUserProtocol" sender:nil];// 自带连接线
        NSLog(@"showDetailUserProtocol 33");
    }
    if (i==4){//软件版本
        //[self onCheckVersion];
    }
    if (i==5){//关于
        [self performSegueWithIdentifier:@"showDetailAbout" sender:nil];// 自带连接线
        //NSLog(@"showAboutDetail AAAAAAA");
    }
    if (i==6){//价格表
        [self performSegueWithIdentifier:@"showDetailPriceTable" sender:nil];// 自带连接线
        NSLog(@"showDetailPriceTable 666");
    }
}

//准备前往下一个界面跳转之前发生的处理
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue aaaaaaa");
    //显示关于界面
    if([segue.identifier isEqualToString:@"showDetailAbout"]){
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
    if([segue.identifier isEqualToString:@"showDetailHelp"]){
        HelpVC *helpVC= segue.destinationViewController;
        helpVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
    if([segue.identifier isEqualToString:@"showDetailPriceTable"]){
        PriceTableVC *priceTableVC= segue.destinationViewController;
        priceTableVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
    if([segue.identifier isEqualToString:@"showDetailUserProtocol"]){
        UserProtocolVC *userProtocolVC= segue.destinationViewController;
        userProtocolVC.hidesBottomBarWhenPushed = YES;//隐藏底部导航栏
    }
}

//显示邀请码
-(void)showDialog
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:@"您的邀请码是12345678"delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
}

//检查更新
-(void)onCheckVersion
{
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
        }
        else
        {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本"delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
            alert.tag= 10001;
            [alert show];
        }
    }
}


//弹出窗口的回调函数 前往appstore更新
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==10000) {
        if(buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

@end
