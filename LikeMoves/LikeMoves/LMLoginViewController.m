//
//  LMLoginViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMLoginViewController.h"
#import "RegViewController.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
/// 登陆界面和注册界面
@interface LMLoginViewController ()

/**
 *  登陆页面
 */
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *loginPwd;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet FUIButton *loginFUI;
@property (weak, nonatomic) IBOutlet FUIButton *resetPwdFUI;
@property (weak, nonatomic) IBOutlet FUIButton *registFUI;
- (IBAction)closeKeyboard:(id)sender;

/**
 *  登陆界面注册按钮监听事件
 *
 *  @param sender 注册按钮对象
 */
- (IBAction)toRegist:(id)sender;
/**
 *  登陆界面登陆按钮监听
 *
 *  @param sender 登陆按钮对象
 */
- (IBAction)login:(id)sender;

/**
 *  注册页面
 */
@property (weak, nonatomic) IBOutlet UILabel *registPhoneNum;

@property (weak, nonatomic) IBOutlet UITextField *registPwd;
- (IBAction)regist:(id)sender;

- (IBAction)back:(id)sender;
@end

@implementation LMLoginViewController

@synthesize phoneNum;
- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[LMUserActBL new];
    _bl.delegate=self;
    _registPhoneNum.text=phoneNum;
    //背景图片设置
    UIImageView* img=[[UIImageView alloc] initWithFrame:_loginView.bounds];
    img.image=[[UIImage imageNamed:@"launch"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    [_loginView addSubview:img];
    [_loginView sendSubviewToBack:img];
    
    /**
     *  Login界面元素配置
     */
    
    //登陆按钮配置
    self.loginFUI.buttonColor = [UIColor turquoiseColor];
    self.loginFUI.shadowColor = [UIColor greenSeaColor];
    self.loginFUI.shadowHeight = 5.0f;
    self.loginFUI.cornerRadius = 6.0f;
    [self.loginFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.loginFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //忘记密码按钮配置
    self.resetPwdFUI.buttonColor = [UIColor turquoiseColor];
    self.resetPwdFUI.shadowColor = [UIColor greenSeaColor];
    self.resetPwdFUI.shadowHeight = 3.0f;
    self.resetPwdFUI.cornerRadius = 6.0f;
    [self.resetPwdFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.resetPwdFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    //注册按钮配置
    self.registFUI.buttonColor = [UIColor turquoiseColor];
    self.registFUI.shadowColor = [UIColor greenSeaColor];
    self.registFUI.shadowHeight = 3.0f;
    self.registFUI.cornerRadius = 6.0f;
    [self.registFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.registFUI setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)toRegist:(id)sender {
    RegViewController* reg=[[RegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
        
    }];
    
}

- (IBAction)login:(id)sender {
    [_bl login:_loginPhone.text withPassword:_loginPwd.text];
}
- (IBAction)regist:(id)sender {
    [_bl regist:_registPhoneNum.text withPassword:_registPwd.text];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - LMUserBLDelegate 个人中心delegate方法
-(void)loginSuccess{
    //TODO: 跳转TAB页面
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainTabPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
    if (![self.presentedViewController isBeingDismissed]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
//    [self dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)loginFail{
    
}
-(void)registSuccess{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self presentViewController:tabVC animated:YES completion:^(void){
    }];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

-(void)registFail{
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)closeKeyboard:(id)sender {
    [_loginPhone resignFirstResponder];
    [_loginPwd resignFirstResponder];
}
@end
