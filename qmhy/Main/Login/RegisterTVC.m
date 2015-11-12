//
//  RegisterTVC.m
//  qmhy
//  注册视图控制器
//  Created by lingsbb on 15-8-23.
//  Copyright (c) 2015年 wsy.Inc. All rights reserved.
//

#import "RegisterTVC.h"
#import "LoginVC.h"

@interface RegisterTVC ()
@property (weak, nonatomic) IBOutlet UITextField *memid;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *userphone1;
@property (weak, nonatomic) IBOutlet UITextField *userphone2;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UITextField *tjm;

@end

@implementation RegisterTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//单击注册按钮
- (IBAction)clickReg:(id)sender {
    NSLog(@"clickreg");
    
    
    //都填写了
    if (self.memid.text.length > 0 &&
        self.username.text.length > 0 &&
        self.userphone1.text.length > 0 &&
        self.password.text.length > 0 &&
        self.password2.text.length > 0)
    {
        if ( ![self.password.text isEqualToString:self.password2.text ]){
            [AppDelegate showAlert:@"两次输入密码不一致！"];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];//关闭自己
        }
    }
    else {
        [AppDelegate showAlert:@"请填写完整信息！"];
        
        // delegate 可设为nil 表示不响应事件 需按钮响应时必须要设置delegate 并实现下面方法；
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //[alert show];
        //[alert release];
    }
    //[self dismissModalViewControllerAnimated:YES];
    /*WidgetsVC *vc=(WidgetsVC *)self.parentViewController ;//[[WidgetsVC alloc]initWithNibName:@"WidgetsVC" bundle:[NSBundle mainBundle]];
    [self presentViewController:vc animated:YES completion:nil];*/
}

//自动隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
