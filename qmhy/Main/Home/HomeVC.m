//
//  HomeVC.m
//  qmhy
//  主页视图控制器
//
//  Created by lingsbb on 15-08-12.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "HomeVC.h"
#import "ConfigCommonTVC.h"//配置 视图控制器
#import "NotifyTVC.h"//我的消息 视图控制器
#import "OrderGetTVC.h"//我的取件 视图控制器
#import "YqTVC.h"//邀请 视图控制器
#import "OrderSendQueryTVC.h"//我的发件 视图控制器  （发件查询）
#import "JSONModelLogin.h"//登录实体
#import "AFNetworkTool.h"//httppost类
#import "MJExtension.h"//JSON与模型转换类

@interface HomeVC ()

//左上角图片
@property (weak, nonatomic) IBOutlet UIButton *topleftImageButton;
//右上角图片
@property (weak, nonatomic) IBOutlet UIButton *toprightImageButton;
//临时字典 装载titles iconPaths
@property (strong,nonatomic) NSDictionary * plistRootDictionary;
//里面菜单按钮的标题和图片
@property (strong,nonatomic) NSMutableArray * titles,*iconPaths;
//右上角按钮
@property (strong,nonatomic) UIViewController * billVC;
-(void)logSubviews:(NSArray *)subviews tabnum:(int)tabnum;
//实现打电话
@property (strong, nonatomic) UIWebView *webview;
//bill_click进去之后里面的右上角按钮回调
//-(void)noDefinitionPopup:(id)sender;
//本界面有上角
- (IBAction)bill_click:(UIBarButtonItem *)sender;

@end


@implementation HomeVC

@synthesize webview;//自己增加的webview引用 后台的 没有界面的 为了打电话用

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置分割线,上面有一个分割线，下面的tabbar还要是白色的
    UIView * spliter=[[UIView alloc]init];
    spliter.backgroundColor=[UIColor blackColor];
    spliter.frame=CGRectMake(0, 0, 320, 100);
    [self.view insertSubview:spliter atIndex:0];
    
    /*
    // 设置左上角的按钮图片
    NSString * imagePath=@"Home.bundle/ap_home_top_icon_scan_new";
    NSString * highlightImagePath=[NSString stringWithFormat:@"%@_highlight",imagePath];
    [self.topleftImageButton setImage:[UIImage imageNamed:imagePath]  forState:UIControlStateNormal];
    [self.topleftImageButton setImage:[UIImage imageNamed:highlightImagePath]  forState:UIControlStateHighlighted];
    
    
    // 设置右上角的按钮图片
    imagePath=@"Home.bundle/ap_home_top_icon_pay_new";
    highlightImagePath=[NSString stringWithFormat:@"%@_highlight",imagePath];
    [self.toprightImageButton setImage:[UIImage imageNamed:imagePath]  forState:UIControlStateNormal];
    [self.toprightImageButton setImage:[UIImage imageNamed:highlightImagePath]  forState:UIControlStateHighlighted];
    */
    
    //加载plist文件 将该文件内容key value分别送给titles  iconPaths
    NSString * s=[[NSBundle mainBundle] pathForResource:@"HomeIcons.bundle/HomeIcons" ofType:@"plist"];
    if (s) {
        self.plistRootDictionary=[NSDictionary dictionaryWithContentsOfFile:s];
    }
    id key;
    self.titles= [[NSMutableArray alloc]init];
    self.iconPaths= [[NSMutableArray alloc]init];
    
    for (key in self.plistRootDictionary) {
        [self.titles addObject:key];
        [self.iconPaths addObject: [self.plistRootDictionary objectForKey:key]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logSubviews:(NSArray *)subviews tabnum:(int)tabnum{
    UIView * i;
    //设置tabstring
    NSMutableString * tabstring=[NSMutableString stringWithString:@""];
    for(int j=1;j<=tabnum;j++){
        [tabstring appendFormat:@"+"];
    }
    //递归遍历
    for (i in subviews) {
        if (i.subviews.count>0) {//还有subviews
            NSLog(@"%@Have %d subvies.%@ ",tabstring,i.subviews.count,i);
            [self logSubviews:i.subviews tabnum:(tabnum+1)];
        }else{//当前是终端view
            NSLog(@"%@ %@",tabstring,i);
        }
    }
}

//分组数量 基本没用
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//行数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.;
}

//头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//脚高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

//行选择事件  对于本页面根本没有用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"didSelectRowAtIndexPath:%d",indexPath.row);
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    NSLog(@"select :%d  %d",section,row);
}

//绘制单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取自定义单元格
    static NSString *CellIdentifier = @"id_fourbuttons";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //设置右边的竖线边框
    for (int i=1; i<=3; i++) {
        UILabel * tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(80*i+1, 0, 1, cell.frame.size.height)];
        tempLabel.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
        [cell addSubview:tempLabel];
    }
    //设置下面的边框
    UILabel * tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, cell.frame.size.width, 1)];
    tempLabel.backgroundColor=[UIColor colorWithRed:235./255 green:235./255 blue:235./255 alpha:1];
    [cell addSubview:tempLabel];
    //绘制完成
    return cell;
}

//实现自定义菜单的委托（图标部分）
-(UIImage *)setIcon{
    static int  i=0;
    i++;
    NSString * s=[NSString stringWithFormat:@"HomeIcons.bundle/%@",self.iconPaths[(i-1)]];
    UIImage * img= [UIImage imageNamed:s];
    UIImage * scaledimg=[UIImage imageWithCGImage:img.CGImage scale:img.scale*2.0 orientation:img.imageOrientation];
    return  scaledimg;
}

//实现自定义菜单的委托（标题部分）
-(NSString *)setIconTitle{
    static int i=0;
    i++;
    return self.titles[(i-1)];
}

//实现自定义菜单的委托（点击主界面的菜单按钮）
-(void)onClicked:(NSString*)str{
    UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //我要下单
    if([str isEqualToString:@"我要下单"]){//我要下单 showMakeOrder 自带连接线
        [self performSegueWithIdentifier:@"showMakeOrder" sender:nil];
    }
    
    //消息菜单
    if([str isEqualToString:@"消息"]){//消息菜单 不自带连接线
        NotifyTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDNotifyTVC"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    //邀请
    if([str isEqualToString:@"邀请"]){//邀请 不自带连接线
        YqTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDYqVC"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    //我的发件
    if([str isEqualToString:@"我的发件"]){//我的发件 SIDOrderSendQueryTVC  不自带连接线
        OrderSendQueryTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDOrderSendQueryTVC"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    //配置
    if([str isEqualToString:@"配置"]){//消息菜单  不自带连接线
        /*UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"111消息功能未实现" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
        [alert show];*/
//        [self performSegueWithIdentifier:@"showHomeNotify" sender:nil];
        
        
        //UIStoryboard * mainsb =[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ConfigCommonTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDConfigCommonTVC"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    //我的取件
    if([str isEqualToString:@"我的取件"]){//我的取件  不自带连接线
        OrderGetTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDOrderGetTVC"];
        [self.navigationController pushViewController:tvc animated:YES];
    }
    
    //电话下单
    if( [str isEqualToString:@"电话下单"]){//客服中心 电话下单  不自带连接线
        NSString *phoneNum=@"4000560013";
        NSURL *phoneURL=[NSURL URLWithString:[ NSString stringWithFormat:@"tel:%@",phoneNum ]];
        if (!webview){
            NSLog(@"电话下单 4000560013");
            webview=[[UIWebView alloc] initWithFrame:CGRectZero];
        }
        [webview loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    
    //客服中心－暂时使用测试登录接口代替
    if ([str isEqualToString:@"客服中心"]) {
        NSString *url=@"http://113.6.252.161:9090/adminapp/WebAppController/json.html?methodName=login&proName=3333_1_consignor";
        NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
        parameters[@"methodName"]= @"login";
        parameters[@"proName"]= @"3333_1_consignor";
        [AFNetworkTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
            NSError *error = nil;
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            NSArray *infoArray = [dic objectForKey:@"rs"];
            NSDictionary *nd = [infoArray objectAtIndex:0];
            JSONModelLogin *testObject =[JSONModelLogin objectWithKeyValues:nd];
            //NSString *str = [NSString stringWithFormat:@"今天是%@",[nd objectForKey:@"phone1"]];
            NSLog(@"weatherInfo字典里面的内容为--》%@", testObject.mem_id);
        } fail:^{
            NSLog(@"失败");
        }];
        
    }
    
    
    //订单跟踪
    if([str isEqualToString:@"订单跟踪"]){//订单跟踪
//        GoodsGetTVC *tvc=[mainsb instantiateViewControllerWithIdentifier:@"SIDGoodsGetTVC"];
//        [self.navigationController pushViewController:tvc animated:YES];
        
        NSLog(@"订单跟踪");
        //RootTabBarController * tabVC=[mainsb instantiateInitialViewController];
        //tabVC.selectedIndex=2;
//        self.window.rootViewController=tabVC;
        //[self.delegate HomeVC:self clickOK:nil];//设置回调  向来源触发事件委托
        
        //直接调转到tabbar的第二个  先找到父类
        UITabBarController *tab=(UITabBarController *)self.parentViewController.parentViewController;
        NSLog(@"订单跟踪===,%lu",(unsigned long)tab.selectedIndex);
        [tab setSelectedIndex:1];
    }
    
}

//本页面右上角的下单菜单按钮
- (IBAction)bill_click:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"showMakeOrder" sender:nil];//下单 提交订单功能  自带连接线
    /*
    self.billVC=[[UIViewController alloc]init];
    self.billVC.view=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.billVC.view.backgroundColor=[UIColor whiteColor];//前面的页面设置背景为黑色了，到这也是黑色？
    UILabel * label=[[UILabel alloc]initWithFrame:self.billVC.view.bounds];
    label.text=@"账单页面是用代码生成的，详见biil_click";
    [self.billVC.view addSubview:label];
    
    //维护UINavigationItem
    //左
    self.billVC.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.billVC.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    //中，高23pt，白色
    //self.billVC.title=@"账单"; //字体较小
    UIButton * but=[[UIButton alloc]init];
    but.tintColor=[UIColor whiteColor];
    [but setTitle:@"账单" forState:UIControlStateNormal];
    but.titleLabel.font= [UIFont systemFontOfSize: 23];
    
    self.billVC.navigationItem.titleView=but;
    //右
    self.billVC.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"HomeIcons.bundle/bill_history.png"] style:UIBarButtonItemStylePlain target:self action:@selector(noDefinitionPopup:)];
    self.billVC.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.navigationController pushViewController:self.billVC animated:YES];
    */
}

/*
-(void)noDefinitionPopup:(id)sender{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"此功能未实现" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
}

-(void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
*/


@end
