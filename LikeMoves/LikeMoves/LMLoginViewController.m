//
//  LMLoginViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-9-15.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LMLoginViewController.h"
/// 登陆界面和注册界面
@interface LMLoginViewController ()
/**
 *  登陆页面
 */
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *loginPwd;

- (IBAction)login:(id)sender;
/**
 *  注册页面
 */
@property (weak, nonatomic) IBOutlet UITextField *registPhone;
@property (weak, nonatomic) IBOutlet UITextField *registPwd;
- (IBAction)regist:(id)sender;

- (IBAction)back:(id)sender;
@end

@implementation LMLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _bl=[LMUserActBL new];
    _bl.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)login:(id)sender {
    [_bl login:_loginPhone.text withPassword:_loginPwd.text];
}
- (IBAction)regist:(id)sender {
    [_bl regist:_registPhone.text withPassword:_registPwd.text];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - LMUserBLDelegate 个人中心delegate方法
-(void)loginSuccess{
    //TODO: 跳转TAB页面
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainTabPage"];
    [self presentViewController:tabVC animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginFail{
    
}
@end
