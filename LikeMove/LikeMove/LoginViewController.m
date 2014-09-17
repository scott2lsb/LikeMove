//
//  LoginViewController.m
//  LikeMove
//
//  Created by 粒橙Leo on 14-9-13.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "LoginViewController.h"
#import "PersonalAction.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *regPhone;
@property (weak, nonatomic) IBOutlet UITextField *regPwd;

- (IBAction)regist:(id)sender;
@end

@implementation LoginViewController
PersonalAction* action;
- (void)viewDidLoad {
    [super viewDidLoad];
    action=[PersonalAction sharePersonalAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(id)sender {
    [action login:_loginPhone.text  withPassword:_loginPwd.text];
}
- (IBAction)regist:(id)sender {
    BOOL isRegist=[action regist:_regPhone.text withPassword:_regPwd.text];
    if (isRegist) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"" message:@"注册不成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
@end
